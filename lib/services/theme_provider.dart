import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  /// Switch between light and dark themes
  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
