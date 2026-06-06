import '../i_chat_repository.dart';

class SendPollInteractor {
  final IChatRepository _chatRepository;

  SendPollInteractor(this._chatRepository);

  Future<void> execute({
    required int threadId,
    required String chatId,
    required String senderId,
    required String question,
    required List<String> options,
    bool allowMultipleVotes = false,
  }) async {
    await _chatRepository.sendPoll(
      chatId: chatId,
      question: question,
      options: options,
      allowMultipleVotes: allowMultipleVotes,
    );
  }
}
