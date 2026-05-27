import 'package:sigma/core/jobs/job.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';
import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/core/crypto/crypto_manager.dart';
import 'package:sigma/data/datasources/chat/chat_remote_data_source.dart';
import 'package:sigma/data/models/signal_payload.dart';

class SendMessageJob extends Job {
  static const String _tag = "SendMessageJob";
  
  final String messageId;
  final String chatId;
  final String text;
  
  final IChatRepository _chatRepository;
  final CryptoManager _cryptoManager;
  final ChatRemoteDataSource _remoteDataSource;

  SendMessageJob({
    required this.messageId,
    required this.chatId,
    required this.text,
    required IChatRepository chatRepository,
    required CryptoManager cryptoManager,
    required ChatRemoteDataSource remoteDataSource,
  }) : _chatRepository = chatRepository,
       _cryptoManager = cryptoManager,
       _remoteDataSource = remoteDataSource,
       super(id: "msg_$messageId");

  @override
  Future<void> run() async {
    SigmaLog.d(_tag, "Executando Job de envio para mensagem $messageId");
    
    // 1. Preparar encriptação
    await _cryptoManager.init();
    
    // 2. Encriptar conteúdo
    // Nota: No Sigma/Signal, o chatId para mensagens privadas é o ID do destinatário
    final payload = SignalPayload(text: text);
    final encryptedEnvelope = await _cryptoManager.encryptMessage(chatId, payload);
    
    // 3. Enviar via rede (WebSocket)
    _remoteDataSource.sendEnvelope(chatId, encryptedEnvelope);
    
    // 4. Atualizar status local para 'sent'
    await _chatRepository.updateMessageStatus(messageId, MessageStatusEntity.sent);
    
    SigmaLog.i(_tag, "Mensagem $messageId enviada e status atualizado.");
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(_tag, "Falha ao enviar mensagem $messageId", error, stackTrace);
  }
}
