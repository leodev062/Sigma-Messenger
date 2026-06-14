import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class PollVoteContentProcessor implements MessageContentProcessor {
  PollVoteContentProcessor(IChatRepository chatRepository);

  @override
  bool canProcess(sigmapb.Message payload) => false; // Missing in current proto

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Message payload,
    required int timestamp,
  }) async {
    // TODO: Implement once PollVote is added to Message proto
  }
}
