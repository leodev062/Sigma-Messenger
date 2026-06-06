import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

/// PushPollSendJob - Envio de enquete via Protobuf.
class PushPollSendJob extends Job {
  static const String KEY = "PushPollSendJob";
  final String messageId;
  final IChatRepository? chatRepository;
  final CryptoManager? cryptoManager;
  final SignalServiceMessageSender? messageSender;

  PushPollSendJob({
    required this.messageId,
    this.chatRepository,
    this.cryptoManager,
    this.messageSender,
    int? databaseId,
  })  : super(
          databaseId: databaseId, 
          factoryKey: KEY,
          queueKey: "msg_$messageId",
          priority: JobPriority.high, 
        );

  @override
  Map<String, dynamic> serialize() => {'messageId': messageId};

  static Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PushPollSendJob(
      messageId: data['messageId'],
      chatRepository: locator<IChatRepository>(),
      cryptoManager: locator<CryptoManager>(),
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    final message = await chatRepository!.getMessage(messageId);
    if (message == null || message.status != MessageStatusEntity.pending) return;

    await cryptoManager!.init();
    
    // Criar Payload de Enquete (Protobuf seguindo Signal)
    final poll = sigmapb.PollCreate()
      ..question = message.pollQuestion ?? ""
      ..options.addAll(message.pollOptions ?? [])
      ..allowMultipleVotes = message.allowMultipleVotes ?? false;

    final content = sigmapb.Content()
      ..dataMessage = (sigmapb.DataMessage()..pollCreate = poll);

    final encryptedEnvelope = await cryptoManager!.encryptMessage(
      message.chatId,
      content,
    );

    messageSender!.sendEnvelope(message.chatId, encryptedEnvelope);
    await chatRepository!.updateMessageStatus(messageId, MessageStatusEntity.sent);
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro no envio de enquete $messageId", error);
  }
}
