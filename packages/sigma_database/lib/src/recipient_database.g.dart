// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipient_database.dart';

// ignore_for_file: type=lint
mixin _$RecipientDatabaseMixin on DatabaseAccessor<SigmaDatabase> {
  $RecipientsTable get recipients => attachedDatabase.recipients;
  RecipientDatabaseManager get managers => RecipientDatabaseManager(this);
}

class RecipientDatabaseManager {
  final _$RecipientDatabaseMixin _db;
  RecipientDatabaseManager(this._db);
  $$RecipientsTableTableManager get recipients =>
      $$RecipientsTableTableManager(_db.attachedDatabase, _db.recipients);
}
