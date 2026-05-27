import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:crypto/crypto.dart' as crypto;

class EncryptedMedia {
  final Uint8List ciphertext;
  final String aesKeyBase64;
  final String ivBase64;
  final String digestBase64;

  EncryptedMedia({
    required this.ciphertext,
    required this.aesKeyBase64,
    required this.ivBase64,
    required this.digestBase64,
  });
}

/// Serviço responsável pela criptografia simétrica de arquivos multimídia (Padrão Signal).
class MediaCryptoService {
  final _algorithm = AesGcm.with256bits();

  /// Encripta um arquivo usando AES-GCM 256-bit.
  /// Retorna o ciphertext e os metadados necessários para o AttachmentPointer.
  Future<EncryptedMedia> encryptFile(File file) async {
    final bytes = await file.readAsBytes();

    // 1. Calcular SHA-256 do arquivo original (Clean Digest)
    final digest = crypto.sha256.convert(bytes);
    final digestBase64 = base64Encode(digest.bytes);

    // 2. Gerar chave AES-256 e IV (Nonce) aleatórios
    final secretKey = await _algorithm.newSecretKey();
    final nonce = _algorithm.newNonce();

    // 3. Executar encriptação
    final secretBox = await _algorithm.encrypt(
      bytes,
      secretKey: secretKey,
      nonce: nonce,
    );

    // 4. Extrair metadados em Base64
    final keyData = await secretKey.extract();
    final keyBytes = keyData.bytes;
    
    return EncryptedMedia(
      ciphertext: Uint8List.fromList(secretBox.concatenation()),
      aesKeyBase64: base64Encode(keyBytes),
      ivBase64: base64Encode(nonce),
      digestBase64: digestBase64,
    );
  }

  /// Decripta bytes de um anexo usando o AttachmentPointer recebido.
  Future<Uint8List> decryptBytes({
    required Uint8List encryptedBytes,
    required String aesKeyBase64,
    required String ivBase64,
  }) async {
    final secretKey = SecretKey(base64Decode(aesKeyBase64));
    
    // O pacote cryptography espera o MAC concatenado ou separado dependendo da versão.
    final secretBox = SecretBox.fromConcatenation(
      encryptedBytes,
      nonceLength: _algorithm.nonceLength,
      macLength: _algorithm.macAlgorithm.macLength,
    );

    final cleartext = await _algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
    );

    return Uint8List.fromList(cleartext);
  }
}
