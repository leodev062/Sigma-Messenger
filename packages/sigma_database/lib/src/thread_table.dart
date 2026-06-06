import 'package:drift/drift.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_database/src/recipient_database.dart';

part 'thread_table.g.dart';

@DataClassName('ThreadData')
class Threads extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recipientId => text().references(Recipients, #id)();
  IntColumn get date => integer()();
  TextColumn get snippet => text().nullable()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  
  // Signal features
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  IntColumn get pinnedOrder => integer().withDefault(const Constant(0))(); // 0: not pinned, >0: sort order
  IntColumn get muteUntil => integer().withDefault(const Constant(0))(); // Timestamp
  BoolColumn get isMarkedUnread => boolean().withDefault(const Constant(false))();
}

@DriftAccessor(tables: [Threads, Recipients])
class ThreadTable extends DatabaseAccessor<SigmaDatabase> with _$ThreadTableMixin {
  ThreadTable(SigmaDatabase db) : super(db);

  Stream<List<ThreadRecord>> watchAllThreads() {
    final query = select(threads).join([
      innerJoin(recipients, recipients.id.equalsExp(threads.recipientId)),
    ]);
    
    // Filtrar apenas conversas NÃO arquivadas por padrão (Inbox)
    query.where(threads.isArchived.equals(false));

    // Ordenação Signal: Pinned primeiro, depois por data
    query.orderBy([
      OrderingTerm(expression: threads.pinnedOrder, mode: OrderingMode.desc),
      OrderingTerm(expression: threads.date, mode: OrderingMode.desc)
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return ThreadRecord(
          row.readTable(threads),
          row.readTable(recipients),
        );
      }).toList();
    });
  }

  Stream<List<ThreadRecord>> watchArchivedThreads() {
    final query = select(threads).join([
      innerJoin(recipients, recipients.id.equalsExp(threads.recipientId)),
    ]);
    
    query.where(threads.isArchived.equals(true));

    query.orderBy([
      OrderingTerm(expression: threads.date, mode: OrderingMode.desc)
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return ThreadRecord(
          row.readTable(threads),
          row.readTable(recipients),
        );
      }).toList();
    });
  }

  Stream<ThreadRecord?> watchThread(int threadId) {
    final query = select(threads).join([
      innerJoin(recipients, recipients.id.equalsExp(threads.recipientId)),
    ])..where(threads.id.equals(threadId));

    return query.watchSingleOrNull().map((row) {
      if (row == null) return null;
      return ThreadRecord(
        row.readTable(threads),
        row.readTable(recipients),
      );
    });
  }

  Future<ThreadData?> getThreadByRecipientId(String recipientId) {
    return (select(threads)..where((t) => t.recipientId.equals(recipientId))).getSingleOrNull();
  }

  Future<void> updateThreadMetadata(ThreadsCompanion companion) {
    if (companion.id.present) {
      return (update(threads)..where((t) => t.id.equals(companion.id.value))).write(companion);
    }
    return into(threads).insertOnConflictUpdate(companion);
  }

  Future<int> insertThread(ThreadsCompanion companion) {
    return into(threads).insert(companion);
  }
  
  Future<void> setArchived(int threadId, bool archived) {
    return (update(threads)..where((t) => t.id.equals(threadId)))
        .write(ThreadsCompanion(isArchived: Value(archived)));
  }

  Future<void> setPinned(int threadId, int order) {
    return (update(threads)..where((t) => t.id.equals(threadId)))
        .write(ThreadsCompanion(pinnedOrder: Value(order)));
  }

  Future<void> deleteThread(int threadId) async {
    await transaction(() async {
      await db.messageTable.deleteMessagesByThreadId(threadId);
      await (delete(threads)..where((t) => t.id.equals(threadId))).go();
    });
  }
}
