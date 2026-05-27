import 'package:dio/dio.dart';
import 'package:sigma/data/models/user_response.dart';
import 'dart:convert';

class ProfileManager {
  final Dio _dio;

  ProfileManager(this._dio);

  /// Busca o perfil de um usuário (Backend v1 - JSON)
  Future<UserResponse> getProfile(String userId) async {
    try {
      final response = await _dio.get("v1/accounts/$userId");
      return UserResponse.fromJson(_flattenEnvelope(_parseResponse(response.data)));
    } catch (e) {
      return UserResponse(status: "ERROR", message: "Erro ao buscar perfil");
    }
  }

  /// Atualiza o perfil completo do utilizador (Backend v1 - JSON)
  Future<UserResponse> updateProfile({
    String? name,
    String? username,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      final response = await _dio.put(
        "v1/accounts/me",
        data: {
          if (name != null) 'name': name,
          if (username != null) 'username': username,
          if (bio != null) 'bio': bio,
          if (avatarUrl != null) 'avatar_url': avatarUrl,
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
        if (dataMap.containsKey('id') || dataMap.containsKey('phone')) {
          result['user'] = dataMap;
        }
      }
      return result;
    }
    return {};
  }
}
