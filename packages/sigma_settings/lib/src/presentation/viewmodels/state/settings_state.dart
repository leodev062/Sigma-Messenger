import 'package:flutter/material.dart';

class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;
  final bool showChatFilters;
  final double messageFontSize;
  final double messageBorderRadius;
  final bool isLoaded;

  SettingsState({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('pt', 'BR'),
    this.showChatFilters = true,
    this.messageFontSize = 16.0,
    this.messageBorderRadius = 18.0,
    this.isLoaded = false,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? showChatFilters,
    double? messageFontSize,
    double? messageBorderRadius,
    bool? isLoaded,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      showChatFilters: showChatFilters ?? this.showChatFilters,
      messageFontSize: messageFontSize ?? this.messageFontSize,
      messageBorderRadius: messageBorderRadius ?? this.messageBorderRadius,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}
