import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

/// TypingIndicatorJob - Envia indicadores de digitação Relay.
class TypingIndicatorJob extends core.Job {
  static const String KEY = "TypingIndicatorJob";

  final String chatId;
  final String recipientId;
  final bool isTyping; // true = começou, false = parou

  final SignalServiceMessageSender? messageSender;

  TypingIndicatorJob({
    required this.chatId,
    required this.recipientId,
    required this.isTyping,
    this.messageSender,
    int? databaseId,
  }) : super(
         databaseId: databaseId,
         factoryKey: KEY,
         queueKey: "typing_$recipientId",
         priority: JobPriority.medium,
       );

  @override
  Map<String, dynamic> serialize() => {
    'chatId': chatId,
    'recipientId': recipientId,
    'isTyping': isTyping,
  };

  static core.Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return TypingIndicatorJob(
      chatId: data['chatId'],
      recipientId: data['recipientId'],
      isTyping: data['isTyping'] ?? true,
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    try {
      final relayMessage = sigmapb.Message()
        ..id = "typing_${DateTime.now().millisecondsSinceEpoch}"
        ..conversationId = recipientId
        ..senderId = "me"
        ..receiverId = recipientId
        ..type = sigmapb.MessageType.TEXT 
        ..timestamp = fixnum.Int64(DateTime.now().millisecondsSinceEpoch);

      messageSender!.sendUnencryptedEnvelope(recipientId, relayMessage);
    } catch (e, stack) {
      SigmaLog.e(KEY, "Erro ao enviar typing indicator Relay: $e", e, stack);
    }
  }

  @override
  bool shouldRetry(Object error) {
    return false;
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.w(KEY, "Falha no envio de typing indicator Relay: $error");
  }
}
