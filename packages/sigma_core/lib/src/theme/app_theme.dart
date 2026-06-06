import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData light() => _buildTheme(Brightness.light);
  static ThemeData dark() => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: isDark ? SigmaColors.signal_dark_colorPrimary : SigmaColors.signal_light_colorPrimary,
      onPrimary: isDark ? SigmaColors.signal_dark_colorOnPrimary : SigmaColors.signal_light_colorOnPrimary,
      primaryContainer: isDark ? SigmaColors.signal_dark_colorPrimaryContainer : SigmaColors.signal_light_colorPrimaryContainer,
      onPrimaryContainer: isDark ? SigmaColors.signal_dark_colorOnPrimaryContainer : SigmaColors.signal_light_colorOnPrimaryContainer,
      secondary: isDark ? SigmaColors.signal_dark_colorSecondary : SigmaColors.signal_light_colorSecondary,
      onSecondary: isDark ? SigmaColors.signal_dark_colorOnSecondary : SigmaColors.signal_light_colorOnSecondary,
      secondaryContainer: isDark ? SigmaColors.signal_dark_colorSecondaryContainer : SigmaColors.signal_light_colorSecondaryContainer,
      onSecondaryContainer: isDark ? SigmaColors.signal_dark_colorOnSecondaryContainer : SigmaColors.signal_light_colorOnSecondaryContainer,
      surface: isDark ? SigmaColors.signal_dark_colorSurface : SigmaColors.signal_light_colorSurface,
      onSurface: isDark ? SigmaColors.signal_dark_colorOnSurface : SigmaColors.signal_light_colorOnSurface,
      surfaceContainerHighest: isDark ? SigmaColors.signal_dark_colorSurfaceVariant : SigmaColors.signal_light_colorSurfaceVariant,
      onSurfaceVariant: isDark ? SigmaColors.signal_dark_colorOnSurfaceVariant : SigmaColors.signal_light_colorOnSurfaceVariant,
      outline: isDark ? SigmaColors.signal_dark_colorOutline : SigmaColors.signal_light_colorOutline,
      error: isDark ? SigmaColors.signal_dark_colorError : SigmaColors.signal_light_colorError,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 2,
      ),
      cardTheme: CardThemeData(
        color: isDark ? SigmaColors.signal_dark_colorSurface1 : SigmaColors.signal_light_colorSurface1,
        elevation: 0,
      ),
    );
  }
}
