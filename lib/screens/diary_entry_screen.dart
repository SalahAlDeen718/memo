import 'package:flutter/material.dart';
import 'package:memo/custom/constants.dart';
import 'package:memo/custom/models/diary_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DiaryEntryScreen extends StatefulWidget {
  final DiaryEntry? entry;

  const DiaryEntryScreen({Key? key, this.entry}) : super(key: key);

  @override
  State<DiaryEntryScreen> createState() => _DiaryEntryScreenState();
}

class _DiaryEntryScreenState extends State<DiaryEntryScreen> {
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _contentController.text = widget.entry!.content;
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[date.weekday - 1];
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute ${date.hour >= 12 ? 'pm' : 'am'}';
  }

  Future<void> _deleteEntry() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Delete Diary',
          style: TextStyle(color: AppColors.tertiary),
        ),
        content: const Text('Are you sure you want to delete this diary?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.tertiary),
            ),
          ),
        ],
      ),
    );

    if (shouldDelete != true) return;

    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getStringList(AppConstants.diaryEntriesKey) ?? [];
    final entries = entriesJson
        .map((e) => DiaryEntry.fromJson(json.decode(e)))
        .toList();

    entries.removeWhere((e) => e.id == widget.entry!.id);

    await prefs.setStringList(
      AppConstants.diaryEntriesKey,
      entries.map((e) => json.encode(e.toJson())).toList(),
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _saveEntry() async {
    if (_contentController.text.isEmpty) return;

    final now = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getStringList(AppConstants.diaryEntriesKey) ?? [];
    final entries = entriesJson
        .map((e) => DiaryEntry.fromJson(json.decode(e)))
        .toList();

    final newEntry = DiaryEntry(
      id: widget.entry?.id ?? DateTime.now().toString(),
      content: _contentController.text,
      date: widget.entry?.date ?? '${now.day}/${now.month}/${now.year}',
      time: widget.entry?.time ?? _formatTime(now),
    );

    if (widget.entry != null) {
      final index = entries.indexWhere((e) => e.id == widget.entry!.id);
      if (index != -1) {
        entries[index] = newEntry;
      }
    } else {
      entries.add(newEntry);
    }

    await prefs.setStringList(
      AppConstants.diaryEntriesKey,
      entries.map((e) => json.encode(e.toJson())).toList(),
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isEditing = widget.entry != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.tertiary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing
              ? widget.entry!.date
              : '${now.day}/${now.month}/${now.year}',
          style: AppStyles.titleStyle,
        ),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: _deleteEntry,
            ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          margin: EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing ? widget.entry!.date : _formatDate(now),
                    style: const TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    isEditing ? widget.entry!.time : _formatTime(now),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Record your memories here...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 16,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: const Alignment(0.88, 0.95),
        child: FloatingActionButton.large(
          backgroundColor: AppColors.tertiary,
          shape: const CircleBorder(),
          onPressed: _saveEntry,
          child: const Icon(Icons.check, size: 50, color: Colors.white),
        ),
      ),
    );
  }
}