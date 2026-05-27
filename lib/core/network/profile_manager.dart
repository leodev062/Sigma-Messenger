import 'package:dio/dio.dart';
import 'package:sigma/data/models/user_response.dart';
import 'dart:convert';

class ProfileManager {
  final Dio _dio;

  ProfileManager(this._dio);

  /// Busca o perfil de um usuário (Backend v1 - JSON)
  Future<UserResponse> getProfile(String userId) async {
    try {
      // No Signal, 'me' ou o ID específico é usado. Aqui usamos v1/accounts/$userId
      final response = await _dio.get("v1/accounts/$userId");
      return UserResponse.fromJson(_flattenEnvelope(_parseResponse(response.data)));
    } catch (e) {
      return UserResponse(status: "ERROR", message: "Erro ao buscar perfil");
    }
  }

  /// Atualiza o perfil do utilizador (Backend v1 - JSON)
  Future<UserResponse> updateProfile(String userId, String name, String? avatarPath) async {
    try {
      final response = await _dio.put(
        "v1/accounts/me",
        data: {
          'name': name,
          if (avatarPath != null) 'avatar_url': avatarPath,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return UserResponse.fromJson(_flattenEnvelope(_parseResponse(response.data)));
    } catch (e) {
      return UserResponse(status: "ERROR", message: "Erro ao atualizar perfil");
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
        // Se a data for o próprio objeto de usuário (comum em PUT /me)
        if (dataMap.containsKey('id') || dataMap.containsKey('phone')) {
          result['user'] = dataMap;
        }
      }
      return result;
    }
    return {};
  }
}
