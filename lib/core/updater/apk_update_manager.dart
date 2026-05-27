import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sigma/core/network/sigma_network_access.dart';

class UpdateInfo {
  final int versionCode;
  final String versionName;
  final String url;
  final String sha256;
  final String releaseNotes;

  UpdateInfo({
    required this.versionCode,
    required this.versionName,
    required this.url,
    required this.sha256,
    required this.releaseNotes,
  });

  factory UpdateInfo.fromJson(Map<String, dynamic> json) {
    return UpdateInfo(
      versionCode: json['version_code'],
      versionName: json['version_name'],
      url: json['url'],
      sha256: json['sha256'],
      releaseNotes: json['release_notes'] ?? '',
    );
  }
}

class ApkUpdateManager {
  final SigmaNetworkAccess _networkAccess;

  ApkUpdateManager(this._networkAccess);

  Future<UpdateInfo?> checkForUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersionCode = int.parse(packageInfo.buildNumber);

      // Usamos o API Client para checagem rápida
      final dio = _networkAccess.getApiClient();
      final response = await dio.get('apk/update.json');
      if (response.statusCode == 200) {
        final data = _parseResponse(response.data);
        final updateInfo = UpdateInfo.fromJson(data);
        if (updateInfo.versionCode > currentVersionCode) {
          return updateInfo;
        }
      }
    } catch (e) {
      // Silencioso
    }
    return null;
  }

  dynamic _parseResponse(dynamic data) {
    if (data is List<int>) {
      return jsonDecode(utf8.decode(data));
    }
    return data;
  }

  Future<String> downloadAndVerifyApk(
    String url,
    String expectedSha256, {
    required Function(int count, int total) onProgress,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/sigma_update.apk';
    
    // 1. Download do APK usando o Media Client (timeout longo)
    final dio = _networkAccess.getMediaClient();
    await dio.download(
      url,
      filePath,
      onReceiveProgress: onProgress,
    );

    // 2. Validação Criptográfica (SHA-256) - Padrão Signal
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final digest = sha256.convert(bytes);
    final generatedHash = digest.toString();

    if (generatedHash.toLowerCase() != expectedSha256.toLowerCase()) {
      await file.delete();
      throw Exception('Falha na integridade do arquivo. Hash SHA-256 não condiz com o esperado.');
    }

    return filePath;
  }

  Future<void> installApk(String filePath) async {
    final result = await OpenFilex.open(filePath);
    if (result.type != ResultType.done) {
      throw Exception('Falha ao abrir instalador: ${result.message}');
    }
  }
}
