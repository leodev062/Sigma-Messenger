import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Locale _locale = const Locale('pt', 'BR');
  Locale get locale => _locale;

  bool _showChatFilters = true;
  bool get showChatFilters => _showChatFilters;

  SettingsViewModel() {
    _loadSettings();
  }

  void _loadSettings() {
    // Aqui carregaríamos do SigmaStore/SharedPreferences
    // Por agora, iniciamos com padrões.
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    // Salvar no storage...
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
    // Salvar no storage...
  }

  void toggleChatFilters(bool value) {
    _showChatFilters = value;
    notifyListeners();
    // Salvar no storage...
  }
}
