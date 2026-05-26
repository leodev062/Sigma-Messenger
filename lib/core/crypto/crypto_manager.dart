import 'dart:convert';
import 'dart:typed_data';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:sigma/core/network/api_service.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'package:sigma/core/util/exceptions.dart';
import 'package:sigma/data/datasources/crypto/drift_signal_protocol_store.dart';
import 'package:sigma/data/models/signal_payload.dart';

/// Gerenciador de Criptografia de Ponta-a-Ponta (E2EE)
/// Utiliza o protocolo Signal para selar e abrir envelopes de mensagens.
/// Agora utiliza persistência em banco de dados blindado (SQLCipher).
class CryptoManager {
  static const String TAG = "CryptoManager";
  
  final ApiService _apiService;
  final DriftSignalProtocolStore _protocolStore;

  CryptoManager(this._apiService, this._protocolStore);

  /// Inicialização simplificada: a persistência é gerida pelo DriftSignalProtocolStore.
  Future<void> init() async {
    // Agora o store é injetado e auto-gerido via Drift.
    // Verificamos apenas se a identidade local existe.
    final identity = await _protocolStore.getIdentityKeyPair();
    SigmaLog.d(TAG, "CryptoManager inicializado. Local Identity: ${identity.getPublicKey().serialize().length} bytes");
  }

  /// Constrói uma sessão segura com o destinatário se ela ainda não existir.
  Future<void> buildSessionIfNeeded(String remoteUserId) async {
    final address = SignalProtocolAddress(remoteUserId, 1);
    
    if (await _protocolStore.containsSession(address)) return;

    SigmaLog.i(TAG, "Construindo nova sessão persistente para $remoteUserId");
    
    // Busca o PreKeyBundle do servidor Go
    final keyData = await _apiService.getUserKeys(remoteUserId);
    
    final bundle = PreKeyBundle(
      int.parse(keyData['registration_id'].toString()),
      1, // deviceId
      int.parse(keyData['pre_key_id'].toString()),
      Curve.decodePoint(base64Decode(keyData['pre_key_public']), 0),
      int.parse(keyData['signed_pre_key_id'].toString()),
      Curve.decodePoint(base64Decode(keyData['signed_pre_key_public']), 0),
      base64Decode(keyData['signed_pre_key_signature']),
      IdentityKey(Curve.decodePoint(base64Decode(keyData['identity_key']), 0)),
    );

    final sessionBuilder = SessionBuilder.fromSignalStore(_protocolStore, address);
    await sessionBuilder.processPreKeyBundle(bundle);
  }

  /// Encripta o SignalPayload para um envelope Signal Base64.
  Future<String> encryptMessage(String remoteUserId, SignalPayload payload) async {
    await buildSessionIfNeeded(remoteUserId);
    
    final address = SignalProtocolAddress(remoteUserId, 1);
    final sessionCipher = SessionCipher.fromStore(_protocolStore, address);
    
    final plaintext = payload.serialize();
    final ciphertext = await sessionCipher.encrypt(Uint8List.fromList(utf8.encode(plaintext)));
    return base64Encode(ciphertext.serialize());
  }

  /// Desencripta um envelope Base64 recebido para um SignalPayload.
  /// Implementa o padrão de Session Reset em caso de falha.
  Future<SignalPayload> decryptMessage(String remoteUserId, String base64Ciphertext) async {
    final address = SignalProtocolAddress(remoteUserId, 1);
    final sessionCipher = SessionCipher.fromStore(_protocolStore, address);
    final ciphertextBytes = base64Decode(base64Ciphertext);

    Uint8List plaintextBytes;
    
    try {
      try {
        plaintextBytes = await sessionCipher.decryptFromSignal(SignalMessage.fromSerialized(ciphertextBytes));
      } catch (e) {
        plaintextBytes = await sessionCipher.decrypt(PreKeySignalMessage(ciphertextBytes));
      }
    } catch (e) {
      SigmaLog.e(TAG, "Falha na descriptografia para $remoteUserId. Resetando sessão.");
      await _protocolStore.deleteSession(address);
      throw DecryptionException("Sessão inválida ou mensagem corrompida. Sessão limpa.");
    }

    final plaintext = utf8.decode(plaintextBytes);
    return SignalPayload.deserialize(plaintext);
  }
}
