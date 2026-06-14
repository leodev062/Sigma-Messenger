import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_ui/sigma_ui.dart';
import '../viewmodels/chat_viewmodel.dart';

/// ThreadDismissibleTile - Refatorado para POO.
/// Encapsula comportamentos de interação (Swipe/Dismiss) da thread.
class ThreadDismissibleTile extends StatelessWidget {
  final ThreadEntity thread;
  final ChatViewModel chatViewModel;
  final bool isArchivedView;

  const ThreadDismissibleTile({
    super.key,
    required this.thread, 
    required this.chatViewModel,
    this.isArchivedView = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('thread_${thread.id}'),
      direction: isArchivedView ? DismissDirection.startToEnd : DismissDirection.endToStart,
      background: _buildDismissBackground(context),
      onDismissed: (_) => _handleDismiss(context),
      child: ThreadTile(
        thread: thread,
        onLongPress: () => _showActionSheet(context),
      ),
    );
  }

  Widget _buildDismissBackground(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      alignment: isArchivedView ? Alignment.centerLeft : Alignment.centerRight,
      padding: EdgeInsets.only(
        left: isArchivedView ? 24 : 0,
        right: isArchivedView ? 0 : 24,
      ),
      child: Icon(
        isArchivedView ? Icons.unarchive_outlined : Icons.archive_outlined, 
        color: Colors.white
      ),
    );
  }

  void _handleDismiss(BuildContext context) {
    chatViewModel.archiveThread(thread.id, !isArchivedView);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isArchivedView ? context.translate('chat_unarchived') : context.translate('chat_archived')),
        action: SnackBarAction(
          label: context.translate('undo'),
          onPressed: () => chatViewModel.archiveThread(thread.id, isArchivedView),
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(thread.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
              title: Text(thread.isPinned ? context.translate('unpin') : context.translate('pin')),
              onTap: () {
                chatViewModel.pinThread(thread.id, !thread.isPinned);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: Text(context.translate('delete'), style: const TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.translate('delete_chat_title')),
        content: Text(context.translate('delete_chat_message')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              chatViewModel.deleteThread(thread.id);
              Navigator.pop(context);
            },
            child: Text(context.translate('delete'), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

/// ThreadTile - Widget de apresentação da conversa.
class ThreadTile extends StatelessWidget {
  final ThreadEntity thread;
  final VoidCallback? onLongPress;
  
  const ThreadTile({super.key, required this.thread, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final recipient = thread.recipient;

    return ListTile(
      onTap: () => context.push('/chat/${thread.id}'),
      onLongPress: onLongPress,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: AvatarImageView(recipient: recipient, size: 56),
      title: _buildTitleRow(colorScheme),
      subtitle: _buildSubtitleRow(context, colorScheme),
    );
  }

  Widget _buildTitleRow(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              if (thread.isPinned)
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(Icons.push_pin, size: 14, color: colorScheme.onSurfaceVariant),
                ),
              Flexible(
                child: Text(
                  thread.recipient.computedDisplayName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              thread.recipient.type.toIcon(colorScheme),
            ],
          ),
        ),
        Text(
          thread.formattedTime, 
          style: TextStyle(
            fontSize: 12, 
            color: thread.unreadCount > 0 ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.5),
            fontWeight: thread.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitleRow(BuildContext context, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              thread.snippet ?? context.translate('no_messages'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14, 
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          if (thread.unreadCount > 0)
            _UnreadBadge(count: thread.unreadCount, isMuted: thread.isMuted),
        ],
      ),
    );
  }
}

/// Widget interno para o Badge de não lidas.
class _UnreadBadge extends StatelessWidget {
  final int count;
  final bool isMuted;
  const _UnreadBadge({required this.count, this.isMuted = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isMuted ? colorScheme.onSurface.withValues(alpha: 0.2) : colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: isMuted ? colorScheme.onSurface.withValues(alpha: 0.6) : Colors.white, 
          fontSize: 11, 
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}

/// Extension POO para formatar dados da Thread na UI.
extension ThreadUiExtensions on ThreadEntity {
  String get formattedTime {
    final date = DateTime.fromMillisecondsSinceEpoch(this.date);
    final now = DateTime.now();
    
    if (date.day == now.day && date.month == now.month && date.year == now.year) {
      // Formatação simples apenas com hora para hoje (Ex: 14:30)
      return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
    }
    // Para dias anteriores, apenas a data (simplificado)
    return "${date.day}/${date.month}";
  }
}

/// Extension POO para ícones de tipo de destinatário.
extension RecipientTypeUiExtensions on RecipientType {
  Widget toIcon(ColorScheme colorScheme) {
    IconData? icon;
    switch (this) {
      case RecipientType.group:
        icon = Icons.group;
        break;
      case RecipientType.channel:
        icon = Icons.campaign;
        break;
      case RecipientType.bot:
        icon = Icons.smart_toy;
        break;
      case RecipientType.individual:
        return const SizedBox.shrink();
    }
    
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Icon(icon, size: 16, color: colorScheme.onSurface.withValues(alpha: 0.4)),
    );
  }
}
