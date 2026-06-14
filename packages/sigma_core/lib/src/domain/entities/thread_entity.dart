import 'recipient.dart';

/// Representa uma entrada na Inbox (Caixa de Entrada).
/// Inspirado na Thread do Signal-Android.
class ThreadEntity {
  final String id;
  final Recipient recipient;
  final String? snippet;
  final int date;
  final int unreadCount;
  
  // Novas flags estilo Signal
  final bool isArchived;
  final bool isMuted;
  final int pinnedOrder;

  ThreadEntity({
    required this.id,
    required this.recipient,
    this.snippet,
    required this.date,
    this.unreadCount = 0,
    this.isArchived = false,
    this.isMuted = false,
    this.pinnedOrder = 0,
  });

  bool get isPinned => pinnedOrder > 0;

  ThreadEntity copyWith({
    String? id,
    Recipient? recipient,
    String? snippet,
    int? date,
    int? unreadCount,
    bool? isArchived,
    bool? isMuted,
    int? pinnedOrder,
  }) {
    return ThreadEntity(
      id: id ?? this.id,
      recipient: recipient ?? this.recipient,
      snippet: snippet ?? this.snippet,
      date: date ?? this.date,
      unreadCount: unreadCount ?? this.unreadCount,
      isArchived: isArchived ?? this.isArchived,
      isMuted: isMuted ?? this.isMuted,
      pinnedOrder: pinnedOrder ?? this.pinnedOrder,
    );
  }

  ThreadEntity copyWithRecipient(Recipient recipient) => copyWith(recipient: recipient);
}
