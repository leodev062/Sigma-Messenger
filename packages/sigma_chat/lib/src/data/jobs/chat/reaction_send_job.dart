import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:fixnum/fixnum.dart' as fixnum;

/// ReactionSendJob - Encapsula a lógica de envio de reações estilo Relay.
class ReactionSendJob extends core.Job with Loggable {
  static const String KEY = 'reaction_send_job';
  final String messageId;
  final String emoji;
  final String recipientId;
  final String destinationType;
  final SignalServiceMessageSender? messageSender;

  ReactionSendJob({
    required this.messageId,
    required this.emoji,
    required this.recipientId,
    this.destinationType = "USER",
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
      'destinationType': destinationType,
    };
  }

  @override
  Future<void> run() async {
    logI("Enviando reação Relay '$emoji' para a mensagem $messageId com tipo $destinationType");

    // Signal style needs author and timestamp for target message resolution
    // Here we use a generic placeholder or ideally we'd fetch message metadata
    final dataMessage = DataMessage()
      ..reaction = (Reaction()
        ..emoji = emoji
        ..targetAuthorAci = "unknown" // Should be the original message sender
        ..targetTimestamp = fixnum.Int64(0)); // Should be the original message timestamp

    final relayMessage = Message()
      ..dataMessage = dataMessage;

    messageSender!.sendUnencryptedEnvelope(
      recipientId, 
      relayMessage, 
      destinationType: destinationType,
    );
    
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
      destinationType: data['destinationType'] ?? "USER",
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }
}
