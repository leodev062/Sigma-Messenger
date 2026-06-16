import 'package:drift/drift.dart';
import 'package:sigma_database/src/sigma_database.dart';

part 'sync_table.g.dart';

class OutboxQueue extends Table {
  @override
  String get tableName => 'outbox_queue';

  TextColumn get id => text()();
  TextColumn get messageId => text().nullable()();
  TextColumn get payload => text().nullable()();
  TextColumn get status => text().nullable()();
  IntColumn get createdAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class KeyValues extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}

class Envelopes extends Table {
  TextColumn get envelopeId => text()();
  TextColumn get messageId => text().nullable()();
  TextColumn get fromUserId => text().nullable()();
  TextColumn get destinationType => text().nullable()();
  TextColumn get destinationId => text().nullable()();
  BlobColumn get payload => blob().nullable()();
  TextColumn get status => text().nullable()();
  IntColumn get createdAt => integer().nullable()();
  IntColumn get deliverAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {envelopeId};
}

@DataClassName('JobRecord')
class Jobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get factoryKey => text()();
  TextColumn get queueKey => text().nullable()();
  TextColumn get data => text()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  IntColumn get runAttempt => integer().withDefault(const Constant(0))();
  IntColumn get createTime => integer()();
  IntColumn get nextRunAttemptTime => integer()();
  BoolColumn get isRunning => boolean().withDefault(const Constant(false))();
}

@DriftAccessor(tables: [KeyValues, OutboxQueue, Jobs])
class KeyValueDao extends DatabaseAccessor<SigmaDatabase> with _$KeyValueDaoMixin {
  KeyValueDao(super.db);

  Future<void> writeValue(String key, String value) {
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

/*
@DriftAccessor(tables: [Envelopes])
class EnvelopeDao extends DatabaseAccessor<SigmaDatabase> with _$EnvelopeDaoMixin {
  EnvelopeDao(super.db);

  Future<void> saveEnvelope(EnvelopesCompanion envelope) {
    return into(envelopes).insertOnConflictUpdate(envelope);
  }

  Future<List<Envelope>> getPendingEnvelopes() {
    return (select(envelopes)..where((t) => t.status.equals('PENDING'))).get();
  }

  Future<void> deleteEnvelope(String id) {
    return (delete(envelopes)..where((t) => t.envelopeId.equals(id))).go();
  }
}
*/

@DriftAccessor(tables: [Jobs])
class JobDao extends DatabaseAccessor<SigmaDatabase> with _$JobDaoMixin {
  JobDao(super.db);

  Future<int> insertJob(JobsCompanion job) => into(jobs).insert(job);

  Future<bool> hasPendingJob(String queueKey) async {
    final result = await (select(jobs)..where((t) => t.queueKey.equals(queueKey))).get();
    return result.isNotEmpty;
  }

  Future<void> deleteJob(int id) => (delete(jobs)..where((t) => t.id.equals(id))).go();

  Future<List<JobRecord>> getPendingJobs() {
    return (select(jobs)
          ..where((t) => t.isRunning.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.priority, mode: OrderingMode.desc)]))
        .get();
  }

  Future<void> markJobRunning(int id, bool running) {
    return (update(jobs)..where((t) => t.id.equals(id))).write(JobsCompanion(isRunning: Value(running)));
  }

  Future<void> updateRetry(int id, int nextAttempt, int attemptCount) {
    return (update(jobs)..where((t) => t.id.equals(id))).write(JobsCompanion(
      nextRunAttemptTime: Value(nextAttempt),
      runAttempt: Value(attemptCount),
      isRunning: const Value(false),
    ));
  }

  Future<void> resetAllJobsStatus() {
    return (update(jobs)).write(const JobsCompanion(isRunning: Value(false)));
  }
}
