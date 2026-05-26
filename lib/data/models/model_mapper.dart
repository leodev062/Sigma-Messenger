import 'package:sigma/core/storage/database.dart' as drift;
import 'package:sigma/data/models/chat_dtos.dart';
import 'package:sigma/domain/entities/chat_entity.dart';
import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/data/models/user_response.dart' as dto;

class ModelMapper {
  // DTO to Entity (Data -> Domain)
  static ChatEntity chatFromDto(ChatDto dto) {
    return ChatEntity(
      id: dto.id,
      title: dto.title,
      type: _mapChatType(dto.type),
      lastMessage: dto.lastMessage,
      lastMessageTimestamp: dto.lastMessageTimestamp,
      recipientId: dto.contactId,
      unreadCount: dto.unreadCount,
      isVerified: dto.isVerified,
      isPinned: dto.isPinned,
      isArchived: dto.isArchived,
    );
  }

  static MessageEntity messageFromDto(MessageDto dto) {
    return MessageEntity(
      id: dto.id,
      chatId: dto.chatId,
      senderId: dto.senderId,
      textContent: dto.textContent,
      type: _mapMessageType(dto.type),
      attachmentUrl: dto.attachmentUrl,
      attachmentAesKey: dto.attachmentAesKey,
      attachmentMacKey: dto.attachmentMacKey,
      timestamp: dto.timestamp,
      status: _mapMessageStatus(dto.status),
      isFromMe: dto.isFromMe,
    );
  }

  static UserEntity userFromDto(dto.UserDto user) {
    return UserEntity(
      id: user.id,
      name: user.name,
      username: user.username,
      phone: user.phone,
      avatarUrl: user.avatar_url,
      isVerified: user.isVerified,
    );
  }

  // Drift to Entity (Alternative if needed, but guideline says Repos convert DTOs)
  static UserEntity userFromDrift(drift.User user) {
    return UserEntity(
      id: user.id,
      name: user.name,
      username: user.username,
      phone: user.phone,
      avatarUrl: user.avatarUrl,
      isVerified: false,
    );
  }

  // Helpers
  static ChatTypeEntity _mapChatType(String typeName) {
    return ChatTypeEntity.values.firstWhere(
      (e) => e.name == typeName,
      orElse: () => ChatTypeEntity.user,
    );
  }

  static MessageTypeEntity _mapMessageType(String typeName) {
    return MessageTypeEntity.values.firstWhere(
      (e) => e.name == typeName,
      orElse: () => MessageTypeEntity.text,
    );
  }

  static MessageStatusEntity _mapMessageStatus(String statusName) {
    return MessageStatusEntity.values.firstWhere(
      (e) => e.name == statusName,
      orElse: () => MessageStatusEntity.pending,
    );
  }
}
