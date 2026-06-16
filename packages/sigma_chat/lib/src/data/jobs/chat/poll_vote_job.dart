import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'package:fixnum/fixnum.dart' as fixnum;

/// PollVoteJob - Envia um voto em uma enquete.
class PollVoteJob extends core.Job {
  static const String KEY = "PollVoteJob";
  
  final String messageId; // ID da mensagem da enquete original
  final List<int> optionIndexes;
  final String targetAuthorId;
  final int targetSentTimestamp;
  final int voteCount;
  final String destinationType;
  
  final IChatRepository? chatRepository;
  final SignalServiceMessageSender? messageSender;

  PollVoteJob({
    required this.messageId,
    required this.optionIndexes,
    required this.targetAuthorId,
    required this.targetSentTimestamp,
    required this.voteCount,
    this.destinationType = "USER",
    this.chatRepository,
    this.messageSender,
    int? databaseId,
  }) : super(
          databaseId: databaseId,
          factoryKey: KEY,
          queueKey: "vote_$messageId",
          priority: JobPriority.high,
        );

  @override
  Map<String, dynamic> serialize() => {
        'messageId': messageId,
        'optionIndexes': optionIndexes,
        'targetAuthorId': targetAuthorId,
        'targetSentTimestamp': targetSentTimestamp,
        'voteCount': voteCount,
        'destinationType': destinationType,
      };

  static core.Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PollVoteJob(
      messageId: data['messageId'],
      optionIndexes: List<int>.from(data['optionIndexes']),
      targetAuthorId: data['targetAuthorId'],
      targetSentTimestamp: data['targetSentTimestamp'],
      voteCount: data['voteCount'],
      destinationType: data['destinationType'] ?? "USER",
      chatRepository: locator<IChatRepository>(),
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    final relayMessage = Message()
      ..pollVote = (PollVote()
        ..pollId = messageId // In this job, messageId is used as pollId or we should have a separate pollId
        ..optionId = optionIndexes.isNotEmpty ? optionIndexes.first.toString() : ""
        ..userId = "me"
        ..timestamp = fixnum.Int64(DateTime.now().millisecondsSinceEpoch));

    // Send vote to server
    messageSender!.sendUnencryptedEnvelope(
      targetAuthorId, 
      relayMessage, 
      destinationType: destinationType,
    );
    
    // Also update local DB for optimistic update (though usually done before queueing)
    await chatRepository!.castVote(messageId, optionIndexes.first.toString(), "me");
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro ao enviar voto na enquete $messageId", error);
  }
}
