import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class ReactionContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  ReactionContentProcessor(this._chatRepository);

  @override
  bool canProcess(sigmapb.Message payload) => payload.hasReaction();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Message payload,
    required int timestamp,
  }) async {
    final reaction = payload.reaction;
    
    SigmaLog.i("ReactionContentProcessor", "Recebida reação \${reaction.emoji} de \$senderId para a mensagem \${reaction.messageId}");
    
    // Buscar a mensagem alvo
    // No novo protocolo, a reação tem o messageId direto se o remetente souber.
    // Se não tiver messageId, o Signal usa metadados (author/timestamp).
    // Vou assumir que o messageId é o ID local ou global que ambos conhecem.
    
    if (reaction.messageId.isNotEmpty) {
      await _chatRepository.addReaction(reaction.messageId, senderId, reaction.emoji);
      SigmaLog.i("ReactionContentProcessor", "Reação registrada para a mensagem \${reaction.messageId}");
    } else {
      SigmaLog.w("ReactionContentProcessor", "Reação recebida sem messageId.");
    }
  }
}
