import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

class TextContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  TextContentProcessor(this._chatRepository);

  @override
  bool canProcess(sigmapb.Message payload) => payload.hasText();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Message payload,
    required int timestamp,
  }) async {
    final message = MessageEntity(
      id: messageId,
      conversationId: senderId,
      senderId: senderId,
      textContent: payload.text.text,
      type: MessageTypeEntity.text,
      timestamp: timestamp,
      status: MessageStatusEntity.delivered,
    );

    await _chatRepository.saveMessageAndMetadata(message);
  }
}
