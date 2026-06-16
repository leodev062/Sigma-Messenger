import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class ReplyContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  ReplyContentProcessor(this._chatRepository);

  @override
  bool canProcess(Message payload) => 
      payload.hasDataMessage() && payload.dataMessage.body.isNotEmpty && 
      payload.dataMessage.reaction.targetAuthorAci.isNotEmpty; // Signal uses reaction for reply metadata sometimes

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required Message payload,
    required int timestamp,
  }) async {
    final data = payload.dataMessage;
    
    // In the unified proto, we don't have a specific Reply message,
    // so we use DataMessage body + Reaction metadata to link messages.
    
    final targetMessage = await _chatRepository.getMessageByMetadata(
      authorAci: data.reaction.targetAuthorAci,
      sentTimestamp: data.reaction.targetTimestamp.toInt(),
    );

    final message = MessageEntity(
      id: messageId,
      conversationId: senderId,
      senderId: senderId,
      textContent: data.body, 
      type: MessageTypeEntity.reply,
      timestamp: timestamp,
      status: MessageStatusEntity.delivered,
      relatedMessageId: targetMessage?.id,
    );

    await _chatRepository.saveMessageAndMetadata(message);
  }
}
