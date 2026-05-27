enum MessageTypeEntity { text, image, video, audio, file }
enum MessageStatusEntity { pending, sent, delivered, read }

class MessageEntity {
  final String id;
  final String chatId;
  final String senderId;
  final String textContent;
  final MessageTypeEntity type;
  
  // E2EE Attachment Pointer Data
  final String? attachmentId;
  final String? attachmentAesKey;
  final String? attachmentIv;
  final String? attachmentDigest;
  
  final int timestamp;
  final MessageStatusEntity status;
  final bool isFromMe;

  MessageEntity({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.textContent,
    required this.type,
    this.attachmentId,
    this.attachmentAesKey,
    this.attachmentIv,
    this.attachmentDigest,
    required this.timestamp,
    required this.status,
    required this.isFromMe,
  });
}
