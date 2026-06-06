import 'package:flutter/material.dart';

class SigmaColors {
  // --- Signal Android Material 3 Palette (Light) ---
  static const Color signal_light_colorPrimary = Color(0xFF2C58C3);
  static const Color signal_light_colorPrimaryContainer = Color(0xFFD2DFFB);
  static const Color signal_light_colorSecondary = Color(0xFF586071);
  static const Color signal_light_colorSecondaryContainer = Color(0xFFDCE5F9);
  static const Color signal_light_colorSurface = Color(0xFFFBFCFF);
  static const Color signal_light_colorSurfaceVariant = Color(0xFFE7EBF3);
  static const Color signal_light_colorBackground = Color(0xFFFBFCFF);
  static const Color signal_light_colorError = Color(0xFFBA1B1B);
  static const Color signal_light_colorErrorContainer = Color(0xFFFFDAD4);
  static const Color signal_light_colorOnPrimary = Color(0xFFFFFFFF);
  static const Color signal_light_colorOnPrimaryContainer = Color(0xFF051845);
  static const Color signal_light_colorOnSecondary = Color(0xFFFFFFFF);
  static const Color signal_light_colorOnSecondaryContainer = Color(0xFF151D2C);
  static const Color signal_light_colorOnSurface = Color(0xFF1B1B1D);
  static const Color signal_light_colorOnSurfaceVariant = Color(0xFF545863);
  static const Color signal_light_colorOutline = Color(0xFF808389);

  // --- Signal Android Material 3 Palette (Dark) ---
  static const Color signal_dark_colorPrimary = Color(0xFFB6C5FA);
  static const Color signal_dark_colorPrimaryContainer = Color(0xFF464B5C);
  static const Color signal_dark_colorSecondary = Color(0xFFC1C6DD);
  static const Color signal_dark_colorSecondaryContainer = Color(0xFF414659);
  static const Color signal_dark_colorSurface = Color(0xFF1B1C1F);
  static const Color signal_dark_colorSurfaceVariant = Color(0xFF303133);
  static const Color signal_dark_colorBackground = Color(0xFF1B1C1F);
  static const Color signal_dark_colorError = Color(0xFFFFB4A9);
  static const Color signal_dark_colorErrorContainer = Color(0xFF930006);
  static const Color signal_dark_colorOnPrimary = Color(0xFF1E2438);
  static const Color signal_dark_colorOnPrimaryContainer = Color(0xFFDBE1FC);
  static const Color signal_dark_colorOnSecondary = Color(0xFF2A3042);
  static const Color signal_dark_colorOnSecondaryContainer = Color(0xFFDCE1F9);
  static const Color signal_dark_colorOnSurface = Color(0xFFE2E1E5);
  static const Color signal_dark_colorOnSurfaceVariant = Color(0xFFBEBFC5);
  static const Color signal_dark_colorOutline = Color(0xFF5C5E65);

  // --- Surface Levels (Material 3) ---
  static const Color signal_light_colorSurface1 = Color(0xFFF2F5F9);
  static const Color signal_dark_colorSurface1 = Color(0xFF23242A);

  // --- Mapeamento para Identificadores Sigma (Retrocompatibilidade e Facilidade) ---
  static const Color signalBlue = signal_light_colorPrimary;
  
  // Bolhas de Chat (Valores extraídos do core_colors.xml e lógica Signal)
  static const Color incomingBubbleLight = Color(0xFFE9E9E9); // core_grey_05
  static const Color incomingBubbleDark = Color(0xFF2E2E2E);  // core_grey_85
  static const Color outgoingBubbleLight = signal_light_colorPrimary;
  static const Color outgoingBubbleDark = signal_dark_colorPrimaryContainer;

  // Atalhos para compatibilidade com o app_theme.dart atualizado
  static const Color primary = signalBlue;
  static const Color backgroundLight = signal_light_colorBackground;
  static const Color backgroundDark = signal_dark_colorBackground;
  static const Color error = signal_light_colorError;
}
