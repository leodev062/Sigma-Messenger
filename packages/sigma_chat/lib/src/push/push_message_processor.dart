import 'dart:async';
import 'package:sigma_core/sigma_core.dart';
import '../data/services/data_message_handler.dart';

/// PushMessageProcessor - Refatorado para POO com Loggable e Relay Engine (agente-server.md).
class PushMessageProcessorImpl with Loggable implements PushMessageProcessor {
  final SignalServiceMessageSender _messageSender;
  final DataMessageHandler _dataHandler;

  PushMessageProcessorImpl(
    this._messageSender,
    this._dataHandler,
  );

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
    } else {
      SigmaLog.w("PushMessageProcessor", "⚠️ Request ignorado: ${request.path}");
      _messageSender.acknowledgeReceipt(request.id);
    }
  }

  Future<void> _handleEnvelope(WebSocketRequestMessage request) async {
    try {
      final envelope = Envelope.fromBuffer(request.body);
      SigmaLog.i(
        "PushMessageProcessor",
        "📦 Envelope recebido de ${envelope.from} (status=${envelope.status}, payloadSize=${envelope.payload.length})",
      );

      await _dataHandler.handle(envelope);
      SigmaLog.i("PushMessageProcessor", "✅ Envelope processado com sucesso");

      _messageSender.acknowledgeReceipt(request.id);
    } catch (e, stack) {
      SigmaLog.e("PushMessageProcessor", "❌ Erro ao processar envelope: $e", e, stack);
    }
  }

  void _handleResponse(WebSocketResponseMessage response) {
    logD("Resposta do servidor recebida para ID: ${response.id}");
  }
}
