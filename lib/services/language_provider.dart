import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  // Default language for the app remains English.
  String _language = 'English';
  // Flag to track if the user has explicitly made a selection.
  bool _hasSelectedLanguage = false;

  bool get hasSelectedLanguage => _hasSelectedLanguage;

  bool get isEnglish => _language == 'English';

  String get language => _language;

  void setLanguage(String language) {
    _language = language;
    _hasSelectedLanguage = true;
    notifyListeners();
  }
}
