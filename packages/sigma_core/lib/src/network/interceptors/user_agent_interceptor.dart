import 'package:dio/dio.dart';
import 'dart:io';

/// Interceptor que adiciona o cabeçalho User-Agent padrão para identificar o cliente.
/// Seguindo o padrão do Signal: [App-Name]/[Version] ([OS])
class UserAgentInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final os = Platform.isAndroid ? 'Android' : 'iOS';
    options.headers['User-Agent'] = 'Sigma-Flutter/1.0.0 ($os)';
    return handler.next(options);
  }
}
