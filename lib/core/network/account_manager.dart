import 'package:dio/dio.dart';
import 'package:sigma/data/models/user_response.dart';
import 'dart:convert';

class AccountManager {
  final Dio _dio;

  AccountManager(this._dio);

  /// Solicita código de verificação via SMS (Backend v1 - JSON)
  Future<UserResponse> requestSmsCode(String phone) async {
    try {
      final response = await _dio.post(
        "v1/auth/request-code",
        data: {'phone': phone},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return UserResponse.fromJson(_flattenEnvelope(_parseResponse(response.data)));
    } catch (e) {
      return UserResponse(status: "ERROR", message: "Falha na conexão");
    }
  }

  /// Realiza login com telefone e código (Backend v1 - JSON)
  Future<UserResponse> verifyCode(String phone, String code) async {
    try {
      final response = await _dio.post(
        "v1/auth/login",
        data: {'phone': phone, 'code': code},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return UserResponse.fromJson(_flattenEnvelope(_parseResponse(response.data)));
    } catch (e) {
      return UserResponse(status: "ERROR", message: "Código inválido ou erro no servidor");
    }
  }

  dynamic _parseResponse(dynamic data) {
    if (data is List<int>) {
      return jsonDecode(utf8.decode(data));
    }
    return data;
  }

  Map<String, dynamic> _flattenEnvelope(dynamic response) {
    if (response is Map<String, dynamic>) {
      final result = Map<String, dynamic>.from(response);
      final data = response['data'];
      if (data != null && data is Map) {
        final dataMap = Map<String, dynamic>.from(data);
        if (dataMap.containsKey('user') || dataMap.containsKey('token')) {
          result.addAll(dataMap);
        }
      }
      return result;
    }
    return {};
  }
}
