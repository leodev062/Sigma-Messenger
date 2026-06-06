import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'apk_update_notifications.dart';

class ApkUpdateDownloadManagerReceiver {
  final Dio _dio;
  final ApkUpdateNotifications _notifications;

  ApkUpdateDownloadManagerReceiver(this._dio, this._notifications);

  Future<void> startDownload(String url, String expectedSha256) async {
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/sigma_update.apk';

    await _dio.download(
      url,
      path,
      onReceiveProgress: (count, total) {
        if (total > 0) {
          _notifications.showDownloadInProgress(((count / total) * 100).toInt());
        }
      },
    );

    // Ao terminar, emite a notificação final com o payload (path|sha256)
    await _notifications.showUpdateReadyToInstall('$path|$expectedSha256');
  }
}
