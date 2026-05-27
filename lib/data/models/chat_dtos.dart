import 'package:sigma/core/storage/database.dart' as drift;

class ChatDto {
  final String id;
  final String? title;
  final String type; // String representation from API or index from Drift
  final String? lastMessage;
  final int? lastMessageTimestamp;
  final String? contactId;
  final int unreadCount;
  final bool isVerified;
  final bool isPinned;
  final bool isArchived;

  ChatDto({
    required this.id,
    this.title,
    required this.type,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.contactId,
    this.unreadCount = 0,
    this.isVerified = false,
    this.isPinned = false,
    this.isArchived = false,
  });

  factory ChatDto.fromDrift(drift.Chat chat) {
    return ChatDto(
      id: chat.id,
      title: chat.title,
      type: chat.type.name,
      lastMessage: chat.lastMessage,
      lastMessageTimestamp: chat.lastMessageTimestamp,
      contactId: chat.contactId,
      unreadCount: chat.unreadCount,
      isVerified: chat.isVerified,
      isPinned: chat.isPinned,
      isArchived: chat.isArchived,
    );
  }
}

class MessageDto {
  final String id;
  final String chatId;
  final String senderId;
  final String textContent;
  final String type;
  
  // E2EE Attachment Data
  final String? attachmentId;
  final String? attachmentAesKey;
  final String? attachmentIv;
  final String? attachmentDigest;
  
  final int timestamp;
  final String status;
  final bool isFromMe;

  MessageDto({
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

  factory MessageDto.fromDrift(drift.Message msg) {
    return MessageDto(
      id: msg.id,
      chatId: msg.chatId,
      senderId: msg.senderId,
      textContent: msg.textContent,
      type: msg.type.name,
      attachmentId: msg.attachmentUrl, // Drift ainda usa attachmentUrl para o ID
      attachmentAesKey: msg.attachmentAesKey,
      attachmentIv: msg.attachmentIv, // Drift campo novo
      attachmentDigest: msg.attachmentMacKey, // Drift ainda usa attachmentMacKey para o Digest
      timestamp: msg.timestamp,
      status: msg.status.name,
      isFromMe: msg.isFromMe,
    );
  }
}
