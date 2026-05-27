import 'dart:typed_data';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'package:sigma/core/network/sigma_network_access.dart';

class AttachmentRequestResponse {
  final String attachmentId;
  final String uploadUrl;

  AttachmentRequestResponse({
    required this.attachmentId,
    required this.uploadUrl,
  });

  factory AttachmentRequestResponse.fromJson(Map<String, dynamic> json) {
    // Ajustado para o padrão de resposta do servidor Go
    final data = json['data'] ?? json;
    return AttachmentRequestResponse(
      attachmentId: data['attachment_id'].toString(),
      uploadUrl: data['upload_url'].toString(),
    );
  }
}

class AttachmentManager {
  final SigmaNetworkAccess _networkAccess;
  static const String TAG = "AttachmentManager";

  AttachmentManager(this._networkAccess);

  /// Solicita permissão e URL para upload de um anexo.
  Future<AttachmentRequestResponse> requestUpload(int fileSize) async {
    try {
      final dio = _networkAccess.getApiClient();
      final response = await dio.post(
        "v1/attachments/request-upload",
        data: {"size": fileSize},
      );
      
      // Parse manual devido ao ResponseType.bytes global no SigmaNetworkAccess
      if (response.data is List<int>) {
        final decoded = jsonDecode(utf8.decode(response.data as List<int>));
        return AttachmentRequestResponse.fromJson(decoded as Map<String, dynamic>);
      }
      
      return AttachmentRequestResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      SigmaLog.e(TAG, "Erro ao solicitar upload de anexo", e);
      rethrow;
    }
  }

  /// Faz o upload dos bytes criptografados diretamente para a URL fornecida.
  Future<void> uploadEncryptedBytes(String uploadUrl, Uint8List encryptedBytes) async {
    try {
      // Para o upload real, usamos o MediaClient (timeouts maiores, sem headers de auth desnecessários)
      final dio = _networkAccess.getMediaClient();
      final response = await dio.post(
        uploadUrl,
        data: Stream.fromIterable([encryptedBytes]),
        options: Options(
          headers: {
            'Content-Type': 'application/octet-stream',
            'Content-Length': encryptedBytes.length,
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Falha no upload: status ${response.statusCode}");
      }
    } catch (e) {
      SigmaLog.e(TAG, "Erro durante o upload de bytes", e);
      rethrow;
    }
  }
}
