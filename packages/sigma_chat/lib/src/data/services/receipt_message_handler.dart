import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'message_handler.dart';

/// ReceiptMessageHandler - Processa recibos de entrega/leitura do Relay Engine.
class ReceiptMessageHandler with Loggable implements MessageHandler {
  final IChatRepository _repository;

  ReceiptMessageHandler(this._repository);

  @override
  Future<void> handle(Envelope envelope) async {
    try {
      final message = sigmapb.Message.fromBuffer(envelope.payload);

      // No novo protocolo, o status está na própria mensagem se for um recibo
      // ou podemos inferir do envelope se for apenas um ACK.
      // O agente-server.md lista MessageStatus.
      
      final status = (message.status == sigmapb.MessageStatus.READ)
          ? MessageStatusEntity.read
          : MessageStatusEntity.delivered;

      // Se a mensagem tem ID preenchido, é um recibo para aquela mensagem
      if (message.id.isNotEmpty) {
         await _repository.updateMessageStatus(message.id, status);
         logD('Mensagem ${message.id} marcada como $status');
      }
      
    } catch (e, stack) {
      logE('Erro ao processar recibo Relay: $e', e, stack);
    }
  }
}
