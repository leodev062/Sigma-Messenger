import 'package:sigma_core/sigma_core.dart';

abstract class IChatRepository {
  Stream<List<ThreadEntity>> watchThreads();
  Stream<List<ThreadEntity>> watchArchivedThreads();
  Stream<ThreadEntity?> watchThread(String threadId);
  Stream<List<MessageEntity>> watchMessages(String conversationId, {int limit = 50});
  Future<void> saveThread(ThreadEntity thread);
  
  // Métodos necessários para Jobs e Interactors
  Future<void> saveMessage(MessageEntity message);
  Future<void> saveMessageAndMetadata(MessageEntity message);
  Future<void> updateMessageStatus(String messageId, MessageStatusEntity status);
  Future<void> markThreadAsRead(String threadId);
  Future<void> updateThreadMetadata(String threadId, String lastMessage, int timestamp);
  Future<MessageEntity?> getMessage(String id);
  Future<String> getOrCreateThread(String chatId);

  // Archive, Pin, Delete
  Future<void> archiveThread(String threadId, bool archived);
  Future<void> pinThread(String threadId, bool pinned);
  Future<void> deleteThread(String threadId);
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
    double? accuracy,
    bool isLive = false,
    String destinationType = "USER",
  });

  Future<void> saveLocationData(MessageEntity message);

  Future<void> sendPoll({
    required String chatId,
    required String question,
    required List<String> options,
    required bool allowMultipleVotes,
    String destinationType = "USER",
  });

  Future<void> savePollData({
    required String pollId,
    required String messageId,
    required String question,
    required List<String> options,
    required bool multipleChoice,
  });

  // Enquetes Avançadas
  Future<void> castVote(String pollId, String optionId, String voterId);
  Stream<PollRecordEntity?> watchPoll(String messageId);

  // Reações e Detalhes (Padrão Signal)
  Future<MessageEntity?> getMessageByMetadata({required String authorAci, required int sentTimestamp});
  Future<void> addReaction(String messageId, String authorId, String emoji);

  Future<void> removeReaction(String messageId, String authorId, String emoji);
  Stream<List<ReactionEntity>> watchReactions(String messageId);
  Future<Map<MessageStatusEntity, int>> getMessageDetailedStatus(String messageId);
}
