import 'package:sigma/app/locator.dart';
import 'package:sigma/core/crypto/crypto_manager.dart';
import 'package:sigma/core/jobs/job.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'package:sigma/data/datasources/chat/chat_remote_data_source.dart';
import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';
import 'package:sigma/data/models/signal_payload.dart';

/// Job responsável por encriptar e enviar uma mensagem de texto.
/// Resolve suas próprias dependências via locator, mantendo o estado serializável se necessário.
class PushTextSendJob extends Job {
  static const String TAG = "PushTextSendJob";
  final String messageId;

  PushTextSendJob(this.messageId) : super(id: "push_text_send_$messageId");

  @override
  Future<void> run() async {
    final chatRepository = locator<IChatRepository>();
    final cryptoManager = locator<CryptoManager>();
    final remoteDataSource = locator<ChatRemoteDataSource>();

    // 1. Buscar mensagem no banco
    final message = await chatRepository.getMessage(messageId);
    
    if (message == null) {
      SigmaLog.w(TAG, "Mensagem $messageId não encontrada. Abortando Job.");
      return;
    }

    if (message.status != MessageStatusEntity.pending) {
      SigmaLog.d(TAG, "Mensagem $messageId já processada (Status: ${message.status}). Ignorando.");
      return;
    }

    // 2. Encriptar para o destinatário
    await cryptoManager.init();
    final encryptedEnvelope = await cryptoManager.encryptMessage(
      message.chatId,
      SignalPayload(text: message.textContent),
    );

    // 3. Transmitir via Socket
    // Se o socket cair aqui, o run() lançará erro e o JobManager fará a re-tentativa.
    remoteDataSource.sendEnvelope(message.chatId, encryptedEnvelope);

    // 4. Atualizar status local
    await chatRepository.updateMessageStatus(messageId, MessageStatusEntity.sent);
    
    SigmaLog.i(TAG, "Mensagem $messageId enviada e confirmada localmente.");
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(TAG, "Erro ao executar PushTextSendJob para $messageId", error, stackTrace);
  }
}
