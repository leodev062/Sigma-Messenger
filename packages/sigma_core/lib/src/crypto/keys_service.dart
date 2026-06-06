import 'package:flutter/foundation.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart' as signal;
import 'dart:convert';
import 'package:sigma_core/src/storage/sigma_store.dart';

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

class GeneratedKey {
  final String publicKey;
  GeneratedKey(this.publicKey);
}

class GeneratedSignedKey extends GeneratedKey {
  final String signature;
  GeneratedSignedKey({required String publicKey, required this.signature})
      : super(publicKey);
}

class KeysService {
  final KeyStore _store;

  KeysService(this._store);

  Future<GeneratedKey> generateIdentityKeyPair() async {
    final keyPair = await compute((_) => signal.generateIdentityKeyPair(), null);
    return GeneratedKey(base64Encode(keyPair.getPublicKey().serialize()));
  }

  Future<GeneratedKey> generatePreKeyPair(int id) async {
    final preKeys = await compute((_) => signal.generatePreKeys(id, 1), null);
    return GeneratedKey(
        base64Encode(preKeys[0].getKeyPair().publicKey.serialize()));
  }

  Future<GeneratedSignedKey> generateSignedPreKeyPair(int id) async {
    final keyPair = signal.generateIdentityKeyPair();
    final signedPreKey = signal.generateSignedPreKey(keyPair, id);
    return GeneratedSignedKey(
      publicKey: base64Encode(signedPreKey.getKeyPair().publicKey.serialize()),
      signature: base64Encode(signedPreKey.signature),
    );
  }

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
    final identityKeyPair = signal.generateIdentityKeyPair();
    final registrationId = signal.generateRegistrationId(false);
    
    // Signed PreKey
    final signedPreKey = signal.generateSignedPreKey(identityKeyPair, 1);
    
    // One-Time PreKeys (100 chaves)
    final preKeys = signal.generatePreKeys(1, 100);

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
      final record = signal.PreKeyRecord.fromBuffer(base64Decode(serializedBase64 as String));
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
    final keyPair = signal.IdentityKeyPair.fromSerialized(Uint8List.fromList(bytes));
    return base64Encode(keyPair.getPublicKey().serialize());
  }

  /// Retorna os dados da SignedPreKey formatados para o servidor
  Future<Map<String, dynamic>?> getSignedPreKeyStructured() async {
    final serialized = await _store.read(_store.signedPreKeyKey);
    if (serialized == null) return null;
    
    final record = signal.SignedPreKeyRecord.fromSerialized(base64Decode(serialized));
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

  /// Gera um novo lote de PreKeys para rotação.
  /// Padrão Signal: O cliente deve manter ~100 chaves no servidor.
  Future<List<Map<String, dynamic>>> rotatePreKeys() async {
    final json = await _store.read(_store.publicPreKeysKey);
    int lastId = 0;
    List<Uint8List> existingRecords = [];
    
    if (json != null) {
      final List<dynamic> list = jsonDecode(json);
      existingRecords = list.map((e) => base64Decode(e as String)).toList();
      if (existingRecords.isNotEmpty) {
        final lastRecord = signal.PreKeyRecord.fromBuffer(existingRecords.last);
        lastId = lastRecord.id;
      }
    }

    // Gerar 50 novas chaves para evitar exaustão
    final newPreKeys = await compute((params) {
      return signal.generatePreKeys(params['startId'] as int, 50);
    }, {'startId': lastId + 1});

    final List<Uint8List> newRecords = newPreKeys.map((pk) => pk.serialize()).toList();
    existingRecords.addAll(newRecords);

    // Salvar o lote atualizado (Idealmente deveríamos limpar as chaves já usadas pelo DriftSignalProtocolStore)
    await _store.write(_store.publicPreKeysKey, jsonEncode(existingRecords.map((pk) => base64Encode(pk)).toList()));

    return newPreKeys.map((pk) => {
      'id': pk.id,
      'key': base64Encode(pk.getKeyPair().publicKey.serialize()),
    }).toList();
  }
}
