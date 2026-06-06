import 'job_priority.dart';

/// Classe base Job - Persistível e Encadeável.
/// Inspirado no Job.java do Signal-Android.
abstract class Job {
  final int? databaseId;
  final String factoryKey;
  final String? queueKey;
  
  // Novos atributos para Alta Escala
  final JobPriority priority;
  final JobNetworkConstraint networkConstraint;

  /// Identificador para encadeamento. Se definido, o JobManager
  /// tentará executar o próximo Job da cadeia após o sucesso deste.
  String? nextJobKey;
  
  /// Dados para o próximo Job na cadeia (opcional).
  Map<String, dynamic>? nextJobData;

  Job({
    this.databaseId,
    required this.factoryKey,
    this.queueKey,
    this.nextJobKey,
    this.nextJobData,
    this.priority = JobPriority.medium,
    this.networkConstraint = JobNetworkConstraint.any,
  });

  /// Executa o trabalho. Deve lançar exceção para disparar retry.
  Future<void> run();

  /// Serializa os parâmetros para o banco.
  Map<String, dynamic> serialize();

  /// Chamado em caso de erro.
  void onRunError(Object error, StackTrace stackTrace);

  /// Determina se deve haver re-tentativa.
  bool shouldRetry(Object error) => true;

  /// Condições para execução (Ex: Requer rede).
  bool get requiresNetwork => networkConstraint != JobNetworkConstraint.none;

  /// Máximo de tentativas (Padrão Signal: 10)
  int get maxAttempts => 10;
}
