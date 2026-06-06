// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_table.dart';

// ignore_for_file: type=lint
mixin _$AttachmentTableMixin on DatabaseAccessor<SigmaDatabase> {
  $RecipientsTable get recipients => attachedDatabase.recipients;
  $ThreadsTable get threads => attachedDatabase.threads;
  $MessagesTable get messages => attachedDatabase.messages;
  $AttachmentsTable get attachments => attachedDatabase.attachments;
  AttachmentTableManager get managers => AttachmentTableManager(this);
}

class AttachmentTableManager {
  final _$AttachmentTableMixin _db;
  AttachmentTableManager(this._db);
  $$RecipientsTableTableManager get recipients =>
      $$RecipientsTableTableManager(_db.attachedDatabase, _db.recipients);
  $$ThreadsTableTableManager get threads =>
      $$ThreadsTableTableManager(_db.attachedDatabase, _db.threads);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db.attachedDatabase, _db.messages);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db.attachedDatabase, _db.attachments);
}
