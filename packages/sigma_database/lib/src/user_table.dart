import 'package:drift/drift.dart';
import 'package:sigma_database/src/sigma_database.dart';

part 'user_table.g.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get phone => text().nullable().unique()();
  TextColumn get name => text().nullable()();
  TextColumn get username => text().nullable().unique()();
  TextColumn get email => text().nullable().unique()();
  TextColumn get bio => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  BoolColumn get isBot => boolean().withDefault(const Constant(false))();
  IntColumn get createdAt => integer().nullable()();
  IntColumn get updatedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get passwordHash => text().nullable()();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
  IntColumn get createdAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Devices extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get deviceName => text().nullable()();
  TextColumn get deviceType => text().nullable()();
  TextColumn get os => text().nullable()();
  TextColumn get pushToken => text().nullable()();
  IntColumn get lastSeen => integer().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get createdAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftAccessor(tables: [Users, Accounts, Devices])
class UserDao extends DatabaseAccessor<SigmaDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<User?> getUser(String id) {
    return (select(users)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Stream<User?> watchUser(String id) {
    return (select(users)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Future<void> upsertUser(UsersCompanion user) {
    return into(users).insertOnConflictUpdate(user);
  }

  Future<List<User>> searchUsers(String term) {
    final query = '%$term%';
    return (select(users)
      ..where((t) => t.username.like(query) | t.name.like(query)))
    .get();
  }
}
