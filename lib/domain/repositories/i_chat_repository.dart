import 'package:sigma/domain/entities/chat_entity.dart';
import 'package:sigma/domain/entities/message_entity.dart';

abstract class IChatRepository {
  Stream<List<ChatEntity>> watchChats();
  Stream<List<MessageEntity>> watchMessages(String chatId);
  
  /// Recupera uma mensagem específica por ID.
  Future<MessageEntity?> getMessage(String id);

  /// Persiste uma nova mensagem localmente.
  Future<void> saveMessage({
    required String id,
    required String chatId,
    required String senderId,
    required String text,
    required bool isFromMe,
    required MessageStatusEntity status,
    String? attachmentUrl,
    String? attachmentAesKey,
    String? attachmentMacKey,
  });

  /// Atualiza o status de uma mensagem existente.
  Future<void> updateMessageStatus(String messageId, MessageStatusEntity status);

  /// Atualiza os metadados do chat (última mensagem, timestamp).
  Future<void> updateChatMetadata({
    required String chatId,
    required String lastMessage,
    required int timestamp,
  });
}
