import 'dart:async';
import 'package:drift/drift.dart';
import 'package:sigma/core/storage/database.dart' as drift;
import 'package:sigma/data/datasources/chat/chat_local_data_source.dart';
import 'package:sigma/data/models/model_mapper.dart';
import 'package:sigma/domain/entities/chat_entity.dart';
import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';

/// Implementação do Repositório de Chat focada APENAS em persistência local.
/// Segue o SRP ao delegar lógica de rede e criptografia para serviços específicos.
class ChatRepositoryImpl implements IChatRepository {
  final ChatLocalDataSource _localDataSource;

  ChatRepositoryImpl(this._localDataSource);

  @override
  Stream<List<ChatEntity>> watchChats() {
    return _localDataSource.watchChats().map(
      (dtos) => dtos.map((dto) => ModelMapper.chatFromDto(dto)).toList(),
    );
  }

  @override
  Stream<List<MessageEntity>> watchMessages(String chatId) {
    return _localDataSource.watchMessages(chatId).map(
      (dtos) => dtos.map((dto) => ModelMapper.messageFromDto(dto)).toList(),
    );
  }

  @override
  Future<MessageEntity?> getMessage(String id) async {
    final dto = await _localDataSource.getMessage(id);
    return dto != null ? ModelMapper.messageFromDto(dto) : null;
  }

  @override
  Future<void> saveMessage({
    required String id,
    required String chatId,
    required String senderId,
    required String text,
    required bool isFromMe,
    required MessageStatusEntity status,
    String? attachmentUrl,
    String? attachmentAesKey,
    String? attachmentIv,
    String? attachmentMacKey,
  }) async {
    await _localDataSource.saveMessage(drift.MessagesCompanion(
      id: Value(id),
      chatId: Value(chatId),
      senderId: Value(senderId),
      textContent: Value(text),
      attachmentUrl: Value(attachmentUrl),
      attachmentAesKey: Value(attachmentAesKey),
      attachmentIv: Value(attachmentIv),
      attachmentMacKey: Value(attachmentMacKey),
      timestamp: Value(DateTime.now().millisecondsSinceEpoch),
      status: Value(_mapStatusToDrift(status)),
      isFromMe: Value(isFromMe),
    ));
  }

  @override
  Future<void> updateMessageStatus(String messageId, MessageStatusEntity status) async {
    await _localDataSource.saveMessage(drift.MessagesCompanion(
      id: Value(messageId),
      status: Value(_mapStatusToDrift(status)),
    ));
  }

  @override
  Future<void> updateChatMetadata({
    required String chatId,
    required String lastMessage,
    required int timestamp,
  }) async {
    await _localDataSource.saveChat(drift.ChatsCompanion(
      id: Value(chatId),
      lastMessage: Value(lastMessage),
      lastMessageTimestamp: Value(timestamp),
    ));
  }

  @override
  Future<ChatEntity?> findPrivateChat(String contactId) async {
    final dto = await _localDataSource.findPrivateChat(contactId);
    return dto != null ? ModelMapper.chatFromDto(dto) : null;
  }

  @override
  Future<void> saveChat(ChatEntity chat) async {
    await _localDataSource.saveChat(drift.ChatsCompanion(
      id: Value(chat.id),
      contactId: Value(chat.recipientId),
      title: Value(chat.title),
      type: Value(drift.ChatType.user), // Por agora apenas user
    ));
  }

  drift.MessageStatus _mapStatusToDrift(MessageStatusEntity status) {
    switch (status) {
      case MessageStatusEntity.pending: return drift.MessageStatus.pending;
      case MessageStatusEntity.sent: return drift.MessageStatus.sent;
      case MessageStatusEntity.delivered: return drift.MessageStatus.delivered;
      case MessageStatusEntity.read: return drift.MessageStatus.read;
    }
  }
}
