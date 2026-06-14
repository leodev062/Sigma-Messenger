import 'package:sigma_core/sigma_core.dart';
import 'message_handler.dart';
import 'content/message_content_processor.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

/// DataMessageHandler - Refatorado para o padrão Relay Protobuf (agente-server.md).
class DataMessageHandler with Loggable implements MessageHandler {
  final List<MessageContentProcessor> _processors;

  DataMessageHandler(this._processors);

  @override
  Future<void> handle(Envelope envelope) async {
    final senderId = envelope.from;

    try {
      final message = sigmapb.Message.fromBuffer(envelope.payload);
      
      final messageId = message.id.isNotEmpty ? message.id : "msg_\${envelope.createdAt}_\${envelope.from}";
      final timestamp = message.timestamp > 0 ? message.timestamp.toInt() : DateTime.now().millisecondsSinceEpoch;

      // Executa a estratégia correta baseada no conteúdo da Message
      bool processed = false;
      
      for (final processor in _processors) {
        if (processor.canProcess(message)) {
          await processor.process(
            messageId: messageId,
            senderId: senderId,
            payload: message,
            timestamp: timestamp,
          );
          processed = true;
          break;
        }
      }

      if (!processed) {
        logW("Nenhum processador encontrado para o payload de \$senderId (content type: \${message.whichContent()})");
      }
      
    } catch (e, stack) {
      logE("Falha ao processar Relay Message", e, stack);
      rethrow;
    }
  }
}
