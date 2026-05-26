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
  final String? attachmentUrl;
  final String? attachmentAesKey;
  final String? attachmentMacKey;
  final int timestamp;
  final String status;
  final bool isFromMe;

  MessageDto({
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

  factory MessageDto.fromDrift(drift.Message msg) {
    return MessageDto(
      id: msg.id,
      chatId: msg.chatId,
      senderId: msg.senderId,
      textContent: msg.textContent,
      type: msg.type.name,
      attachmentUrl: msg.attachmentUrl,
      attachmentAesKey: msg.attachmentAesKey,
      attachmentMacKey: msg.attachmentMacKey,
      timestamp: msg.timestamp,
      status: msg.status.name,
      isFromMe: msg.isFromMe,
    );
  }
}
