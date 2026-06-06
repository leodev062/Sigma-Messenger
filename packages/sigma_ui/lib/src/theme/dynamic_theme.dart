import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';

class DynamicTheme {
  static ThemeData light({ColorScheme? dynamicColorScheme}) {
    final colorScheme = dynamicColorScheme?.brightness == Brightness.light
        ? dynamicColorScheme!
        : AppTheme.light().colorScheme;
    return _buildTheme(colorScheme);
  }

  static ThemeData dark({ColorScheme? dynamicColorScheme}) {
    final colorScheme = dynamicColorScheme?.brightness == Brightness.dark
        ? dynamicColorScheme!
        : AppTheme.dark().colorScheme;
    return _buildTheme(colorScheme);
  }

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 2,
      ),
    );
  }
}
