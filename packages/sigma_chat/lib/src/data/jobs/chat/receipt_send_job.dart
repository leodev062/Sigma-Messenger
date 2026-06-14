import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

/// ReceiptSendJob - Envia confirmações de entrega/leitura estilo Relay Engine.
class ReceiptSendJob extends core.Job {
  static const String KEY = "ReceiptSendJob";

  final String messageId;
  final String senderId;
  final String recipientId;
  final String receiptType; // "DELIVERY" ou "READ"

  final SignalServiceMessageSender? messageSender;

  ReceiptSendJob({
    required this.messageId,
    required this.senderId,
    required this.recipientId,
    required this.receiptType,
    this.messageSender,
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

  static core.Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return ReceiptSendJob(
      messageId: data['messageId'],
      senderId: data['senderId'],
      recipientId: data['recipientId'],
      receiptType: data['receiptType'],
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    try {
      final type = this.receiptType.toUpperCase() == "READ"
          ? sigmapb.MessageStatus.READ
          : sigmapb.MessageStatus.DELIVERED;

      final relayMessage = sigmapb.Message()
        ..id = "receipt_${DateTime.now().millisecondsSinceEpoch}"
        ..conversationId = senderId
        ..senderId = "me" 
        ..receiverId = senderId
        ..type = sigmapb.MessageType.REPLY 
        ..timestamp = fixnum.Int64(DateTime.now().millisecondsSinceEpoch)
        ..status = type;

      messageSender!.sendUnencryptedEnvelope(senderId, relayMessage);

      SigmaLog.d(KEY, "Recibo $type enviado para $senderId");
    } catch (e, stack) {
      SigmaLog.e(KEY, "Erro ao enviar recibo Relay: $e", e, stack);
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
    SigmaLog.e(KEY, "Falha no envio de recibo Relay $receiptType: $error");
  }
}
