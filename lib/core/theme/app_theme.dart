import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: SigmaColors.primary,
      primary: SigmaColors.primary,
      onPrimary: Colors.white,
      secondary: SigmaColors.secondary,
      onSecondary: Colors.white,
      primaryContainer: isDark ? const Color(0xFF1E88E5).withOpacity(0.2) : const Color(0xFFE3F2FD),
      onPrimaryContainer: isDark ? Colors.white : SigmaColors.primary,
      surface: isDark ? SigmaColors.surfaceDark : SigmaColors.surfaceLight,
      background: isDark ? SigmaColors.backgroundDark : SigmaColors.backgroundLight,
      onBackground: isDark ? Colors.white : Colors.black,
      onSurface: isDark ? Colors.white : Colors.black,
      error: SigmaColors.error,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? SigmaColors.surfaceDark : SigmaColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          systemNavigationBarColor: isDark ? SigmaColors.backgroundDark : SigmaColors.backgroundLight,
          systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? Colors.white.withOpacity(0.05) : SigmaColors.backgroundLight.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: isDark ? Colors.white24 : Colors.black26),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : Colors.black,
          height: 1.1,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: isDark ? Colors.white70 : Colors.black54,
          height: 1.5,
        ),
      ),
    );
  }
}
