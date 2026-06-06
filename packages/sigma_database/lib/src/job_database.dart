import 'package:drift/drift.dart';
import 'package:sigma_database/sigma_database.dart';

part 'job_database.g.dart';

/// JobTable - Persiste tarefas em background para garantir resiliência.
/// Baseado no JobDatabase.java do Signal.
@DataClassName('JobData')
class Jobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get factoryKey => text()(); // Identificador do tipo de Job (ex: PushTextSendJob)
  TextColumn get queueKey => text().nullable()(); // Identificador da fila (ex: recipient_id)
  TextColumn get data => text()(); // JSON serializado dos parâmetros do Job
  IntColumn get priority => integer().withDefault(const Constant(1))(); // JobPriority
  IntColumn get createTime => integer()();
  IntColumn get nextRunAttemptTime => integer()();
  IntColumn get runAttempt => integer().withDefault(const Constant(0))();
  BoolColumn get isRunning => boolean().withDefault(const Constant(false))();

  @override
  List<String> get customConstraints => [
    'UNIQUE (factory_key, queue_key)'
  ];
}

@DriftAccessor(tables: [Jobs])
class JobDatabase extends DatabaseAccessor<SigmaDatabase> with _$JobDatabaseMixin {
  JobDatabase(SigmaDatabase db) : super(db);

  Future<int> insertJob(JobsCompanion job) => into(jobs).insert(job, mode: InsertMode.insertOrReplace);

  Future<void> deleteJob(int id) => (delete(jobs)..where((t) => t.id.equals(id))).go();

  Future<void> resetAllJobsStatus() {
    return (update(jobs)).write(const JobsCompanion(isRunning: Value(false)));
  }

  Future<List<JobData>> getPendingJobs() {
    return (select(jobs)
          ..where((t) => t.isRunning.not())
          ..orderBy([
            (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.createTime)
          ]))
        .get();
  }

  Future<void> markJobRunning(int id, bool running) {
    return (update(jobs)..where((t) => t.id.equals(id)))
        .write(JobsCompanion(isRunning: Value(running)));
  }

  Future<void> updateRetry(int id, int nextAttempt, int attemptCount) {
    return (update(jobs)..where((t) => t.id.equals(id)))
        .write(JobsCompanion(
          nextRunAttemptTime: Value(nextAttempt),
          runAttempt: Value(attemptCount),
          isRunning: const Value(false),
        ));
  }
}
