import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:fixnum/fixnum.dart' as $fixnum;

/// ReactionSendJob - Encapsula a lógica de envio de reações em background.
/// Segue o padrão Command/Job do Signal Android para garantir resiliência.
class ReactionSendJob extends Job with Loggable {
  static const String KEY = 'reaction_send_job';
  final String messageId;
  final String emoji;
  final String recipientId;
  final SignalServiceMessageSender? messageSender;
  final CryptoManager? cryptoManager;

  ReactionSendJob({
    required this.messageId,
    required this.emoji,
    required this.recipientId,
    this.messageSender,
    this.cryptoManager,
    super.databaseId,
  }) : super(
         factoryKey: KEY,
         queueKey: recipientId,
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
    logI("Enviando reação estilo Signal '$emoji' para a mensagem $messageId");

    await cryptoManager!.init();

    // No Signal original, construímos um DataMessage com o campo reaction (Tag 10)
    final reaction = sigmapb.Reaction()
      ..emoji = emoji
      ..targetAuthorAci = recipientId // Simplificação: em 1:1 o autor original é o recipient
      ..targetTimestamp = $fixnum.Int64(DateTime.now().millisecondsSinceEpoch);

    final content = sigmapb.Content()
      ..dataMessage = (sigmapb.DataMessage()..reaction = reaction);

    final encryptedEnvelope = await cryptoManager!.encryptMessage(
      recipientId,
      content,
    );

    messageSender!.sendEnvelope(recipientId, encryptedEnvelope);
    
    logD("Reação encriptada enviada para $recipientId");
  }

  @override
  bool shouldRetry(Object error) {
    return error.toString().contains("Socket") || error.toString().contains("Exception");
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    logE("Erro ao processar ReactionSendJob: $error");
  }

  /// Factory estático para o JobManager instanciar o trabalho a partir do banco.
  static Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return ReactionSendJob(
      messageId: data['messageId'],
      emoji: data['emoji'],
      recipientId: data['recipientId'],
      messageSender: locator<SignalServiceMessageSender>(),
      cryptoManager: locator<CryptoManager>(),
      databaseId: databaseId,
    );
  }
}
