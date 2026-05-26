import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/domain/repositories/i_recipient_repository.dart';
import 'package:sigma/data/datasources/chat/recipient_local_data_source.dart';
import 'package:sigma/data/models/model_mapper.dart';

class RecipientRepositoryImpl implements IRecipientRepository {
  final RecipientLocalDataSource _localDataSource;

  RecipientRepositoryImpl(this._localDataSource);

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
}
