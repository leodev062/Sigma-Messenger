import 'package:sigma_core/sigma_core.dart';
import '../i_chat_repository.dart';

class WatchMessagesInteractor {
  final IChatRepository _repository;

  WatchMessagesInteractor(this._repository);

  Stream<List<MessageEntity>> execute(int threadId, {int limit = 50}) => _repository.watchMessages(threadId, limit: limit);
}
