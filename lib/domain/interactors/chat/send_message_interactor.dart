import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';
import 'package:sigma/core/jobs/job_manager.dart';
import 'package:sigma/core/jobs/send_message_job.dart';
import 'package:sigma/core/crypto/crypto_manager.dart';
import 'package:sigma/data/datasources/chat/chat_remote_data_source.dart';
import 'package:sigma/app/locator.dart';

class SendMessageInteractor {
  final IChatRepository _chatRepository;
  final JobManager _jobManager;

  SendMessageInteractor(this._chatRepository, this._jobManager);

  Future<void> execute({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    final messageId = DateTime.now().millisecondsSinceEpoch.toString();

    // 1. Salvar IMEDIATAMENTE no banco local como 'pending'
    // Esta é a ÚNICA fonte de verdade para a UI
    await _chatRepository.saveMessage(
      id: messageId,
      chatId: chatId,
      senderId: senderId,
      text: text,
      isFromMe: true,
      status: MessageStatusEntity.pending,
    );

    // 2. Atualizar metadados do chat para refletir na lista
    await _chatRepository.updateChatMetadata(
      chatId: chatId,
      lastMessage: text,
      timestamp: int.parse(messageId),
    );

    // 3. Enfileirar o Job de envio
    // O JobManager tentará enviar agora ou quando a rede voltar
    final job = SendMessageJob(
      messageId: messageId,
      chatId: chatId,
      text: text,
      chatRepository: _chatRepository,
      cryptoManager: locator<CryptoManager>(),
      remoteDataSource: locator<ChatRemoteDataSource>(),
    );

    _jobManager.add(job);
  }
}
