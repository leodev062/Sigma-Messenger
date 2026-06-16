import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class TextContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  TextContentProcessor(this._chatRepository);

  @override
  bool canProcess(Message payload) => 
      payload.hasDataMessage() && payload.dataMessage.body.isNotEmpty;

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required Message payload,
    required int timestamp,
  }) async {
    final message = MessageEntity(
      id: messageId,
      conversationId: senderId,
      senderId: senderId,
      textContent: payload.dataMessage.body,
      type: MessageTypeEntity.text,
      timestamp: timestamp,
      status: MessageStatusEntity.delivered,
    );

    await _chatRepository.saveMessageAndMetadata(message);
  }
}
