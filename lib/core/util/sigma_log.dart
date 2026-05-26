import 'package:flutter/foundation.dart';

class SigmaLog {
  static void d(String tag, String message) {
    if (kDebugMode) {
      print('DEBUG [$tag]: $message');
    }
  }

  static void e(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    print('ERROR [$tag]: $message');
    if (error != null) print('Error Details: $error');
    if (stackTrace != null) print(stackTrace);
  }

  static void i(String tag, String message) {
    print('INFO [$tag]: $message');
  }

  static void w(String tag, String message) {
    print('WARN [$tag]: $message');
  }

  /// Logs sensitive data only in Debug mode.
  /// Content like message payloads should only use this.
  static void s(String tag, String message) {
    if (kDebugMode) {
      print('SENSITIVE [$tag]: $message');
    }
  }
}
