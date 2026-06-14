import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class MediaContentProcessor implements MessageContentProcessor {
  final IChatRepository _chatRepository;

  MediaContentProcessor(this._chatRepository);

  @override
  bool canProcess(sigmapb.Message payload) => 
      payload.hasImage() || payload.hasVideo() || payload.hasAudio();

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Message payload,
    required int timestamp,
  }) async {
    MessageTypeEntity type;
    String url = "";
    String? thumb;
    int? duration;

    if (payload.hasImage()) {
      type = MessageTypeEntity.image;
      url = payload.image.url;
      thumb = payload.image.thumbnail;
    } else if (payload.hasVideo()) {
      type = MessageTypeEntity.video;
      url = payload.video.url;
      thumb = payload.video.thumbnail;
      duration = payload.video.duration.toInt();
    } else if (payload.hasAudio()) {
      type = MessageTypeEntity.audio;
      url = payload.audio.url;
      duration = payload.audio.duration.toInt();
    } else {
      return;
    }

    final message = MessageEntity(
      id: messageId,
      conversationId: senderId,
      senderId: senderId,
      textContent: "",
      type: type,
      timestamp: timestamp,
      status: MessageStatusEntity.delivered,
      url: url,
      thumbnail: thumb,
      duration: duration,
    );

    await _chatRepository.saveMessageAndMetadata(message);
  }
}
