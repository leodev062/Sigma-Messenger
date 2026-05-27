import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sigma/domain/entities/chat_entity.dart';
import 'package:sigma/features/chat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:sigma/features/settings/presentation/viewmodels/settings_viewmodel.dart';
import 'package:sigma/features/updater/update_banner.dart';
import 'package:sigma/core/i18n/strings.dart';
import 'package:sigma/core/widgets/sigma_avatar.dart';

class ConversationsView extends StatelessWidget {
  final ChatViewModel chatViewModel;
  final VoidCallback onSearchTap;

  const ConversationsView({
    super.key, 
    required this.chatViewModel,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final settingsViewModel = context.watch<SettingsViewModel>();

    return Column(
      children: [
        const UpdateBanner(),
        // Barra de Busca Pill-Style
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: InkWell(
            onTap: onSearchTap,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(Icons.circle_outlined, color: colorScheme.primary, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    context.translate('search_ai_hint'),
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Filtros (Visibilidade controlada pelo SettingsViewModel)
        if (settingsViewModel.showChatFilters)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _FilterChip(label: context.translate('filter_all'), isSelected: true),
                const SizedBox(width: 8),
                _FilterChip(label: context.translate('filter_unread')),
                const SizedBox(width: 8),
                _FilterChip(label: context.translate('filter_groups')),
              ],
            ),
          ),

        Expanded(
          child: StreamBuilder<List<ChatEntity>>(
            stream: chatViewModel.chats,
            builder: (context, snapshot) {
              final chats = snapshot.data ?? [];
              final isWaiting = snapshot.connectionState == ConnectionState.waiting;

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildContent(context, chats, isWaiting, colorScheme),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, List<ChatEntity> chats, bool isWaiting, ColorScheme colorScheme) {
    // Enquanto espera a primeira resposta do banco, fica vazio para não piscar
    if (isWaiting && chats.isEmpty) {
      return const SizedBox.shrink();
    }

    // Se o banco respondeu e está vazio, mostra a mensagem com animação
    if (chats.isEmpty) {
      return Center(
        key: const ValueKey('empty_state'),
        child: Text(
          context.translate('no_chats'),
          style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4)),
        ),
      );
    }

    // Se houver chats, mostra a lista
    return ListView.builder(
      key: const ValueKey('chat_list'),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return _ChatTile(chat: chats[index]);
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _FilterChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primaryContainer : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final ChatEntity chat;
  const _ChatTile({required this.chat});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final time = chat.lastMessageTimestamp != null 
      ? TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(chat.lastMessageTimestamp!)).format(context)
      : '';

    return ListTile(
      onTap: () => context.push('/chat/${chat.id}'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: SigmaAvatar(
        avatarUrl: chat.avatarUrl,
        name: chat.title,
        radius: 28,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              chat.title ?? context.translate('no_name'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            time, 
            style: TextStyle(
              fontSize: 12, 
              color: chat.unreadCount > 0 ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.5),
              fontWeight: chat.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                chat.lastMessage ?? context.translate('no_messages'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14, 
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
            if (chat.unreadCount > 0)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${chat.unreadCount}',
                  style: const TextStyle(
                    color: Colors.white, 
                    fontSize: 11, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
