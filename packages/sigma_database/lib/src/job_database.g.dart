// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_database.dart';

// ignore_for_file: type=lint
mixin _$JobDatabaseMixin on DatabaseAccessor<SigmaDatabase> {
  $JobsTable get jobs => attachedDatabase.jobs;
  JobDatabaseManager get managers => JobDatabaseManager(this);
}

class JobDatabaseManager {
  final _$JobDatabaseMixin _db;
  JobDatabaseManager(this._db);
  $$JobsTableTableManager get jobs =>
      $$JobsTableTableManager(_db.attachedDatabase, _db.jobs);
}
