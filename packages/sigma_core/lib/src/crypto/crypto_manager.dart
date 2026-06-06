import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart' as signal;
import 'package:sigma_core/sigma_core.dart';

import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

class CryptoManager {
  final KeysRemoteDataSource _keysRemoteDataSource;
  final DriftSignalProtocolStore _protocolStore;

  CryptoManager(this._keysRemoteDataSource, this._protocolStore);

  Future<void> init() async {
    // A inicialização real ocorre sob demanda no DriftSignalProtocolStore
  }

  /// Encripta uma mensagem para o destinatário usando o Signal Protocol.
  /// Suporta múltiplos dispositivos (deviceId dinâmico).
  Future<String> encryptMessage(String remoteUserId, sigmapb.Content payload, {int deviceId = 1}) async {
    debugPrint("DEBUG CryptoManager: Encrypting message for $remoteUserId");
    final remoteAddress = signal.SignalProtocolAddress(remoteUserId, deviceId);
    
    // 1. Verificar se já temos uma sessão estabelecida
    if (!await _protocolStore.containsSession(remoteAddress)) {
      debugPrint("DEBUG CryptoManager: No session for $remoteUserId. Fetching keys...");
      // 2. Buscar PreKeyBundle do servidor
      final result = await _keysRemoteDataSource.getUserKeys(remoteUserId);
      
      final bundle = result.when(
        (b) => b,
        (failure) {
          debugPrint("DEBUG CryptoManager: FAILED to fetch keys: ${failure.message}");
          throw CryptoFailure("Falha ao buscar chaves: ${failure.message}");
        },
      );
      
      debugPrint("DEBUG CryptoManager: Keys fetched. Building session...");
      // 3. Seleção Aleatória de PreKey (Evita exaustão e melhora privacidade)
      int? preKeyId;
      signal.ECPublicKey? preKeyPublic;
      
      if (bundle.preKeys.isNotEmpty) {
        final randomIndex = Random().nextInt(bundle.preKeys.length);
        final pk = bundle.preKeys[randomIndex];
        preKeyId = pk.id;
        preKeyPublic = signal.Curve.decodePoint(Uint8List.fromList(pk.publicKey), 0);
      }

      // 4. Converter Protobuf PreKeyBundle para libsignal PreKeyBundle
      final preKeyBundle = signal.PreKeyBundle(
        bundle.registrationId,
        deviceId,
        preKeyId,
        preKeyPublic,
        bundle.signedPreKeyId,
        signal.Curve.decodePoint(Uint8List.fromList(bundle.signedPreKeyPublic), 0),
        Uint8List.fromList(bundle.signedPreKeySignature),
        signal.IdentityKey(signal.Curve.decodePoint(Uint8List.fromList(bundle.identityKey), 0)),
      );

      // 5. Iniciar sessão
      final sessionBuilder = signal.SessionBuilder(_protocolStore, _protocolStore, _protocolStore, _protocolStore, remoteAddress);
      await sessionBuilder.processPreKeyBundle(preKeyBundle);
      debugPrint("DEBUG CryptoManager: Session established with $remoteUserId");
    }

    // 6. Encriptar o payload (Protobuf)
    debugPrint("DEBUG CryptoManager: Encrypting payload (Protobuf)...");
    final sessionCipher = signal.SessionCipher(_protocolStore, _protocolStore, _protocolStore, _protocolStore, remoteAddress);
    final ciphertext = await sessionCipher.encrypt(payload.writeToBuffer());

    // 7. Retornar em Base64 para transporte no Envelope
    debugPrint("DEBUG CryptoManager: Encryption SUCCESS.");
    return base64Encode(ciphertext.serialize());
  }

  /// Decripta uma mensagem vinda do destinatário.
  Future<sigmapb.Content> decryptMessage(String remoteUserId, String encryptedBase64, {int deviceId = 1}) async {
    final remoteAddress = signal.SignalProtocolAddress(remoteUserId, deviceId);
    final sessionCipher = signal.SessionCipher(_protocolStore, _protocolStore, _protocolStore, _protocolStore, remoteAddress);
    
    final encryptedBytes = base64Decode(encryptedBase64);
    
    Uint8List plaintext;
    try {
      // Tenta decriptar como PreKeySignalMessage (Tipo 3)
      final preKeyMsg = signal.PreKeySignalMessage(encryptedBytes);
      plaintext = await sessionCipher.decrypt(preKeyMsg);
    } catch (e) {
      // Fallback para SignalMessage (Tipo 2)
      final signalMsg = signal.SignalMessage.fromSerialized(encryptedBytes);
      plaintext = await sessionCipher.decryptFromSignal(signalMsg);
    }

    return sigmapb.Content.fromBuffer(plaintext);
  }
}
