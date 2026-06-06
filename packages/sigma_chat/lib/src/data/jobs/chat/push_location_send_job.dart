import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'package:sigma_core/sigma_core.dart' as sigmapb;

/// PushLocationSendJob - Envio de localização via Protobuf.
class PushLocationSendJob extends Job {
  static const String KEY = "PushLocationSendJob";
  final String messageId;
  final IChatRepository? chatRepository;
  final CryptoManager? cryptoManager;
  final SignalServiceMessageSender? messageSender;

  PushLocationSendJob({
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
    return PushLocationSendJob(
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
    
    // Criar Payload de Localização (Protobuf)
    final location = sigmapb.Location()
      ..latitude = message.latitude ?? 0.0
      ..longitude = message.longitude ?? 0.0;

    final content = sigmapb.Content()
      ..dataMessage = (sigmapb.DataMessage()..location = location);

    final encryptedEnvelope = await cryptoManager!.encryptMessage(
      message.chatId,
      content,
    );

    messageSender!.sendEnvelope(message.chatId, encryptedEnvelope);
    await chatRepository!.updateMessageStatus(messageId, MessageStatusEntity.sent);
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro no envio de localização $messageId", error);
  }
}
