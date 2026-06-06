import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sigma_core/src/data/models/user_response.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_core/sigma_core.dart';

/// Central SigmaStore - Refatorado para POO com Tipagem Forte.
class SigmaStore {
  final AccountStore account;
  final KeyStore keys;
  final SettingsStore settings;

  SigmaStore({
    required this.account,
    required this.keys,
    required this.settings,
  });

  Future<void> init() async {
    await account.loadToMemory();
  }

  /// Limpa TODOS os dados do app (Logout Completo)
  Future<void> clearAll() async {
    await account.clear();
    await keys.deleteAll();
    // Opcional: settings.clear() se quiser resetar tema etc.
  }
}

/// Gerencia estado da conta.
class AccountStore {
  final FlutterSecureStorage _storage;
  
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
      try {
        _user = UserDto.fromJson(jsonDecode(userStr));
      } catch (_) {}
    }
  }

  String? getTokenSync() => _authToken;
  UserDto? getUserSync() => _user;
  String? getUserId() => _userId;

  Future<UserDto?> getUser() async => _user;

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

/// SettingsStore - Refatorado para ocultar a complexidade de Strings e conversões.
class SettingsStore {
  final KeyValueDatabase _db;
  
  SettingsStore(this._db);

  // Chaves encapsuladas (Privadas)
  static const _keyTheme = "settings_theme";
  static const _keyReadReceipts = "settings_read_receipts";
  static const _keyLocale = "settings_locale";
  static const _keyChatFilters = "settings_chat_filters";
  static const _keyLastTab = "ui_last_tab";
  static const _keyMessageFontSize = "settings_message_font_size";
  static const _keyMessageBorderRadius = "settings_message_border_radius";

  // Métodos Tipados (Abstração POO)
  Future<void> setTheme(String theme) => _db.writeString(_keyTheme, theme);
  Future<String?> getTheme() => _db.readString(_keyTheme);

  Future<void> setReadReceipts(bool enabled) => _db.writeBool(_keyReadReceipts, enabled);
  Future<bool> isReadReceiptsEnabled() => _db.readBool(_keyReadReceipts, defaultValue: true);

  Future<void> setLocale(String languageCode) => _db.writeString(_keyLocale, languageCode);
  Future<String?> getLocale() => _db.readString(_keyLocale);

  Future<void> setShowChatFilters(bool enabled) => _db.writeBool(_keyChatFilters, enabled);
  Future<bool> isShowChatFiltersEnabled() => _db.readBool(_keyChatFilters, defaultValue: true);

  Future<void> setLastTab(int index) => _db.writeInt(_keyLastTab, index);
  Future<int> getLastTab() async => (await _db.readInt(_keyLastTab)) ?? 0;

  Future<void> setMessageFontSize(double size) => _db.writeDouble(_keyMessageFontSize, size);
  Future<double> getMessageFontSize() async => (await _db.readDouble(_keyMessageFontSize)) ?? 16.0;

  Future<void> setMessageBorderRadius(double radius) => _db.writeDouble(_keyMessageBorderRadius, radius);
  Future<double> getMessageBorderRadius() async => (await _db.readDouble(_keyMessageBorderRadius)) ?? 18.0;
}

/// Helpers para o KeyValueDatabase (Extension on KeyValueDatabase para centralizar conversão)
extension KeyValueTypedAccess on KeyValueDatabase {
  Future<void> writeBool(String key, bool value) => writeValue(key, value.toString());
  
  Future<bool> readBool(String key, {bool defaultValue = false}) async {
    final val = await readValue(key);
    if (val == null) return defaultValue;
    return val == "true";
  }

  Future<void> writeString(String key, String value) => writeValue(key, value);
  Future<String?> readString(String key) => readValue(key);

  Future<void> writeInt(String key, int value) => writeValue(key, value.toString());
  Future<int?> readInt(String key) async {
    final val = await readValue(key);
    return val != null ? int.tryParse(val) : null;
  }

  Future<void> writeDouble(String key, double value) => writeValue(key, value.toString());
  Future<double?> readDouble(String key) async {
    final val = await readValue(key);
    return val != null ? double.tryParse(val) : null;
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

  Future<void> write(String key, String value) => _storage.write(key: key, value: value);
  Future<String?> read(String key) => _storage.read(key: key);

  Future<void> deleteAll() => _storage.deleteAll();

  Future<String> getDatabasePassword() async {
    var pass = await _storage.read(key: _keyDatabasePassword);
    if (pass == null) {
      pass = 'sigma_master_key_${DateTime.now().microsecondsSinceEpoch}'; 
      await _storage.write(key: _keyDatabasePassword, value: pass);
    }
    return pass;
  }

  String get identityKeyPairKey => _keyIdentityKeyPair;
  String get registrationIdKey => _keyRegistrationId;
  String get signedPreKeyKey => _keySignedPreKey;
  String get publicPreKeysKey => _keyPublicPreKeys;
}
