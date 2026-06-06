import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma_core/sigma_core.dart';
import '../viewmodels/chat_viewmodel.dart';
import '../widgets/thread_tile.dart';

class ArchivedChatsScreen extends StatelessWidget {
  const ArchivedChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatViewModel = context.watch<ChatViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('archived')),
      ),
      body: StreamBuilder<List<ThreadEntity>>(
        stream: chatViewModel.archivedThreads,
        builder: (context, snapshot) {
          final threads = snapshot.data ?? [];
          
          if (snapshot.connectionState == ConnectionState.waiting && threads.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (threads.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.archive_outlined, size: 64, color: colorScheme.onSurface.withValues(alpha: 0.2)),
                  const SizedBox(height: 16),
                  Text(
                    context.translate('no_archived_chats'),
                    style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4)),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: threads.length,
            itemBuilder: (context, index) {
              return ThreadDismissibleTile(
                thread: threads[index], 
                chatViewModel: chatViewModel,
                isArchivedView: true,
              );
            },
          );
        },
      ),
    );
  }
}
