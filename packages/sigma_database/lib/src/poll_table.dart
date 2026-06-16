import 'package:drift/drift.dart';
import 'package:sigma_database/src/sigma_database.dart';

part 'poll_table.g.dart';

class Polls extends Table {
  TextColumn get id => text()();
  TextColumn get messageId => text().nullable()();
  TextColumn get question => text().nullable()();
  BoolColumn get multipleChoice => boolean().withDefault(const Constant(false))();
  IntColumn get createdAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PollOptions extends Table {
  @override
  String get tableName => 'poll_options';

  TextColumn get id => text()();
  TextColumn get pollId => text().nullable()();
  TextColumn get textContent => text().nullable().named('text')();
  IntColumn get voteCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class PollVotes extends Table {
  @override
  String get tableName => 'poll_votes';

  TextColumn get id => text()();
  TextColumn get pollId => text().nullable()();
  TextColumn get optionId => text().nullable()();
  TextColumn get userId => text().nullable()();
  IntColumn get createdAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PollWithDetails {
  final Poll poll;
  final List<PollOption> options;
  PollWithDetails(this.poll, this.options);
}

@DriftAccessor(tables: [Polls, PollOptions, PollVotes])
class PollDao extends DatabaseAccessor<SigmaDatabase> with _$PollDaoMixin {
  PollDao(super.db);

  Future<void> createPoll(PollsCompanion poll, List<String> options) async {
    await transaction(() async {
      await into(polls).insert(poll);
      for (final opt in options) {
        await into(pollOptions).insert(PollOptionsCompanion.insert(
          id: 'opt_${DateTime.now().microsecondsSinceEpoch}',
          pollId: Value(poll.id.value),
          textContent: Value(opt),
        ));
      }
    });
  }

  Future<void> castVote(String pollId, String optionId, String userId) async {
    await transaction(() async {
      await into(pollVotes).insert(PollVotesCompanion.insert(
        id: 'vote_${DateTime.now().microsecondsSinceEpoch}',
        pollId: Value(pollId),
        optionId: Value(optionId),
        userId: Value(userId),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));
      // In a real app, we might want to update voteCount in pollOptions too
      // or just count them in the watch query.
    });
  }

  Stream<PollWithDetails?> watchPoll(String messageId) {
    final query = select(polls)..where((t) => t.messageId.equals(messageId));
    return query.watchSingleOrNull().asyncMap((poll) async {
      if (poll == null) return null;
      final opts = await (select(pollOptions)..where((t) => t.pollId.equals(poll.id))).get();
      return PollWithDetails(poll, opts);
    });
  }

  Future<List<PollVote>> getVotes(String pollId) {
    return (select(pollVotes)..where((t) => t.pollId.equals(pollId))).get();
  }
}
