import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sigma/core/network/socket_manager.dart';
import 'package:sigma/domain/entities/chat_entity.dart';
import 'package:sigma/features/chat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:sigma/features/updater/update_banner.dart';
import 'package:sigma/features/updater/update_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Padrão Signal: Verifica atualizações ao abrir a Home
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UpdateViewModel>().check();
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = context.watch<ChatViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Consumer<SocketManager>(
          builder: (context, socketManager, child) {
            switch (socketManager.status) {
              case SocketStatus.connecting:
                return const Text('Conectando...', style: TextStyle(fontSize: 18));
              case SocketStatus.disconnected:
                return const Text('Desconectado', style: TextStyle(fontSize: 18, color: Colors.grey));
              case SocketStatus.connected:
                return const Text('Sigma', style: TextStyle(fontWeight: FontWeight.bold));
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: ContactSearchDelegate(chatViewModel),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          // Banner de Atualização Segura (Signal-Style)
          const UpdateBanner(),
          
          Expanded(
            child: StreamBuilder<List<ChatEntity>>(
              stream: chatViewModel.chats,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final chats = snapshot.data ?? [];

                if (chats.isEmpty) {
                  return const Center(
                    child: Text('Nenhuma conversa ainda.', style: TextStyle(color: Colors.grey)),
                  );
                }

                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return _ChatTile(chat: chat);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: ContactSearchDelegate(chatViewModel),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.message),
      ),
    );
  }
}

class ContactSearchDelegate extends SearchDelegate {
  final ChatViewModel chatViewModel;

  ContactSearchDelegate(this.chatViewModel);

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

        if (results.isEmpty) {
          return Center(
            child: Text(
              query.isEmpty ? 'Procure por utilizadores...' : 'Nenhum utilizador encontrado.',
              style: const TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final user = results[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(user.name?[0] ?? user.username?[0] ?? '?'),
              ),
              title: Text(user.name ?? user.username ?? 'Sem nome'),
              subtitle: Text(user.phone),
              onTap: () async {
                // Ao clicar, fecha a busca, garante que o chat existe e abre o chat
                final chatId = await chatViewModel.openChatWithUser(user);
                if (context.mounted) {
                  close(context, null);
                  context.push('/chat/$chatId');
                }
              },
            );
          },
        );
      },
    );
  }
}

class _ChatTile extends StatelessWidget {
  final ChatEntity chat;
  const _ChatTile({required this.chat});

  @override
  Widget build(BuildContext context) {
    final time = chat.lastMessageTimestamp != null 
      ? TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(chat.lastMessageTimestamp!)).format(context)
      : '';

    return ListTile(
      onTap: () => context.push('/chat/${chat.id}'),
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Text(
          (chat.title?.isNotEmpty == true) ? chat.title![0].toUpperCase() : '?',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        chat.title ?? 'Sem nome',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        chat.lastMessage ?? 'Nenhuma mensagem',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          if (chat.unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${chat.unreadCount}',
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
