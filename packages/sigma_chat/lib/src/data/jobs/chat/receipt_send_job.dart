import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

/// ReceiptSendJob - Envia confirmações de entrega/leitura estilo Signal.
/// Agrupa múltiplos recibos para eficiência.
class ReceiptSendJob extends Job {
  static const String KEY = "ReceiptSendJob";

  final String messageId;
  final String senderId;
  final String recipientId;
  final String receiptType; // "DELIVERY" ou "READ"

  final SignalServiceMessageSender? messageSender;
  final CryptoManager? cryptoManager;

  ReceiptSendJob({
    required this.messageId,
    required this.senderId,
    required this.recipientId,
    required this.receiptType,
    this.messageSender,
    this.cryptoManager,
    int? databaseId,
  }) : super(
         databaseId: databaseId,
         factoryKey: KEY,
         queueKey: "receipt_${recipientId}_$receiptType",
         priority: JobPriority.high,
       );

  @override
  Map<String, dynamic> serialize() => {
    'messageId': messageId,
    'senderId': senderId,
    'recipientId': recipientId,
    'receiptType': receiptType,
  };

  static Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return ReceiptSendJob(
      messageId: data['messageId'],
      senderId: data['senderId'],
      recipientId: data['recipientId'],
      receiptType: data['receiptType'],
      messageSender: locator<SignalServiceMessageSender>(),
      cryptoManager: locator<CryptoManager>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    try {
      await cryptoManager!.init();

      // Determinar tipo de recibo
      final receiptType = this.receiptType.toUpperCase() == "READ"
          ? sigmapb.ReceiptMessage_ReceiptType.READ
          : sigmapb.ReceiptMessage_ReceiptType.DELIVERY;

      // Criar ReceiptMessage protobuf
      final receipt = sigmapb.ReceiptMessage()
        ..type = receiptType
        ..messageId = messageId
        ..senderId = senderId
        ..timestamp = $fixnum.Int64(DateTime.now().millisecondsSinceEpoch);

      // Encapsular em Content
      final content = sigmapb.Content()..receipt = receipt;

      // Encriptar com Double Ratchet
      final encryptedEnvelope = await cryptoManager!.encryptMessage(
        recipientId,
        content,
      );

      // Enviar via WebSocket (para quem enviou a mensagem original)
      messageSender!.sendEnvelope(senderId, encryptedEnvelope);

      SigmaLog.d(KEY, "Recibo $receiptType enviado para $senderId");
    } catch (e, stack) {
      SigmaLog.e(KEY, "Erro ao enviar recibo: $e", e, stack);
      rethrow;
    }
  }

  @override
  bool shouldRetry(Object error) {
    return error.toString().contains("Socket") ||
        error.toString().contains("Exception");
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Falha no envio de recibo $receiptType: $error");
  }
}
