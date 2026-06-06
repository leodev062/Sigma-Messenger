import 'package:dio/dio.dart';
import 'package:sigma_core/src/network/sigma_network_access.dart';

/// Wrapper para o cliente Dio que centraliza a lógica de requisições.
/// Preparado para o "Request Queue Manager" no futuro.
class SigmaHttpClient {
  final SigmaNetworkAccess _networkAccess;
  late final Dio _dio;

  SigmaHttpClient(this._networkAccess) {
    _dio = _networkAccess.getApiClient();
  }

  Dio get dio => _dio;

  // Aqui podemos adicionar métodos de conveniência no futuro,
  // como monitoramento de progresso global, etc.
}
