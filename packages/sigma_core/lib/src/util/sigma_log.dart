import 'dart:developer' as dev;

/// SigmaLog - Refatorado para POO com Mixin.
/// Agora as classes não precisam definir a tag manualmente.
class SigmaLog {
  static void d(String tag, String message) {
    dev.log('DEBUG: $message', name: tag);
  }

  static void i(String tag, String message) {
    dev.log('INFO: $message', name: tag);
  }

  static void w(String tag, String message) {
    dev.log('WARNING: $message', name: tag);
  }

  static void e(String tag, String message, [Object? error, StackTrace? stack]) {
    dev.log('ERROR: $message', name: tag, error: error, stackTrace: stack);
  }
}

/// Mixin Loggable - POO para automatizar logs com a tag correta da classe.
mixin Loggable {
  String get _logTag => runtimeType.toString();

  void logD(String message) => SigmaLog.d(_logTag, message);
  void logI(String message) => SigmaLog.i(_logTag, message);
  void logW(String message) => SigmaLog.w(_logTag, message);
  void logE(String message, [Object? error, StackTrace? stack]) => 
      SigmaLog.e(_logTag, message, error, stack);
}
