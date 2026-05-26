import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sigma/data/models/user_response.dart';

/// Central SigmaStore - Inspirado na arquitetura do Signal-Android.
/// Provê acesso centralizado, criptografado e cacheado à persistência.
class SigmaStore {
  static final SigmaStore _instance = SigmaStore._internal();
  static SigmaStore get instance => _instance;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  late final AccountStore account;
  late final KeyStore keys;

  SigmaStore._internal() {
    account = AccountStore(_storage);
    keys = KeyStore(_storage);
  }

  /// Inicializa o cache em memória lendo dados críticos do disco seguro.
  Future<void> init() async {
    await account.loadToMemory();
  }
}

class AccountStore {
  final FlutterSecureStorage _storage;
  
  // Cache em memória para acesso síncrono instantâneo (estilo SignalStore)
  String? _authToken;
  String? _userId;
  UserDto? _user;

  AccountStore(this._storage);

  static const _keyUser = 'account_user';
  static const _keyToken = 'account_token';
  static const _keyUserId = 'account_user_id';

  Future<void> loadToMemory() async {
    _authToken = await _storage.read(key: _keyToken);
    _userId = await _storage.read(key: _keyUserId);
    final userStr = await _storage.read(key: _keyUser);
    if (userStr != null) {
      _user = UserDto.fromJson(jsonDecode(userStr));
    }
  }

  /// Acesso síncrono ao Token (Ideal para Interceptors do Dio)
  String? getTokenSync() => _authToken;

  /// Acesso síncrono ao Usuário (Ideal para o boot/splash screen)
  UserDto? getUserSync() => _user;

  Future<void> saveSession(UserDto user, String token) async {
    _user = user;
    _userId = user.id;
    _authToken = token;

    await Future.wait([
      _storage.write(key: _keyUser, value: jsonEncode(user.toJson())),
      _storage.write(key: _keyToken, value: token),
      _storage.write(key: _keyUserId, value: user.id),
    ]);
  }

  Future<UserDto?> getUser() async => _user;
  String? getUserId() => _userId;

  Future<void> clear() async {
    _user = null;
    _userId = null;
    _authToken = null;
    await Future.wait([
      _storage.delete(key: _keyUser),
      _storage.delete(key: _keyToken),
      _storage.delete(key: _keyUserId),
    ]);
  }
}

class KeyStore {
  final FlutterSecureStorage _storage;
  KeyStore(this._storage);

  static const _keyIdentityKeyPair = 'signal_identity_key_pair';
  static const _keyRegistrationId = 'signal_registration_id';
  static const _keySignedPreKey = 'signal_signed_pre_key';
  static const _keyPublicPreKeys = 'signal_public_pre_keys';
  static const _keyDatabasePassword = 'database_password';

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Gera ou recupera uma chave mestre para encriptação do banco via SQLCipher.
  Future<String> getDatabasePassword() async {
    var pass = await _storage.read(key: _keyDatabasePassword);
    if (pass == null) {
      // Simula a geração de uma chave AES-256 forte
      pass = 'sigma_master_key_${DateTime.now().microsecondsSinceEpoch}'; 
      await _storage.write(key: _keyDatabasePassword, value: pass);
    }
    return pass;
  }

  // Atalhos para chaves específicas do protocolo
  String get identityKeyPairKey => _keyIdentityKeyPair;
  String get registrationIdKey => _keyRegistrationId;
  String get signedPreKeyKey => _keySignedPreKey;
  String get publicPreKeysKey => _keyPublicPreKeys;
}

