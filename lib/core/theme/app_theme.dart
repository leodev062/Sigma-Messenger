import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: warmPrimary,
      onPrimary: warmOnPrimary,
      secondary: warmSecondary,
      onSecondary: warmOnSecondary,
      error: warmError,
      onError: warmOnError,
      surface: warmSurface,
      onSurface: warmOnSurface,
      outline: warmOutline,
      tertiary: warmTertiary,
      onTertiary: warmOnTertiary,
    ),
    scaffoldBackgroundColor: warmBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: warmSurface,
      foregroundColor: warmOnSurface,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: warmPrimaryDark,
      onPrimary: warmOnPrimaryDark,
      secondary: warmSecondaryDark,
      onSecondary: warmOnSecondaryDark,
      error: warmError,
      onError: warmOnError,
      surface: warmSurfaceDark,
      onSurface: warmOnSurfaceDark,
      outline: warmOutline,
      tertiary: warmTertiaryDark,
      onTertiary: warmOnTertiaryDark,
    ),
    scaffoldBackgroundColor: warmBackgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: warmSurfaceDark,
      foregroundColor: warmOnSurfaceDark,
      elevation: 0,
    ),
  );
}
