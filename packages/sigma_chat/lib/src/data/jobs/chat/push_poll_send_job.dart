import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_chat/src/domain/i_chat_repository.dart';

/// PushPollSendJob - Envio de enquete via Relay Protobuf.
class PushPollSendJob extends core.Job {
  static const String KEY = "PushPollSendJob";
  final String messageId;
  final String? pollId;
  final String destinationType;
  final IChatRepository? chatRepository;
  final SignalServiceMessageSender? messageSender;

  PushPollSendJob({
    required this.messageId,
    this.pollId,
    this.destinationType = "USER",
    this.chatRepository,
    this.messageSender,
    int? databaseId,
  })  : super(
          databaseId: databaseId, 
          factoryKey: KEY,
          queueKey: "msg_$messageId",
          priority: JobPriority.high, 
        );

  @override
  Map<String, dynamic> serialize() => {
    'messageId': messageId,
    'pollId': pollId,
    'destinationType': destinationType,
  };

  static core.Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PushPollSendJob(
      messageId: data['messageId'],
      pollId: data['pollId'],
      destinationType: data['destinationType'] ?? "USER",
      chatRepository: locator<IChatRepository>(),
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    final message = await chatRepository!.getMessage(messageId);
    if (message == null || message.status != MessageStatusEntity.pending) return;

    final pollCreate = PollCreate()
      ..id = pollId ?? "poll_$messageId"
      ..question = message.pollQuestion ?? ""
      ..multipleChoice = message.multipleChoice ?? false;
    
    // In a real scenario, we might want to fetch actual IDs from DB, 
    // but here we just re-create options.
    pollCreate.options.addAll((message.pollOptions ?? []).asMap().entries.map((entry) {
      return PollOption()
        ..id = "opt_${entry.key}"
        ..text = entry.value;
    }));

    final dataMessage = DataMessage()
      ..pollCreate = pollCreate;

    final relayMessage = Message()
      ..dataMessage = dataMessage;

    messageSender!.sendUnencryptedEnvelope(
      message.chatId, 
      relayMessage, 
      destinationType: destinationType,
    );
    await chatRepository!.updateMessageStatus(messageId, MessageStatusEntity.sent);
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro no envio de enquete Relay $messageId", error);
  }
}
