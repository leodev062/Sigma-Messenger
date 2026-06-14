import 'package:sigma_core/sigma_core.dart';
import '../models/chat_ui_item.dart';

/// MessageGroupProcessor - Encapsula a lógica de agrupamento seguindo POO.
/// Implementado para suportar execução em Isolates (Thread secundária).
class MessageGroupProcessor {
  static const int groupingThresholdMs = 60000;

  /// Parâmetros para processamento em Isolate.
  /// Necessário porque Isolates não compartilham memória estática (Identity.currentUserId).
  static List<ChatUiItem> processInIsolate(Map<String, dynamic> params) {
    final List<MessageEntity> messages = params['messages'] as List<MessageEntity>;
    final String currentUserId = params['currentUserId'] as String;

    if (messages.isEmpty) return [];

    final List<ChatUiItem> uiItems = [];

    for (int i = 0; i < messages.length; i++) {
      final current = messages[i];
      final prev = i < messages.length - 1 ? messages[i + 1] : null;
      final next = i > 0 ? messages[i - 1] : null;

      final currentDate = DateTime.fromMillisecondsSinceEpoch(current.timestamp);

      final bool isFirstInGroup = _checkIsFirstInGroup(current, prev);
      final bool isLastInGroup = _checkIsLastInGroup(current, next);

      final bool isFromMe = current.senderId == currentUserId;
      final bool showAvatar = !isFromMe && isLastInGroup;
      final bool showName = !isFromMe && isFirstInGroup;

      uiItems.add(MessageUiItem(
        current,
        isFirstInGroup: isFirstInGroup,
        isLastInGroup: isLastInGroup,
        showAvatar: showAvatar,
        showName: showName,
      ));

      if (prev == null || !DateUtil.isSameDay(currentDate, DateTime.fromMillisecondsSinceEpoch(prev.timestamp))) {
        uiItems.add(DateSeparatorUiItem("", current.timestamp));
      }
    }

    return uiItems;
  }

  static bool _checkIsFirstInGroup(MessageEntity current, MessageEntity? prev) {
    if (prev == null) return true;
    if (prev.senderId != current.senderId) return true;
    if ((current.timestamp - prev.timestamp).abs() > groupingThresholdMs) return true;
    if (!DateUtil.isSameDay(
      DateTime.fromMillisecondsSinceEpoch(current.timestamp),
      DateTime.fromMillisecondsSinceEpoch(prev.timestamp),
    )) return true;
    return false;
  }

  static bool _checkIsLastInGroup(MessageEntity current, MessageEntity? next) {
    if (next == null) return true;
    if (next.senderId != current.senderId) return true;
    if ((next.timestamp - current.timestamp).abs() > groupingThresholdMs) return true;
    if (!DateUtil.isSameDay(
      DateTime.fromMillisecondsSinceEpoch(next.timestamp),
      DateTime.fromMillisecondsSinceEpoch(current.timestamp),
    )) return true;
    return false;
  }
}
