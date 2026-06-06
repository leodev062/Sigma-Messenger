import 'dart:io';
import 'dart:convert';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sigma_core/src/network/sigma_network_access.dart';
import 'package:sigma_core/src/util/sigma_log.dart';

/// UpdateInfo - Entidade Imutável de Atualização.
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

/// ApkUpdateManager - Refatorado para POO com Loggable.
class ApkUpdateManager with Loggable {
  final SigmaNetworkAccess _networkAccess;

  ApkUpdateManager(this._networkAccess);

  Future<UpdateInfo?> checkForUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersionCode = int.parse(packageInfo.buildNumber);

      final dio = _networkAccess.getApiClient();
      final response = await dio.get('apk/update.json');
      
      if (response.statusCode == 200) {
        final data = _parseResponse(response.data);
        final updateInfo = UpdateInfo.fromJson(data);
        
        if (updateInfo.versionCode > currentVersionCode) {
          logI("Nova versão encontrada: ${updateInfo.versionName}");
          return updateInfo;
        }
      }
    } catch (e) {
      logW("Falha silenciosa ao checar atualizações: $e");
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
    
    logI("Iniciando download da atualização...");
    
    final dio = _networkAccess.getMediaClient();
    await dio.download(
      url,
      filePath,
      onReceiveProgress: onProgress,
    );

    // Validação de Integridade (Responsabilidade de Expert: O Manager sabe validar o que baixa)
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final generatedHash = sha256.convert(bytes).toString();

    if (generatedHash.toLowerCase() != expectedSha256.toLowerCase()) {
      await file.delete();
      logE("Falha de integridade SHA-256. Esperado: $expectedSha256, Gerado: $generatedHash");
      throw Exception('Falha na integridade do arquivo de atualização.');
    }

    logI("Download concluído e verificado.");
    return filePath;
  }

  Future<void> installApk(String filePath) async {
    logI("Abrindo instalador para: $filePath");
    final result = await OpenFilex.open(filePath);
    if (result.type != ResultType.done) {
      throw Exception('Falha ao abrir instalador: ${result.message}');
    }
  }
}
