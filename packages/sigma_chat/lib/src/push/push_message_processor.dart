import 'dart:async';
import 'package:sigma_core/sigma_core.dart';
import '../data/services/message_handler.dart';
import '../data/services/data_message_handler.dart';
import '../data/services/receipt_message_handler.dart';

/// PushMessageProcessor - Refatorado para POO com Loggable.
class PushMessageProcessorImpl with Loggable implements PushMessageProcessor {
  final SignalServiceMessageSender _messageSender;
  final Map<int, MessageHandler> _handlers;

  PushMessageProcessorImpl(
    this._messageSender,
    DataMessageHandler dataHandler,
    ReceiptMessageHandler receiptHandler,
  ) : _handlers = {
        1: dataHandler, // CIPHERTEXT
        3: receiptHandler, // RECEIPT
      };

  @override
  Future<void> process(List<int> bytes) async {
    SigmaLog.i(
      "PushMessageProcessor",
      "🔄 process() INICIADO com ${bytes.length} bytes",
    );

    try {
      final wsMsg = WebSocketMessage.fromBuffer(bytes);
      SigmaLog.i(
        "PushMessageProcessor",
        "✅ Decodificado WebSocketMessage: type=${wsMsg.type}, hasRequest=${wsMsg.hasRequest()}, hasResponse=${wsMsg.hasResponse()}",
      );

      if (wsMsg.hasRequest()) {
        final req = wsMsg.request;
        SigmaLog.i(
          "PushMessageProcessor",
          "   REQUEST detectado: verb=${req.verb}, path=${req.path}, bodySize=${req.body.length}",
        );
        await _handleRequest(wsMsg.request);
      } else if (wsMsg.hasResponse()) {
        SigmaLog.i("PushMessageProcessor", "   RESPONSE detectado: id=${wsMsg.response.id}, status=${wsMsg.response.status}");
        _handleResponse(wsMsg.response);
      } else {
        SigmaLog.w("PushMessageProcessor", "⚠️ WebSocketMessage sem request nem response");
      }
    } catch (e, stack) {
      SigmaLog.e("PushMessageProcessor", "❌ Erro no processamento do frame WebSocket: $e", e, stack);
    }
  }

  Future<void> _handleRequest(WebSocketRequestMessage request) async {
    SigmaLog.i("PushMessageProcessor", "📋 _handleRequest: verb=${request.verb}, path=${request.path}");

    if (request.path.contains("v2/messages")) {
      SigmaLog.i("PushMessageProcessor", "✅ Path v2/messages detectado - processando envelope");
      await _handleEnvelope(request);
    } else if (request.path.contains("v1/sync")) {
      SigmaLog.i("PushMessageProcessor", "📅 Path v1/sync detectado - processando sync");
      await _handleSyncMessage(request);
    } else {
      SigmaLog.w("PushMessageProcessor", "⚠️ Request ignorado: ${request.path}");
    }
  }

  Future<void> _handleEnvelope(WebSocketRequestMessage request) async {
    try {
      final envelope = Envelope.fromBuffer(request.body);
      SigmaLog.i(
        "PushMessageProcessor",
        "📦 Envelope recebido de ${envelope.source} (type=${envelope.type}, contentSize=${envelope.content.length})",
      );

      final handler = _handlers[envelope.type.value];
      if (handler != null) {
        SigmaLog.i("PushMessageProcessor", "✅ Handler encontrado para tipo ${envelope.type} - processando");
        await handler.handle(envelope);
        SigmaLog.i("PushMessageProcessor", "✅ Envelope processado com sucesso");
      } else {
        SigmaLog.w(
          "PushMessageProcessor",
          "⚠️ Tipo de envelope não suportado ou sem handler: ${envelope.type} (value=${envelope.type.value})",
        );
      }

      _messageSender.acknowledgeReceipt(request.id);
    } catch (e, stack) {
      SigmaLog.e("PushMessageProcessor", "❌ Erro ao processar envelope: $e", e, stack);
    }
  }

  Future<void> _handleSyncMessage(WebSocketRequestMessage request) async {
    _messageSender.acknowledgeReceipt(request.id);
  }

  void _handleResponse(WebSocketResponseMessage response) {
    logD("Resposta do servidor recebida para ID: \${response.id}");
  }
}
