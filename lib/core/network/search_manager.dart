import 'package:dio/dio.dart';
import 'dart:convert';

class SearchManager {
  final Dio _dio;

  SearchManager(this._dio);

  /// Pesquisa utilizadores por username ou nome (Backend v1 - JSON)
  Future<List<Map<String, dynamic>>> searchUsers(String term) async {
    final response = await _dio.get(
      "v1/accounts/search",
      queryParameters: {'term': term},
    );
    final data = _parseResponse(response.data);
    if (data['data'] != null && data['data'] is List) {
      return List<Map<String, dynamic>>.from(data['data'] as List);
    }
    return [];
  }

  /// Verifica disponibilidade de nome de usuário (Backend v1 - JSON)
  Future<Map<String, bool>> checkUsername(String username) async {
    final response = await _dio.get("v1/accounts/check-username/$username");
    final data = _parseResponse(response.data);
    if (data['data'] != null) {
      return Map<String, bool>.from(data['data'] as Map);
    }
    return {'available': false};
  }

  dynamic _parseResponse(dynamic data) {
    if (data is List<int>) {
      return jsonDecode(utf8.decode(data));
    }
    return data;
  }
}
