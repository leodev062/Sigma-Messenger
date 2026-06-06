import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'package:provider/provider.dart';

/// MessageDetailsScreen - Réplica da tela de logs do Signal.
class MessageDetailsScreen extends StatelessWidget {
  final String messageId;

  const MessageDetailsScreen({super.key, required this.messageId});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ChatViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('message_info')),
      ),
      body: FutureBuilder<MessageDetailsData?>(
        future: viewModel.getMessageDetails(messageId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final data = snapshot.data;
          if (data == null) return Center(child: Text(context.translate('message_not_found')));

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Preview simplificado
              _buildMessagePreview(data.message, colorScheme),
              const SizedBox(height: 32),
              
              Text(
                context.translate('delivery_status'),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              
              _buildStatusTile(context, Icons.send_outlined, context.translate('status_sent'), data.statusTimestamps[MessageStatusEntity.sent]),
              _buildStatusTile(context, Icons.done_all, context.translate('status_delivered'), data.statusTimestamps[MessageStatusEntity.delivered]),
              _buildStatusTile(context, Icons.done_all, context.translate('status_read'), data.statusTimestamps[MessageStatusEntity.read], isRead: true),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessagePreview(MessageEntity message, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        message.textContent,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildStatusTile(BuildContext context, IconData icon, String label, int? timestamp, {bool isRead = false}) {
    final timeStr = timestamp != null 
        ? DateFormat('HH:mm:ss - dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp))
        : context.translate('status_pending');

    return ListTile(
      leading: Icon(icon, color: isRead ? Colors.blue : null),
      title: Text(label),
      subtitle: Text(timeStr),
      contentPadding: EdgeInsets.zero,
    );
  }
}
