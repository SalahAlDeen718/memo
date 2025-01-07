import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFF7B7B);
  static const Color secondary = Color(0xFF838383);
  static const Color tertiary = Color(0xFF445D67);
  static const Color background = Colors.transparent;

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primary,
      secondary,
    ],
  );
}

class AppStyles {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(0.0, 3.0),
        blurRadius: 3.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ],
  );

  static const TextStyle defaultStyle = TextStyle(
    color: Color(0xFF375B64),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

}

class AppConstants {
  static const String appName = 'Memo';
  static const String testEmail = 'test@test.com';
  static const String testPassword = '12345678';
  static const String diaryEntriesKey = 'diary_entries';
}
//Todo:make EdgeInsets.symmetric method