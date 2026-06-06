import 'dart:async';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:sigma_database/sigma_database.dart' as drift;
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_profile/sigma_profile.dart';
import 'jobs/chat/reaction_send_job.dart';
import 'jobs/chat/push_media_send_job.dart';
import 'jobs/chat/push_location_send_job.dart';
import 'jobs/chat/push_poll_send_job.dart';
import 'package:sigma_chat/src/domain/i_chat_repository.dart';

/// ChatRepositoryImpl - Refatorado para POO e Clean Architecture.
class ChatRepositoryImpl implements IChatRepository {
  final MessageTable _messageTable;
  final RecipientDatabase _recipientDatabase;
  final ThreadTable _threadTable;
  final AttachmentTable _attachmentTable;
  final PollTable _pollTable;
  final SigmaJobManager _jobManager;

  ChatRepositoryImpl(
    this._messageTable,
    this._recipientDatabase,
    this._threadTable,
    this._attachmentTable,
    this._pollTable,
    this._jobManager,
  );

  @override
  Stream<List<ThreadEntity>> watchThreads() {
    return _threadTable.watchAllThreads().map(
      (list) => list.map((record) => ModelMapper.threadFromDrift(record)).toList(),
    );
  }

  @override
  Stream<List<ThreadEntity>> watchArchivedThreads() {
    return _threadTable.watchArchivedThreads().map(
      (list) => list.map((record) => ModelMapper.threadFromDrift(record)).toList(),
    );
  }

  @override
  Stream<ThreadEntity?> watchThread(int threadId) {
    return _threadTable.watchThread(threadId).map(
      (record) => record != null ? ModelMapper.threadFromDrift(record) : null,
    );
  }

  @override
  Stream<List<MessageEntity>> watchMessages(int threadId, {int limit = 50}) {
    return _messageTable.watchMessagesWithReactions(threadId, limit: limit).map((list) {
      return list.map((item) => ModelMapper.messageFromDrift(item.message, item.reactions)).toList();
    });
  }

  @override
  Future<void> saveThread(ThreadEntity thread) async {
    // Implementação caso necessário salvar threads manualmente
  }

  @override
  Future<void> saveMessage(MessageEntity message) async {
    await _messageTable.saveMessage(message.toCompanion());
  }

  @override
  Future<void> saveMessageAndMetadata(MessageEntity message) async {
    // BUG FIX: O MessageTable agora decide internamente se incrementa o unreadCount
    // baseado na flag isFromMe da mensagem.
    await _messageTable.saveMessageAndUpdateThread(
      chatId: message.chatId,
      message: message.toCompanion(),
      snippet: message.snippet,
    );

    // Padrão Signal: Buscar perfil se contato for desconhecido
    if (!message.isFromMe) {
      final recipient = await _recipientDatabase.getRecipient(message.chatId);
      if (recipient == null || recipient.displayName == "Unknown") {
        _jobManager.add(FetchProfileJob(recipientId: message.chatId));
      }
    }
  }

  @override
  Future<void> markThreadAsRead(int threadId) async {
    await _messageTable.markThreadAsRead(threadId);
  }

  @override
  Future<void> updateMessageStatus(String messageId, MessageStatusEntity status) async {
    await _messageTable.updateMessageStatus(messageId, status.toDrift());
  }

  @override
  Future<void> updateThreadMetadata(int threadId, String lastMessage, int timestamp) async {
    await _threadTable.updateThreadMetadata(drift.ThreadsCompanion(
      id: Value(threadId),
      snippet: Value(lastMessage),
      date: Value(timestamp),
    ));
  }

  @override
  Future<MessageEntity?> getMessage(String id) async {
    final driftMsg = await _messageTable.getMessage(id);
    return driftMsg != null ? ModelMapper.messageFromDrift(driftMsg) : null;
  }

  @override
  Future<MessageEntity?> getMessageByMetadata({required String authorAci, required int sentTimestamp}) async {
    final driftMsg = await _messageTable.getMessageByMetadata(authorAci, sentTimestamp);
    return driftMsg != null ? ModelMapper.messageFromDrift(driftMsg) : null;
  }

  @override
  Future<int> getOrCreateThread(String chatId) async {
    final existing = await _threadTable.getThreadByRecipientId(chatId);
    if (existing != null) return existing.id;

    var record = await _recipientDatabase.getRecipient(chatId);
    if (record == null) {
      await _recipientDatabase.upsertRecipient(
        Recipient.createUnknown(chatId).toCompanion(),
      );
    }

    return await _threadTable.insertThread(drift.ThreadsCompanion.insert(
      recipientId: chatId,
      date: DateTime.now().millisecondsSinceEpoch,
      unreadCount: const Value(0),
    ));
  }

  @override
  Future<void> archiveThread(int threadId, bool archived) async {
    await _threadTable.setArchived(threadId, archived);
  }

  @override
  Future<void> pinThread(int threadId, bool pinned) async {
    final order = pinned ? DateTime.now().millisecondsSinceEpoch : 0;
    await _threadTable.setPinned(threadId, order);
  }

  @override
  Future<void> deleteThread(int threadId) async {
    await _threadTable.deleteThread(threadId);
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    await _messageTable.deleteMessage(messageId);
  }

  @override
  Future<void> saveMessageWithAttachment({
    required MessageEntity message,
    required String filePath,
    required String contentType,
  }) async {
    final file = File(filePath);
    if (!file.existsSync()) throw Exception("Arquivo não encontrado: $filePath");

    // 1. Persistir Mensagem
    await saveMessage(message);

    // 2. Registrar Anexo no Banco (SSOT)
    await _attachmentTable.insertAttachment(drift.AttachmentsCompanion.insert(
      messageId: message.id,
      contentType: contentType,
      fileName: Value(file.path.split('/').last),
      size: file.lengthSync(),
      transferState: const Value(1), // Uploading
    ));

    // 3. Enfileirar Job Persistente
    _jobManager.add(PushMediaSendJob(
      messageId: message.id,
      filePath: filePath,
      chatId: message.chatId,
    ));
  }

  @override
  Future<void> sendLocation({
    required String chatId,
    required double latitude,
    required double longitude,
  }) async {
    final threadId = await getOrCreateThread(chatId);
    final message = MessageEntity.createLocationOutgoing(
      threadId: threadId,
      chatId: chatId,
      senderId: "me", // TODO: Pegar ACI atual do AuthService
      latitude: latitude,
      longitude: longitude,
    );

    await saveMessageAndMetadata(message);

    _jobManager.add(PushLocationSendJob(
      messageId: message.id,
    ));
  }

  @override
  Future<void> sendPoll({
    required String chatId,
    required String question,
    required List<String> options,
    required bool allowMultipleVotes,
  }) async {
    final threadId = await getOrCreateThread(chatId);
    final message = MessageEntity.createPollOutgoing(
      threadId: threadId,
      chatId: chatId,
      senderId: "me", // TODO: Pegar do AuthService
      question: question,
      options: options,
      allowMultipleVotes: allowMultipleVotes,
    );

    await saveMessageAndMetadata(message);

    // Salvar na tabela de enquetes especializada
    await _pollTable.createPoll(
      drift.PollsCompanion.insert(
        id: "poll_${message.id}",
        question: question,
        authorId: "me",
        messageId: message.id,
        allowMultipleVotes: Value(allowMultipleVotes),
      ),
      options,
    );

    _jobManager.add(PushPollSendJob(
      messageId: message.id,
    ));
  }

  @override
  Future<void> castVote(String pollId, int optionId, String voterId) async {
    await _pollTable.castVote(pollId, optionId, voterId);
  }

  @override
  Stream<PollRecordEntity?> watchPoll(String messageId) {
    return _pollTable.watchPoll(messageId).map((data) {
      if (data == null) return null;
      return PollRecordEntity(
        id: data.poll.id,
        question: data.poll.question,
        allowMultipleVotes: data.poll.allowMultipleVotes,
        hasEnded: data.poll.hasEnded,
        authorId: data.poll.authorId,
        messageId: data.poll.messageId,
        options: data.options.map((opt) => PollOptionEntity(
          id: opt.option.id,
          text: opt.option.optionText,
          voters: opt.votes.map((v) => Voter(id: v.voterId, voteCount: 1)).toList(),
          voteState: opt.votes.any((v) => v.voterId == "me") ? VoteState.added : VoteState.none,
        )).toList(),
      );
    });
  }

  @override
  Future<void> addReaction(String messageId, String authorId, String emoji) async {
    // 1. Persistência Local Imediata (Optimistic UI)
    await _messageTable.upsertReaction(drift.ReactionsCompanion.insert(
      messageId: messageId,
      authorId: authorId,
      emoji: emoji,
      dateSent: DateTime.now().millisecondsSinceEpoch,
      dateReceived: DateTime.now().millisecondsSinceEpoch,
    ));

    // 2. Enfileiramento de Job para Sincronização (Padrão Signal)
    // Buscamos a mensagem para saber quem é o destinatário
    final message = await _messageTable.getMessage(messageId);
    if (message != null && message.isFromMe) {
      // Se a mensagem for minha, enviamos a reação para o chatId (o outro usuário)
      _jobManager.add(ReactionSendJob(
        messageId: messageId,
        emoji: emoji,
        recipientId: message.chatId,
      ));
    }
  }


  @override
  Future<void> removeReaction(String messageId, String authorId, String emoji) async {
    await _messageTable.deleteReaction(messageId, authorId);
  }

  @override
  Stream<List<ReactionEntity>> watchReactions(String messageId) {
    return _messageTable.watchReactionsForMessage(messageId).map(
      (list) => list.map((r) => ModelMapper.reactionFromDrift(r)).toList(),
    );
  }

  @override
  Future<Map<MessageStatusEntity, int>> getMessageDetailedStatus(String messageId) async {
    final receipts = await _messageTable.getReceiptsForMessage(messageId);
    final map = <MessageStatusEntity, int>{};
    for (final r in receipts) {
      final status = r.status.toDomain();
      map[status] = r.timestamp;
    }
    return map;
  }
}
