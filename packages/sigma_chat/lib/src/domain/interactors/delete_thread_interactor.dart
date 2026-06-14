import '../i_chat_repository.dart';

/// Caso de uso para excluir uma conversa inteira.
class DeleteThreadInteractor {
  final IChatRepository _repository;

  DeleteThreadInteractor(this._repository);

  Future<void> execute(String threadId) async {
    await _repository.deleteThread(threadId);
  }
}
