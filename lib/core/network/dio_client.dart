import 'package:dio/dio.dart';
import 'package:sigma/core/storage/sigma_store.dart';

class DioClient {
  static const String baseUrl = "http://192.99.236.216:3000/";

  static Dio getDio() {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.bytes, // Evita parse automático de JSON
      headers: {
        'Accept': 'application/x-protobuf, application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Padrão Signal: Acesso síncrono ao token cacheado em memória no SigmaStore.
        // Removemos o uso de SharedPreferences e o await, tornando a requisição instantânea.
        final token = SigmaStore.instance.account.getTokenSync();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));

    return dio;
  }
}

