/// RecipientId - Identificador único tipado.
/// Segue o padrão RecipientId.java do Signal para evitar confusão entre UUID, PNI e ACI.
class RecipientId {
  final String rawId;

  const RecipientId(this.rawId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipientId && runtimeType == other.runtimeType && rawId == other.rawId;

  @override
  int get hashCode => rawId.hashCode;

  @override
  String toString() => 'RecipientId($rawId)';

  /// Converte para String para uso em APIs ou Banco
  String serialize() => rawId;
}
