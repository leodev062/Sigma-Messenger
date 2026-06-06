import 'package:sigma_core/sigma_core.dart';
import '../i_chat_repository.dart';

class WatchChatsInteractor {
  final IChatRepository _repository;

  WatchChatsInteractor(this._repository);

  Stream<List<ThreadEntity>> execute() => _repository.watchThreads();
}
