import 'package:flutter/material.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'package:sigma_contacts/sigma_contacts.dart';
import 'package:sigma_settings/sigma_settings.dart';
import 'package:sigma_profile/sigma_profile.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_ui/sigma_ui.dart';

enum HomeTab {
  chats,
  updates,
  communities,
  calls;

  Widget get view {
    switch (this) {
      case HomeTab.chats:
        return const ConversationsViewWrapper();
      case HomeTab.updates:
        // Por enquanto usando ContactsView como placeholder para Updates
        return const ContactsView();
      case HomeTab.communities:
        // Por enquanto usando SettingsView como placeholder para Communities
        return const SettingsView();
      case HomeTab.calls:
        // Por enquanto usando ProfileView como placeholder para Calls
        return const ProfileView();
    }
  }

  IconData get icon {
    switch (this) {
      case HomeTab.chats:
        return Icons.chat_bubble_outline;
      case HomeTab.updates:
        return Icons.update_outlined;
      case HomeTab.communities:
        return Icons.group_work_outlined;
      case HomeTab.calls:
        return Icons.call_outlined;
    }
  }

  IconData get selectedIcon {
    switch (this) {
      case HomeTab.chats:
        return Icons.chat_bubble;
      case HomeTab.updates:
        return Icons.update;
      case HomeTab.communities:
        return Icons.group_work;
      case HomeTab.calls:
        return Icons.call;
    }
  }

  String label(BuildContext context) {
    switch (this) {
      case HomeTab.chats:
        return 'Chats';
      case HomeTab.updates:
        return 'Updates';
      case HomeTab.communities:
        return 'Communities';
      case HomeTab.calls:
        return 'Calls';
    }
  }
}

/// Wrapper para ConversationsView para manter o contrato limpo
class ConversationsViewWrapper extends StatelessWidget {
  const ConversationsViewWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ConversationsView(
      chatViewModel: context.watch<ChatViewModel>(),
      onSearchTap: () {
        // Esta lógica deve ser movida para um Navigator ou Service futuramente
        showSearch(
          context: context,
          delegate: ContactSearchDelegate(context.read<ChatViewModel>()),
        );
      },
    );
  }
}

/// Importado do home_screen original para evitar dependência circular imediata
class ContactSearchDelegate extends SearchDelegate {
  final ChatViewModel chatViewModel;

  ContactSearchDelegate(this.chatViewModel);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: theme.colorScheme.surface,
        iconTheme: theme.iconTheme.copyWith(color: theme.colorScheme.onSurface),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          chatViewModel.clearSearch();
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    chatViewModel.search(query);
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 2) {
      chatViewModel.search(query);
    }
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return ListenableBuilder(
      listenable: chatViewModel,
      builder: (context, _) {
        if (chatViewModel.state.isSearching) {
          return const Center(child: CircularProgressIndicator());
        }

        final results = chatViewModel.state.searchResults;
        final colorScheme = Theme.of(context).colorScheme;

        if (results.isEmpty) {
          return Center(
            child: Text(
              query.isEmpty ? context.translate('search_hint') : context.translate('no_contacts'),
              style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4)),
            ),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final user = results[index];
            return ListTile(
              leading: AvatarImageView(
                recipient: user,
                size: 40,
              ),
              title: Text(user.computedDisplayName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(user.phone?.isNotEmpty == true ? user.phone! : (user.username != null ? '@${user.username}' : '')),
              onTap: () async {
                final threadId = await chatViewModel.openChatWithRecipient(user);
                if (context.mounted) {
                  context.push('/chat/$threadId');
                  close(context, null);
                }
              },
            );
          },
        );
      },
    );
  }
}
