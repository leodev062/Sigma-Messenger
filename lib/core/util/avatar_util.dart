import 'package:flutter/material.dart';

class AvatarUtil {
  /// Gera as iniciais a partir de um nome completo, com suporte a emojis.
  static String getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    
    final trimmedName = name.trim();
    // Usamos .characters para tratar emojis (surrogate pairs) como um único caractere
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

  /// Retorna uma cor determinística baseada no nome para manter consistência visual.
  static Color getBackgroundColor(String? name) {
    if (name == null || name.isEmpty) return const Color(0xFF2E4D2E);

    final List<Color> colors = [
      const Color(0xFF2E4D2E), // Verde escuro
      const Color(0xFF4D2E2E), // Marrom escuro
      const Color(0xFF2E2E4D), // Azul escuro
      const Color(0xFF4D4D2E), // Oliva
      const Color(0xFF2E4D4D), // Teal
      const Color(0xFF4D2E4D), // Roxo
      const Color(0xFF1E88E5), // Azul Sigma
      const Color(0xFFD81B60), // Rosa
      const Color(0xFFFB8C00), // Laranja
    ];

    // Simples hash para escolher a cor baseada no tamanho e conteúdo do nome
    final int hash = name.codeUnits.fold(0, (prev, element) => prev + element);
    final int index = hash % colors.length;
    return colors[index];
  }
}
