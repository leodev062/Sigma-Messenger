import 'package:sigma/core/storage/database.dart';

abstract class RecipientLocalDataSource {
  Stream<User?> getRecipient(String id);
  Stream<List<User>> getAllRecipients();
  Future<void> saveUser(UsersCompanion user);
}

class RecipientLocalDataSourceImpl implements RecipientLocalDataSource {
  final AppDatabase _db;

  RecipientLocalDataSourceImpl(this._db);

  @override
  Stream<User?> getRecipient(String id) => _db.watchUser(id);

  @override
  Stream<List<User>> getAllRecipients() => _db.select(_db.users).watch();

  @override
  Future<void> saveUser(UsersCompanion user) async {
    await _db.upsertUser(user);
  }
}
