import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sigma_core/sigma_core.dart';
import '../viewmodels/chat_viewmodel.dart';
import 'package:sigma_settings/sigma_settings.dart';
import 'thread_tile.dart';

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
        _buildSearchBar(context, colorScheme),
        
        if (settingsViewModel.showChatFilters)
          _buildFilters(context, colorScheme),

        Expanded(
          child: StreamBuilder<List<ThreadEntity>>(
            stream: chatViewModel.threads,
            builder: (context, snapshot) {
              final threads = snapshot.data ?? [];
              return StreamBuilder<List<ThreadEntity>>(
                stream: chatViewModel.archivedThreads,
                builder: (context, archivedSnapshot) {
                  final archivedThreads = archivedSnapshot.data ?? [];
                  final hasArchived = archivedThreads.isNotEmpty;
                  final isWaiting = snapshot.connectionState == ConnectionState.waiting;

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildContent(context, threads, hasArchived, isWaiting, colorScheme),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, ColorScheme colorScheme) {
    return Padding(
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
    );
  }

  Widget _buildFilters(BuildContext context, ColorScheme colorScheme) {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildContent(BuildContext context, List<ThreadEntity> threads, bool hasArchived, bool isWaiting, ColorScheme colorScheme) {
    if (isWaiting && threads.isEmpty && !hasArchived) {
      return const SizedBox.shrink();
    }

    if (threads.isEmpty && !hasArchived) {
      return Center(
        key: const ValueKey('empty_state'),
        child: Text(
          context.translate('no_chats'),
          style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4)),
        ),
      );
    }

    return ListView.builder(
      key: const ValueKey('chat_list'),
      itemCount: threads.length + (hasArchived ? 1 : 0),
      itemBuilder: (context, index) {
        if (hasArchived && index == 0) {
          return _buildArchivedHeader(context);
        }
        
        final thread = threads[hasArchived ? index - 1 : index];
        return ThreadDismissibleTile(
          thread: thread, 
          chatViewModel: chatViewModel,
        );
      },
    );
  }

  Widget _buildArchivedHeader(BuildContext context) {
    return ListTile(
      leading: const SizedBox(
        width: 56,
        child: Center(child: Icon(Icons.archive_outlined, size: 24, color: Colors.grey)),
      ),
      title: Text(
        context.translate('archived'),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () => context.push('/archived'),
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
