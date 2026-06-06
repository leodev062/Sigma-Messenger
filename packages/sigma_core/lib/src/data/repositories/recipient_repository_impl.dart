import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_core/src/data/datasources/chat/recipient_remote_data_source.dart';
import 'package:sigma_core/src/data/models/model_mapper.dart';
import 'package:sigma_core/src/domain/entities/recipient.dart';
import 'package:sigma_core/src/domain/repositories/i_recipient_repository.dart';

/// RecipientRepositoryImpl - Refatorado para POO usando Extensions.
/// Removemos o mapeamento manual e usamos as extensões toCompanion() e toDrift().
class RecipientRepositoryImpl implements IRecipientRepository {
  final RecipientDatabase _recipientDatabase;
  final RecipientRemoteDataSource _remoteDataSource;

  RecipientRepositoryImpl(this._recipientDatabase, this._remoteDataSource);

  @override
  Stream<Recipient?> watchRecipient(String id) {
    return _recipientDatabase.watchRecipient(id).map(
      (record) => record != null ? ModelMapper.recipientFromDrift(record.data) : null,
    );
  }

  @override
  Future<void> saveRecipient(Recipient recipient) async {
    // Usando a Extension toCompanion() definida no ModelMapper
    await _recipientDatabase.upsertRecipient(recipient.toCompanion());
  }

  @override
  Future<Recipient?> getRecipientByUuid(String uuid) async {
    final record = await _recipientDatabase.getRecipient(uuid);
    return record != null ? ModelMapper.recipientFromDrift(record.data) : null;
  }

  @override
  Future<List<Recipient>> getAllRecipients() async {
    final list = await _recipientDatabase.getAllRecipients();
    return list.map((r) => ModelMapper.recipientFromDrift(r)).toList();
  }

  @override
  Stream<List<Recipient>> watchAllRecipients() {
    return _recipientDatabase.watchAllRecipients().map(
      (list) => list.map((r) => ModelMapper.recipientFromDrift(r)).toList(),
    );
  }

  @override
  Future<List<Recipient>> search(String term) async {
    // 1. Busca Local Instantânea (SSOT)
    final localResults = await _recipientDatabase.searchRecipients(term);
    final List<Recipient> results = localResults
        .map((r) => ModelMapper.recipientFromDrift(r))
        .toList();

    // 2. Busca Remota em Background (Silent Refresh)
    // Não damos await aqui para retornar os resultados locais imediatamente se necessário,
    // mas para busca, geralmente queremos esperar os remotos para popular a lista.
    // Seguindo a recomendação de SSOT: O repositório decide.
    try {
      final remoteDtos = await _remoteDataSource.searchUsers(term);
      for (final dto in remoteDtos) {
        final recipient = ModelMapper.recipientFromDto(dto);
        await saveRecipient(recipient);
        
        // Evita duplicatas na lista de retorno imediata
        if (!results.any((r) => r.id == recipient.id)) {
          results.add(recipient);
        }
      }
    } catch (e) {
      // Falha na rede silenciada - já temos resultados locais
    }

    return results;
  }

  @override
  Future<List<Recipient>> searchRemote(String term) async {
    final dtos = await _remoteDataSource.searchUsers(term);
    return dtos.map((dto) => ModelMapper.recipientFromDto(dto)).toList();
  }
}
