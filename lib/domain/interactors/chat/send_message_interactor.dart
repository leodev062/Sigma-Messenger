import 'package:sigma/data/services/message_sender_service.dart';

class SendMessageInteractor {
  final MessageSenderService _senderService;

  SendMessageInteractor(this._senderService);

  Future<void> execute({
    required String chatId, 
    required String senderId, 
    required String text,
  }) {
    return _senderService.send(chatId, senderId, text);
  }
}
