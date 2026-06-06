import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_core/sigma_core.dart';
import '../i_chat_repository.dart';

/// DataMessageProcessor - O "Cérebro" de processamento de entrada (Estilo Signal Android).
/// Responsável por interpretar payloads recebidos e coordenar as ações no domínio.
class DataMessageProcessor with Loggable {
  final IChatRepository _chatRepository;

  DataMessageProcessor(this._chatRepository);

  /// Ponto de entrada para qualquer dado recebido via Push ou Socket.
  Future<void> process(sigmapb.Content payload, Map<String, dynamic> metadata) async {
    if (!payload.hasDataMessage()) return;

    final dataMsg = payload.dataMessage;

    if (dataMsg.hasReaction()) {
      await _handleReaction(dataMsg.reaction, metadata['senderId']);
    } else if (dataMsg.body.isNotEmpty || dataMsg.hasAttachment() || dataMsg.hasLocation()) {
      await _handleMessage(payload, metadata);
    }
    // Outros campos como receipts, typing, sync...
  }

  Future<void> _handleReaction(sigmapb.Reaction reaction, String senderId) async {
    logI("Processando reação estilo Signal: ${reaction.emoji} de $senderId");

    // No Signal, a reação é vinculada pela combinação (AutorOriginal + TimestampOriginal)
    final targetMessage = await _chatRepository.getMessageByMetadata(
      authorAci: reaction.targetAuthorAci,
      sentTimestamp: reaction.targetTimestamp.toInt(),
    );

    if (targetMessage != null) {
      if (reaction.remove) {
        await _chatRepository.removeReaction(targetMessage.id, senderId, reaction.emoji);
      } else {
        await _chatRepository.addReaction(targetMessage.id, senderId, reaction.emoji);
      }
    } else {
      logW("Mensagem alvo não encontrada para a reação. Armazenando como pendente...");
    }
  }

  Future<void> _handleMessage(sigmapb.Content payload, Map<String, dynamic> metadata) async {
    final dataMsg = payload.dataMessage;
    
    MessageTypeEntity type = MessageTypeEntity.text;
    if (dataMsg.hasAttachment()) type = MessageTypeEntity.file;
    if (dataMsg.hasLocation()) type = MessageTypeEntity.location;

    final message = MessageEntity(
      id: metadata['id'],
      threadId: metadata['threadId'] ?? 0,
      chatId: metadata['chatId'],
      senderRecipientId: metadata['senderId'],
      textContent: dataMsg.hasLocation() ? (dataMsg.location.address.isNotEmpty ? dataMsg.location.address : "📍 Localização") : dataMsg.body,
      timestamp: metadata['timestamp'],
      isFromMe: false,
      status: MessageStatusEntity.delivered,
      type: type,
      latitude: dataMsg.hasLocation() ? dataMsg.location.latitude : null,
      longitude: dataMsg.hasLocation() ? dataMsg.location.longitude : null,
      reactions: [],
    );

    logI("Salvando nova mensagem recebida: ${message.id}");
    await _chatRepository.saveMessageAndMetadata(message);
  }
}
