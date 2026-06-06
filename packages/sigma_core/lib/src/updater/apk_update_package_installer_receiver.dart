import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ApkUpdatePackageInstallerReceiver {
  Future<void> onInstallSuccessful() async {
    final tempDir = await getTemporaryDirectory();
    final dir = Directory(tempDir.path);
    
    // Limpa apenas ficheiros .apk do Sigma
    await for (var file in dir.list()) {
      if (file is File && file.path.endsWith('.apk') && file.path.contains('sigma_update')) {
        await file.delete();
      }
    }
  }
}
