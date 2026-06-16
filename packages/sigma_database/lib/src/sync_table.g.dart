// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_table.dart';

// ignore_for_file: type=lint
mixin _$KeyValueDaoMixin on DatabaseAccessor<SigmaDatabase> {
  $KeyValuesTable get keyValues => attachedDatabase.keyValues;
  $OutboxQueueTable get outboxQueue => attachedDatabase.outboxQueue;
  $JobsTable get jobs => attachedDatabase.jobs;
  KeyValueDaoManager get managers => KeyValueDaoManager(this);
}

class KeyValueDaoManager {
  final _$KeyValueDaoMixin _db;
  KeyValueDaoManager(this._db);
  $$KeyValuesTableTableManager get keyValues =>
      $$KeyValuesTableTableManager(_db.attachedDatabase, _db.keyValues);
  $$OutboxQueueTableTableManager get outboxQueue =>
      $$OutboxQueueTableTableManager(_db.attachedDatabase, _db.outboxQueue);
  $$JobsTableTableManager get jobs =>
      $$JobsTableTableManager(_db.attachedDatabase, _db.jobs);
}

mixin _$JobDaoMixin on DatabaseAccessor<SigmaDatabase> {
  $JobsTable get jobs => attachedDatabase.jobs;
  JobDaoManager get managers => JobDaoManager(this);
}

class JobDaoManager {
  final _$JobDaoMixin _db;
  JobDaoManager(this._db);
  $$JobsTableTableManager get jobs =>
      $$JobsTableTableManager(_db.attachedDatabase, _db.jobs);
}
