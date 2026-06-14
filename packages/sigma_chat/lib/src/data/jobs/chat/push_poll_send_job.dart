import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:fixnum/fixnum.dart' as fixnum;

/// PushPollSendJob - Envio de enquete via Relay Protobuf.
class PushPollSendJob extends core.Job {
  static const String KEY = "PushPollSendJob";
  final String messageId;
  final IChatRepository? chatRepository;
  final SignalServiceMessageSender? messageSender;

  PushPollSendJob({
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
    return PushPollSendJob(
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
      ..type = sigmapb.MessageType.POLL
      ..timestamp = fixnum.Int64(message.timestamp)
      ..poll = (sigmapb.PollContent()
        ..question = message.pollQuestion ?? ""
        ..multipleChoice = message.multipleChoice ?? false
        ..options.addAll((message.pollOptions ?? []).map((o) => sigmapb.PollOption()..text = o)));

    messageSender!.sendUnencryptedEnvelope(message.chatId, relayMessage);
    await chatRepository!.updateMessageStatus(messageId, MessageStatusEntity.sent);
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro no envio de enquete Relay $messageId", error);
  }
}
