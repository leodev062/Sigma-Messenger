import 'package:get_it/get_it.dart';
import 'dart:convert';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_core/src/network/pb/keys.pb.dart' as sigmapb;
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart' as signal;

/// PushKeysUploadJob - Garante o upload do KeyBundle para o servidor.
/// Padrão Signal: Vital para que outros usuários possam iniciar chats criptografados.
class PushKeysUploadJob extends Job {
  static const String KEY = "PushKeysUploadJob";

  final KeysRemoteDataSource? keysRemoteDataSource;
  final KeyStore? keyStore;

  PushKeysUploadJob({
    this.keysRemoteDataSource,
    this.keyStore,
    int? databaseId,
  })  : super(
          databaseId: databaseId,
          factoryKey: KEY,
          queueKey: "identity_upload",
          priority: JobPriority.critical, 
        );

  @override
  Map<String, dynamic> serialize() => {};

  static Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PushKeysUploadJob(
      keysRemoteDataSource: locator<KeysRemoteDataSource>(),
      keyStore: locator<KeyStore>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    SigmaLog.d(KEY, "Iniciando upload de chaves públicas para o servidor...");

    final serializedIdentity = await keyStore!.read(keyStore!.identityKeyPairKey);
    final registrationIdStr = await keyStore!.read(keyStore!.registrationIdKey);
    final signedPreKeyStr = await keyStore!.read(keyStore!.signedPreKeyKey);
    final publicPreKeysJson = await keyStore!.read(keyStore!.publicPreKeysKey);

    if (serializedIdentity == null || registrationIdStr == null || 
        signedPreKeyStr == null || publicPreKeysJson == null) {
      throw Exception("Dados de chaves incompletos");
    }

    final identityKeyPair = signal.IdentityKeyPair.fromSerialized(base64Decode(serializedIdentity));
    final signedPreKey = signal.SignedPreKeyRecord.fromSerialized(base64Decode(signedPreKeyStr));
    final List<dynamic> preKeysList = jsonDecode(publicPreKeysJson);

    // Ajuste conforme o keys.pb.dart gerado
    final bundle = sigmapb.PreKeyBundle()
      ..identityKey = identityKeyPair.getPublicKey().serialize()
      ..registrationId = int.parse(registrationIdStr)
      ..signedPreKeyId = signedPreKey.id
      ..signedPreKeyPublic = signedPreKey.getKeyPair().publicKey.serialize()
      ..signedPreKeySignature = signedPreKey.signature;

    for (var serializedBase64 in preKeysList) {
      final pk = signal.PreKeyRecord.fromBuffer(base64Decode(serializedBase64 as String));
      bundle.preKeys.add(sigmapb.PreKeyRecord()
        ..id = pk.id
        ..publicKey = pk.getKeyPair().publicKey.serialize());
    }

    final result = await keysRemoteDataSource!.putKeys(bundle);
    
    result.when(
      (_) => SigmaLog.i(KEY, "KeyBundle enviado com sucesso."),
      (failure) => throw Exception("Falha ao enviar chaves: ${failure.message}"),
    );
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Falha ao enviar chaves.", error);
  }
}
