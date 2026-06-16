import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';

class BotMessageBody extends StatelessWidget {
  final MessageEntity message;
  final Color textColor;
  final double fontSize;

  const BotMessageBody({
    super.key,
    required this.message,
    required this.textColor,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    // For now, it's a simple text with a potential "AI" badge or icon
    // In the future, we can add Markdown support or action buttons.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome, size: 14, color: Colors.white70),
            const SizedBox(width: 4),
            Text(
              "AI Response",
              style: TextStyle(
                color: Colors.white70,
                fontSize: fontSize * 0.7,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          message.textContent,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
