import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class ReplyContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  ReplyContentProcessor(this._chatRepository);

  @override
  bool canProcess(sigmapb.Message payload) => payload.hasReply();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Message payload,
    required int timestamp,
  }) async {
    final reply = payload.reply;
    
    final message = MessageEntity(
      id: messageId,
      conversationId: senderId,
      senderId: senderId,
      textContent: reply.previewText, 
      type: MessageTypeEntity.reply,
      timestamp: timestamp,
      status: MessageStatusEntity.delivered,
      relatedMessageId: reply.messageId,
    );

    await _chatRepository.saveMessageAndMetadata(message);
  }
}
