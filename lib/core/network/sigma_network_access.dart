import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:crypto/crypto.dart';
import 'package:sigma/core/config/app_config.dart';
import 'package:sigma/core/network/interceptors/user_agent_interceptor.dart';
import 'package:sigma/core/storage/sigma_store.dart';

/// Arquiteto de Rede Sigma - Inspirado no SignalServiceNetworkAccess do Signal-Android.
/// Centraliza a criação de instâncias Dio com segurança rigorosa e configurações específicas.
class SigmaNetworkAccess {
  final AppConfig _config;

  SigmaNetworkAccess(this._config);

  /// Cliente para chamadas de API RPC/Protobuf (Short-lived).
  Dio getApiClient() {
    return _createBaseDio(
      timeout: const Duration(seconds: 10),
      includeAuth: true,
    );
  }

  /// Cliente para Upload/Download de anexos (Long-lived).
  Dio getMediaClient() {
    return _createBaseDio(
      timeout: const Duration(seconds: 60),
      includeAuth: false,
    );
  }

  Dio _createBaseDio({required Duration timeout, required bool includeAuth}) {
    final dio = Dio(BaseOptions(
      baseUrl: _config.apiBaseUrl,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
      responseType: ResponseType.bytes,
      headers: {
        'Accept': 'application/x-protobuf, application/json',
      },
    ));

    // 1. User Agent Interceptor (Passo 3)
    dio.interceptors.add(UserAgentInterceptor());

    // 2. Auth Interceptor (Padrão Signal)
    if (includeAuth) {
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = SigmaStore.instance.account.getTokenSync();
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

        // Validação de Certificate Pinning
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          // Em um cenário real de Pinning, podemos extrair a chave pública ou o certificado DER.
          // Aqui implementamos a verificação contra os hashes definidos no AppConfig.
          final bytes = cert.der;
          final hash = sha256.convert(bytes).toString();
          final pin = 'sha256/$hash';

          if (_config.certificatePins.contains(pin)) {
            return true; // Pin coincide, aceitar conexão mesmo que o OS falhe (ex: self-signed confiável)
          }
          
          return false; // Rejeitar se não estiver no Pinning
        };

        return client;
      },
      validateCertificate: (cert, host, port) {
        if (cert == null) return false;

        // Verificação redundante para garantir o Pinning em todas as camadas
        final bytes = cert.der;
        final hash = sha256.convert(bytes).toString();
        final pin = 'sha256/$hash';

        return _config.certificatePins.contains(pin);
      },
    );
  }
}
