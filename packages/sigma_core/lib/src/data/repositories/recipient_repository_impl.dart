import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_core/src/data/datasources/chat/recipient_remote_data_source.dart';
import 'package:sigma_core/src/data/models/model_mapper.dart';
import 'package:sigma_core/src/domain/entities/recipient.dart';
import 'package:sigma_core/src/domain/repositories/i_recipient_repository.dart';

/// RecipientRepositoryImpl - Refatorado para a nova arquitetura CSFA.
class RecipientRepositoryImpl implements IRecipientRepository {
  final UserDao _userDao;
  final RecipientRemoteDataSource _remoteDataSource;

  RecipientRepositoryImpl(this._userDao, this._remoteDataSource);

  @override
  Stream<Recipient?> watchRecipient(String id) {
    return _userDao.watchUser(id).map((user) => user != null ? ModelMapper.recipientFromDrift(user) : null);
  }

  @override
  Future<void> saveRecipient(Recipient recipient) async {
    await _userDao.upsertUser(recipient.toCompanion());
  }

  @override
  Future<Recipient?> getRecipientByUuid(String uuid) async {
    final data = await _userDao.getUser(uuid);
    return data != null ? ModelMapper.recipientFromDrift(data) : null;
  }

  @override
  Future<List<Recipient>> getAllRecipients() async {
    return [];
  }

  @override
  Stream<List<Recipient>> watchAllRecipients() {
    return Stream.value([]);
  }

  @override
  Future<List<Recipient>> search(String term) async {
    final localResults = await _userDao.searchUsers(term);
    final List<Recipient> results = localResults
        .map((r) => ModelMapper.recipientFromDrift(r))
        .toList();

    try {
      final remoteDtos = await _remoteDataSource.searchUsers(term);
      for (final dto in remoteDtos) {
        final recipient = ModelMapper.recipientFromDto(dto);
        await saveRecipient(recipient);
        
        if (!results.any((r) => r.id == recipient.id)) {
          results.add(recipient);
        }
      }
    } catch (e) {
      // Falha na rede silenciada
    }

    return results;
  }

  @override
  Future<List<Recipient>> searchRemote(String term) async {
    final dtos = await _remoteDataSource.searchUsers(term);
    return dtos.map((dto) => ModelMapper.recipientFromDto(dto)).toList();
  }
}
