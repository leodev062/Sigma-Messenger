import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:fixnum/fixnum.dart' as fixnum;

/// PushLocationSendJob - Envio de localização via Relay Protobuf.
class PushLocationSendJob extends core.Job {
  static const String KEY = "PushLocationSendJob";
  final String messageId;
  final IChatRepository? chatRepository;
  final SignalServiceMessageSender? messageSender;

  PushLocationSendJob({
    required this.messageId,
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
  Map<String, dynamic> serialize() => {'messageId': messageId};

  static core.Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PushLocationSendJob(
      messageId: data['messageId'],
      chatRepository: locator<IChatRepository>(),
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    final message = await chatRepository!.getMessage(messageId);
    if (message == null || message.status != MessageStatusEntity.pending) return;

    final relayMessage = sigmapb.Message()
      ..id = message.id
      ..conversationId = message.chatId
      ..senderId = "me"
      ..receiverId = message.chatId
      ..type = sigmapb.MessageType.TEXT 
      ..timestamp = fixnum.Int64(message.timestamp)
      ..text = (sigmapb.TextContent()..text = "📍 Localização: ${message.latitude}, ${message.longitude}");

    messageSender!.sendUnencryptedEnvelope(message.chatId, relayMessage);
    await chatRepository!.updateMessageStatus(messageId, MessageStatusEntity.sent);
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro no envio de localização Relay $messageId", error);
  }
}
