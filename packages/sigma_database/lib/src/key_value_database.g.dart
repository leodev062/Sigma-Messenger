// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_value_database.dart';

// ignore_for_file: type=lint
mixin _$KeyValueDatabaseMixin on DatabaseAccessor<SigmaDatabase> {
  $KeyValuesTable get keyValues => attachedDatabase.keyValues;
  KeyValueDatabaseManager get managers => KeyValueDatabaseManager(this);
}

class KeyValueDatabaseManager {
  final _$KeyValueDatabaseMixin _db;
  KeyValueDatabaseManager(this._db);
  $$KeyValuesTableTableManager get keyValues =>
      $$KeyValuesTableTableManager(_db.attachedDatabase, _db.keyValues);
}
