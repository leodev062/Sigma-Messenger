import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';

class WatchMessagesInteractor {
  final IChatRepository _repository;

  WatchMessagesInteractor(this._repository);

  Stream<List<MessageEntity>> execute(String chatId) => _repository.watchMessages(chatId);
}
