import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:sigma/domain/services/i_socket_service.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'job.dart';

/// Gerenciador de Fila de Trabalhos em Background.
/// Inspirado no JobManager do Signal-Android para garantir entrega confiável.
class JobManager {
  static const String _tag = "JobManager";
  
  final Queue<Job> _queue = Queue<Job>();
  final ISocketService _socketService;
  bool _isProcessing = false;
  StreamSubscription? _statusSubscription;

  JobManager(this._socketService) {
    _statusSubscription = _socketService.status.listen((status) {
      if (status == SocketConnectionStatus.connected) {
        SigmaLog.d(_tag, "Socket conectado. Retomando processamento da fila.");
        _processQueue();
      }
    });
  }

  void dispose() {
    _statusSubscription?.cancel();
  }

  /// Adiciona um novo trabalho à fila e inicia o processamento se possível.
  void add(Job job) {
    SigmaLog.d(_tag, "Adicionando Job: ${job.id}");
    _queue.add(job);
    _processQueue();
  }

  /// Percorre a fila e executa os trabalhos. Implementa Exponential Backoff.
  Future<void> _processQueue() async {
    if (_isProcessing || !_socketService.isConnected || _queue.isEmpty) return;
    
    _isProcessing = true;
    SigmaLog.i(_tag, "Iniciando processamento de ${_queue.length} jobs.");
    
    while (_queue.isNotEmpty && _socketService.isConnected) {
      final job = _queue.removeFirst();
      try {
        await job.run();
        SigmaLog.i(_tag, "Job ${job.id} finalizado com sucesso.");
      } catch (e, stack) {
        job.onRunError(e, stack);
        
        if (job.shouldRetry(e)) {
          job.retryCount++;
          // Exponential Backoff: 2, 4, 8, 16... segundos
          final delay = pow(2, job.retryCount).toInt(); 
          SigmaLog.w(_tag, "Job ${job.id} falhou. Agendando re-tentativa em $delay seg. (Tentativa ${job.retryCount})");
          
          Timer(Duration(seconds: delay), () {
            add(job);
          });
        } else {
          SigmaLog.e(_tag, "Job ${job.id} falhou permanentemente após ${job.retryCount} tentativas.");
        }
      }
    }
    
    _isProcessing = false;
  }
}
