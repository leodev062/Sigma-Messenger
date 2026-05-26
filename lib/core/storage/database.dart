import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

enum ChatType { user, group, bot, channel }
enum MessageStatus { pending, sent, delivered, read }
enum MessageType { text, image, video, audio, file }

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get username => text().nullable()();
  TextColumn get phone => text()();
  TextColumn get avatarUrl => text().nullable()();
  BoolColumn get isMe => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class Chats extends Table {
  TextColumn get id => text()();
  TextColumn get contactId => text().nullable().references(Users, #id)();
  TextColumn get title => text().nullable()();
  IntColumn get type => intEnum<ChatType>().withDefault(Constant(ChatType.user.index))();
  TextColumn get lastMessage => text().nullable()();
  IntColumn get lastMessageTimestamp => integer().nullable()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class Messages extends Table {
  TextColumn get id => text()();
  TextColumn get chatId => text().references(Chats, #id)();
  TextColumn get senderId => text().references(Users, #id)();
  TextColumn get textContent => text()();
  IntColumn get type => intEnum<MessageType>().withDefault(Constant(MessageType.text.index))();
  TextColumn get attachmentUrl => text().nullable()();
  IntColumn get timestamp => integer()();
  IntColumn get status => intEnum<MessageStatus>().withDefault(Constant(MessageStatus.pending.index))();
  BoolColumn get isFromMe => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Users, Chats, Messages])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3; // Incremented schema version (Jobs table removed)

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'sigma_database');
  }
  
  // User Operations
  Future<int> upsertUser(UsersCompanion user) => into(users).insertOnConflictUpdate(user);
  Stream<User> watchUser(String id) => (select(users)..where((t) => t.id.equals(id))).watchSingle();

  // Chat Operations
  Future<int> upsertChat(ChatsCompanion chat) => into(chats).insertOnConflictUpdate(chat);
  Stream<List<Chat>> watchAllChats() => (select(chats)..orderBy([(t) => OrderingTerm(expression: t.lastMessageTimestamp, mode: OrderingMode.desc)])).watch();

  Future<Chat?> findPrivateChatByContactId(String contactId) {
    return (select(chats)
          ..where((t) => t.contactId.equals(contactId))
          ..where((t) => t.type.equals(ChatType.user.index))
          ..limit(1))
        .getSingleOrNull();
  }

  // Message Operations
  Future<int> insertMessage(MessagesCompanion message) => into(messages).insert(message);
  Stream<List<Message>> watchMessagesForChat(String chatId) => (select(messages)..where((t) => t.chatId.equals(chatId))..orderBy([(t) => OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc)])).watch();
}
