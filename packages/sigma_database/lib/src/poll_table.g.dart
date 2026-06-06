// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_table.dart';

// ignore_for_file: type=lint
mixin _$PollTableMixin on DatabaseAccessor<SigmaDatabase> {
  $RecipientsTable get recipients => attachedDatabase.recipients;
  $ThreadsTable get threads => attachedDatabase.threads;
  $MessagesTable get messages => attachedDatabase.messages;
  $PollsTable get polls => attachedDatabase.polls;
  $PollOptionsTable get pollOptions => attachedDatabase.pollOptions;
  $PollVotesTable get pollVotes => attachedDatabase.pollVotes;
  PollTableManager get managers => PollTableManager(this);
}

class PollTableManager {
  final _$PollTableMixin _db;
  PollTableManager(this._db);
  $$RecipientsTableTableManager get recipients =>
      $$RecipientsTableTableManager(_db.attachedDatabase, _db.recipients);
  $$ThreadsTableTableManager get threads =>
      $$ThreadsTableTableManager(_db.attachedDatabase, _db.threads);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db.attachedDatabase, _db.messages);
  $$PollsTableTableManager get polls =>
      $$PollsTableTableManager(_db.attachedDatabase, _db.polls);
  $$PollOptionsTableTableManager get pollOptions =>
      $$PollOptionsTableTableManager(_db.attachedDatabase, _db.pollOptions);
  $$PollVotesTableTableManager get pollVotes =>
      $$PollVotesTableTableManager(_db.attachedDatabase, _db.pollVotes);
}
