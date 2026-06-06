import 'package:sigma_core/sigma_core.dart';

/// MessageHandler - Interface base para todos os processadores de mensagens.
/// Segue o princípio da inversão de dependência (SOLID).
abstract class MessageHandler {
  Future<void> handle(Envelope envelope);
}
