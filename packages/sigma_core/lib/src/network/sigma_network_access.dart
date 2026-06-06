import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:sigma_core/src/config/app_config.dart';
import 'package:sigma_core/src/domain/services/i_connectivity_service.dart';
import 'package:sigma_core/src/network/interceptors/connectivity_interceptor.dart';
import 'package:sigma_core/src/network/interceptors/user_agent_interceptor.dart';
import 'package:sigma_core/src/storage/sigma_store.dart';

/// Arquiteto de Rede Sigma - Inspirado no SignalServiceNetworkAccess do Signal-Android.
/// Centraliza a criação de instâncias Dio com segurança rigorosa e configurações específicas.
class SigmaNetworkAccess {
  final AppConfig _config;
  final SigmaStore _sigmaStore;
  final IConnectivityService _connectivityService;

  SigmaNetworkAccess(this._config, this._sigmaStore, this._connectivityService);

  /// Cliente para chamadas de API RPC/Protobuf (Short-lived).
  Dio getApiClient() {
    return _createBaseDio(
      timeout: const Duration(seconds: 10),
      includeAuth: true,
      jsonMode: true, // Forçar JSON por padrão para APIs
    );
  }

  /// Cliente para Upload/Download de anexos (Long-lived).
  Dio getMediaClient() {
    return _createBaseDio(
      timeout: const Duration(seconds: 60),
      includeAuth: false,
    );
  }

  Dio _createBaseDio({required Duration timeout, required bool includeAuth, bool jsonMode = false}) {
    final dio = Dio(BaseOptions(
      baseUrl: _config.apiBaseUrl,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
      responseType: jsonMode ? ResponseType.json : ResponseType.bytes,
      headers: {
        'Accept': jsonMode ? 'application/json' : 'application/x-protobuf, application/json',
      },
    ));

    // 1. Connectivity Interceptor
    dio.interceptors.add(ConnectivityInterceptor(_connectivityService));

    // 2. User Agent Interceptor (Passo 3)
    dio.interceptors.add(UserAgentInterceptor());

    // 3. Auth Interceptor (Padrão Signal)
    if (includeAuth) {
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _sigmaStore.account.getTokenSync();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ));
    }

    // 3. Segurança: Certificate Pinning e TLS Enforcement (Passo 2)
    _applySecurityConfiguration(dio);

    return dio;
  }

  void _applySecurityConfiguration(Dio dio) {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Criar contexto com raízes confiáveis do sistema
        final SecurityContext context = SecurityContext(withTrustedRoots: true);

        final client = HttpClient(context: context);

        // No Signal, TLS 1.2+ é obrigatório.
        // O Dart HttpClient já tenta as versões mais altas por padrão.

        // Validação de Certificate Pinning (DESATIVADO TEMPORARIAMENTE PARA DESENVOLVIMENTO)
        /*
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          final bytes = cert.der;
          final hash = sha256.convert(bytes).toString();
          final pin = 'sha256/$hash';

          if (_config.certificatePins.contains(pin)) {
            return true;
          }
          return false;
        };
        */

        return client;
      },
    );
  }
}
