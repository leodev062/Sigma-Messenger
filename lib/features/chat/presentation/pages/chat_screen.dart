import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/features/chat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:sigma/core/storage/sigma_store.dart';
import 'package:sigma/core/i18n/strings.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final userId = SigmaStore.instance.account.getUserId();
    if (userId == null) return;

    context.read<ChatViewModel>().sendMessage(widget.chatId, userId, text);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = context.read<ChatViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<UserEntity?>(
          stream: chatViewModel.watchRecipient(widget.chatId),
          builder: (context, snapshot) {
            final user = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.name ?? user?.username ?? context.translate('loading'),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (user?.phone != null)
                  Text(
                    user!.phone,
                    style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.5)),
                  ),
              ],
            );
          },
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageEntity>>(
              stream: chatViewModel.watchMessages(widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data ?? [];

                if (messages.isEmpty) {
                  return Center(
                    child: Text(
                      context.translate('no_messages'),
                      style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.4)),
                    ),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return _MessageBubble(message: message);
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, -2))
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.add, color: Colors.grey), onPressed: () {}),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: context.translate('type_message_hint'),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _sendMessage,
              child: CircleAvatar(
                backgroundColor: colorScheme.primary,
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final MessageEntity message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isMe = message.isFromMe;
    
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: isMe 
                  ? colorScheme.primary 
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isMe ? 16 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 16),
              ),
            ),
            child: Text(
              message.textContent,
              style: TextStyle(
                color: isMe ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(message.timestamp)).format(context),
                  style: TextStyle(fontSize: 10, color: colorScheme.onSurface.withValues(alpha: 0.5)),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  _buildStatusIcon(message.status, colorScheme),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(MessageStatusEntity status, ColorScheme colorScheme) {
    switch (status) {
      case MessageStatusEntity.pending:
        return Icon(Icons.access_time, size: 12, color: colorScheme.onSurface.withValues(alpha: 0.5));
      case MessageStatusEntity.sent:
        return const Icon(Icons.check, size: 12, color: Colors.grey);
      case MessageStatusEntity.delivered:
        return const Icon(Icons.done_all, size: 12, color: Colors.grey);
      case MessageStatusEntity.read:
        return Icon(Icons.done_all, size: 12, color: colorScheme.primary);
    }
  }
}
