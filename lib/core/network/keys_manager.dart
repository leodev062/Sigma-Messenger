import 'package:dio/dio.dart';
import 'package:sigma/core/network/pb/keys.pb.dart' as sigmapb;

class KeysManager {
  final Dio _dio;

  KeysManager(this._dio);

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
}
