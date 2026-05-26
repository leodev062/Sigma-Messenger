enum ChatTypeEntity { user, group, channel, bot }

class ChatEntity {
  final String id;
  final String? title;
  final ChatTypeEntity type;
  final String? lastMessage;
  final int? lastMessageTimestamp;
  final String? contactId;

  ChatEntity({
    required this.id,
    this.title,
    required this.type,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.contactId,
  });
}
