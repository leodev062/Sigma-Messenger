import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:sigma_database/sigma_database.dart' as drift;
import 'package:sigma_core/src/domain/entities/message_entity.dart';
import 'package:sigma_core/src/domain/entities/recipient.dart';
import 'package:sigma_core/src/domain/entities/thread_entity.dart';
import 'package:sigma_core/src/domain/entities/reaction_entity.dart';
import 'package:sigma_core/src/data/models/user_response.dart' as api;

/// ModelMapper - Centraliza as conversões entre camadas (API -> Domain, Drift -> Domain).
/// Refatorado para o Padrão Signal-Android (Snapshot & Precedência).
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

  static ThreadEntity threadFromDrift(drift.ThreadRecord record) {
    return ThreadEntity(
      id: record.thread.id,
      recipient: recipientFromDrift(record.recipient),
      snippet: record.thread.snippet,
      date: record.thread.date,
      unreadCount: record.thread.unreadCount,
      isArchived: record.thread.isArchived,
      pinnedOrder: record.thread.pinnedOrder,
    );
  }

  static Recipient recipientFromDrift(drift.RecipientData data) {
    return Recipient(
      id: data.id,
      aci: data.aci,
      pni: data.pni,
      type: data.type.toDomain(),
      phone: data.phone,
      username: data.username,
      systemDisplayName: data.systemDisplayName,
      profileName: data.profileName,
      avatarUrl: data.avatarUrl,
      bio: data.bio,
      isOnline: data.isOnline,
      lastSeen: data.lastSeen,
      fallbackColor: _parseColor(data.fallbackColor),
    );
  }

  static ReactionEntity reactionFromDrift(drift.Reaction data) {
    return ReactionEntity(
      authorId: data.authorId,
      emoji: data.emoji,
      dateSent: data.dateSent,
      dateReceived: data.dateReceived,
    );
  }

  static MessageEntity messageFromDrift(drift.Message data, [List<drift.Reaction> reactions = const []]) {
    return MessageEntity(
      id: data.id,
      threadId: data.threadId,
      chatId: data.chatId,
      senderRecipientId: data.senderRecipientId,
      textContent: data.textContent,
      type: data.type.toDomain(),
      timestamp: data.timestamp,
      status: data.status.toDomain(),
      isFromMe: data.isFromMe,
      reactions: reactions.map((r) => reactionFromDrift(r)).toList(),
      attachmentUrl: data.attachmentUrl,
      attachmentAesKey: data.attachmentAesKey,
      attachmentIv: data.attachmentIv,
      attachmentMacKey: data.attachmentMacKey,
      latitude: data.latitude,
      longitude: data.longitude,
      pollQuestion: data.pollQuestion,
      pollOptions: data.pollOptions,
      allowMultipleVotes: data.allowMultipleVotes,
    );
  }

  static Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xff')));
    } catch (e) {
      return const Color(0xFF1C6689);
    }
  }
}

/// Extensions para mapeamento bidirecional entre Domain e Data.
extension MessageTypeMapping on MessageTypeEntity {
  drift.MessageTypeDb toDrift() => drift.MessageTypeDb.values.byName(name);
}

extension MessageTypeDbMapping on drift.MessageTypeDb {
  MessageTypeEntity toDomain() => MessageTypeEntity.values.byName(name);
}

extension MessageStatusMapping on MessageStatusEntity {
  drift.MessageStatusDb toDrift() => drift.MessageStatusDb.values.byName(name);
}

extension MessageStatusDbMapping on drift.MessageStatusDb {
  MessageStatusEntity toDomain() => MessageStatusEntity.values.byName(name);
}

extension RecipientTypeMapping on RecipientType {
  drift.RecipientTypeDb toDrift() => drift.RecipientTypeDb.values.byName(name);
}

extension RecipientTypeDbMapping on drift.RecipientTypeDb {
  RecipientType toDomain() => RecipientType.values.byName(name);
}

extension ColorMapping on Color {
  String toHex() => '#${toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
}

extension MessageEntityMapping on MessageEntity {
  drift.MessagesCompanion toCompanion() {
    return drift.MessagesCompanion(
      id: Value(id),
      threadId: Value(threadId),
      chatId: Value(chatId),
      senderRecipientId: Value(senderRecipientId),
      textContent: Value(textContent),
      type: Value(type.toDrift()),
      timestamp: Value(timestamp),
      status: Value(status.toDrift()),
      isFromMe: Value(isFromMe),
      attachmentUrl: Value(attachmentUrl),
      attachmentAesKey: Value(attachmentAesKey),
      attachmentIv: Value(attachmentIv),
      attachmentMacKey: Value(attachmentMacKey),
      latitude: Value(latitude),
      longitude: Value(longitude),
      pollQuestion: Value(pollQuestion),
      pollOptions: Value(pollOptions),
      allowMultipleVotes: Value(allowMultipleVotes),
    );
  }
}

extension RecipientMapping on Recipient {
  drift.RecipientsCompanion toCompanion() {
    return drift.RecipientsCompanion(
      id: Value(id),
      aci: Value(aci),
      pni: Value(pni),
      type: Value(type.toDrift()),
      phone: Value(phone),
      username: Value(username),
      systemDisplayName: Value(systemDisplayName),
      profileName: Value(profileName),
      avatarUrl: Value(avatarUrl),
      bio: Value(bio),
      isOnline: Value(isOnline),
      lastSeen: Value(lastSeen),
      fallbackColor: Value(fallbackColor.toHex()),
    );
  }
}
