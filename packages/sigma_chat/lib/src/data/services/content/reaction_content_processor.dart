import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class ReactionContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  ReactionContentProcessor(this._chatRepository);

  @override
  bool canProcess(Message payload) => 
      payload.hasDataMessage() && payload.dataMessage.hasReaction();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required Message payload,
    required int timestamp,
  }) async {
    final reaction = payload.dataMessage.reaction;
    
    // Resolve target message by metadata if needed
    final targetMessage = await _chatRepository.getMessageByMetadata(
      authorAci: reaction.targetAuthorAci,
      sentTimestamp: reaction.targetTimestamp.toInt(),
    );

    if (targetMessage != null) {
      if (reaction.remove) {
        await _chatRepository.removeReaction(targetMessage.id, senderId, reaction.emoji);
      } else {
        await _chatRepository.addReaction(targetMessage.id, senderId, reaction.emoji);
      }
    }
  }
}
