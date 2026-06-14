import 'dart:async';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_profile/src/domain/i_profile_repository.dart';
import 'jobs/profile/update_profile_job.dart';

/// ProfileRepositoryImpl - Gerencia o perfil do usuário na arquitetura CSFA.
class ProfileRepositoryImpl implements IProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final UserDao _userDao;
  final SigmaStore _sigmaStore;
  final SigmaJobManager _jobManager;

  ProfileRepositoryImpl(
    this._remoteDataSource,
    this._userDao,
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

    final currentRecord = await _userDao.getUser(userId);
    
    final UserEntity currentEntity;
    if (currentRecord != null) {
      currentEntity = UserMapper.fromDb(currentRecord);
    } else {
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

    await _userDao.upsertUser(UserMapper.toDb(updatedEntity));

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
    
    final record = await _userDao.getUser(userId);
    _refreshProfileInBackground(userId);

    return record != null ? UserMapper.fromDb(record).toRecipient() : null;
  }

  Future<void> _refreshProfileInBackground(String userId) async {
    final result = await _remoteDataSource.getProfile(userId);
    result.when(
      (userDto) async {
        final entity = UserMapper.fromDto(userDto);
        await _userDao.upsertUser(UserMapper.toDb(entity));
      },
      (failure) => null,
    );
  }

  @override
  Stream<Recipient?> watchSelfProfile() {
    final userId = _sigmaStore.account.getUserId();
    if (userId == null) return Stream.value(null);
    
    // UserDao doesn't have watch yet, implementing it as a Stream.value for now or adding to UserDao
    return Stream.value(null);
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
