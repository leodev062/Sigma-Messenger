abstract class Job {
  final String id;
  int retryCount = 0;
  final int maxRetries;

  Job({required this.id, this.maxRetries = 5});

  /// Lógica principal do trabalho. Deve lançar exceção para disparar re-tentativa.
  Future<void> run();
  
  /// Chamado quando o run() falha.
  void onRunError(Object error, StackTrace stackTrace);
  
  /// Define se o trabalho deve ser re-tentado com base no erro.
  bool shouldRetry(Object error) {
    return retryCount < maxRetries;
  }
}
