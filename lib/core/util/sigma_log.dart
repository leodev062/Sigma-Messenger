import 'package:flutter/foundation.dart';

/// Sistema de Log Centralizado Sigma.
/// Utiliza códigos ANSI para cores no console e formatação profissional.
class SigmaLog {
  // ANSI Escape Codes para Cores
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _cyan = '\x1B[36m';
  static const String _magenta = '\x1B[35m';

  static void d(String tag, String message) {
    if (kDebugMode) {
      _log('$_blue[DEBUG]$_reset', tag, message);
    }
  }

  static void i(String tag, String message) {
    _log('$_green[INFO]$_reset', tag, message);
  }

  static void w(String tag, String message) {
    _log('$_yellow[WARN]$_reset', tag, message);
  }

  static void e(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    _log('$_red[ERROR]$_reset', tag, message);
    if (error != null) {
      debugPrint('   $_red└─ Error: $error$_reset');
    }
    if (stackTrace != null) {
      debugPrint('   $_red└─ StackTrace: $stackTrace$_reset');
    }
  }

  /// Log para tráfego de rede e mensagens (Monitoramento em Tempo Real)
  static void traffic(String tag, String direction, String message) {
    if (kDebugMode) {
      final color = direction.contains('📥') ? _magenta : _cyan;
      _log('$color[TRAFFIC]$_reset', tag, '$direction $message');
    }
  }

  /// Logs de dados sensíveis (apenas em Debug)
  static void s(String tag, String message) {
    if (kDebugMode) {
      _log('$_magenta[SENSITIVE]$_reset', tag, message);
    }
  }

  static void _log(String level, String tag, String message) {
    final timestamp = DateTime.now().toIso8601String().split('T').last.split('.').first;
    debugPrint('$level [$timestamp] [$tag]: $message');
  }
}
