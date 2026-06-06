import 'package:sigma_core/sigma_core.dart';
import '../i_chat_repository.dart';

class MessageDetailsData {
  final MessageEntity message;
  final Map<MessageStatusEntity, int> statusTimestamps;

  MessageDetailsData({required this.message, required this.statusTimestamps});
}

class GetMessageDetailsInteractor {
  final IChatRepository _repository;

  GetMessageDetailsInteractor(this._repository);

  Future<MessageDetailsData?> execute(String messageId) async {
    final message = await _repository.getMessage(messageId);
    if (message == null) return null;

    final statuses = await _repository.getMessageDetailedStatus(messageId);
    return MessageDetailsData(message: message, statusTimestamps: statuses);
  }
}
