import 'dart:io';
import 'package:sigma_core/sigma_core.dart';
import '../i_chat_repository.dart';

/// SendMediaInteractor - Refatorado seguindo boas práticas de POO.
class SendMediaInteractor {
  final IChatRepository _chatRepository;

  SendMediaInteractor(this._chatRepository);

  Future<void> execute({
    required String chatId,
    required String senderId,
    required File file,
  }) async {
    // 1. Criar a Thread (Conversa)
    final threadId = await _chatRepository.getOrCreateThread(chatId);

    // 2. Criar a Entidade de Mensagem usando Factory OO
    final message = MessageEntity.createMediaOutgoing(
      threadId: threadId,
      chatId: chatId,
      senderId: senderId,
      textContent: "📷 Foto", 
      type: MessageTypeEntity.image,
    );

    // 3. Persistir via Repositório (SSOT)
    await _chatRepository.saveMessageWithAttachment(
      message: message,
      filePath: file.path,
      contentType: "image/jpeg",
    );
  }
}
