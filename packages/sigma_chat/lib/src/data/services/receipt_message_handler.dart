import 'dart:convert';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'message_handler.dart';

/// ReceiptMessageHandler - Processa recibos de entrega/leitura.
/// Atualiza status das mensagens quando confirmadas pelo destinatário.
class ReceiptMessageHandler implements MessageHandler {
  final IChatRepository _repository;
  final CryptoManager _cryptoManager;

  ReceiptMessageHandler(this._repository, this._cryptoManager);

  @override
  Future<void> handle(Envelope envelope) async {
    try {
      final senderId = envelope.source;
      final encryptedEnvelope = base64Encode(envelope.content);

      final payload = await _cryptoManager.decryptMessage(senderId, encryptedEnvelope);

      if (payload.whichContent() != sigmapb.Content_Content.receipt) {
        return;
      }

      final receipt = payload.receipt;

      // Mapear tipo de recibo para status
      final status = receipt.type == sigmapb.ReceiptMessage_ReceiptType.READ
          ? MessageStatusEntity.read
          : MessageStatusEntity.delivered;

      // Atualizar status da mensagem no banco
      await _repository.updateMessageStatus(receipt.messageId, status);

      SigmaLog.d(
        'receipt_handler',
        'Mensagem ${receipt.messageId} marcada como $status',
      );
    } catch (e, stack) {
      SigmaLog.e('receipt_handler', 'Erro ao processar recibo: $e', e, stack);
    }
  }
}
