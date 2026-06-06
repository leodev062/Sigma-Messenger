import 'package:dio/dio.dart';
import 'package:sigma_core/src/domain/services/i_connectivity_service.dart';
import 'package:sigma_core/src/network/error/failure.dart';

/// Interceptor que verifica a conectividade antes de realizar qualquer requisição.
/// Evita chamadas de rede inúteis quando o dispositivo está comprovadamente offline.
class ConnectivityInterceptor extends Interceptor {
  final IConnectivityService _connectivityService;

  ConnectivityInterceptor(this._connectivityService);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final isOnline = await _connectivityService.isConnected;
    if (!isOnline) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: NetworkFailure("Sem conexão com a internet"),
          type: DioExceptionType.connectionError,
        ),
      );
    }
    return handler.next(options);
  }
}
