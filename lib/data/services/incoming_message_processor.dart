import 'dart:async';
import 'package:sigma/core/crypto/crypto_manager.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'package:sigma/core/util/exceptions.dart';
import 'package:sigma/data/datasources/chat/chat_remote_data_source.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';
import 'package:sigma/domain/entities/message_entity.dart';

/// Serviço responsável por processar envelopes vindos do socket.
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
    SigmaLog.i(TAG, "Processor inicializado e escutando socket.");
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  void _processIncomingData(dynamic data) async {
    try {
      if (data.type == 1 && data.request != null) {
        final request = data.request!;
        if (request.verb == "PUT" && request.path == "/api/v1/message") {
          final body = request.body;
          final chatId = body['chat_id'];
          final senderId = body['sender_id'];
          final encryptedEnvelope = body['envelope'];

          SigmaLog.d(TAG, "Envelope recebido de $senderId. Iniciando abertura.");
          
          try {
            await _cryptoManager.init();
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

          _remoteDataSource.acknowledgeReceipt(request.id);
        }
      }
    } catch (e) {
      SigmaLog.e(TAG, "Erro crítico no processamento de socket", e);
    }
  }
}
