import 'apk_update_installer.dart';

class ApkUpdateNotificationReceiver {
  final ApkUpdateInstaller _installer;

  ApkUpdateNotificationReceiver(this._installer);

  void onNotificationClicked(String? payload) {
    if (payload == null || !payload.contains('|')) return;

    final parts = payload.split('|');
    final path = parts[0];
    final sha256 = parts[1];

    _installer.install(path, sha256);
  }
}
