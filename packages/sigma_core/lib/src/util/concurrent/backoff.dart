import 'dart:math';

/// Backoff - Utilitário de atraso exponencial com Jitter.
/// Tradução direta do padrão Backoff.java do Signal-Android.
class Backoff {
  final int baseDelay;
  final int maxDelay;
  int _attempts = 0;
  final Random _random = Random();

  Backoff({
    this.baseDelay = 1000, // 1 segundo
    this.maxDelay = 120000, // 2 minutos (Capped)
  });

  /// Retorna o próximo atraso em milissegundos.
  int getNextDelay() {
    // Delay = base * (2 ^ attempts)
    final exponential = baseDelay * pow(2, _attempts).toInt();
    final delay = min(exponential, maxDelay);
    
    _attempts++;

    // Adiciona Jitter (vulnerabilidade aleatória de +/- 10%)
    // Isso evita que milhões de dispositivos tentem reconectar no exato milissegundo.
    final jitter = (delay * 0.1).toInt();
    if (jitter <= 0) return delay;
    
    return (delay - jitter) + _random.nextInt(jitter * 2);
  }

  /// Reseta o contador de tentativas.
  /// Chamado no Signal após um handshake WebSocket bem-sucedido.
  void reset() {
    _attempts = 0;
  }

  int get attemptCount => _attempts;
}
