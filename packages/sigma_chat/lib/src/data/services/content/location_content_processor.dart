import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_chat/sigma_chat.dart';
import 'message_content_processor.dart';

class LocationContentProcessor implements MessageContentProcessor {
  LocationContentProcessor(IChatRepository chatRepository);

  @override
  bool canProcess(sigmapb.Message payload) => false; // Missing in current proto

  @override
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Message payload,
    required int timestamp,
  }) async {
    // TODO: Implement once Location is added to Message proto
  }
}
