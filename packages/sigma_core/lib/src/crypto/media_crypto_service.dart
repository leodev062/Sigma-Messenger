import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
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
/// Refatorado para usar Isolates (compute) em operações pesadas.
class MediaCryptoService {
  
  /// Encripta um arquivo usando AES-GCM 256-bit em um Isolate.
  Future<EncryptedMedia> encryptFile(File file) async {
    final bytes = await file.readAsBytes();
    return await compute(_encryptIsolate, bytes);
  }

  static Future<EncryptedMedia> _encryptIsolate(Uint8List bytes) async {
    final algorithm = AesGcm.with256bits();

    // 1. Calcular SHA-256 do arquivo original (Clean Digest)
    final digest = crypto.sha256.convert(bytes);
    final digestBase64 = base64Encode(digest.bytes);

    // 2. Gerar chave AES-256 e IV (Nonce) aleatórios
    final secretKey = await algorithm.newSecretKey();
    final nonce = algorithm.newNonce();

    // 3. Executar encriptação
    final secretBox = await algorithm.encrypt(
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

  /// Decripta bytes de um anexo usando Isolates.
  Future<Uint8List> decryptBytes({
    required Uint8List encryptedBytes,
    required String aesKeyBase64,
    required String ivBase64,
  }) async {
    return await compute(_decryptIsolate, {
      'encryptedBytes': encryptedBytes,
      'aesKey': aesKeyBase64,
      'iv': ivBase64,
    });
  }

  static Future<Uint8List> _decryptIsolate(Map<String, dynamic> params) async {
    final algorithm = AesGcm.with256bits();
    final Uint8List encryptedBytes = params['encryptedBytes'];
    final String aesKeyBase64 = params['aesKey'];
    // ivBase64 é ignorado aqui porque o IV/Nonce já está concatenado no encryptedBytes
    // via SecretBox.concatenation() no processo de encriptação.

    final secretKey = SecretKey(base64Decode(aesKeyBase64));
    
    // SecretBox.fromConcatenation espera [nonce, ciphertext, mac]
    final secretBox = SecretBox.fromConcatenation(
      encryptedBytes,
      nonceLength: algorithm.nonceLength,
      macLength: algorithm.macAlgorithm.macLength,
    );

    final cleartext = await algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
    );

    return Uint8List.fromList(cleartext);
  }
}
