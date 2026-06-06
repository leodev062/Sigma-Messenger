import 'dart:async';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_profile/src/domain/i_profile_repository.dart';
import 'jobs/profile/update_profile_job.dart';

/// ProfileRepositoryImpl - Gerencia o perfil do usuário (Self Recipient).
/// Implementa padrão Offline-First e Request Queue (Nível Telegram).
class ProfileRepositoryImpl implements IProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final RecipientDatabase _recipientDatabase;
  final SigmaStore _sigmaStore;
  final SigmaJobManager _jobManager;

  ProfileRepositoryImpl(
    this._remoteDataSource,
    this._recipientDatabase,
    this._sigmaStore,
    this._jobManager,
  );

  @override
  Future<Recipient> updateProfile({
    String? name,
    String? username,
    String? bio,
    String? avatarUrl,
    String? email,
    String? country,
    String? relativeName,
    String? relativeId,
    bool? isPrivate,
  }) async {
    final userId = _sigmaStore.account.getUserId();
    if (userId == null) throw Exception("Usuário não autenticado");

    // 1. Otimismo Total: Atualiza localmente independente de conexão ou existência prévia.
    final currentRecord = await _recipientDatabase.getRecipient(userId);
    
    final UserEntity currentEntity;
    if (currentRecord != null) {
      currentEntity = UserMapper.fromDb(currentRecord.data);
    } else {
      // Criação dinâmica para novos usuários ou fresh install
      final storedUser = _sigmaStore.account.getUserSync();
      currentEntity = UserEntity(
        id: userId,
        phone: storedUser?.phone ?? "",
        name: storedUser?.name,
        username: storedUser?.username,
        avatarUrl: storedUser?.avatarUrl,
        bio: storedUser?.bio,
        type: 'individual',
      );
    }

    final updatedEntity = currentEntity.copyWith(
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

    // Salva no banco local (UI reativa via Stream vai capturar isso)
    await _recipientDatabase.upsertRecipient(UserMapper.toDb(updatedEntity));

    // 2. Resiliência: Agenda o JOB para sincronizar com o servidor
    await _jobManager.add(UpdateProfileJob(
      name: name,
      username: username,
      bio: bio,
      avatarUrl: avatarUrl,
      email: email,
      country: country,
      relativeName: relativeName,
      relativeId: relativeId,
      isPrivate: isPrivate,
    ));

    return updatedEntity.toRecipient();
  }

  @override
  Future<Recipient?> getSelfProfile() async {
    final userId = _sigmaStore.account.getUserId();
    if (userId == null) return null;
    
    // Busca do banco local (Single Source of Truth)
    final record = await _recipientDatabase.getRecipient(userId);
    
    // Dispara atualização em background sem bloquear a UI
    _refreshProfileInBackground(userId);

    return record != null ? UserMapper.fromDb(record.data).toRecipient() : null;
  }

  Future<void> _refreshProfileInBackground(String userId) async {
    final result = await _remoteDataSource.getProfile(userId);
    result.when(
      (userDto) async {
        final entity = UserMapper.fromDto(userDto);
        await _recipientDatabase.upsertRecipient(UserMapper.toDb(entity));
      },
      (failure) => null, // Silencioso em background
    );
  }

  @override
  Stream<Recipient?> watchSelfProfile() {
    final userId = _sigmaStore.account.getUserId();
    if (userId == null) return Stream.value(null);
    
    // UI observa o Banco de Dados, não a API.
    return _recipientDatabase.watchRecipient(userId).map(
      (record) => record != null ? UserMapper.fromDb(record.data).toRecipient() : null,
    );
  }

  @override
  Future<bool> isUsernameAvailable(String username) async {
    final result = await _remoteDataSource.checkUsername(username);
    return result.when(
      (available) => available,
      (failure) => false,
    );
  }
}
