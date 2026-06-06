import 'package:sigma_core/sigma_core.dart';

abstract class IChatRepository {
  Stream<List<ThreadEntity>> watchThreads();
  Stream<List<ThreadEntity>> watchArchivedThreads();
  Stream<ThreadEntity?> watchThread(int threadId);
  Stream<List<MessageEntity>> watchMessages(int threadId, {int limit = 50});
  Future<void> saveThread(ThreadEntity thread);
  
  // Métodos necessários para Jobs e Interactors
  Future<void> saveMessage(MessageEntity message);
  Future<void> saveMessageAndMetadata(MessageEntity message);
  Future<void> updateMessageStatus(String messageId, MessageStatusEntity status);
  Future<void> markThreadAsRead(int threadId);
  Future<void> updateThreadMetadata(int threadId, String lastMessage, int timestamp);
  Future<MessageEntity?> getMessage(String id);
  Future<int> getOrCreateThread(String chatId);

  // Archive, Pin, Delete
  Future<void> archiveThread(int threadId, bool archived);
  Future<void> pinThread(int threadId, bool pinned);
  Future<void> deleteThread(int threadId);
  Future<void> deleteMessage(String messageId);

  // Anexos
  Future<void> saveMessageWithAttachment({
    required MessageEntity message,
    required String filePath,
    required String contentType,
  });

  Future<void> sendLocation({
    required String chatId,
    required double latitude,
    required double longitude,
  });

  Future<void> sendPoll({
    required String chatId,
    required String question,
    required List<String> options,
    required bool allowMultipleVotes,
  });

  // Enquetes Avançadas
  Future<void> castVote(String pollId, int optionId, String voterId);
  Stream<PollRecordEntity?> watchPoll(String messageId);

  // Reações e Detalhes (Padrão Signal)
  Future<MessageEntity?> getMessageByMetadata({required String authorAci, required int sentTimestamp});
  Future<void> addReaction(String messageId, String authorId, String emoji);

  Future<void> removeReaction(String messageId, String authorId, String emoji);
  Stream<List<ReactionEntity>> watchReactions(String messageId);
  Future<Map<MessageStatusEntity, int>> getMessageDetailedStatus(String messageId);
}
