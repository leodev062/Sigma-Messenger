import 'package:sigma/domain/entities/chat_entity.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';

class WatchChatsInteractor {
  final IChatRepository _repository;

  WatchChatsInteractor(this._repository);

  Stream<List<ChatEntity>> execute() => _repository.watchChats();
}
