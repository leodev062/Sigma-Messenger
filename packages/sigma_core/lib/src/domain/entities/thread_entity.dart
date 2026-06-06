import 'recipient.dart';

/// Representa uma entrada na Inbox (Caixa de Entrada).
/// Inspirado na Thread do Signal-Android.
class ThreadEntity {
  final int id;
  final Recipient recipient;
  final String? snippet;
  final int date;
  final int unreadCount;
  
  // Novas flags estilo Signal
  final bool isArchived;
  final int pinnedOrder;

  ThreadEntity({
    required this.id,
    required this.recipient,
    this.snippet,
    required this.date,
    this.unreadCount = 0,
    this.isArchived = false,
    this.pinnedOrder = 0,
  });

  bool get isPinned => pinnedOrder > 0;
}
