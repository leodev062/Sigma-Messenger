// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_table.dart';

// ignore_for_file: type=lint
mixin _$PollDaoMixin on DatabaseAccessor<SigmaDatabase> {
  $PollsTable get polls => attachedDatabase.polls;
  $PollOptionsTable get pollOptions => attachedDatabase.pollOptions;
  $PollVotesTable get pollVotes => attachedDatabase.pollVotes;
  PollDaoManager get managers => PollDaoManager(this);
}

class PollDaoManager {
  final _$PollDaoMixin _db;
  PollDaoManager(this._db);
  $$PollsTableTableManager get polls =>
      $$PollsTableTableManager(_db.attachedDatabase, _db.polls);
  $$PollOptionsTableTableManager get pollOptions =>
      $$PollOptionsTableTableManager(_db.attachedDatabase, _db.pollOptions);
  $$PollVotesTableTableManager get pollVotes =>
      $$PollVotesTableTableManager(_db.attachedDatabase, _db.pollVotes);
}
