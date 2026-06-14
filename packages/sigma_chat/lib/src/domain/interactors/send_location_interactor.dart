import 'package:sigma_core/sigma_core.dart';
import '../i_chat_repository.dart';
import '../../data/jobs/chat/push_location_send_job.dart';

class SendLocationInteractor {
  final IChatRepository _chatRepository;
  final SigmaJobManager _jobManager;

  SendLocationInteractor(this._chatRepository, this._jobManager);

  Future<void> execute({
    required String conversationId,
    required String senderId,
    required double latitude,
    required double longitude,
  }) async {
    final message = MessageEntity.createLocationOutgoing(
      conversationId: conversationId,
      senderId: senderId,
      latitude: latitude,
      longitude: longitude,
    );

    await _chatRepository.saveMessageAndMetadata(message);
    
    // Entrega garantida via Job especializado em localização
    await _jobManager.add(PushLocationSendJob(messageId: message.id));
  }
}
