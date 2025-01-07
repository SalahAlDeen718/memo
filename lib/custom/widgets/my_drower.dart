import 'package:flutter/material.dart';
import 'package:memo/custom/constants.dart';
import 'package:memo/custom/models/diary_entry.dart';
import 'package:memo/screens/diary_entry_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class my_Drawer extends StatelessWidget {
  const my_Drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: AppColors.backgroundGradient,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("assets/images/app_icon.png"),
                      height: 90,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppConstants.appName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info, color: AppColors.primary),
                title: const Text('About App'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: const Text(
                        'About App',
                        style: TextStyle(color: AppColors.tertiary),
                      ),
                      content: const Text(
                          'keep your thoughts and memories saved with Memo app'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: AppColors.tertiary),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: AppColors.primary),
                title: const Text('Developer'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: const Text(
                        'About Developer',
                        style: TextStyle(color: AppColors.tertiary),
                      ),
                      content: Card(
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          width: 390,
                          height: 175,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(7),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/images/me.jpg'),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Salah al-Deen Sehrij',
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'sala718h.sehrij@gmail.com',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    '+90 534 887 75 50',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: AppColors.tertiary),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
 }


