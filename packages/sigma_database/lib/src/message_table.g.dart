// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_table.dart';

// ignore_for_file: type=lint
mixin _$MessageTableMixin on DatabaseAccessor<SigmaDatabase> {
  $RecipientsTable get recipients => attachedDatabase.recipients;
  $ThreadsTable get threads => attachedDatabase.threads;
  $MessagesTable get messages => attachedDatabase.messages;
  $MessageSearchTable get messageSearch => attachedDatabase.messageSearch;
  $ReactionsTable get reactions => attachedDatabase.reactions;
  $MessageReceiptsTable get messageReceipts => attachedDatabase.messageReceipts;
  MessageTableManager get managers => MessageTableManager(this);
}

class MessageTableManager {
  final _$MessageTableMixin _db;
  MessageTableManager(this._db);
  $$RecipientsTableTableManager get recipients =>
      $$RecipientsTableTableManager(_db.attachedDatabase, _db.recipients);
  $$ThreadsTableTableManager get threads =>
      $$ThreadsTableTableManager(_db.attachedDatabase, _db.threads);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db.attachedDatabase, _db.messages);
  $$MessageSearchTableTableManager get messageSearch =>
      $$MessageSearchTableTableManager(_db.attachedDatabase, _db.messageSearch);
  $$ReactionsTableTableManager get reactions =>
      $$ReactionsTableTableManager(_db.attachedDatabase, _db.reactions);
  $$MessageReceiptsTableTableManager get messageReceipts =>
      $$MessageReceiptsTableTableManager(
        _db.attachedDatabase,
        _db.messageReceipts,
      );
}
