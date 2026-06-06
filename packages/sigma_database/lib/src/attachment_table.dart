import 'package:drift/drift.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_database/src/message_table.dart';

part 'attachment_table.g.dart';

/// AttachmentTable - Gerencia metadados de arquivos e mídias.
/// Baseado no AttachmentDatabase.java do Signal.
@DataClassName('AttachmentData')
class Attachments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get messageId => text().references(Messages, #id)();
  TextColumn get contentType => text()();
  TextColumn get fileName => text().nullable()();
  IntColumn get size => integer()();
  TextColumn get localPath => text().nullable()(); // Caminho no disco encriptado
  TextColumn get thumbnailPath => text().nullable()(); // Miniatura otimizada para a lista de chat
  TextColumn get remoteId => text().nullable()(); // ID no S3/Servidor
  
  // Chaves de criptografia do anexo (AES-GCM)
  TextColumn get aesKey => text().nullable()();
  TextColumn get iv => text().nullable()();
  TextColumn get digest => text().nullable()();

  IntColumn get transferState => integer().withDefault(const Constant(0))(); // 0: Pending, 1: Progress, 2: Done, 3: Failed

  List<Index> get indexes => [
    Index('attachments_message_id', 'CREATE INDEX attachments_message_id ON attachments (message_id);'),
  ];
}

@DriftAccessor(tables: [Attachments])
class AttachmentTable extends DatabaseAccessor<SigmaDatabase> with _$AttachmentTableMixin {
  AttachmentTable(SigmaDatabase db) : super(db);

  Future<int> insertAttachment(AttachmentsCompanion attachment) => into(attachments).insert(attachment);
  
  Future<List<AttachmentData>> getAttachmentsForMessage(String messageId) {
    return (select(attachments)..where((t) => t.messageId.equals(messageId))).get();
  }

  Future<void> updateLocalPath(int id, String path) {
    return (update(attachments)..where((t) => t.id.equals(id)))
        .write(AttachmentsCompanion(localPath: Value(path), transferState: const Value(2)));
  }
}
