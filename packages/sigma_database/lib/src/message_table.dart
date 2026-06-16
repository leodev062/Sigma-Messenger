import 'package:drift/drift.dart';
import 'package:sigma_database/src/sigma_database.dart';
import 'package:sigma_database/src/conversation_table.dart';

part 'message_table.g.dart';

class Messages extends Table {
  TextColumn get id => text()();
  TextColumn get conversationId => text().nullable()();
  TextColumn get senderId => text().nullable()();
  TextColumn get type => text().nullable()(); 
  // TEXT | IMAGE | VIDEO | AUDIO | POLL | REPLY | REACTION | LOCATION
  TextColumn get content => text().nullable()();
  TextColumn get status => text().nullable()();
  // PENDING | SENT | DELIVERED | READ | FAILED
  TextColumn get replyToMessageId => text().nullable()();
  IntColumn get createdAt => integer().nullable()();
  IntColumn get updatedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Reactions extends Table {
  TextColumn get id => text()();
  TextColumn get messageId => text().nullable()();
  TextColumn get userId => text().nullable()();
  TextColumn get emoji => text().nullable()();
  IntColumn get createdAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class MessageLocations extends Table {
  TextColumn get messageId => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  RealColumn get accuracy => real().nullable()();
  BoolColumn get isLive => boolean().withDefault(const Constant(false))();
  IntColumn get updatedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {messageId};
}

class DeliveryLogs extends Table {
  @override
  String get tableName => 'delivery_log';

  TextColumn get id => text()();
  TextColumn get messageId => text().nullable()();
  TextColumn get userId => text().nullable()();
  TextColumn get status => text().nullable()();
  IntColumn get timestamp => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftAccessor(tables: [Messages, Reactions, MessageLocations, DeliveryLogs, Conversations])
class MessageDao extends DatabaseAccessor<SigmaDatabase> with _$MessageDaoMixin {
  MessageDao(super.db);

  Future<void> saveMessage(MessagesCompanion message) {
    return into(messages).insertOnConflictUpdate(message);
  }

  Future<void> saveLocation(MessageLocationsCompanion location) {
    return into(messageLocations).insertOnConflictUpdate(location);
  }

  Future<MessageLocation?> getLocation(String messageId) {
    return (select(messageLocations)..where((t) => t.messageId.equals(messageId))).getSingleOrNull();
  }

  Future<Message?> getMessage(String id) {
    return (select(messages)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<void> updateMessageStatus(String messageId, String status) {
    return (update(messages)..where((t) => t.id.equals(messageId)))
        .write(MessagesCompanion(status: Value(status), updatedAt: Value(DateTime.now().millisecondsSinceEpoch)));
  }

  Stream<List<Message>> watchMessages(String conversationId, {int limit = 50}) {
    return (select(messages)
      ..where((t) => t.conversationId.equals(conversationId))
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)])
      ..limit(limit))
    .watch();
  }

  Future<void> deleteMessage(String messageId) {
    return (delete(messages)..where((t) => t.id.equals(messageId))).go();
  }

  Future<void> upsertReaction(ReactionsCompanion reaction) {
    return into(reactions).insertOnConflictUpdate(reaction);
  }

  Future<void> deleteReaction(String messageId, String userId) {
    return (delete(reactions)
      ..where((t) => t.messageId.equals(messageId))
      ..where((t) => t.userId.equals(userId)))
    .go();
  }

  Stream<List<Reaction>> watchReactionsForMessage(String messageId) {
    return (select(reactions)..where((t) => t.messageId.equals(messageId))).watch();
  }

  Future<void> saveMessageAndUpdateConversation({
    required String conversationId,
    required MessagesCompanion message,
    required String snippet,
    bool incrementUnread = false,
  }) async {
    await transaction(() async {
      await saveMessage(message);
      
      await (update(conversations)..where((t) => t.id.equals(conversationId))).write(
        ConversationsCompanion(
          lastMessageId: Value(message.id.value),
          updatedAt: Value(message.createdAt.value ?? DateTime.now().millisecondsSinceEpoch),
        ),
      );
    });
  }
}
