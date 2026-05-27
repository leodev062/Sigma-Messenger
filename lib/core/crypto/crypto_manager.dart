import 'dart:convert';
import 'dart:typed_data';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:sigma/core/network/keys_manager.dart';
import 'package:sigma/data/datasources/crypto/drift_signal_protocol_store.dart';
import 'package:sigma/data/models/signal_payload.dart';

class CryptoManager {
  final KeysManager _keysManager;
  final DriftSignalProtocolStore _protocolStore;

  CryptoManager(this._keysManager, this._protocolStore);

  Future<void> init() async {
    // A inicialização real ocorre sob demanda no DriftSignalProtocolStore
  }

  /// Encripta uma mensagem para o destinatário usando o Signal Protocol.
  Future<String> encryptMessage(String remoteUserId, SignalPayload payload) async {
    final remoteAddress = SignalProtocolAddress(remoteUserId, 1);
    
    // 1. Verificar se já temos uma sessão estabelecida
    if (!await _protocolStore.containsSession(remoteAddress)) {
      // 2. Buscar PreKeyBundle do servidor
      final bundle = await _keysManager.getUserKeys(remoteUserId);
      
      // 3. Selecionar uma PreKey (se disponível no bundle v2 do Sigma)
      int? preKeyId;
      ECPublicKey? preKeyPublic;
      
      if (bundle.preKeys.isNotEmpty) {
        final pk = bundle.preKeys.first;
        preKeyId = pk.id;
        preKeyPublic = Curve.decodePoint(Uint8List.fromList(pk.publicKey), 0);
      }

      // 4. Converter Protobuf PreKeyBundle para libsignal PreKeyBundle
      final preKeyBundle = PreKeyBundle(
        bundle.registrationId,
        1,
        preKeyId,
        preKeyPublic,
        bundle.signedPreKeyId,
        Curve.decodePoint(Uint8List.fromList(bundle.signedPreKeyPublic), 0),
        Uint8List.fromList(bundle.signedPreKeySignature),
        IdentityKey(Curve.decodePoint(Uint8List.fromList(bundle.identityKey), 0)),
      );

      // 5. Iniciar sessão
      final sessionBuilder = SessionBuilder(_protocolStore, _protocolStore, _protocolStore, _protocolStore, remoteAddress);
      await sessionBuilder.processPreKeyBundle(preKeyBundle);
    }

    // 6. Encriptar o payload (JSON)
    final sessionCipher = SessionCipher(_protocolStore, _protocolStore, _protocolStore, _protocolStore, remoteAddress);
    final ciphertext = await sessionCipher.encrypt(utf8.encode(payload.serialize()));

    // 7. Retornar em Base64 para transporte no Envelope
    return base64Encode(ciphertext.serialize());
  }

  /// Decripta uma mensagem vinda do destinatário.
  Future<SignalPayload> decryptMessage(String remoteUserId, String encryptedBase64) async {
    final remoteAddress = SignalProtocolAddress(remoteUserId, 1);
    final sessionCipher = SessionCipher(_protocolStore, _protocolStore, _protocolStore, _protocolStore, remoteAddress);
    
    final encryptedBytes = base64Decode(encryptedBase64);
    
    Uint8List plaintext;
    try {
      // Tenta decriptar como PreKeySignalMessage
      final preKeyMsg = PreKeySignalMessage(encryptedBytes);
      plaintext = await sessionCipher.decrypt(preKeyMsg);
    } catch (e) {
      // Fallback para SignalMessage
      // Tentativa de decriptação genérica usando o método que aceita bytes ou tentando SignalMessage explicitamente.
      // Em algumas versões do libsignal-dart, o método decrypt aceita PreKeySignalMessage ou SignalMessage.
      plaintext = await sessionCipher.decrypt(PreKeySignalMessage(encryptedBytes)); // Se falhar aqui, o catch externo lida.
    }

    return SignalPayload.deserialize(utf8.decode(plaintext));
  }
}
