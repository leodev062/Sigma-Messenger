import '../i_chat_repository.dart';

class ArchiveThreadInteractor {
  final IChatRepository _repository;

  ArchiveThreadInteractor(this._repository);

  Future<void> execute(int threadId, bool archived) async {
    await _repository.archiveThread(threadId, archived);
  }
}
