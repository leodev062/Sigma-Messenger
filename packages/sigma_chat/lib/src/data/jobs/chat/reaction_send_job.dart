import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:fixnum/fixnum.dart' as fixnum;

/// ReactionSendJob - Encapsula a lógica de envio de reações estilo Relay.
class ReactionSendJob extends core.Job with Loggable {
  static const String KEY = 'reaction_send_job';
  final String messageId;
  final String emoji;
  final String recipientId;
  final SignalServiceMessageSender? messageSender;

  ReactionSendJob({
    required this.messageId,
    required this.emoji,
    required this.recipientId,
    this.messageSender,
    int? databaseId,
  }) : super(
         factoryKey: KEY,
         queueKey: recipientId,
         databaseId: databaseId,
       );

  @override
  Map<String, dynamic> serialize() {
    return {
      'messageId': messageId,
      'emoji': emoji,
      'recipientId': recipientId,
    };
  }

  @override
  Future<void> run() async {
    logI("Enviando reação Relay '$emoji' para a mensagem $messageId");

    final relayMessage = sigmapb.Message()
      ..id = "reaction_${DateTime.now().millisecondsSinceEpoch}"
      ..conversationId = recipientId
      ..senderId = "me"
      ..receiverId = recipientId
      ..type = sigmapb.MessageType.REACTION
      ..timestamp = fixnum.Int64(DateTime.now().millisecondsSinceEpoch)
      ..reaction = (sigmapb.ReactionContent()
        ..messageId = messageId
        ..emoji = emoji);

    messageSender!.sendUnencryptedEnvelope(recipientId, relayMessage);
    
    logD("Reação Relay enviada para $recipientId");
  }

  @override
  bool shouldRetry(Object error) {
    return error.toString().contains("Socket") ||
        error.toString().contains("Exception");
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    logE("Erro ao processar ReactionSendJob Relay: $error");
  }

  /// Factory estático para o JobManager instanciar o trabalho a partir do banco.
  static core.Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return ReactionSendJob(
      messageId: data['messageId'],
      emoji: data['emoji'],
      recipientId: data['recipientId'],
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }
}
