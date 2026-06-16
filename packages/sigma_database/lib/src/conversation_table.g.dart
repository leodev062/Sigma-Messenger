// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_table.dart';

// ignore_for_file: type=lint
mixin _$ConversationDaoMixin on DatabaseAccessor<SigmaDatabase> {
  $ConversationsTable get conversations => attachedDatabase.conversations;
  $ConversationMembersTable get conversationMembers =>
      attachedDatabase.conversationMembers;
  $UsersTable get users => attachedDatabase.users;
  ConversationDaoManager get managers => ConversationDaoManager(this);
}

class ConversationDaoManager {
  final _$ConversationDaoMixin _db;
  ConversationDaoManager(this._db);
  $$ConversationsTableTableManager get conversations =>
      $$ConversationsTableTableManager(_db.attachedDatabase, _db.conversations);
  $$ConversationMembersTableTableManager get conversationMembers =>
      $$ConversationMembersTableTableManager(
        _db.attachedDatabase,
        _db.conversationMembers,
      );
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
}
