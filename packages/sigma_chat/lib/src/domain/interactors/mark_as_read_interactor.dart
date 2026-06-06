import '../i_chat_repository.dart';

class MarkAsReadInteractor {
  final IChatRepository _repository;

  MarkAsReadInteractor(this._repository);

  Future<void> execute(int threadId) async {
    await _repository.markThreadAsRead(threadId);
  }
}
