enum ChatTypeEntity { user, group, channel, bot }

class ChatEntity {
  final String id;
  final String? title;
  final String? avatarUrl;
  final ChatTypeEntity type;
  final String? lastMessage;
  final int? lastMessageTimestamp;
  final String? recipientId;
  final int unreadCount;
  final bool isVerified;
  final bool isPinned;
  final bool isArchived;

  ChatEntity({
    required this.id,
    this.title,
    this.avatarUrl,
    required this.type,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.recipientId,
    this.unreadCount = 0,
    this.isVerified = false,
    this.isPinned = false,
    this.isArchived = false,
  });
}
