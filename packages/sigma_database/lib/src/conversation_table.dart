import 'package:drift/drift.dart';
import 'package:sigma_database/src/sigma_database.dart';
import 'package:sigma_database/src/user_table.dart';

part 'conversation_table.g.dart';

class Conversations extends Table {
  TextColumn get id => text()();
  TextColumn get type => text().nullable()(); // USER | GROUP | CHANNEL | BOT
  TextColumn get title => text().nullable()();
  TextColumn get avatar => text().nullable()();
  TextColumn get lastMessageId => text().nullable()();
  IntColumn get updatedAt => integer().nullable()();
  BoolColumn get isMuted => boolean().withDefault(const Constant(false))();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class ConversationMembers extends Table {
  @override
  String get tableName => 'conversation_members';

  TextColumn get id => text()();
  TextColumn get conversationId => text().nullable()();
  TextColumn get userId => text().nullable()();
  TextColumn get role => text().nullable()();
  IntColumn get joinedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class ConversationRecord {
  final Conversation conversation;
  final List<User> members;
  ConversationRecord(this.conversation, this.members);
}

@DriftAccessor(tables: [Conversations, ConversationMembers, Users])
class ConversationDao extends DatabaseAccessor<SigmaDatabase> with _$ConversationDaoMixin {
  ConversationDao(super.db);

  Stream<List<Conversation>> watchAllConversations() {
    return (select(conversations)
      ..where((t) => t.isArchived.equals(false))
      ..orderBy([
        (t) => OrderingTerm(expression: t.isPinned, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc),
      ]))
    .watch();
  }

  Stream<List<Conversation>> watchArchivedConversations() {
    return (select(conversations)
      ..where((t) => t.isArchived.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc)]))
    .watch();
  }

  Stream<Conversation?> watchConversation(String id) {
    return (select(conversations)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Future<Conversation?> getConversation(String id) {
    return (select(conversations)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<void> upsertConversation(ConversationsCompanion conversation) {
    return into(conversations).insertOnConflictUpdate(conversation);
  }

  Future<void> setArchived(String id, bool archived) {
    return (update(conversations)..where((t) => t.id.equals(id)))
        .write(ConversationsCompanion(isArchived: Value(archived)));
  }

  Future<void> setPinned(String id, bool pinned) {
    return (update(conversations)..where((t) => t.id.equals(id)))
        .write(ConversationsCompanion(isPinned: Value(pinned)));
  }

  Future<void> deleteConversation(String id) {
    return (delete(conversations)..where((t) => t.id.equals(id))).go();
  }
}
