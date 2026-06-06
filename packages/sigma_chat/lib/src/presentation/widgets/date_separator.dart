import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';

/// Separador de data estilo Signal.
/// Usa o tema do app para cores dinâmicas.
class DateSeparator extends StatelessWidget {
  final int timestamp;

  const DateSeparator({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final label = DateUtil.getFriendlyDateLabel(context, date).toUpperCase();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
