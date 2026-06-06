import 'package:flutter/material.dart';

/// AvatarUtil - Refatorado para POO.
/// Fornece extensões para manipulação visual de nomes e cores.
class AvatarUtil {
  /// Retorna as iniciais a partir de um nome.
  static String getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    
    final trimmedName = name.trim();
    final characters = trimmedName.characters;
    
    if (characters.isEmpty) return '?';

    final names = trimmedName.split(' ');
    if (names.length >= 2 && names[1].isNotEmpty) {
      final firstInitial = names[0].characters.first;
      final secondInitial = names[1].characters.first;
      return '$firstInitial$secondInitial'.toUpperCase();
    }
    
    return characters.first.toUpperCase();
  }

  /// Retorna uma cor determinística baseada no nome.
  static Color getBackgroundColor(String? name) {
    if (name == null || name.isEmpty) return const Color(0xFF2E4D2E);

    final List<Color> colors = [
      const Color(0xFF2E4D2E),
      const Color(0xFF4D2E2E),
      const Color(0xFF2E2E4D),
      const Color(0xFF4D4D2E),
      const Color(0xFF2E4D4D),
      const Color(0xFF4D2E4D),
      const Color(0xFF1C6689),
      const Color(0xFFD81B60),
      const Color(0xFFFB8C00),
    ];

    final int hash = name.codeUnits.fold(0, (prev, element) => prev + element);
    final int index = hash % colors.length;
    return colors[index];
  }
}

/// Extension POO para facilitar o uso direto em objetos de domínio ou Strings.
extension AvatarStringExtensions on String {
  String toInitials() => AvatarUtil.getInitials(this);
  Color toAvatarColor() => AvatarUtil.getBackgroundColor(this);
}
