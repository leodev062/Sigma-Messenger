import 'package:sigma_core/sigma_core.dart';

/// MessageContentProcessor - Interface para processadores de conteúdo do Relay.
abstract class MessageContentProcessor {
  bool canProcess(Message payload);

  Future<void> process({
    required String messageId,
    required String senderId,
    required Message payload,
    required int timestamp,
  });
}
