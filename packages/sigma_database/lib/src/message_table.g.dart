// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_table.dart';

// ignore_for_file: type=lint
mixin _$MessageDaoMixin on DatabaseAccessor<SigmaDatabase> {
  $MessagesTable get messages => attachedDatabase.messages;
  $ReactionsTable get reactions => attachedDatabase.reactions;
  $MessageLocationsTable get messageLocations =>
      attachedDatabase.messageLocations;
  $DeliveryLogsTable get deliveryLogs => attachedDatabase.deliveryLogs;
  $ConversationsTable get conversations => attachedDatabase.conversations;
  MessageDaoManager get managers => MessageDaoManager(this);
}

class MessageDaoManager {
  final _$MessageDaoMixin _db;
  MessageDaoManager(this._db);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db.attachedDatabase, _db.messages);
  $$ReactionsTableTableManager get reactions =>
      $$ReactionsTableTableManager(_db.attachedDatabase, _db.reactions);
  $$MessageLocationsTableTableManager get messageLocations =>
      $$MessageLocationsTableTableManager(
        _db.attachedDatabase,
        _db.messageLocations,
      );
  $$DeliveryLogsTableTableManager get deliveryLogs =>
      $$DeliveryLogsTableTableManager(_db.attachedDatabase, _db.deliveryLogs);
  $$ConversationsTableTableManager get conversations =>
      $$ConversationsTableTableManager(_db.attachedDatabase, _db.conversations);
}
