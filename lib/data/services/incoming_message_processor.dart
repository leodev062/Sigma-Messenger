import 'dart:async';
import 'dart:convert';
import 'package:sigma/core/crypto/crypto_manager.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'package:sigma/core/util/exceptions.dart';
import 'package:sigma/data/datasources/chat/chat_remote_data_source.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';
import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/core/network/pb/websocket.pb.dart' as ws_pb;
import 'package:sigma/core/network/pb/envelope.pb.dart' as env_pb;

/// Serviço responsável por processar envelopes vindos do socket (Protobuf v1).
/// Desencripta e persiste no banco via Repositório.
class IncomingMessageProcessor {
  static const String TAG = "IncomingMessageProcessor";

  final ChatRemoteDataSource _remoteDataSource;
  final IChatRepository _chatRepository;
  final CryptoManager _cryptoManager;
  
  StreamSubscription? _subscription;

  IncomingMessageProcessor(
    this._remoteDataSource,
    this._chatRepository,
    this._cryptoManager,
  );

  void init() {
    _subscription?.cancel();
    _subscription = _remoteDataSource.messageStream.listen((msg) {
      _processIncomingData(msg);
    });
    SigmaLog.i(TAG, "Processor inicializado e escutando socket (Protobuf v1).");
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  void _processIncomingData(ws_pb.WebSocketMessage data) async {
    try {
      // No backend v1, mensagens entre usuários chegam como REQUEST ou MESSAGE
      if ((data.type == ws_pb.WebSocketMessage_Type.REQUEST || data.type == ws_pb.WebSocketMessage_Type.MESSAGE) && data.hasRequest()) {
        final request = data.request;
        
        // Caminho esperado conforme connection.go: v2/messages/{id}
        if (request.verb == "PUT" && request.path.contains("v2/messages")) {
          // O body do request contém o Envelope binário
          final envelope = env_pb.Envelope.fromBuffer(request.body);
          
          final senderId = envelope.source;
          final encryptedEnvelope = base64Encode(envelope.content);

          SigmaLog.d(TAG, "Envelope recebido de $senderId via Protobuf. Iniciando abertura.");
          
          try {
            await _cryptoManager.init();
            
            // O chatId para mensagens recebidas é o ID do remetente
            final chatId = senderId; 
            
            final payload = await _cryptoManager.decryptMessage(senderId, encryptedEnvelope);

            final now = DateTime.now().millisecondsSinceEpoch;
            final messageId = now.toString();

            final cleanText = payload.text ?? "";
            final attachment = payload.attachment;

            await _chatRepository.saveMessage(
              id: messageId,
              chatId: chatId,
              senderId: senderId,
              text: cleanText,
              isFromMe: false,
              status: MessageStatusEntity.read,
              attachmentUrl: attachment?.url,
              attachmentAesKey: attachment?.aesKeyBase64,
              attachmentMacKey: attachment?.macKeyBase64,
            );

            await _chatRepository.updateChatMetadata(
              chatId: chatId,
              lastMessage: cleanText.isEmpty && attachment != null ? "📎 Anexo" : cleanText,
              timestamp: now,
            );

            SigmaLog.i(TAG, "Mensagem de $senderId processada e salva.");
          } on DecryptionException catch (e) {
            SigmaLog.e(TAG, "Falha na descriptografia: ${e.message}");
          } catch (e) {
            SigmaLog.e(TAG, "Erro ao descriptografar/salvar mensagem", e);
          }

          // Confirma recebimento para o servidor
          _remoteDataSource.acknowledgeReceipt(request.id);
        }
      }
    } catch (e) {
      SigmaLog.e(TAG, "Erro crítico no processamento de socket Protobuf v1", e);
    }
  }
}
