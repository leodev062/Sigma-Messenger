import 'package:drift/drift.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_database/src/recipient_database.dart';

part 'poll_table.g.dart';

@DataClassName('PollDb')
class Polls extends Table {
  TextColumn get id => text()(); 
  TextColumn get question => text()();
  BoolColumn get allowMultipleVotes => boolean().withDefault(const Constant(false))();
  BoolColumn get hasEnded => boolean().withDefault(const Constant(false))();
  TextColumn get authorId => text().customConstraint('NOT NULL REFERENCES recipients(id)')();
  TextColumn get messageId => text().customConstraint('NOT NULL REFERENCES messages(id)')();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PollOptionDb')
class PollOptions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get pollId => text().customConstraint('NOT NULL REFERENCES polls(id)')();
  TextColumn get optionText => text()();
}

@DataClassName('PollVoteDb')
class PollVotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get pollId => text().customConstraint('NOT NULL REFERENCES polls(id)')();
  IntColumn get optionId => integer().customConstraint('NOT NULL REFERENCES poll_options(id)')();
  TextColumn get voterId => text().customConstraint('NOT NULL REFERENCES recipients(id)')();
  IntColumn get timestamp => integer()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {pollId, optionId, voterId}
  ];
}

class PollWithDetails {
  final PollDb poll;
  final List<PollOptionWithVoters> options;

  PollWithDetails(this.poll, this.options);
}

class PollOptionWithVoters {
  final PollOptionDb option;
  final List<PollVoteDb> votes;

  PollOptionWithVoters(this.option, this.votes);
}

@DriftAccessor(tables: [Polls, PollOptions, PollVotes, Recipients])
class PollTable extends DatabaseAccessor<SigmaDatabase> with _$PollTableMixin {
  PollTable(super.db);

  Future<void> createPoll(PollsCompanion pollCompanion, List<String> options) async {
    await transaction(() async {
      await into(polls).insert(pollCompanion);
      for (final text in options) {
        await into(pollOptions).insert(PollOptionsCompanion.insert(
          pollId: pollCompanion.id.value,
          optionText: text,
        ));
      }
    });
  }

  Future<void> castVote(String pollId, int optionId, String voterId) async {
    final pollRow = await (select(polls)..where((t) => t.id.equals(pollId))).getSingle();
    
    await transaction(() async {
      if (!pollRow.allowMultipleVotes) {
        await (delete(pollVotes)
          ..where((t) => t.pollId.equals(pollId))
          ..where((t) => t.voterId.equals(voterId)))
        .go();
      }
      
      await into(pollVotes).insertOnConflictUpdate(PollVotesCompanion.insert(
        pollId: pollId,
        optionId: optionId,
        voterId: voterId,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ));
    });
  }

  Stream<PollWithDetails?> watchPoll(String messageId) {
    return (select(polls)..where((t) => t.messageId.equals(messageId)))
        .watchSingleOrNull()
        .asyncMap((pollRow) async {
      if (pollRow == null) return null;

      final optionRows = await (select(pollOptions)..where((t) => t.pollId.equals(pollRow.id))).get();
      final List<PollOptionWithVoters> optionsWithVoters = [];

      for (final option in optionRows) {
        final voteRows = await (select(pollVotes)..where((t) => t.optionId.equals(option.id))).get();
        optionsWithVoters.add(PollOptionWithVoters(option, voteRows));
      }

      return PollWithDetails(pollRow, optionsWithVoters);
    });
  }
}
