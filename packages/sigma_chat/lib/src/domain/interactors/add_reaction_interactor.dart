import '../i_chat_repository.dart';

class AddReactionInteractor {
  final IChatRepository _repository;

  AddReactionInteractor(this._repository);

  Future<void> execute(String messageId, String authorId, String emoji) async {
    await _repository.addReaction(messageId, authorId, emoji);
    // Futuro: Enviar ReactionSendJob via JobManager (Padrão Signal)
  }
}
