import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class MediaContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  MediaContentProcessor(this._chatRepository);

  @override
  bool canProcess(Message payload) => 
      payload.hasDataMessage() && payload.dataMessage.hasAttachment();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required Message payload,
    required int timestamp,
  }) async {
    final attachment = payload.dataMessage.attachment;
    
    // In the unified proto, we just have AttachmentPointer.
    // We need to infer the type from fileName or handle it generically as 'file'.
    MessageTypeEntity type = MessageTypeEntity.file;
    final fileName = attachment.fileName.toLowerCase();
    
    if (fileName.endsWith('.jpg') || fileName.endsWith('.png') || fileName.endsWith('.jpeg')) {
      type = MessageTypeEntity.image;
    } else if (fileName.endsWith('.mp4') || fileName.endsWith('.mov')) {
      type = MessageTypeEntity.video;
    } else if (fileName.endsWith('.mp3') || fileName.endsWith('.aac') || fileName.endsWith('.m4a')) {
      type = MessageTypeEntity.audio;
    }

    final message = MessageEntity(
      id: messageId,
      conversationId: senderId,
      senderId: senderId,
      textContent: attachment.fileName,
      type: type,
      timestamp: timestamp,
      status: MessageStatusEntity.delivered,
      url: attachment.id, // Using attachment ID as URL/pointer
    );

    await _chatRepository.saveMessageAndMetadata(message);
  }
}
