import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_database/sigma_database.dart';

/// UpdateProfileJob - Garante que as mudanças de perfil cheguem ao servidor.
class UpdateProfileJob extends core.Job {
  static const String KEY = "UpdateProfileJob";
  
  final String? name;
  final String? username;
  final String? bio;
  final String? avatarUrl;
  final String? email;
  final String? country;
  final String? relativeName;
  final String? relativeId;
  final bool? isPrivate;

  final ProfileRemoteDataSource? remoteDataSource;
  final UserDao? userDao;

  UpdateProfileJob({
    this.name,
    this.username,
    this.bio,
    this.avatarUrl,
    this.email,
    this.country,
    this.relativeName,
    this.relativeId,
    this.isPrivate,
    this.remoteDataSource,
    this.userDao,
    int? databaseId,
  }) : super(
    databaseId: databaseId,
    factoryKey: KEY,
    queueKey: "profile_sync",
    priority: JobPriority.low, 
  );

  @override
  Map<String, dynamic> serialize() => {
    'name': name,
    'username': username,
    'bio': bio,
    'avatarUrl': avatarUrl,
    'email': email,
    'country': country,
    'relativeName': relativeName,
    'relativeId': relativeId,
    'isPrivate': isPrivate,
  };

  static core.Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return UpdateProfileJob(
      name: data['name'],
      username: data['username'],
      bio: data['bio'],
      avatarUrl: data['avatarUrl'],
      email: data['email'],
      country: data['country'],
      relativeName: data['relativeName'],
      relativeId: data['relativeId'],
      isPrivate: data['isPrivate'],
      remoteDataSource: locator<ProfileRemoteDataSource>(),
      userDao: locator<UserDao>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    SigmaLog.d(KEY, "Sincronizando mudanças de perfil com o servidor...");

    final result = await remoteDataSource!.updateProfile(
      name: name,
      username: username,
      bio: bio,
      avatarUrl: avatarUrl,
      email: email,
      country: country,
      relativeName: relativeName,
      relativeId: relativeId,
      isPrivate: isPrivate,
    );

    await result.when(
      (userDto) async {
        SigmaLog.i(KEY, "Perfil sincronizado com sucesso. Atualizando banco local com dados oficiais.");
        final recipient = ModelMapper.recipientFromDto(userDto);
        
        await userDao!.upsertUser(recipient.toCompanion());
      },
      (failure) {
        SigmaLog.w(KEY, "Falha temporária ao sincronizar perfil: ${failure.message}");
        throw Exception(failure.message); // Faz o Job Manager tentar novamente mais tarde
      },
    );
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro crítico no UpdateProfileJob", error);
  }
}
