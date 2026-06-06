import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';
import 'state/settings_state.dart';

/// SettingsViewModel - Refatorado para POO com State Pattern.
class SettingsViewModel extends ChangeNotifier {
  final SigmaStore _sigmaStore;
  SettingsState _state = SettingsState();
  SettingsState get state => _state;

  ThemeMode get themeMode => _state.themeMode;
  Locale get locale => _state.locale;
  bool get showChatFilters => _state.showChatFilters;
  double get messageFontSize => _state.messageFontSize;
  double get messageBorderRadius => _state.messageBorderRadius;
  bool get isLoaded => _state.isLoaded;

  SettingsViewModel(this._sigmaStore) {
    _loadSettings();
  }

  Future<void> load() => _loadSettings();

  Future<void> _loadSettings() async {
    if (_state.isLoaded) return;

    final settings = _sigmaStore.settings;
    
    final savedTheme = await settings.getTheme();
    final savedLocale = await settings.getLocale();
    final chatFilters = await settings.isShowChatFiltersEnabled();
    final fontSize = await settings.getMessageFontSize();
    final borderRadius = await settings.getMessageBorderRadius();

    final locale = savedLocale != null ? Locale(savedLocale) : const Locale('pt', 'BR');

    _state = _state.copyWith(
      themeMode: savedTheme != null ? _parseThemeMode(savedTheme) : ThemeMode.system,
      locale: locale,
      showChatFilters: chatFilters,
      messageFontSize: fontSize,
      messageBorderRadius: borderRadius,
      isLoaded: true,
    );

    // Carrega as strings para o idioma inicial
    await SigmaStrings.load(locale.languageCode);

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_state.themeMode == mode) return;
    _state = _state.copyWith(themeMode: mode);
    notifyListeners();
    await _sigmaStore.settings.setTheme(mode.name);
  }

  Future<void> setLocale(Locale locale) async {
    if (_state.locale == locale) return;
    
    // Carrega as novas strings antes de notificar a UI
    await SigmaStrings.load(locale.languageCode);

    _state = _state.copyWith(locale: locale);
    notifyListeners();
    await _sigmaStore.settings.setLocale(locale.languageCode);
  }

  Future<void> toggleChatFilters(bool value) async {
    if (_state.showChatFilters == value) return;
    _state = _state.copyWith(showChatFilters: value);
    notifyListeners();
    await _sigmaStore.settings.setShowChatFilters(value);
  }

  Future<void> setMessageFontSize(double size) async {
    if (_state.messageFontSize == size) return;
    _state = _state.copyWith(messageFontSize: size);
    notifyListeners();
    await _sigmaStore.settings.setMessageFontSize(size);
  }

  Future<void> setMessageBorderRadius(double radius) async {
    if (_state.messageBorderRadius == radius) return;
    _state = _state.copyWith(messageBorderRadius: radius);
    notifyListeners();
    await _sigmaStore.settings.setMessageBorderRadius(radius);
  }

  ThemeMode _parseThemeMode(String name) {
    return ThemeMode.values.firstWhere(
      (e) => e.name == name,
      orElse: () => ThemeMode.system,
    );
  }
}
