import 'package:sigma/core/storage/database.dart';
import 'package:sigma/features/chat/domain/repositories/recipient_repository.dart';

class RecipientRepositoryImpl implements IRecipientRepository {
  final AppDatabase _database;

  RecipientRepositoryImpl(this._database);

  @override
  Stream<User?> getRecipient(String id) {
    final query = _database.select(_database.users)..where((u) => u.id.equals(id));
    return query.watchSingleOrNull();
  }

  @override
  Stream<List<User>> getAllRecipients() => _database.select(_database.users).watch();

  @override
  Future<void> refreshRecipient(String id) async {
    // Sincronização desativada
  }
}
