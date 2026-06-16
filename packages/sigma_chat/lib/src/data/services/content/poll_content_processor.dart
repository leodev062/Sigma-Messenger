import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class PollContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  PollContentProcessor(this._chatRepository);

  @override
  bool canProcess(Message payload) => 
      payload.hasDataMessage() && payload.dataMessage.hasPollCreate();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required Message payload,
    required int timestamp,
  }) async {
    final pollCreate = payload.dataMessage.pollCreate;
    
    final message = MessageEntity(
      id: messageId,
      conversationId: senderId,
      senderId: senderId,
      textContent: "📊 Enquete: ${pollCreate.question}",
      type: MessageTypeEntity.poll,
      timestamp: timestamp,
      status: MessageStatusEntity.delivered,
      pollQuestion: pollCreate.question,
      pollOptions: pollCreate.options.map((o) => o.text).toList(),
      multipleChoice: pollCreate.multipleChoice,
    );

    await _chatRepository.saveMessageAndMetadata(message);

    // Save actual poll data to PollDao
    // The ID comes from pollCreate.id
    await _chatRepository.savePollData(
      pollId: pollCreate.id,
      messageId: messageId,
      question: pollCreate.question,
      options: pollCreate.options.map((o) => o.text).toList(),
      multipleChoice: pollCreate.multipleChoice,
    );
  }
}
