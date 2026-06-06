import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';

/// MessageContextMenu - Réplica Pixel-Perfect do Signal Android 2025.
class MessageContextMenu extends StatelessWidget {
  final MessageEntity message;
  final Function(String emoji)? onReact;
  final VoidCallback? onReply;
  final VoidCallback? onEdit;
  final VoidCallback? onForward;
  final VoidCallback? onCopy;
  final VoidCallback? onSelect;
  final VoidCallback? onInfo;
  final VoidCallback? onPin;
  final VoidCallback? onDelete;

  const MessageContextMenu({
    super.key,
    required this.message,
    this.onReact,
    this.onReply,
    this.onEdit,
    this.onForward,
    this.onCopy,
    this.onSelect,
    this.onInfo,
    this.onPin,
    this.onDelete,
  });

  static Future<void> show(
    BuildContext context, {
    required MessageEntity message,
    Function(String emoji)? onReact,
    VoidCallback? onReply,
    VoidCallback? onEdit,
    VoidCallback? onForward,
    VoidCallback? onCopy,
    VoidCallback? onSelect,
    VoidCallback? onInfo,
    VoidCallback? onPin,
    VoidCallback? onDelete,
  }) {
    // Implementação simplificada usando Dialog, mas preparada para Overlay futuro
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (context) => MessageContextMenu(
        message: message,
        onReact: onReact,
        onReply: onReply,
        onEdit: onEdit,
        onForward: onForward,
        onCopy: onCopy,
        onSelect: onSelect,
        onInfo: onInfo,
        onPin: onPin,
        onDelete: onDelete,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF2E2E2E) : Colors.white;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Barra de Reações (Floating Top)
              _buildReactionPill(context, backgroundColor, isDark),
              const SizedBox(height: 12),
              // 2. Menu de Ações (Vertical List)
              _buildActionCard(context, backgroundColor, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReactionPill(BuildContext context, Color bgColor, bool isDark) {
    final emojis = ["❤️", "👍", "👎", "😂", "😮", "😢"];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...emojis.map((e) => _buildEmoji(context, e)),
          Container(
            width: 1, height: 24, 
            color: isDark ? Colors.white24 : Colors.black12, 
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
          Icon(Icons.add_circle_outline, color: isDark ? Colors.white70 : Colors.black54, size: 24),
        ],
      ),
    );
  }

  Widget _buildEmoji(BuildContext context, String emoji) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (onReact != null) onReact!(emoji);
      },
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(emoji, style: const TextStyle(fontSize: 28)),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, Color bgColor, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildActionItem(Icons.reply, "Responder", onReply, context, isDark),
            if (message.isFromMe)
              _buildActionItem(Icons.edit_outlined, "Editar", onEdit, context, isDark),
            _buildActionItem(Icons.forward_outlined, "Encaminhar", onForward, context, isDark),
            _buildActionItem(Icons.copy_outlined, "Copiar", onCopy, context, isDark),
            _buildActionItem(Icons.check_circle_outline, "Selecionar", onSelect, context, isDark),
            _buildActionItem(Icons.info_outline, "Info", onInfo, context, isDark),
            _buildActionItem(Icons.push_pin_outlined, "Fixar", onPin, context, isDark),
            const Divider(height: 1, thickness: 0.5),
            _buildActionItem(Icons.delete_outline, "Apagar", onDelete, context, isDark, isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, VoidCallback? onTap, BuildContext context, bool isDark, {bool isDestructive = false}) {
    final color = isDestructive ? Colors.red : (isDark ? Colors.white : Colors.black87);
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (onTap != null) onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Row(
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label, 
                style: TextStyle(
                  fontSize: 16, 
                  color: color,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
