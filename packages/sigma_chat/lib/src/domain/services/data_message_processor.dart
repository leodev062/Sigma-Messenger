import 'package:sigma_core/sigma_core.dart';
import '../i_chat_repository.dart';

/// DataMessageProcessor - O "Cérebro" de processamento de entrada (Estilo Signal Android).
/// Responsável por interpretar payloads recebidos e coordenar as ações no domínio.
class DataMessageProcessor with Loggable {
  final IChatRepository _chatRepository;

  DataMessageProcessor(this._chatRepository);

  /// Ponto de entrada para qualquer dado recebido via Push ou Socket.
  Future<void> process(Message payload, Map<String, dynamic> metadata) async {
    if (payload.hasReaction()) {
      await _handleReaction(payload.reaction, metadata['senderId']);
    } else {
      await _handleMessage(payload, metadata);
    }
  }

  Future<void> _handleReaction(ReactionContent reaction, String senderId) async {
    logI("Processando reação: ${reaction.emoji} de $senderId");

    final targetMessage = await _chatRepository.getMessage(reaction.messageId);

    if (targetMessage != null) {
      await _chatRepository.addReaction(targetMessage.id, senderId, reaction.emoji);
    } else {
      logW("Mensagem alvo não encontrada para a reação.");
    }
  }

  Future<void> _handleMessage(Message payload, Map<String, dynamic> metadata) async {
    MessageTypeEntity type = MessageTypeEntity.text;
    if (payload.hasImage()) type = MessageTypeEntity.image;
    if (payload.hasVideo()) type = MessageTypeEntity.video;
    if (payload.hasAudio()) type = MessageTypeEntity.audio;
    if (payload.hasPoll()) type = MessageTypeEntity.poll;

    final message = MessageEntity(
      id: payload.messageId.isNotEmpty ? payload.messageId : metadata['id'],
      conversationId: payload.conversationId.isNotEmpty ? payload.conversationId : metadata['chatId'],
      senderId: payload.senderId.isNotEmpty ? payload.senderId : metadata['senderId'],
      textContent: payload.hasText() ? payload.text.text : "",
      timestamp: payload.timestamp > 0 ? payload.timestamp.toInt() : metadata['timestamp'],
      status: MessageStatusEntity.delivered,
      type: type,
    );

    logI("Salvando nova mensagem recebida: ${message.id}");
    await _chatRepository.saveMessageAndMetadata(message);
  }
}
