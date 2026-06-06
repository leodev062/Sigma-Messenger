import 'dart:io';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';
import 'failure.dart';

/// Mixin para tratar erros de rede de forma padronizada.
mixin NetworkErrorHandler {
  Future<Result<T, Failure>> safeCall<T>(Future<T> Function() call) async {
    try {
      final response = await call();
      return Success(response);
    } on DioException catch (e) {
      return Error(_handleDioError(e));
    } on SocketException {
      return Error(NetworkFailure("Sem conexão com a internet"));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return NetworkFailure("Tempo de conexão esgotado", statusCode: 408);
    }

    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;
      final message = (data is Map && data.containsKey('message')) 
          ? data['message'] 
          : "Erro no servidor";

      if (statusCode == 401 || statusCode == 403) {
        return AuthFailure(message, statusCode: statusCode);
      }
      
      if (statusCode! >= 500) {
        return ServerFailure("Erro interno do servidor", statusCode: statusCode);
      }

      return ServerFailure(message, statusCode: statusCode);
    }

    return NetworkFailure("Falha na rede: ${e.message}");
  }
}
