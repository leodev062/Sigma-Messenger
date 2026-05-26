import 'package:sigma/core/jobs/job_manager.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'package:sigma/data/jobs/push_text_send_job.dart';
import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';

/// Serviço de alto nível para orquestrar o início do fluxo de envio.
/// Apenas persiste e agenda o trabalho em background.
class MessageSenderService {
  static const String TAG = "MessageSenderService";

  final IChatRepository _chatRepository;
  final JobManager _jobManager;

  MessageSenderService(this._chatRepository, this._jobManager);

  Future<void> send(String chatId, String senderId, String text) async {
    final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    SigmaLog.d(TAG, "Agendando envio de mensagem para $chatId");

    // 1. Persistência local imediata (Estado: Pendente)
    await _chatRepository.saveMessage(
      id: messageId,
      chatId: chatId,
      senderId: senderId,
      text: text,
      isFromMe: true,
      status: MessageStatusEntity.pending,
    );

    // 2. Delegar complexidade de rede/cripto para o Job Queue
    _jobManager.add(PushTextSendJob(messageId));
    
    // Sincronização básica de metadados local
    await _chatRepository.updateChatMetadata(
      chatId: chatId,
      lastMessage: text,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
