import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:drift/drift.dart' show Value;
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_core/src/domain/services/i_socket_service.dart';
import 'package:sigma_core/src/util/sigma_log.dart';
import 'job.dart';
import 'job_priority.dart';

import 'package:get_it/get_it.dart';
import 'job_chain.dart';

typedef JobFactory =
    Job Function(Map<String, dynamic> data, int databaseId, GetIt locator);

/// SigmaJobManager - Refatorado para POO com Mixin Loggable.
/// Gerencia o ciclo de vida e a resiliência de tarefas em background.
class SigmaJobManager with Loggable {
  final JobDao _jobDao;
  final ISocketService _socketService;
  final GetIt _locator;
  final Map<String, JobFactory> _factories = {};

  ISocketService get socketService => _socketService;

  bool _isProcessing = false;
  Completer<void>? _processingCompleter;

  StreamSubscription? _statusSubscription;
  StreamSubscription? _incomingMessagesSubscription;

  SigmaJobManager(this._jobDao, this._socketService, this._locator) {
    _jobDao.resetAllJobsStatus();

    _statusSubscription = _socketService.status.listen((status) {
      logI("🔄 JobManager: Socket status mudou para $status");
      if (status == SocketConnectionStatus.connected) {
        _processPendingJobs();
      }
    });

    _incomingMessagesSubscription = _socketService.messages.listen((
      msg,
    ) {
      logI("JobManager: Mensagem recebida do socket. Tipo: ${msg.type}");
      
      bool isMessagePath = false;
      if (msg.hasRequest()) {
        final path = msg.request.path;
        logI("JobManager: Request detectado. Path: $path");
        isMessagePath = path.contains("v2/messages");
      }

      if (isMessagePath) {
        SigmaLog.i(
          "JobManager",
          "📨 Mensagem de entrada (Envelope) detectada no stream - enfileirando PushReceiveJob",
        );
        addRaw("PushReceiveJob", {'bytes': msg.writeToBuffer()});
      } else {
        logW("JobManager: Mensagem ignorada (não é v2/messages ou não tem request)");
      }
    });

    logI("✅ JobManager inicializado. Escutando socket...");
  }

  void registerFactory(String key, JobFactory factory) {
    _factories[key] = factory;
  }

  Future<bool> hasJob(String queueKey) => _jobDao.hasPendingJob(queueKey);

  /// Enfileira uma cadeia de trabalhos.
  Future<void> addChain(JobChain chain) async {
    final jobs = chain.build();
    if (jobs.isEmpty) return;

    for (int i = 0; i < jobs.length - 1; i++) {
      final current = jobs[i];
      final next = jobs[i + 1];

      current.nextJobKey = next.factoryKey;
      current.nextJobData = next.serialize();
    }

    await add(jobs.first);
  }

  /// Enfileira um novo trabalho de forma encapsulada.
  Future<void> add(Job job) async {
    final id = await _jobDao.insertJob(
      JobsCompanion.insert(
        factoryKey: job.factoryKey,
        queueKey: Value(job.queueKey),
        data: jsonEncode(job.serialize()),
        priority: Value(job.priority.index),
        createTime: DateTime.now().millisecondsSinceEpoch,
        nextRunAttemptTime: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    logD(
      "Job enfileirado: ${job.factoryKey} (ID: $id, Priority: ${job.priority})",
    );
    _processPendingJobs();
  }

  /// Adiciona um job diretamente pelo factory key e dados (para evitar dependência circular).
  Future<void> addRaw(
    String factoryKey,
    Map<String, dynamic> data, {
    JobPriority priority = JobPriority.medium,
    String? queueKey,
  }) async {
    logI(
      "📌 addRaw($factoryKey): Enfileirando novo job com priority=$priority",
    );

    final id = await _jobDao.insertJob(
      JobsCompanion.insert(
        factoryKey: factoryKey,
        queueKey: Value(queueKey),
        data: jsonEncode(data),
        priority: Value(priority.index),
        createTime: DateTime.now().millisecondsSinceEpoch,
        nextRunAttemptTime: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    logI("✅ Job enfileirado: $factoryKey (ID: $id, Priority: $priority)");
    _processPendingJobs();
  }

  Future<void> _processPendingJobs() async {
    if (_isProcessing) {
      logD(
        "⏳ Processamento de Jobs já em andamento. Ignorando chamada redundante.",
      );
      return;
    }
    _isProcessing = true;
    _processingCompleter = Completer<void>();

    logI("🚀 Iniciando processamento de Jobs pendentes...");

    try {
      while (true) {
        if (!_socketService.isConnected) {
          logW(
            "⚠️ WebSocket desconectado. Interrompendo processamento de Jobs.",
          );
          break;
        }

        final pendingData = await _jobDao.getPendingJobs();
        if (pendingData.isEmpty) {
          logD("✓ Nenhum Job pendente encontrado.");
          break;
        }

        bool processedAny = false;
        for (final data in pendingData) {
          if (!_socketService.isConnected) break;

          final now = DateTime.now().millisecondsSinceEpoch;
          if (now < data.nextRunAttemptTime) {
            continue;
          }

          final factory = _factories[data.factoryKey];
          if (factory == null) {
            logE(
              "Nenhum factory registrado para ${data.factoryKey}. Deletando Job órfão.",
            );
            await _jobDao.deleteJob(data.id);
            processedAny = true;
            continue;
          }

          final job = factory(jsonDecode(data.data), data.id, _locator);

          await _runJob(job, data);
          processedAny = true;
        }

        if (!processedAny) break;
      }
    } catch (e, stack) {
      logE("Erro crítico no loop de processamento de Jobs", e, stack);
    } finally {
      _isProcessing = false;
      _processingCompleter?.complete();
    }
  }

  Future<void> _runJob(Job job, JobRecord data) async {
    await _jobDao.markJobRunning(data.id, true);

    final stopwatch = Stopwatch()..start();
    try {
      logI(
        ">> Executando Job: ${job.factoryKey} (ID: ${data.id}, Tentativa: ${data.runAttempt + 1})",
      );
      await job.run();
      stopwatch.stop();
      logI(
        "<< Job ${job.factoryKey} (ID: ${data.id}) concluído com sucesso em ${stopwatch.elapsedMilliseconds}ms",
      );
      await _jobDao.deleteJob(data.id);

      if (job.nextJobKey != null) {
        logI("Encadeando próximo Job: ${job.nextJobKey}");
        _processChain(job);
      }
    } catch (e, stack) {
      stopwatch.stop();
      logE(
        "!! Falha no Job ${job.factoryKey} (ID: ${data.id}) após ${stopwatch.elapsedMilliseconds}ms",
        e,
        stack,
      );
      job.onRunError(e, stack);
      await _handleJobFailure(job, data, e);
    }
  }

  void _processChain(Job job) {
    final nextFactory = _factories[job.nextJobKey];
    if (nextFactory != null) {
      final nextJob = nextFactory(job.nextJobData ?? {}, -1, _locator);
      add(nextJob);
    } else {
      logE("Falha ao encadear: Factory ${job.nextJobKey} não encontrada");
    }
  }

  Future<void> _handleJobFailure(Job job, JobRecord data, Object error) async {
    final attemptCount = data.runAttempt + 1;

    if (job.shouldRetry(error) && attemptCount < job.maxAttempts) {
      final delay = pow(2, attemptCount).toInt() * 5000;
      final nextAttempt = DateTime.now().millisecondsSinceEpoch + delay;

      await _jobDao.updateRetry(data.id, nextAttempt, attemptCount);
      logW("Job ${data.id} falhou. Reagendado para +${delay / 1000}s");
    } else {
      await _jobDao.deleteJob(data.id);
      logE("Job ${data.id} falhou permanentemente.", error);
    }
  }

  void dispose() {
    _statusSubscription?.cancel();
    _incomingMessagesSubscription?.cancel();
  }
}
