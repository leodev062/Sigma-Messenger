import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class PollContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  PollContentProcessor(this._chatRepository);

  @override
  bool canProcess(sigmapb.Message payload) => payload.hasPoll();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Message payload,
    required int timestamp,
  }) async {
    final poll = payload.poll;
    
    final message = MessageEntity(
      id: messageId,
      conversationId: senderId,
      senderId: senderId,
      textContent: "📊 Enquete: \${poll.question}",
      type: MessageTypeEntity.poll,
      timestamp: timestamp,
      status: MessageStatusEntity.delivered,
      pollQuestion: poll.question,
      pollOptions: poll.options.map((o) => o.text).toList(),
      multipleChoice: poll.multipleChoice,
    );

    await _chatRepository.saveMessageAndMetadata(message);
  }
}
