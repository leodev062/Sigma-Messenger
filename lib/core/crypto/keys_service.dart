import 'package:flutter/foundation.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'dart:convert';
import 'package:sigma/core/storage/sigma_store.dart';

class SignalKeysBundle {
  final Uint8List identityKeyPair; // Inclui chave privada
  final int registrationId;
  
  final Uint8List signedPreKeyFull; // Record completo (com privada) para o disco
  final List<Uint8List> preKeysFull; // Records completos (com privadas) para o disco
  
  // Dados públicos para o servidor
  final int signedPreKeyId;
  final Uint8List signedPreKeyPublic;
  final Uint8List signedPreKeySignature;
  final List<Map<String, dynamic>> publicPreKeys;

  SignalKeysBundle({
    required this.identityKeyPair,
    required this.registrationId,
    required this.signedPreKeyFull,
    required this.preKeysFull,
    required this.signedPreKeyId,
    required this.signedPreKeyPublic,
    required this.signedPreKeySignature,
    required this.publicPreKeys,
  });
}

class KeysService {
  final _store = SigmaStore.instance.keys;

  Future<void> generateAndStoreKeys() async {
    if (await getIdentityKey() != null) return;

    final bundle = await compute(_generateKeysIsolate, null);

    // Salva no SigmaStore (Cofre Local)
    // Guardamos os Records COMPLETOS (com chaves privadas) para podermos descriptografar depois.
    await Future.wait([
      _store.write(_store.identityKeyPairKey, base64Encode(bundle.identityKeyPair)),
      _store.write(_store.registrationIdKey, bundle.registrationId.toString()),
      _store.write(_store.signedPreKeyKey, base64Encode(bundle.signedPreKeyFull)),
      _store.write(_store.publicPreKeysKey, jsonEncode(bundle.preKeysFull.map((pk) => base64Encode(pk)).toList())),
    ]);
  }

  static SignalKeysBundle _generateKeysIsolate(dynamic _) {
    final identityKeyPair = generateIdentityKeyPair();
    final registrationId = generateRegistrationId(false);
    
    // Signed PreKey
    final signedPreKey = generateSignedPreKey(identityKeyPair, 1);
    
    // One-Time PreKeys (100 chaves)
    final preKeys = generatePreKeys(1, 100);

    final publicPreKeys = preKeys.map((pk) {
      return {
        'id': pk.id,
        'key': base64Encode(pk.getKeyPair().publicKey.serialize()),
      };
    }).toList();

    return SignalKeysBundle(
      identityKeyPair: identityKeyPair.serialize(),
      registrationId: registrationId,
      signedPreKeyFull: signedPreKey.serialize(),
      preKeysFull: preKeys.map((pk) => pk.serialize()).toList(),
      signedPreKeyId: signedPreKey.id,
      signedPreKeyPublic: signedPreKey.getKeyPair().publicKey.serialize(),
      signedPreKeySignature: signedPreKey.signature,
      publicPreKeys: publicPreKeys,
    );
  }

  /// Retorna as PreKeys formatadas para o upload ao servidor
  Future<List<Map<String, dynamic>>> getOneTimePreKeysPublic() async {
    final json = await _store.read(_store.publicPreKeysKey);
    if (json == null) return [];
    final List<dynamic> list = jsonDecode(json);
    
    return list.map((serializedBase64) {
      // Correção: PreKeyRecord usa fromBuffer
      final record = PreKeyRecord.fromBuffer(base64Decode(serializedBase64 as String));
      return {
        'id': record.id,
        'key': base64Encode(record.getKeyPair().publicKey.serialize()),
      };
    }).toList();
  }

  Future<String?> getIdentityKey() async {
    final serialized = await _store.read(_store.identityKeyPairKey);
    if (serialized == null) return null;
    final bytes = base64Decode(serialized);
    final keyPair = IdentityKeyPair.fromSerialized(Uint8List.fromList(bytes));
    return base64Encode(keyPair.getPublicKey().serialize());
  }

  /// Retorna os dados da SignedPreKey formatados para o servidor
  Future<Map<String, dynamic>?> getSignedPreKeyStructured() async {
    final serialized = await _store.read(_store.signedPreKeyKey);
    if (serialized == null) return null;
    
    final record = SignedPreKeyRecord.fromSerialized(base64Decode(serialized));
    return {
      'id': record.id,
      'public': base64Encode(record.getKeyPair().publicKey.serialize()),
      'signature': base64Encode(record.signature),
    };
  }

  Future<int?> getRegistrationId() async {
    final id = await _store.read(_store.registrationIdKey);
    return id != null ? int.parse(id) : null;
  }
}

