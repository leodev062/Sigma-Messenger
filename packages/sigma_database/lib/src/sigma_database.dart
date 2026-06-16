import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sigma_core/sigma_core.dart';

import 'user_table.dart';
import 'conversation_table.dart';
import 'message_table.dart';
import 'poll_table.dart';
import 'sync_table.dart';

part 'sigma_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Accounts,
    Devices,
    Conversations,
    ConversationMembers,
    Messages,
    Reactions,
    MessageLocations,
    DeliveryLogs,
    Polls,
    PollOptions,
    PollVotes,
    OutboxQueue,
    Envelopes,
    KeyValues,
    Jobs,
  ],
  daos: [
    UserDao,
    ConversationDao,
    MessageDao,
    PollDao,
    KeyValueDao,
    JobDao,
  ],
)
class SigmaDatabase extends _$SigmaDatabase {
  SigmaDatabase(KeyStore keyStore) : super(_openConnection(keyStore));

  @override
  int get schemaVersion => 1; // Reset para nova arquitetura

  static QueryExecutor _openConnection(KeyStore keyStore) {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'sigma.db'));
      final password = await keyStore.getDatabasePassword();

      return NativeDatabase.createInBackground(
        file,
        setup: (database) {
          database.execute("PRAGMA key = '$password'");
        },
      );
    });
  }
  
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async => await m.createAll(),
      onUpgrade: (m, from, to) async {
        // Nova arquitetura começa do zero
      },
    );
  }

  /// Limpa todas as tabelas do banco de dados (Logout Completo)
  Future<void> clearAllData() async {
    await transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}
