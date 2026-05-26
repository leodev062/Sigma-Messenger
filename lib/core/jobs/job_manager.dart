import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:sigma/core/network/socket_manager.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'job.dart';

/// Gerenciador de Fila de Trabalhos em Background.
/// Inspirado no JobManager do Signal-Android para garantir entrega confiável.
class JobManager {
  static const String TAG = "JobManager";
  
  final Queue<Job> _queue = Queue<Job>();
  final SocketManager _socketManager;
  bool _isProcessing = false;

  JobManager(this._socketManager) {
    _socketManager.addListener(_onSocketStatusChanged);
  }

  /// Adiciona um novo trabalho à fila e inicia o processamento se possível.
  void add(Job job) {
    SigmaLog.d(TAG, "Adicionando Job: ${job.id}");
    _queue.add(job);
    _processQueue();
  }

  void _onSocketStatusChanged() {
    if (_socketManager.isConnected) {
      SigmaLog.d(TAG, "Socket conectado. Retomando processamento da fila.");
      _processQueue();
    }
  }

  /// Percorre a fila e executa os trabalhos. Implementa Exponential Backoff.
  Future<void> _processQueue() async {
    if (_isProcessing || !_socketManager.isConnected || _queue.isEmpty) return;
    
    _isProcessing = true;
    SigmaLog.i(TAG, "Iniciando processamento de ${_queue.length} jobs.");
    
    while (_queue.isNotEmpty && _socketManager.isConnected) {
      final job = _queue.removeFirst();
      try {
        await job.run();
        SigmaLog.i(TAG, "Job ${job.id} finalizado com sucesso.");
      } catch (e, stack) {
        job.onRunError(e, stack);
        
        if (job.shouldRetry(e)) {
          job.retryCount++;
          // Exponential Backoff: 2, 4, 8, 16... segundos
          final delay = pow(2, job.retryCount).toInt(); 
          SigmaLog.w(TAG, "Job ${job.id} falhou. Agendando re-tentativa em $delay seg. (Tentativa ${job.retryCount})");
          
          Timer(Duration(seconds: delay), () {
            add(job);
          });
        } else {
          SigmaLog.e(TAG, "Job ${job.id} falhou permanentemente após ${job.retryCount} tentativas.");
        }
      }
    }
    
    _isProcessing = false;
  }
}
