import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class LocationContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  LocationContentProcessor(this._chatRepository);

  @override
  bool canProcess(sigmapb.Content payload) => 
      payload.hasDataMessage() && payload.dataMessage.hasLocation();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Content payload,
    required int timestamp,
  }) async {
    final location = payload.dataMessage.location;
    
    final message = MessageEntity(
      id: messageId,
      threadId: 0,
      chatId: senderId,
      senderRecipientId: senderId,
      textContent: location.address.isNotEmpty ? location.address : "📍 Localização",
      type: MessageTypeEntity.location,
      timestamp: timestamp,
      status: MessageStatusEntity.read,
      isFromMe: false,
      latitude: location.latitude,
      longitude: location.longitude,
    );

    await _chatRepository.saveMessageAndMetadata(message);
  }
}
