import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/app_themes.dart';

class AppSettings extends ChangeNotifier {
  String _fingerprint = "false";
  String get fingerprint => _fingerprint;

  ThemeData _currentTheme = light;
  ThemeData get currentTheme => _currentTheme;

  AppSettings(bool isDark, bool useFinger) {
    if (isDark) {
      _currentTheme = dark;
    } else {
      _currentTheme = light;
    }

    if (useFinger)  {
      _fingerprint = "true";
    } else {
      _fingerprint = "false";
    }
  }

  void toggleSecurity() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (_fingerprint == "false") {
      _fingerprint = "true";
      sharedPreferences.setBool("use_finger", true);
    } else {
      _fingerprint = "false";
      sharedPreferences.setBool("use_finger", false);
    }
    notifyListeners();
  }

  void toggleTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (_currentTheme == light) {
      _currentTheme = dark;
      sharedPreferences.setBool('is_dark', true);
    } else {
      _currentTheme = light;
      sharedPreferences.setBool('is_dark', false);
    }
    notifyListeners();
  }
}