/// ReactionEntity - Representa uma reação de emoji em uma mensagem.
/// Inspirado no ReactionRecord.kt do Signal.
class ReactionEntity {
  final String authorId;
  final String emoji;
  final int dateSent;
  final int dateReceived;

  ReactionEntity({
    required this.authorId,
    required this.emoji,
    required this.dateSent,
    required this.dateReceived,
  });
}
