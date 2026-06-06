import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sigma_core/sigma_core.dart';

// Tabelas especializadas (Padrão Signal-Android)
import 'package:sigma_database/src/recipient_database.dart';
import 'package:sigma_database/src/thread_table.dart';
import 'package:sigma_database/src/message_table.dart';
import 'package:sigma_database/src/job_database.dart';
import 'package:sigma_database/src/key_value_database.dart';
import 'package:sigma_database/src/attachment_table.dart';
import 'package:sigma_database/src/poll_table.dart';

part 'sigma_database.g.dart';

enum RecipientTypeDb { individual, group, channel, bot }
enum MessageStatusDb { pending, sent, delivered, read }
enum MessageTypeDb { text, image, video, audio, file, location, gif, poll }

@DriftDatabase(
  tables: [
    Recipients, 
    Threads, 
    Messages, 
    MessageSearch,
    Jobs,
    KeyValues,
    Attachments,
    Reactions,
    MessageReceipts,
    SignalSessions, 
    SignalPreKeys, 
    SignalSignedPreKeys, 
    SignalIdentities,
    Polls,
    PollOptions,
    PollVotes,
  ],
  daos: [
    RecipientDatabase,
    ThreadTable,
    MessageTable,
    JobDatabase,
    KeyValueDatabase,
    AttachmentTable,
    PollTable,
  ],
)
class SigmaDatabase extends _$SigmaDatabase {
  SigmaDatabase(KeyStore keyStore) : super(_openConnection(keyStore));

  @override
  int get schemaVersion => 4; // Incrementar para disparar a migração

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
        if (from < 2) {
          // Adiciona a coluna priority na tabela jobs
          await m.addColumn(jobs, jobs.priority);
        }
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

class ThreadRecord {
  final ThreadData thread;
  final RecipientData recipient;
  ThreadRecord(this.thread, this.recipient);
}
