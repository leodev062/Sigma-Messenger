// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_table.dart';

// ignore_for_file: type=lint
mixin _$ThreadTableMixin on DatabaseAccessor<SigmaDatabase> {
  $RecipientsTable get recipients => attachedDatabase.recipients;
  $ThreadsTable get threads => attachedDatabase.threads;
  ThreadTableManager get managers => ThreadTableManager(this);
}

class ThreadTableManager {
  final _$ThreadTableMixin _db;
  ThreadTableManager(this._db);
  $$RecipientsTableTableManager get recipients =>
      $$RecipientsTableTableManager(_db.attachedDatabase, _db.recipients);
  $$ThreadsTableTableManager get threads =>
      $$ThreadsTableTableManager(_db.attachedDatabase, _db.threads);
}
