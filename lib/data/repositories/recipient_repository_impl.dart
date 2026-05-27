import 'package:drift/drift.dart';
import 'package:sigma/core/storage/database.dart' as drift;
import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/domain/repositories/i_recipient_repository.dart';
import 'package:sigma/data/datasources/chat/recipient_local_data_source.dart';
import 'package:sigma/data/datasources/chat/recipient_remote_data_source.dart';
import 'package:sigma/data/models/model_mapper.dart';

class RecipientRepositoryImpl implements IRecipientRepository {
  final RecipientLocalDataSource _localDataSource;
  final RecipientRemoteDataSource _remoteDataSource;

  RecipientRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Stream<UserEntity?> getRecipient(String id) {
    return _localDataSource.getRecipient(id).map(
      (user) => user != null ? ModelMapper.userFromDrift(user) : null,
    );
  }

  @override
  Stream<List<UserEntity>> getAllRecipients() {
    return _localDataSource.getAllRecipients().map(
      (users) => users.map((u) => ModelMapper.userFromDrift(u)).toList(),
    );
  }

  @override
  Future<void> refreshRecipient(String id) async {
    // Sincronização via RemoteDataSource futuramente
  }

  @override
  Future<List<UserEntity>> searchRemote(String term) async {
    final dtos = await _remoteDataSource.searchUsers(term);
    return dtos.map((dto) => ModelMapper.userFromDto(dto)).toList();
  }

  @override
  Future<void> saveRecipient(UserEntity user) async {
    await _localDataSource.saveUser(drift.UsersCompanion(
      id: Value(user.id),
      name: Value(user.name),
      username: Value(user.username),
      phone: Value(user.phone),
      avatarUrl: Value(user.avatarUrl),
    ));
  }
}
