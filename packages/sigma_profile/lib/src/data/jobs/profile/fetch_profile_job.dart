import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_database/sigma_database.dart';

/// FetchProfileJob - Busca dados públicos de um perfil no servidor.
class FetchProfileJob extends Job {
  static const String KEY = "FetchProfileJob";
  final String recipientId;
  final ProfileRemoteDataSource? remoteDataSource;
  final RecipientDatabase? recipientDatabase;

  FetchProfileJob({
    required this.recipientId,
    this.remoteDataSource,
    this.recipientDatabase,
    int? databaseId,
  })  : super(
          databaseId: databaseId,
          factoryKey: KEY,
          queueKey: "profile_$recipientId",
        );

  @override
  Map<String, dynamic> serialize() => {'recipientId': recipientId};

  static Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return FetchProfileJob(
      recipientId: data['recipientId'],
      remoteDataSource: locator<ProfileRemoteDataSource>(),
      recipientDatabase: locator<RecipientDatabase>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    SigmaLog.d(KEY, "Buscando perfil remoto para $recipientId");

    final result = await remoteDataSource!.getProfile(recipientId);

    await result.when(
      (dto) async {
        final recipient = ModelMapper.recipientFromDto(dto);
        await recipientDatabase!.upsertRecipient(recipient.toCompanion());
        SigmaLog.i(KEY, "Perfil de $recipientId atualizado.");
      },
      (failure) {
        SigmaLog.e(KEY, "Erro ao buscar perfil de $recipientId: ${failure.message}");
        throw Exception(failure.message);
      },
    );
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {}
}
