import 'package:drift/drift.dart';
import 'package:sigma_database/sigma_database.dart';

part 'key_value_database.g.dart';

/// KeyValueTable - Persiste configurações e estados de flag.
/// Baseado no KeyValueDatabase.java do Signal.
class KeyValues extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftAccessor(tables: [KeyValues])
class KeyValueDatabase extends DatabaseAccessor<SigmaDatabase> with _$KeyValueDatabaseMixin {
  KeyValueDatabase(SigmaDatabase db) : super(db);

  Future<void> writeValue(String key, String? value) {
    return into(keyValues).insertOnConflictUpdate(KeyValuesCompanion(
      key: Value(key),
      value: Value(value),
    ));
  }

  Future<String?> readValue(String key) async {
    final row = await (select(keyValues)..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }
}
