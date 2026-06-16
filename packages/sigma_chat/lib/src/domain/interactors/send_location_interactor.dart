import 'package:sigma_core/sigma_core.dart';
import '../i_chat_repository.dart';
import '../../data/jobs/chat/push_location_send_job.dart';

class SendLocationInteractor {
  final IChatRepository _chatRepository;
  final SigmaJobManager _jobManager;

  SendLocationInteractor(this._chatRepository, this._jobManager);

  Future<MessageEntity> execute({
    required String conversationId,
    required String senderId,
    required double latitude,
    required double longitude,
    double? accuracy,
    bool isLive = false,
    String destinationType = "USER",
  }) async {
    final message = MessageEntity.createLocationOutgoing(
      conversationId: conversationId,
      senderId: senderId,
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
      isLive: isLive,
    );

    await _chatRepository.saveMessageAndMetadata(message);
    await _chatRepository.saveLocationData(message);
    
    // Entrega garantida via Job especializado em localização
    await _jobManager.add(PushLocationSendJob(
      messageId: message.id,
      destinationType: destinationType,
    ));
    
    return message;
  }
}
