import 'dart:convert';
import 'package:sigma_core/sigma_core.dart';
import 'message_handler.dart';
import 'content/message_content_processor.dart';

/// DataMessageHandler (Anteriormente TextMessageHandler)
/// Refatorado para o padrão Strategy. Agora ele coordena os processadores de conteúdo.
class DataMessageHandler with Loggable implements MessageHandler {
  final CryptoManager _cryptoManager;
  final List<MessageContentProcessor> _processors;

  DataMessageHandler(this._cryptoManager, this._processors);

  @override
  Future<void> handle(Envelope envelope) async {
    final senderId = envelope.source;
    final encryptedEnvelope = base64Encode(envelope.content);

    logD("Recebida DataMessage de $senderId. Desencriptando...");

    try {
      final payload = await _cryptoManager.decryptMessage(senderId, encryptedEnvelope);
      final messageId = "msg_${envelope.timestamp}_${envelope.source}";
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      // Executa a estratégia correta baseada no conteúdo do payload
      bool processed = false;
      for (final processor in _processors) {
        if (processor.canProcess(payload)) {
          await processor.process(
            messageId: messageId,
            senderId: senderId,
            payload: payload,
            timestamp: timestamp,
          );
          processed = true;
          break;
        }
      }

      if (!processed) {
        logW("Nenhum processador encontrado para o payload de $senderId");
      }
      
    } catch (e) {
      logE("Falha ao processar DataMessage", e);
      rethrow;
    }
  }
}
