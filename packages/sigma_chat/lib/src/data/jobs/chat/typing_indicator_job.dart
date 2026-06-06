import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

/// TypingIndicatorJob - Envia indicadores de digitação em tempo real.
/// Usa WebSocket direto (não encriptado inicialmente).
class TypingIndicatorJob extends Job {
  static const String KEY = "TypingIndicatorJob";

  final String chatId;
  final String recipientId;
  final bool isTyping; // true = começou, false = parou

  final SignalServiceMessageSender? messageSender;
  final CryptoManager? cryptoManager;

  TypingIndicatorJob({
    required this.chatId,
    required this.recipientId,
    required this.isTyping,
    this.messageSender,
    this.cryptoManager,
    int? databaseId,
  }) : super(
         databaseId: databaseId,
         factoryKey: KEY,
         queueKey: "typing_$recipientId",
         priority: JobPriority.medium,
       );

  @override
  Map<String, dynamic> serialize() => {
    'chatId': chatId,
    'recipientId': recipientId,
    'isTyping': isTyping,
  };

  static Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return TypingIndicatorJob(
      chatId: data['chatId'],
      recipientId: data['recipientId'],
      isTyping: data['isTyping'] ?? true,
      messageSender: locator<SignalServiceMessageSender>(),
      cryptoManager: locator<CryptoManager>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    try {
      await cryptoManager!.init();

      // Criar TypingMessage protobuf
      final typing = sigmapb.TypingMessage()
        ..state = isTyping
            ? sigmapb.TypingMessage_TypingState.STARTED
            : sigmapb.TypingMessage_TypingState.STOPPED
        ..timestamp = $fixnum.Int64(DateTime.now().millisecondsSinceEpoch);

      // Encapsular em Content
      final content = sigmapb.Content()..typing = typing;

      // Encriptar
      final encryptedEnvelope = await cryptoManager!.encryptMessage(
        recipientId,
        content,
      );

      // Enviar via WebSocket
      messageSender!.sendEnvelope(recipientId, encryptedEnvelope);

      SigmaLog.d(
        KEY,
        "Typing indicator ${isTyping ? 'started' : 'stopped'} para $recipientId",
      );
    } catch (e, stack) {
      SigmaLog.e(KEY, "Erro ao enviar typing indicator: $e", e, stack);
      // Não rethrow para typing - não é crítico
    }
  }

  @override
  bool shouldRetry(Object error) {
    return false; // Typing indicators não precisam de retry
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.w(KEY, "Falha no envio de typing indicator: $error");
  }
}
