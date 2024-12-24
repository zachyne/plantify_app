import 'package:flutter/material.dart';

class LanguageNotifier extends ChangeNotifier {
  String _language = 'english';

  String get language => _language;

  void toggleLanguage() {
    _language = _language == 'english' ? 'tagalog' : 'english';
    notifyListeners(); // Notify any listeners that the language has changed
  }
}
