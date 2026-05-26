import 'dart:convert';
import 'dart:typed_data';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:sigma/core/network/api_service.dart';
import 'package:sigma/core/storage/sigma_store.dart';

/// Gerenciador de Criptografia de Ponta-a-Ponta (E2EE)
/// Utiliza o protocolo Signal para selar e abrir envelopes de mensagens.
class CryptoManager {
  final ApiService _apiService;
  InMemorySignalProtocolStore? _protocolStore;

  CryptoManager(this._apiService);

  /// Inicializa o store do Signal com as chaves do utilizador logado.
  /// Lê do SigmaStore (disco seguro) e carrega para a RAM.
  Future<void> init() async {
    if (_protocolStore != null) return;

    final keys = SigmaStore.instance.keys;
    
    final serializedIdentity = await keys.read(keys.identityKeyPairKey);
    final registrationIdStr = await keys.read(keys.registrationIdKey);
    
    if (serializedIdentity == null || registrationIdStr == null) {
      throw Exception("Chaves não encontradas. Login necessário.");
    }

    final identityKeyPair = IdentityKeyPair.fromSerialized(base64Decode(serializedIdentity));
    final registrationId = int.parse(registrationIdStr);

    _protocolStore = InMemorySignalProtocolStore(identityKeyPair, registrationId);
    
    // Carregar Signed PreKey (Record completo com privada)
    final serializedSignedPreKey = await keys.read(keys.signedPreKeyKey);
    if (serializedSignedPreKey != null) {
      final signedPreKey = SignedPreKeyRecord.fromSerialized(base64Decode(serializedSignedPreKey));
      // Padrão síncrono no InMemoryStore
      _protocolStore!.storeSignedPreKey(signedPreKey.id, signedPreKey);
    }

    // Carregar One-Time PreKeys (Records completos com privadas)
    final serializedPreKeys = await keys.read(keys.publicPreKeysKey);
    if (serializedPreKeys != null) {
      final List<dynamic> list = jsonDecode(serializedPreKeys);
      for (var item in list) {
        // Correção: PreKeyRecord usa fromBuffer
        final record = PreKeyRecord.fromBuffer(base64Decode(item as String));
        _protocolStore!.storePreKey(record.id, record);
      }
    }
  }

  /// Constrói uma sessão segura com o destinatário se ela ainda não existir.
  Future<void> buildSessionIfNeeded(String remoteUserId) async {
    await init();
    final address = SignalProtocolAddress(remoteUserId, 1);
    
    if (await _protocolStore!.containsSession(address)) return;

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

    final sessionBuilder = SessionBuilder.fromSignalStore(_protocolStore!, address);
    await sessionBuilder.processPreKeyBundle(bundle);
  }

  /// Encripta o texto para um envelope Signal Base64.
  Future<String> encryptMessage(String remoteUserId, String plaintext) async {
    await buildSessionIfNeeded(remoteUserId);
    
    final address = SignalProtocolAddress(remoteUserId, 1);
    final sessionCipher = SessionCipher.fromStore(_protocolStore!, address);
    
    final ciphertext = await sessionCipher.encrypt(Uint8List.fromList(utf8.encode(plaintext)));
    return base64Encode(ciphertext.serialize());
  }

  /// Desencripta um envelope Base64 recebido para texto limpo.
  Future<String> decryptMessage(String remoteUserId, String base64Ciphertext) async {
    await init();
    
    final address = SignalProtocolAddress(remoteUserId, 1);
    final sessionCipher = SessionCipher.fromStore(_protocolStore!, address);
    final ciphertextBytes = base64Decode(base64Ciphertext);

    Uint8List plaintextBytes;
    
    try {
      // Tenta decifrar como SignalMessage
      plaintextBytes = await sessionCipher.decryptFromSignal(SignalMessage.fromSerialized(ciphertextBytes));
    } catch (e) {
      // Tenta como PreKeySignalMessage (nova sessão)
      plaintextBytes = await sessionCipher.decrypt(PreKeySignalMessage(ciphertextBytes));
    }

    return utf8.decode(plaintextBytes);
  }
}

