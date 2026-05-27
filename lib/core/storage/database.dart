import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sigma/core/storage/sigma_store.dart';

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
  
  // E2EE Attachment Columns
  TextColumn get attachmentUrl => text().nullable()();
  TextColumn get attachmentAesKey => text().nullable()();
  TextColumn get attachmentIv => text().nullable()();
  TextColumn get attachmentMacKey => text().nullable()();
  
  IntColumn get timestamp => integer()();
  IntColumn get status => intEnum<MessageStatus>().withDefault(Constant(MessageStatus.pending.index))();
  BoolColumn get isFromMe => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

// --- Tabelas de Persistência do Protocolo Signal ---

class SignalSessions extends Table {
  TextColumn get addressName => text()();
  IntColumn get deviceId => integer()();
  BlobColumn get sessionRecord => blob()();

  @override
  Set<Column> get primaryKey => {addressName, deviceId};
}

class SignalPreKeys extends Table {
  IntColumn get preKeyId => integer()();
  BlobColumn get preKeyRecord => blob()();

  @override
  Set<Column> get primaryKey => {preKeyId};
}

class SignalSignedPreKeys extends Table {
  IntColumn get signedPreKeyId => integer()();
  BlobColumn get signedPreKeyRecord => blob()();

  @override
  Set<Column> get primaryKey => {signedPreKeyId};
}

class SignalIdentities extends Table {
  TextColumn get addressName => text()();
  IntColumn get registrationId => integer()();
  BlobColumn get identityKey => blob().nullable()(); // IdentityKey pública do remoto

  @override
  Set<Column> get primaryKey => {addressName};
}

@DriftDatabase(tables: [
  Users, 
  Chats, 
  Messages, 
  SignalSessions, 
  SignalPreKeys, 
  SignalSignedPreKeys, 
  SignalIdentities
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 6; // Incrementado para incluir attachmentIv

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'sigma_database.db'));
      
      // Recupera a senha mestre do SecureStorage
      final password = await SigmaStore.instance.keys.getDatabasePassword();

      return NativeDatabase.createInBackground(
        file,
        setup: (database) {
          // Ativa encriptação via SQLCipher
          database.execute("PRAGMA key = '$password'");
        },
      );
    });
  }
  
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        if (from < 6) {
          // Adiciona a coluna attachment_iv se ela não existir
          await m.addColumn(messages, messages.attachmentIv);
        }
      },
    );
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
