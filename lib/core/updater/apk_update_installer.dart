import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:open_filex/open_filex.dart';

class ApkUpdateInstaller {
  Future<void> install(String apkPath, String expectedSha256) async {
    final file = File(apkPath);
    if (!await file.exists()) return;

    // Validação Criptográfica (Prevenção contra MITM)
    final bytes = await file.readAsBytes();
    final digest = sha256.convert(bytes);
    
    if (digest.toString().toLowerCase() == expectedSha256.toLowerCase()) {
      await OpenFilex.open(apkPath);
    } else {
      await file.delete(); // Segurança: apaga APK adulterado
      throw Exception('Assinatura do APK inválida. Instalação abortada.');
    }
  }
}
