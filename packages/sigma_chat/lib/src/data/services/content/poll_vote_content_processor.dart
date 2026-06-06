import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class PollVoteContentProcessor implements MessageContentProcessor {
  PollVoteContentProcessor(IChatRepository chatRepository);

  @override
  bool canProcess(sigmapb.Content payload) => 
      payload.hasDataMessage() && payload.dataMessage.hasPollVote();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Content payload,
    required int timestamp,
  }) async {
    final vote = payload.dataMessage.pollVote;
    
    SigmaLog.i("PollVoteContentProcessor", "Recebido voto de $senderId para enquete enviada em ${vote.targetSentTimestamp}");
    
    // No Signal, os votos não são mensagens visíveis, mas atualizações de estado.
    // 1. Localizar a enquete original baseada no autor (vote.targetAuthorAci) e timestamp (vote.targetSentTimestamp)
    // 2. Atualizar o banco de dados de enquetes (PollTables)
    
    // Por enquanto, apenas logamos, pois a infra de banco de enquetes precisa ser expandida.
  }
}
