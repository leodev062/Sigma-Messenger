import 'package:get_it/get_it.dart';
import 'package:fixnum/fixnum.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

/// PollVoteJob - Envia um voto em uma enquete, seguindo a lógica do Signal.
class PollVoteJob extends Job {
  static const String KEY = "PollVoteJob";
  
  final String messageId; // ID da mensagem da enquete original
  final List<int> optionIndexes;
  final String targetAuthorId;
  final int targetSentTimestamp;
  final int voteCount;
  
  final IChatRepository? chatRepository;
  final CryptoManager? cryptoManager;
  final SignalServiceMessageSender? messageSender;

  PollVoteJob({
    required this.messageId,
    required this.optionIndexes,
    required this.targetAuthorId,
    required this.targetSentTimestamp,
    required this.voteCount,
    this.chatRepository,
    this.cryptoManager,
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

  static Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PollVoteJob(
      messageId: data['messageId'],
      optionIndexes: List<int>.from(data['optionIndexes']),
      targetAuthorId: data['targetAuthorId'],
      targetSentTimestamp: data['targetSentTimestamp'],
      voteCount: data['voteCount'],
      chatRepository: locator<IChatRepository>(),
      cryptoManager: locator<CryptoManager>(),
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    final message = await chatRepository!.getMessage(messageId);
    if (message == null) return;

    await cryptoManager!.init();

    // Criar Payload de Voto (Protobuf seguindo Signal)
    final pollVote = sigmapb.PollVote()
      ..targetAuthorAci = targetAuthorId
      ..targetSentTimestamp = Int64(targetSentTimestamp)
      ..optionIndexes.addAll(optionIndexes)
      ..voteCount = voteCount;

    final content = sigmapb.Content()
      ..dataMessage = (sigmapb.DataMessage()..pollVote = pollVote);

    final encryptedEnvelope = await cryptoManager!.encryptMessage(
      message.chatId,
      content,
    );

    messageSender!.sendEnvelope(message.chatId, encryptedEnvelope);
    
    // No Signal, após enviar o voto com sucesso, atualizamos o estado local
    // para ADDED ou REMOVED.
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro ao enviar voto na enquete $messageId", error);
  }
}
