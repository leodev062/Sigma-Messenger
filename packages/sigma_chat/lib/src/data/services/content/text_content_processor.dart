import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

class TextContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  TextContentProcessor(this._chatRepository);

  @override
  bool canProcess(sigmapb.Content payload) => 
      payload.hasDataMessage() && 
      payload.dataMessage.body.isNotEmpty && 
      !payload.dataMessage.hasAttachment();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Content payload,
    required int timestamp,
  }) async {
    final message = MessageEntity(
      id: messageId,
      threadId: 0,
      chatId: senderId,
      senderRecipientId: senderId,
      textContent: payload.dataMessage.body,
      type: MessageTypeEntity.text,
      timestamp: timestamp,
      status: MessageStatusEntity.read,
      isFromMe: false,
    );

    await _chatRepository.saveMessageAndMetadata(message);
  }
}
