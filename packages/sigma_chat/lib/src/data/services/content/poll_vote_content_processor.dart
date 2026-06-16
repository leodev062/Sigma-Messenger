import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class PollVoteContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  PollVoteContentProcessor(this._chatRepository);

  @override
  bool canProcess(Message payload) => 
      payload.hasPollVote();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required Message payload,
    required int timestamp,
  }) async {
    final vote = payload.pollVote;
    
    // Save vote to local DB. This will trigger UI updates via streams.
    await _chatRepository.castVote(
      vote.pollId,
      vote.optionId,
      vote.userId,
    );
  }
}
