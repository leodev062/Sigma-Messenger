import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'message_handler.dart';

/// ReceiptMessageHandler - Processa recibos de entrega/leitura do Relay Engine.
class ReceiptMessageHandler with Loggable implements MessageHandler {
  final IChatRepository _repository;

  ReceiptMessageHandler(this._repository);

  @override
  Future<void> handle(Envelope envelope) async {
    try {
      final message = Message.fromBuffer(envelope.payload);

      if (message.hasReceipt()) {
        final receipt = message.receipt;
        final status = (receipt.type == ReceiptMessage_ReceiptType.READ)
            ? MessageStatusEntity.read
            : MessageStatusEntity.delivered;

        if (receipt.messageId.isNotEmpty) {
           await _repository.updateMessageStatus(receipt.messageId, status);
           logD('Mensagem ${receipt.messageId} marcada como $status');
        }
      }
      
    } catch (e, stack) {
      logE('Erro ao processar recibo Relay: $e', e, stack);
    }
  }
}
