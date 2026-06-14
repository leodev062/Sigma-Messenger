import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:sigma_database/sigma_database.dart' as drift;
import 'package:sigma_core/src/domain/entities/message_entity.dart';
import 'package:sigma_core/src/domain/entities/recipient.dart';
import 'package:sigma_core/src/domain/entities/thread_entity.dart';
import 'package:sigma_core/src/domain/entities/reaction_entity.dart';
import 'package:sigma_core/src/data/models/user_response.dart' as api;

/// ModelMapper - Centraliza as conversões entre camadas (API -> Domain, Drift -> Domain).
class ModelMapper {
  static Recipient recipientFromDto(api.UserDto dto) {
    return Recipient(
      id: dto.id,
      aci: dto.id,
      type: RecipientType.individual,
      phone: dto.phone,
      username: dto.username,
      profileName: dto.name,
      avatarUrl: dto.avatarUrl,
      bio: dto.bio,
      verificationType: dto.isVerified ? 'verified' : 'none',
    );
  }

  static ThreadEntity threadFromDrift(drift.Conversation data, [drift.User? recipientData]) {
    return ThreadEntity(
      id: data.id,
      recipient: recipientData != null 
          ? recipientFromDrift(recipientData) 
          : Recipient.createUnknown(data.id),
      snippet: data.lastMessageId, // Snippet could be more complex
      date: data.updatedAt ?? 0,
      unreadCount: data.unreadCount,
      isArchived: data.isArchived,
      isMuted: data.isMuted,
      pinnedOrder: data.isPinned ? 1 : 0,
    );
  }

  static Recipient recipientFromDrift(drift.User data) {
    return Recipient(
      id: data.id,
      type: data.isBot ? RecipientType.bot : RecipientType.individual,
      username: data.username,
      profileName: data.name,
      avatarUrl: data.avatarUrl,
      bio: data.bio,
    );
  }

  static ReactionEntity reactionFromDrift(drift.Reaction data) {
    return ReactionEntity(
      authorId: data.userId ?? "unknown",
      emoji: data.emoji ?? "",
      dateSent: data.createdAt ?? 0,
      dateReceived: data.createdAt ?? 0,
    );
  }

  static MessageEntity messageFromDrift(drift.Message data, [List<drift.Reaction> reactions = const []]) {
    return MessageEntity(
      id: data.id,
      conversationId: data.conversationId ?? "",
      senderId: data.senderId ?? "",
      textContent: data.content ?? "",
      type: (data.type ?? "text").toMessageTypeEntity(),
      timestamp: data.createdAt ?? 0,
      updatedAt: data.updatedAt ?? (data.createdAt ?? 0),
      status: (data.status ?? "pending").toMessageStatusEntity(),
      reactions: reactions.map((r) => reactionFromDrift(r)).toList(),
      relatedMessageId: data.replyToMessageId,
    );
  }
}

extension StringToMessageType on String {
  MessageTypeEntity toMessageTypeEntity() {
    switch (toLowerCase()) {
      case 'text': return MessageTypeEntity.text;
      case 'image': return MessageTypeEntity.image;
      case 'video': return MessageTypeEntity.video;
      case 'audio': return MessageTypeEntity.audio;
      case 'poll': return MessageTypeEntity.poll;
      case 'reply': return MessageTypeEntity.reply;
      case 'reaction': return MessageTypeEntity.reaction;
      case 'location': return MessageTypeEntity.location;
      default: return MessageTypeEntity.text;
    }
  }
}

extension StringToMessageStatus on String {
  MessageStatusEntity toMessageStatusEntity() {
    switch (toLowerCase()) {
      case 'pending': return MessageStatusEntity.pending;
      case 'sent': return MessageStatusEntity.sent;
      case 'delivered': return MessageStatusEntity.delivered;
      case 'read': return MessageStatusEntity.read;
      case 'failed': return MessageStatusEntity.failed;
      default: return MessageStatusEntity.pending;
    }
  }
}

extension MessageTypeMapping on MessageTypeEntity {
  String toDrift() => name.toUpperCase();
}

extension MessageStatusMapping on MessageStatusEntity {
  String toDrift() => name.toUpperCase();
}

extension MessageEntityMapping on MessageEntity {
  drift.MessagesCompanion toCompanion() {
    return drift.MessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      senderId: Value(senderId),
      content: Value(textContent),
      type: Value(type.toDrift()),
      createdAt: Value(timestamp),
      status: Value(status.toDrift()),
      updatedAt: Value(updatedAt),
      replyToMessageId: Value(relatedMessageId),
    );
  }
}

extension RecipientMapping on Recipient {
  drift.UsersCompanion toCompanion() {
    return drift.UsersCompanion(
      id: Value(id),
      name: Value(profileName),
      username: Value(username),
      email: Value(email),
      bio: Value(bio),
      avatarUrl: Value(avatarUrl),
      isBot: Value(type == RecipientType.bot),
    );
  }
}
