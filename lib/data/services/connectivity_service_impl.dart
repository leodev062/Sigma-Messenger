import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sigma/domain/services/i_connectivity_service.dart';
import 'package:sigma/core/util/sigma_log.dart';

class ConnectivityServiceImpl implements IConnectivityService {
  static const String _tag = "ConnectivityService";
  final Connectivity _connectivity = Connectivity();
  
  final _controller = StreamController<bool>.broadcast();

  ConnectivityServiceImpl() {
    _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  @override
  Stream<bool> get isConnectedStream => _controller.stream;

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return _isOnline(result);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final online = _isOnline(results);
    SigmaLog.i(_tag, "Conexão alterada: ${online ? 'ONLINE' : 'OFFLINE'}");
    _controller.add(online);
  }

  bool _isOnline(List<ConnectivityResult> results) {
    return results.any((result) => 
      result == ConnectivityResult.mobile || 
      result == ConnectivityResult.wifi || 
      result == ConnectivityResult.ethernet
    );
  }
}
