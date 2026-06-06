import 'package:sigma_core/sigma_core.dart';
import '../i_chat_repository.dart';
import '../../data/jobs/chat/push_text_send_job.dart';

/// SendMessageInteractor - Refatorado para usar o novo modelo OO de MessageEntity.
class SendMessageInteractor with Loggable {
  final IChatRepository _chatRepository;
  final SigmaJobManager _jobManager;

  SendMessageInteractor(this._chatRepository, this._jobManager);

  Future<void> execute(
    int threadId,
    String chatId,
    String senderId,
    String text,
  ) async {
    try {
      // A lógica de criação foi movida para o método da classe MessageEntity (Factory POO)
      final message = MessageEntity.createTextOutgoing(
        threadId: threadId,
        chatId: chatId,
        senderId: senderId,
        text: text,
      );

      logD("Iniciando envio local: \${message.id}");

      // 1. Persistência local imediata e atualização de metadados da thread (Atômico)
      await _chatRepository.saveMessageAndMetadata(message);
      
      logI("Mensagem salva localmente: \${message.id}");

      // 2. Entrega assíncrona garantida via Jobs
      _jobManager.add(PushTextSendJob(messageId: message.id));
      
    } catch (e, stack) {
      logE("Erro crítico ao processar envio de mensagem", e, stack);
    }
  }
}
