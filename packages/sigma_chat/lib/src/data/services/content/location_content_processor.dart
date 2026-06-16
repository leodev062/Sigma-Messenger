import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class LocationContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  LocationContentProcessor(this._chatRepository);

  @override
  bool canProcess(Message payload) => 
      payload.hasDataMessage() && payload.dataMessage.hasLocation();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required Message payload,
    required int timestamp,
  }) async {
    final location = payload.dataMessage.location;
    
    final message = MessageEntity(
      id: messageId,
      conversationId: senderId,
      senderId: senderId,
      textContent: "📍 Localização",
      type: MessageTypeEntity.location,
      timestamp: timestamp,
      status: MessageStatusEntity.delivered,
      latitude: location.latitude,
      longitude: location.longitude,
      accuracy: location.accuracy,
      isLive: location.isLive,
      locationTimestamp: location.timestamp.toInt(),
    );

    // Save message (metadata and content)
    await _chatRepository.saveMessageAndMetadata(message);
    
    // Save specific location data
    await _chatRepository.saveLocationData(message);
  }
}
