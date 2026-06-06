import 'dart:io';
import 'package:sigma_core/sigma_core.dart';
import '../i_chat_repository.dart';

class SendFileInteractor {
  final IChatRepository _chatRepository;

  SendFileInteractor(this._chatRepository);

  Future<void> execute({
    required String chatId,
    required String senderId,
    required File file,
    required MessageTypeEntity type,
  }) async {
    final threadId = await _chatRepository.getOrCreateThread(chatId);

    final message = MessageEntity.createMediaOutgoing(
      threadId: threadId,
      chatId: chatId,
      senderId: senderId,
      textContent: file.path.split('/').last,
      type: type,
    );

    await _chatRepository.saveMessageWithAttachment(
      message: message,
      filePath: file.path,
      contentType: _getContentType(type),
    );
  }

  String _getContentType(MessageTypeEntity type) {
    switch (type) {
      case MessageTypeEntity.image: return "image/jpeg";
      case MessageTypeEntity.video: return "video/mp4";
      case MessageTypeEntity.audio: return "audio/mpeg";
      case MessageTypeEntity.gif: return "image/gif";
      default: return "application/octet-stream";
    }
  }
}
