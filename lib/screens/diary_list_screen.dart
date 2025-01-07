import 'package:flutter/material.dart';
import 'package:memo/custom/constants.dart';
import 'package:memo/custom/models/diary_entry.dart';
import 'package:memo/custom/widgets/my_drower.dart';
import 'package:memo/screens/diary_entry_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DiaryListScreen extends StatefulWidget {
  const DiaryListScreen({Key? key}) : super(key: key);

  @override
  State<DiaryListScreen> createState() => _DiaryListScreenState();
}

class _DiaryListScreenState extends State<DiaryListScreen> {
  List<DiaryEntry> _entries = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getStringList(AppConstants.diaryEntriesKey) ?? [];
    setState(() {
      _entries =
          entriesJson.map((e) => DiaryEntry.fromJson(json.decode(e))).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF445D67),
        title: const Text(
          'My Diary',
          style: AppStyles.titleStyle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: my_Drawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white70,
          ),
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(vertical: 20),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: _entries.length,
            itemBuilder: (context, index) {
              final entry = _entries[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    entry.date,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                subtitle: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  color: Colors.white,
                  child: Text(entry.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.defaultStyle),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiaryEntryScreen(entry: entry),
                    ),
                  ).then((_) => _loadEntries());
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment(0.88, 0.95),
        child: FloatingActionButton.large(
          backgroundColor: AppColors.tertiary,
          shape: CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white70,
            size: 35,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DiaryEntryScreen(),
              ),
            ).then((_) => _loadEntries());
          },
        ),
      ),
    );
  }
}
