import 'package:sigma_core/sigma_core.dart';
import '../i_chat_repository.dart';
import 'send_message_interactor.dart';

class ForwardMessageInteractor {
  final SendMessageInteractor _sendMessageInteractor;
  final IChatRepository _chatRepository;

  ForwardMessageInteractor(this._sendMessageInteractor, this._chatRepository);

  Future<void> execute({
    required MessageEntity message,
    required List<String> targetChatIds,
    required String senderId,
  }) async {
    for (final chatId in targetChatIds) {
      final conversationId = await _chatRepository.getOrCreateThread(chatId);
      await _sendMessageInteractor.execute(
        conversationId,
        chatId,
        senderId,
        message.textContent,
      );
    }
  }
}
