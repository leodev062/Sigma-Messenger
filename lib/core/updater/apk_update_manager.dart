import 'dart:io';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:open_filex/open_filex.dart';

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
  final Dio _dio;

  ApkUpdateManager(this._dio);

  Future<UpdateInfo?> checkForUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersionCode = int.parse(packageInfo.buildNumber);

      final response = await _dio.get('api/update');
      if (response.statusCode == 200) {
        final updateInfo = UpdateInfo.fromJson(response.data);
        if (updateInfo.versionCode > currentVersionCode) {
          return updateInfo;
        }
      }
    } catch (e) {
      // Falha na verificação silenciosa
    }
    return null;
  }

  Future<String> downloadAndVerifyApk(
    String url,
    String expectedSha256, {
    required Function(int count, int total) onProgress,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/sigma_update.apk';
    
    // 1. Download do APK
    await _dio.download(
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
