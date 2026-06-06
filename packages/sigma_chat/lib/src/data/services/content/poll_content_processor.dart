import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class PollContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  PollContentProcessor(this._chatRepository);

  @override
  bool canProcess(sigmapb.Content payload) => 
      payload.hasDataMessage() && payload.dataMessage.hasPollCreate();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Content payload,
    required int timestamp,
  }) async {
    final poll = payload.dataMessage.pollCreate;
    
    final message = MessageEntity(
      id: messageId,
      threadId: 0,
      chatId: senderId,
      senderRecipientId: senderId,
      textContent: "📊 Enquete: ${poll.question}",
      type: MessageTypeEntity.poll,
      timestamp: timestamp,
      status: MessageStatusEntity.read,
      isFromMe: false,
      pollQuestion: poll.question,
      pollOptions: poll.options,
      allowMultipleVotes: poll.allowMultipleVotes,
    );

    await _chatRepository.saveMessageAndMetadata(message);
  }
}
