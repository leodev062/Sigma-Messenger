import '../i_chat_repository.dart';

class PinThreadInteractor {
  final IChatRepository _repository;

  PinThreadInteractor(this._repository);

  Future<void> execute(int threadId, bool pinned) async {
    await _repository.pinThread(threadId, pinned);
  }
}
