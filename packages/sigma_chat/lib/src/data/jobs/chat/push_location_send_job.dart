import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'package:fixnum/fixnum.dart' as fixnum;

/// PushLocationSendJob - Envio de localização via Relay Protobuf.
class PushLocationSendJob extends core.Job {
  static const String KEY = "PushLocationSendJob";
  final String messageId;
  final bool isUpdate;
  final String destinationType;
  final IChatRepository? chatRepository;
  final SignalServiceMessageSender? messageSender;

  PushLocationSendJob({
    required this.messageId,
    this.isUpdate = false,
    this.destinationType = "USER",
    this.chatRepository,
    this.messageSender,
    int? databaseId,
  })  : super(
          databaseId: databaseId, 
          factoryKey: KEY,
          queueKey: isUpdate ? "loc_update_$messageId" : "msg_$messageId",
          priority: isUpdate ? JobPriority.medium : JobPriority.high, 
        );

  @override
  Map<String, dynamic> serialize() => {
    'messageId': messageId,
    'isUpdate': isUpdate,
    'destinationType': destinationType,
  };

  static core.Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PushLocationSendJob(
      messageId: data['messageId'],
      isUpdate: data['isUpdate'] ?? false,
      destinationType: data['destinationType'] ?? "USER",
      chatRepository: locator<IChatRepository>(),
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    final message = await chatRepository!.getMessage(messageId);
    if (message == null) return;
    
    // For updates, we don't check PENDING status as it might already be SENT
    if (!isUpdate && message.status != MessageStatusEntity.pending) return;

    final dataMessage = DataMessage()
      ..location = (Location()
        ..latitude = message.latitude ?? 0.0
        ..longitude = message.longitude ?? 0.0
        ..accuracy = message.accuracy ?? 0.0
        ..isLive = message.isLive ?? false
        ..timestamp = fixnum.Int64(message.locationTimestamp ?? message.timestamp));

    final relayMessage = Message()
      ..messageId = messageId
      ..dataMessage = dataMessage;

    messageSender!.sendUnencryptedEnvelope(
      message.chatId, 
      relayMessage, 
      destinationType: destinationType,
    );
    
    if (!isUpdate) {
      await chatRepository!.updateMessageStatus(messageId, MessageStatusEntity.sent);
    }
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro no envio de localização Relay $messageId", error);
  }
}
