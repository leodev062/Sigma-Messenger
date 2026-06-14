import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_chat/src/domain/i_chat_repository.dart';

/// PollVoteJob - Envia um voto em uma enquete.
class PollVoteJob extends core.Job {
  static const String KEY = "PollVoteJob";
  
  final String messageId; // ID da mensagem da enquete original
  final List<int> optionIndexes;
  final String targetAuthorId;
  final int targetSentTimestamp;
  final int voteCount;
  
  final IChatRepository? chatRepository;
  final SignalServiceMessageSender? messageSender;

  PollVoteJob({
    required this.messageId,
    required this.optionIndexes,
    required this.targetAuthorId,
    required this.targetSentTimestamp,
    required this.voteCount,
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
      };

  static core.Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PollVoteJob(
      messageId: data['messageId'],
      optionIndexes: List<int>.from(data['optionIndexes']),
      targetAuthorId: data['targetAuthorId'],
      targetSentTimestamp: data['targetSentTimestamp'],
      voteCount: data['voteCount'],
      chatRepository: locator<IChatRepository>(),
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    final message = await chatRepository!.getMessage(messageId);
    if (message == null) return;

    // TODO: Implement PollVote in proto if missing. 
    // Sending as a special text message for now or skipping until proto is updated.
    SigmaLog.i(KEY, "Voto em enquete não enviado: PollVote missing in proto.");
    
    /*
    final relayMessage = sigmapb.Message()
      ..id = "vote_${DateTime.now().millisecondsSinceEpoch}"
      ..conversationId = message.chatId
      ..senderId = "me"
      ..receiverId = message.chatId
      ..type = sigmapb.MessageType.POLL
      ..timestamp = Int64(DateTime.now().millisecondsSinceEpoch);
      // ..pollVote = ... (Missing in generated Dart code)

    messageSender!.sendUnencryptedEnvelope(message.chatId, relayMessage);
    */
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro ao enviar voto na enquete $messageId", error);
  }
}
