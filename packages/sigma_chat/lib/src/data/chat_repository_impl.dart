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

/// ChatRepositoryImpl - Refatorado para a nova arquitetura CSFA.
class ChatRepositoryImpl implements IChatRepository {
  final MessageDao _messageDao;
  final UserDao _userDao;
  final ConversationDao _conversationDao;
  final PollDao _pollDao;
  final SigmaJobManager _jobManager;
  final SigmaStore _sigmaStore;
  final ResolveProfileInteractor _resolveProfileInteractor;

  ChatRepositoryImpl(
    this._messageDao,
    this._userDao,
    this._conversationDao,
    this._pollDao,
    this._jobManager,
    this._sigmaStore,
    this._resolveProfileInteractor,
  );

  @override
  Stream<List<ThreadEntity>> watchThreads() {
    return _conversationDao.watchAllConversations().asyncMap(
      (list) async {
        final results = <ThreadEntity>[];
        for (final conv in list) {
          final recipient = await _resolveProfileInteractor.execute(conv.id);
          results.add(ModelMapper.threadFromDrift(conv).copyWithRecipient(recipient));
        }
        return results;
      },
    );
  }

  @override
  Stream<List<ThreadEntity>> watchArchivedThreads() {
    return _conversationDao.watchArchivedConversations().asyncMap(
      (list) async {
        final results = <ThreadEntity>[];
        for (final conv in list) {
          final recipient = await _resolveProfileInteractor.execute(conv.id);
          results.add(ModelMapper.threadFromDrift(conv).copyWithRecipient(recipient));
        }
        return results;
      },
    );
  }

  @override
  Stream<ThreadEntity?> watchThread(String threadId) {
    return _conversationDao.watchConversation(threadId).asyncMap(
      (data) async {
        if (data == null) return null;
        final recipient = await _resolveProfileInteractor.execute(data.id);
        return ModelMapper.threadFromDrift(data).copyWithRecipient(recipient);
      },
    );
  }

  @override
  Stream<List<MessageEntity>> watchMessages(String conversationId, {int limit = 50}) {
    return _messageDao.watchMessages(conversationId, limit: limit).map((list) {
      return list.map((item) => ModelMapper.messageFromDrift(item)).toList();
    });
  }

  @override
  Future<void> saveThread(ThreadEntity thread) async {
    await _conversationDao.upsertConversation(drift.ConversationsCompanion(
      id: Value(thread.id),
      title: Value(thread.recipient.displayName),
      updatedAt: Value(thread.date),
    ));
  }

  @override
  Future<void> saveMessage(MessageEntity message) async {
    await _messageDao.saveMessage(message.toCompanion());
  }

  @override
  Future<void> saveMessageAndMetadata(MessageEntity message) async {
    final currentUserId = _sigmaStore.account.getUserId();
    final bool shouldIncrement = message.senderId != currentUserId;

    await _messageDao.saveMessageAndUpdateConversation(
      conversationId: message.conversationId,
      message: message.toCompanion(),
      snippet: message.snippet,
      incrementUnread: shouldIncrement,
    );

    // UPRA: Resolver perfil automaticamente se contato for desconhecido
    if (!message.isFromMe) {
      await _resolveProfileInteractor.execute(message.conversationId);
    }
  }

  @override
  Future<void> markThreadAsRead(String threadId) async {
    await _conversationDao.resetUnreadCount(threadId);
  }

  @override
  Future<void> updateMessageStatus(String messageId, MessageStatusEntity status) async {
    await _messageDao.updateMessageStatus(messageId, status.toDrift());
  }

  @override
  Future<void> updateThreadMetadata(String threadId, String lastMessage, int timestamp) async {
    await _conversationDao.upsertConversation(drift.ConversationsCompanion(
      id: Value(threadId),
      lastMessageId: Value(lastMessage), // In CSFA this is message ID, but snippet works too
      updatedAt: Value(timestamp),
    ));
  }

  @override
  Future<MessageEntity?> getMessage(String id) async {
    final driftMsg = await _messageDao.getMessage(id);
    return driftMsg != null ? ModelMapper.messageFromDrift(driftMsg) : null;
  }

  @override
  Future<MessageEntity?> getMessageByMetadata({required String authorAci, required int sentTimestamp}) async {
    // Adjust based on new schema
    return null;
  }

  @override
  Future<String> getOrCreateThread(String chatId) async {
    final existing = await _conversationDao.getConversation(chatId);
    if (existing != null) return existing.id;

    // UPRA: Resolve e salva o stub inicial se necessário
    final recipient = await _resolveProfileInteractor.execute(chatId);
    await _userDao.upsertUser(recipient.toCompanion());

    await _conversationDao.upsertConversation(drift.ConversationsCompanion.insert(
      id: chatId,
      updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    ));

    return chatId;
  }

  @override
  Future<void> archiveThread(String threadId, bool archived) async {
    await _conversationDao.setArchived(threadId, archived);
  }

  @override
  Future<void> pinThread(String threadId, bool pinned) async {
    await _conversationDao.setPinned(threadId, pinned);
  }

  @override
  Future<void> deleteThread(String threadId) async {
    await _conversationDao.deleteConversation(threadId);
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    await _messageDao.deleteMessage(messageId);
  }

  @override
  Future<void> saveMessageWithAttachment({
    required MessageEntity message,
    required String filePath,
    required String contentType,
  }) async {
    final file = File(filePath);
    if (!file.existsSync()) throw Exception("Arquivo não encontrado: $filePath");

    await saveMessage(message);

    // Enfileirar Job Persistente
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
    await getOrCreateThread(chatId);
    final message = MessageEntity.createLocationOutgoing(
      conversationId: chatId,
      senderId: "me", // TODO: Pegar do AuthService
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
    await getOrCreateThread(chatId);
    final message = MessageEntity.createPollOutgoing(
      conversationId: chatId,
      senderId: "me", // TODO: Pegar do AuthService
      question: question,
      options: options,
      allowMultipleVotes: allowMultipleVotes,
    );

    await saveMessageAndMetadata(message);

    await _pollDao.createPoll(
      drift.PollsCompanion.insert(
        id: "poll_${message.id}",
        question: Value(question),
        messageId: Value(message.id),
        multipleChoice: Value(allowMultipleVotes),
      ),
      options,
    );

    _jobManager.add(PushPollSendJob(
      messageId: message.id,
    ));
  }

  @override
  Future<void> castVote(String pollId, String optionId, String voterId) async {
    await _pollDao.castVote(pollId, optionId, voterId);
  }

  @override
  Stream<PollRecordEntity?> watchPoll(String messageId) {
    return _pollDao.watchPoll(messageId).map((data) {
      if (data == null) return null;
      // Map to PollRecordEntity (Domain)
      return null; // Implementation needed
    });
  }

  @override
  Future<void> addReaction(String messageId, String authorId, String emoji) async {
    await _messageDao.upsertReaction(drift.ReactionsCompanion.insert(
      id: "react_${messageId}_$authorId",
      messageId: Value(messageId),
      userId: Value(authorId),
      emoji: Value(emoji),
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
    ));

    final message = await _messageDao.getMessage(messageId);
    if (message != null) {
      _jobManager.add(ReactionSendJob(
        messageId: messageId,
        emoji: emoji,
        recipientId: message.conversationId ?? "",
      ));
    }
  }

  @override
  Future<void> removeReaction(String messageId, String authorId, String emoji) async {
    await _messageDao.deleteReaction(messageId, authorId);
  }

  @override
  Stream<List<ReactionEntity>> watchReactions(String messageId) {
    return _messageDao.watchReactionsForMessage(messageId).map(
      (list) => list.map((r) => ModelMapper.reactionFromDrift(r)).toList(),
    );
  }

  @override
  Future<Map<MessageStatusEntity, int>> getMessageDetailedStatus(String messageId) async {
    return {};
  }
}
