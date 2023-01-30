import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/app_themes.dart';
import '../Constants/shared_constants.dart';

class AppSettings extends ChangeNotifier {
  String _fingerprint = "false";
  String get fingerprint => _fingerprint;

  ThemeData _currentTheme = light;
  ThemeData get currentTheme => _currentTheme;

  final Map<String, String> _portrait = {};
  Map<String, String> get portrait => _portrait;

  final Map<String, List<String>> _owned = {};
  Map<String, List<String>> get owned => _owned;

  final Map<String, int> _index = {};
  Map<String, int> get index => _index;

  String _useCard = "false";
  String get useCard => _useCard;

  AppSettings(bool isDark, bool useFinger, bool useCard) {
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

    if (useCard) {
      _useCard = "true";
    } else {
      _useCard = "false";
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

  void toggleCard() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (_useCard == "true") {
      _useCard = "false";
      sharedPreferences.setBool(usePortraits, false);
    } else {
      _useCard = "true";
      sharedPreferences.setBool(usePortraits, true);
    }
    notifyListeners();
  }

  void changeIndex(int index, String nome) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _index[nome] = index;
    sharedPreferences.setInt(selectedCard + nome, index);
    notifyListeners();
  }

  void changePortrait(String portrait, String nome) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _portrait[nome] = portrait;
    sharedPreferences.setString(currentCard + nome, portrait);
    notifyListeners();
  }

  void updateCards(List<String> cards, String nome) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _owned[nome] = cards;
    sharedPreferences.setStringList(ownedCards + nome, cards.toSet().toList());
    notifyListeners();
  }
}