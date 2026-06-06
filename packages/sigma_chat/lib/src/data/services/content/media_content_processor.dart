import 'dart:convert';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class MediaContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  MediaContentProcessor(this._chatRepository);

  @override
  bool canProcess(sigmapb.Content payload) => 
      payload.hasDataMessage() && payload.dataMessage.hasAttachment();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Content payload,
    required int timestamp,
  }) async {
    final dataMsg = payload.dataMessage;
    final attachment = dataMsg.attachment;
    
    // Determina o tipo de mídia baseado na extensão ou metadados
    MessageTypeEntity type = MessageTypeEntity.image;
    if (attachment.fileName.endsWith(".mp4")) type = MessageTypeEntity.video;
    if (attachment.fileName.endsWith(".mp3")) type = MessageTypeEntity.audio;

    final message = MessageEntity(
      id: messageId,
      threadId: 0,
      chatId: senderId,
      senderRecipientId: senderId,
      textContent: dataMsg.body,
      type: type,
      timestamp: timestamp,
      status: MessageStatusEntity.read,
      isFromMe: false,
      attachmentUrl: attachment.id,
      attachmentAesKey: base64Encode(attachment.key),
      attachmentIv: base64Encode(attachment.iv),
      attachmentMacKey: base64Encode(attachment.digest),
    );

    await _chatRepository.saveMessageAndMetadata(message);
  }
}
