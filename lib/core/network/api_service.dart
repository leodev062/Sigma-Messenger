import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sigma/data/models/user_response.dart';
import 'package:sigma/core/updater/apk_update_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sigma/core/network/pb/keys.pb.dart' as sigmapb;

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  /// Solicita código de verificação via SMS (Backend v1 - JSON)
  Future<UserResponse> requestCode(RequestCodeRequest request) async {
    final response = await _dio.post(
      "v1/auth/request-code", 
      data: request.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return UserResponse.fromJson(_flattenEnvelope(_parseResponse(response.data)));
  }

  /// Realiza login com telefone e código (Backend v1 - JSON)
  Future<UserResponse> loginWithPhone(VerifyCodeRequest request) async {
    final response = await _dio.post(
      "v1/auth/login", 
      data: request.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return UserResponse.fromJson(_flattenEnvelope(_parseResponse(response.data)));
  }

  /// Atualiza o token FCM do usuário autenticado (Backend v1 - JSON)
  Future<UserResponse> updateFcmToken(Map<String, dynamic> body) async {
    final response = await _dio.put(
      "v1/accounts/me/fcm", 
      data: body,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return UserResponse.fromJson(_flattenEnvelope(_parseResponse(response.data)));
  }

  /// Verifica disponibilidade de nome de usuário (Backend v1 - JSON)
  Future<Map<String, bool>> checkUsername(String username) async {
    final response = await _dio.get("v1/accounts/check-username/$username");
    final data = _parseResponse(response.data);
    // Envelope: {"status": "SUCCESS", "data": {"available": true}}
    if (data['data'] != null) {
      return Map<String, bool>.from(data['data'] as Map);
    }
    return {'available': false};
  }

  /// Padrão Signal: Busca o PreKeyBundle em formato Protobuf (v2 - Binário)
  Future<sigmapb.PreKeyBundle> getUserKeys(String userId) async {
    final response = await _dio.get(
      "v2/keys/$userId",
      options: Options(headers: {'Accept': 'application/x-protobuf'}),
    );
    return sigmapb.PreKeyBundle.fromBuffer(response.data as List<int>);
  }

  /// Envia as chaves públicas em formato Protobuf (v2 - Binário)
  Future<void> putKeys(sigmapb.PreKeyBundle bundle) async {
    await _dio.put(
      "v2/keys", 
      data: bundle.writeToBuffer(),
      options: Options(headers: {'Content-Type': 'application/x-protobuf'}),
    );
  }

  /// Verifica se há uma atualização disponível no servidor (APK)
  Future<UpdateInfo?> checkForUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersionCode = int.parse(packageInfo.buildNumber);

      final response = await _dio.get('apk/update.json');
      if (response.statusCode == 200) {
        final updateInfo = UpdateInfo.fromJson(_parseResponse(response.data));
        if (updateInfo.versionCode > currentVersionCode) {
          return updateInfo;
        }
      }
    } catch (e) {
      // Silencioso
    }
    return null;
  }

  /// Helper para converter bytes de volta para JSON
  dynamic _parseResponse(dynamic data) {
    if (data is List<int>) {
      final str = utf8.decode(data);
      return jsonDecode(str);
    }
    return data;
  }

  /// Achata o envelope {"status": "...", "data": {...}} para {"status": "...", ...data}
  Map<String, dynamic> _flattenEnvelope(dynamic response) {
    if (response is Map<String, dynamic>) {
      final result = Map<String, dynamic>.from(response);
      if (response['data'] != null && response['data'] is Map) {
        result.addAll(Map<String, dynamic>.from(response['data'] as Map));
      }
      return result;
    }
    return {};
  }
}
