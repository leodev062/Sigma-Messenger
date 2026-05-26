enum MessageTypeEntity { text, image, video, audio, file }
enum MessageStatusEntity { pending, sent, delivered, read }

class MessageEntity {
  final String id;
  final String chatId;
  final String senderId;
  final String textContent;
  final MessageTypeEntity type;
  final String? attachmentUrl;
  final String? attachmentAesKey;
  final String? attachmentMacKey;
  final int timestamp;
  final MessageStatusEntity status;
  final bool isFromMe;

  MessageEntity({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.textContent,
    required this.type,
    this.attachmentUrl,
    this.attachmentAesKey,
    this.attachmentMacKey,
    required this.timestamp,
    required this.status,
    required this.isFromMe,
  });
}
