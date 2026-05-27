import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma/features/chat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:sigma/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:sigma/features/updater/update_viewmodel.dart';
import 'package:sigma/core/i18n/strings.dart';
import 'package:sigma/core/widgets/sigma_avatar.dart';

// Novas Views separadas seguindo Clean Architecture
import 'package:sigma/features/chat/presentation/widgets/conversations_view.dart';
import 'package:sigma/features/contacts/presentation/pages/contacts_view.dart';
import 'package:sigma/features/settings/presentation/pages/settings_view.dart';
import 'package:sigma/features/profile/presentation/pages/profile_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UpdateViewModel>().check();
    });
  }

  void _onSearchTap() {
    showSearch(
      context: context,
      delegate: ContactSearchDelegate(context.read<ChatViewModel>()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = context.watch<ChatViewModel>();
    final homeViewModel = context.watch<HomeViewModel>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          homeViewModel.getTitle(context),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.normal,
            fontSize: 22,
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          // Ícone de câmera visível apenas na aba de Chats (index 0)
          if (homeViewModel.selectedIndex == 0)
            IconButton(
              icon: Icon(Icons.camera_alt_outlined, color: colorScheme.onSurface),
              onPressed: () {},
            ),
          
          // Menu de 3 pontinhos com opções
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
            onSelected: (value) {
              if (value == 'settings') {
                homeViewModel.setSelectedIndex(2); // Muda para aba de configurações
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'new_group',
                child: Text(context.translate('new_group')),
              ),
              const PopupMenuItem(
                value: 'new_broadcast',
                child: Text('New broadcast'),
              ),
              const PopupMenuItem(
                value: 'linked_devices',
                child: Text('Linked devices'),
              ),
              const PopupMenuItem(
                value: 'starred_messages',
                child: Text('Starred messages'),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Text(context.translate('settings')),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: homeViewModel.selectedIndex,
        children: [
          ConversationsView(
            chatViewModel: chatViewModel,
            onSearchTap: _onSearchTap,
          ),
          const ContactsView(),
          const SettingsView(),
          const ProfileView(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: homeViewModel.selectedIndex,
        onDestinationSelected: (index) => homeViewModel.setSelectedIndex(index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.chat_bubble_outline),
            selectedIcon: const Icon(Icons.chat_bubble),
            label: context.translate('chats'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.contacts_outlined),
            selectedIcon: const Icon(Icons.contacts),
            label: context.translate('contacts'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: context.translate('settings'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: context.translate('profile'),
          ),
        ],
      ),
      floatingActionButton: homeViewModel.selectedIndex == 0 
        ? FloatingActionButton(
            onPressed: () {}, // Sem função por enquanto
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.add_comment_rounded),
          )
        : null,
    );
  }
}

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
        if (chatViewModel.isSearching) {
          return const Center(child: CircularProgressIndicator());
        }

        final results = chatViewModel.searchResults;
        final colorScheme = Theme.of(context).colorScheme;

        if (results.isEmpty) {
          return Center(
            child: Text(
              query.isEmpty ? context.translate('search_hint') : context.translate('no_contacts'),
              style: TextStyle(color: colorScheme.onSurface.withOpacity(0.4)),
            ),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final user = results[index];
            return ListTile(
              leading: SigmaAvatar(
                avatarUrl: user.avatarUrl,
                name: user.name ?? user.username,
                radius: 20,
              ),
              title: Text(user.name ?? user.username ?? 'No name', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(user.phone),
              onTap: () async {
                await chatViewModel.openChatWithUser(user);
                if (context.mounted) {
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
