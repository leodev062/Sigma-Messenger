import '../i_chat_repository.dart';

/// Caso de uso para excluir uma única mensagem (Padrão Signal).
class DeleteMessageInteractor {
  final IChatRepository _repository;

  DeleteMessageInteractor(this._repository);

  Future<void> execute(String messageId) async {
    await _repository.deleteMessage(messageId);
    // Futuro: Adicionar lógica para 'Apagar para todos' (RemoteDeleteJob)
  }
}
