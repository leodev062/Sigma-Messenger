import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sigma/core/util/sigma_log.dart';
import 'package:collection/collection.dart';

/// Resultado da encriptação de um ficheiro de média.
class MediaEncryptionResult {
  final File file;
  final String aesKeyBase64;
  final String macKeyBase64;

  MediaEncryptionResult({
    required this.file,
    required this.aesKeyBase64,
    required this.macKeyBase64,
  });
}

/// Serviço de Criptografia de Ficheiros (Média).
/// Implementa AES-256-CBC + HMAC-SHA256, similar ao Signal.
class MediaCryptoService {
  static const String tag = "MediaCryptoService";

  final AesCbc _aesCbc = AesCbc.with256bits(macAlgorithm: MacAlgorithm.empty);
  final Hmac _hmac = Hmac.sha256();

  /// Encripta um ficheiro e retorna o ficheiro encriptado e as chaves geradas.
  /// O formato do ficheiro resultante é: [IV (16 bytes)] + [Ciphertext] + [HMAC (32 bytes)].
  Future<MediaEncryptionResult> encryptFile(File input) async {
    SigmaLog.d(tag, "A encriptar ficheiro: ${input.path}");
    final bytes = await input.readAsBytes();

    // Gerar chaves aleatórias de 256 bits
    final aesKey = await _aesCbc.newSecretKey();
    
    // Gerar chave HMAC manualmente (256 bits)
    final random = Random.secure();
    final generatedHmacKeyBytes = Uint8List.fromList(List.generate(32, (i) => random.nextInt(256)));
    final hmacKey = SecretKey(generatedHmacKeyBytes);

    // Gerar IV (Nonce) de 16 bytes
    final iv = _aesCbc.newNonce();

    // Encriptar com AES-CBC
    final secretBox = await _aesCbc.encrypt(
      bytes,
      secretKey: aesKey,
      nonce: iv,
    );

    // Calcular HMAC sobre IV + Ciphertext (Encrypt-then-MAC)
    final hmacInput = Uint8List.fromList([...iv, ...secretBox.cipherText]);
    final mac = await _hmac.calculateMac(
      hmacInput,
      secretKey: hmacKey,
    );

    // Concatenar: IV + Ciphertext + MAC
    final outputBytes = Uint8List.fromList([
      ...iv,
      ...secretBox.cipherText,
      ...mac.bytes,
    ]);

    // Gravar no diretório de cache/temp
    final tempDir = await getTemporaryDirectory();
    final outputFileName = "${DateTime.now().microsecondsSinceEpoch}.enc";
    final outputFile = File(p.join(tempDir.path, outputFileName));
    await outputFile.writeAsBytes(outputBytes);

    final aesKeyBytes = await aesKey.extractBytes();

    SigmaLog.i(tag, "Ficheiro encriptado com sucesso: ${outputFile.path}");

    return MediaEncryptionResult(
      file: outputFile,
      aesKeyBase64: base64Encode(aesKeyBytes),
      macKeyBase64: base64Encode(generatedHmacKeyBytes),
    );
  }

  /// Desencripta um ficheiro usando as chaves AES e MAC fornecidas.
  Future<File> decryptFile(File encryptedInput, String aesKeyBase64, String macKeyBase64) async {
    SigmaLog.d(tag, "A desencriptar ficheiro: ${encryptedInput.path}");
    final bytes = await encryptedInput.readAsBytes();

    if (bytes.length < 16 + 32) {
      throw Exception("Ficheiro encriptado inválido ou corrompido (muito pequeno).");
    }

    // Extrair IV, Ciphertext e MAC
    final iv = bytes.sublist(0, 16);
    final macBytes = bytes.sublist(bytes.length - 32);
    final cipherText = bytes.sublist(16, bytes.length - 32);

    final aesKey = SecretKey(base64Decode(aesKeyBase64));
    final hmacKey = SecretKey(base64Decode(macKeyBase64));

    // Verificar HMAC (Integridade)
    final hmacInput = Uint8List.fromList([...iv, ...cipherText]);
    final calculatedMac = await _hmac.calculateMac(
      hmacInput,
      secretKey: hmacKey,
    );

    if (!const ListEquality().equals(calculatedMac.bytes, macBytes)) {
      SigmaLog.e(tag, "Falha na verificação de integridade (HMAC inválido)!");
      throw Exception("Erro de integridade: O ficheiro pode ter sido alterado.");
    }

    // Desencriptar com AES-CBC
    final clearBytes = await _aesCbc.decrypt(
      SecretBox(cipherText, nonce: iv, mac: Mac.empty),
      secretKey: aesKey,
    );

    // Gravar ficheiro desencriptado
    final tempDir = await getTemporaryDirectory();
    final outputFileName = "${DateTime.now().microsecondsSinceEpoch}.dec";
    final outputFile = File(p.join(tempDir.path, outputFileName));
    await outputFile.writeAsBytes(clearBytes);

    SigmaLog.i(tag, "Ficheiro desencriptado com sucesso: ${outputFile.path}");

    return outputFile;
  }
}
