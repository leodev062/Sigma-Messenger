import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

/// MessageContentProcessor - Interface para processadores de conteúdo do Relay.
abstract class MessageContentProcessor {
  bool canProcess(sigmapb.Message payload);

  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Message payload,
    required int timestamp,
  });
}
