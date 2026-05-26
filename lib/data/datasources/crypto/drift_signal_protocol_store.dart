import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:sigma/core/storage/database.dart';
import 'package:sigma/core/storage/sigma_store.dart';

/// Implementação persistente do SignalProtocolStore utilizando Drift.
/// Substitui o InMemorySignalProtocolStore para garantir a catraca (ratchet) entre reinicializações.
/// Carrega a identidade local do SigmaStore (SecureStorage) sob demanda.
class DriftSignalProtocolStore implements SignalProtocolStore {
  final AppDatabase _db;
  
  IdentityKeyPair? _cachedIdentityKeyPair;
  int? _cachedRegistrationId;

  DriftSignalProtocolStore(this._db);

  /// Garante que a identidade local e o ID de registro estão carregados na memória.
  Future<void> _ensureLocalIdentity() async {
    if (_cachedIdentityKeyPair != null && _cachedRegistrationId != null) return;

    final keys = SigmaStore.instance.keys;
    final serializedIdentity = await keys.read(keys.identityKeyPairKey);
    final registrationIdStr = await keys.read(keys.registrationIdKey);
    
    if (serializedIdentity == null || registrationIdStr == null) {
      throw Exception("Chaves de identidade não encontradas no SecureStorage.");
    }

    _cachedIdentityKeyPair = IdentityKeyPair.fromSerialized(base64Decode(serializedIdentity));
    _cachedRegistrationId = int.parse(registrationIdStr);
  }

  // --- SessionStore ---

  @override
  Future<SessionRecord> loadSession(SignalProtocolAddress address) async {
    final query = _db.select(_db.signalSessions)
      ..where((t) => t.addressName.equals(address.getName()))
      ..where((t) => t.deviceId.equals(address.getDeviceId()));
    
    final result = await query.getSingleOrNull();
    if (result != null) {
      return SessionRecord.fromSerialized(result.sessionRecord);
    } else {
      return SessionRecord();
    }
  }

  @override
  Future<List<int>> getSubDeviceSessions(String name) async {
    final query = _db.select(_db.signalSessions)
      ..where((t) => t.addressName.equals(name));
    
    final results = await query.get();
    return results.map((r) => r.deviceId).toList();
  }

  @override
  Future<void> storeSession(SignalProtocolAddress address, SessionRecord record) async {
    await _db.into(_db.signalSessions).insertOnConflictUpdate(
      SignalSessionsCompanion.insert(
        addressName: address.getName(),
        deviceId: address.getDeviceId(),
        sessionRecord: record.serialize(),
      ),
    );
  }

  @override
  Future<bool> containsSession(SignalProtocolAddress address) async {
    final query = _db.select(_db.signalSessions)
      ..where((t) => t.addressName.equals(address.getName()))
      ..where((t) => t.deviceId.equals(address.getDeviceId()));
    
    final result = await query.getSingleOrNull();
    return result != null;
  }

  @override
  Future<void> deleteSession(SignalProtocolAddress address) async {
    await (_db.delete(_db.signalSessions)
      ..where((t) => t.addressName.equals(address.getName()))
      ..where((t) => t.deviceId.equals(address.getDeviceId())))
    .go();
  }

  @override
  Future<void> deleteAllSessions(String name) async {
    await (_db.delete(_db.signalSessions)..where((t) => t.addressName.equals(name))).go();
  }

  // --- PreKeyStore ---

  @override
  Future<PreKeyRecord> loadPreKey(int preKeyId) async {
    final query = _db.select(_db.signalPreKeys)..where((t) => t.preKeyId.equals(preKeyId));
    final result = await query.getSingleOrNull();
    if (result == null) {
      throw InvalidKeyIdException("PreKey não encontrada: $preKeyId");
    }
    return PreKeyRecord.fromBuffer(result.preKeyRecord);
  }

  @override
  Future<void> storePreKey(int preKeyId, PreKeyRecord record) async {
    await _db.into(_db.signalPreKeys).insertOnConflictUpdate(
      SignalPreKeysCompanion.insert(
        preKeyId: Value(preKeyId),
        preKeyRecord: record.serialize(),
      ),
    );
  }

  @override
  Future<bool> containsPreKey(int preKeyId) async {
    final query = _db.select(_db.signalPreKeys)..where((t) => t.preKeyId.equals(preKeyId));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  @override
  Future<void> removePreKey(int preKeyId) async {
    await (_db.delete(_db.signalPreKeys)..where((t) => t.preKeyId.equals(preKeyId))).go();
  }

  // --- SignedPreKeyStore ---

  @override
  Future<SignedPreKeyRecord> loadSignedPreKey(int signedPreKeyId) async {
    final query = _db.select(_db.signalSignedPreKeys)..where((t) => t.signedPreKeyId.equals(signedPreKeyId));
    final result = await query.getSingleOrNull();
    if (result == null) {
      throw InvalidKeyIdException("SignedPreKey não encontrada: $signedPreKeyId");
    }
    return SignedPreKeyRecord.fromSerialized(result.signedPreKeyRecord);
  }

  @override
  Future<List<SignedPreKeyRecord>> loadSignedPreKeys() async {
    final results = await _db.select(_db.signalSignedPreKeys).get();
    return results.map((r) => SignedPreKeyRecord.fromSerialized(r.signedPreKeyRecord)).toList();
  }

  @override
  Future<void> storeSignedPreKey(int signedPreKeyId, SignedPreKeyRecord record) async {
    await _db.into(_db.signalSignedPreKeys).insertOnConflictUpdate(
      SignalSignedPreKeysCompanion.insert(
        signedPreKeyId: Value(signedPreKeyId),
        signedPreKeyRecord: record.serialize(),
      ),
    );
  }

  @override
  Future<bool> containsSignedPreKey(int signedPreKeyId) async {
    final query = _db.select(_db.signalSignedPreKeys)..where((t) => t.signedPreKeyId.equals(signedPreKeyId));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  @override
  Future<void> removeSignedPreKey(int signedPreKeyId) async {
    await (_db.delete(_db.signalSignedPreKeys)..where((t) => t.signedPreKeyId.equals(signedPreKeyId))).go();
  }

  // --- IdentityKeyStore ---

  @override
  Future<IdentityKeyPair> getIdentityKeyPair() async {
    await _ensureLocalIdentity();
    return _cachedIdentityKeyPair!;
  }

  @override
  Future<int> getLocalRegistrationId() async {
    await _ensureLocalIdentity();
    return _cachedRegistrationId!;
  }

  @override
  Future<bool> saveIdentity(SignalProtocolAddress address, IdentityKey? identityKey) async {
    await _db.into(_db.signalIdentities).insertOnConflictUpdate(
      SignalIdentitiesCompanion.insert(
        addressName: address.getName(),
        registrationId: 0, 
        identityKey: Value(identityKey?.serialize()),
      ),
    );
    return true;
  }

  @override
  Future<bool> isTrustedIdentity(SignalProtocolAddress address, IdentityKey? identityKey, Direction direction) async {
    final query = _db.select(_db.signalIdentities)..where((t) => t.addressName.equals(address.getName()));
    final result = await query.getSingleOrNull();
    
    if (result == null || result.identityKey == null) return true;
    
    final storedKey = IdentityKey(Curve.decodePoint(result.identityKey!, 0));
    return storedKey == identityKey;
  }

  @override
  Future<IdentityKey?> getIdentity(SignalProtocolAddress address) async {
    final query = _db.select(_db.signalIdentities)..where((t) => t.addressName.equals(address.getName()));
    final result = await query.getSingleOrNull();
    if (result == null || result.identityKey == null) return null;
    return IdentityKey(Curve.decodePoint(result.identityKey!, 0));
  }
}
