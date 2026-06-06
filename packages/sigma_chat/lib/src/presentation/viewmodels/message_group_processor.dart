import 'package:sigma_core/sigma_core.dart';
import '../models/chat_ui_item.dart';

/// MessageGroupProcessor - Encapsula a lógica de agrupamento seguindo POO.
/// Implementado para suportar execução em Isolates (Thread secundária).
class MessageGroupProcessor {
  static const int groupingThresholdMs = 60000;

  /// Método estático para ser usado com 'compute' (Isolates).
  /// Recebe uma lista de MessageEntity e retorna a lista de UI Items processada.
  static List<ChatUiItem> processInIsolate(List<MessageEntity> messages) {
    if (messages.isEmpty) return [];

    final List<ChatUiItem> uiItems = [];

    for (int i = 0; i < messages.length; i++) {
      final current = messages[i];
      final prev = i < messages.length - 1 ? messages[i + 1] : null;
      final next = i > 0 ? messages[i - 1] : null;

      final currentDate = DateTime.fromMillisecondsSinceEpoch(current.timestamp);

      final bool isFirstInGroup = _checkIsFirstInGroup(current, prev);
      final bool isLastInGroup = _checkIsLastInGroup(current, next);

      final bool showAvatar = !current.isFromMe && isLastInGroup;
      final bool showName = !current.isFromMe && isFirstInGroup;

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
    if (prev.senderRecipientId != current.senderRecipientId) return true;
    if ((current.timestamp - prev.timestamp).abs() > groupingThresholdMs) return true;
    if (!DateUtil.isSameDay(
      DateTime.fromMillisecondsSinceEpoch(current.timestamp),
      DateTime.fromMillisecondsSinceEpoch(prev.timestamp),
    )) return true;
    return false;
  }

  static bool _checkIsLastInGroup(MessageEntity current, MessageEntity? next) {
    if (next == null) return true;
    if (next.senderRecipientId != current.senderRecipientId) return true;
    if ((next.timestamp - current.timestamp).abs() > groupingThresholdMs) return true;
    if (!DateUtil.isSameDay(
      DateTime.fromMillisecondsSinceEpoch(next.timestamp),
      DateTime.fromMillisecondsSinceEpoch(current.timestamp),
    )) return true;
    return false;
  }
}
