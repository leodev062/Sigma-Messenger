import 'package:flutter/material.dart';
import 'package:sigma/core/util/avatar_util.dart';

/// Widget de Avatar inteligente do Sigma - Estilo Telegram.
/// Suporta: Imagens via URL, Emojis como ícone principal e Iniciais automáticas.
class SigmaAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String? name;
  final double radius;
  final VoidCallback? onTap;

  const SigmaAvatar({
    super.key,
    this.avatarUrl,
    this.name,
    this.radius = 24,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Widget content;
    final bool isEmoji = avatarUrl != null && _isOnlyEmoji(avatarUrl!);

    if (avatarUrl != null && avatarUrl!.isNotEmpty && !isEmoji) {
      // 1. Prioridade: Imagem Real (URL)
      content = CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(avatarUrl!),
        backgroundColor: colorScheme.surfaceContainerHighest,
      );
    } else if (isEmoji) {
      // 2. Suporte a Emojis como Ícone (Estilo Telegram)
      // Se o campo avatarUrl contiver apenas um emoji, exibimos ele em destaque.
      content = CircleAvatar(
        radius: radius,
        backgroundColor: AvatarUtil.getBackgroundColor(name ?? avatarUrl),
        child: Text(
          avatarUrl!,
          style: TextStyle(
            fontSize: radius * 1.2, // Emoji maior para preencher o círculo
            height: 1.0,
          ),
        ),
      );
    } else {
      // 3. Fallback: Iniciais Determinísticas
      final initials = AvatarUtil.getInitials(name);
      final bgColor = AvatarUtil.getBackgroundColor(name);

      content = CircleAvatar(
        radius: radius,
        backgroundColor: bgColor,
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: radius * 0.8,
          ),
        ),
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }

  /// Verifica se a string consiste apenas em emojis (padrão para ícones de perfil).
  bool _isOnlyEmoji(String text) {
    if (text.isEmpty) return false;
    // No Dart, emojis são tratados como caracteres especiais na propriedade .characters
    return text.characters.length <= 2 && text.characters.every((char) {
      // Uma verificação simples de range Unicode para emojis comuns ou se é multi-byte
      return char.runes.any((rune) => rune > 0x2000);
    });
  }
}
