import 'package:sigma_core/sigma_core.dart';

/// ChatUiItem - Classe base para itens exibidos na lista de chat.
/// POO: Usa polimorfismo para lidar com diferentes tipos de itens na mesma lista.
sealed class ChatUiItem {
  final int timestamp;
  ChatUiItem(this.timestamp);
}

/// Representa uma mensagem real com lógica de agrupamento do Signal.
class MessageUiItem extends ChatUiItem {
  final MessageEntity message;
  final bool isFirstInGroup;
  final bool isLastInGroup;
  final bool showAvatar;
  final bool showName;
  final RecipientType recipientType;

  MessageUiItem(
    this.message, {
    this.isFirstInGroup = true,
    this.isLastInGroup = true,
    this.showAvatar = true,
    this.showName = true,
    this.recipientType = RecipientType.individual,
  }) : super(message.timestamp);
}

/// Representa um separador de data (ex: "Hoje", "Ontem").
class DateSeparatorUiItem extends ChatUiItem {
  final String dateLabel;
  DateSeparatorUiItem(this.dateLabel, int timestamp) : super(timestamp);
}
