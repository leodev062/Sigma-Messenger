/// Tracks general state information when a user votes in a poll.
enum VoteState {
  none(0),
  pendingRemove(1),
  pendingAdd(2),
  removed(3),
  added(4);

  final int value;
  const VoteState(this.value);

  factory VoteState.fromValue(int value) {
    return VoteState.values.firstWhere((e) => e.value == value, orElse: () => VoteState.none);
  }
}

/// Class to track someone who has voted in an option within a poll.
class Voter {
  final String id; // RecipientId in Signal, String for Sigma
  final int voteCount;

  Voter({required this.id, required this.voteCount});
}

/// Represents a poll option and a list of recipients who have voted for that option
class PollOptionEntity {
  final String id;
  final String text;
  final List<Voter> voters;
  final VoteState voteState;

  PollOptionEntity({
    required this.id,
    required this.text,
    required this.voters,
    this.voteState = VoteState.none,
  });

  PollOptionEntity copyWith({
    String? id,
    String? text,
    List<Voter>? voters,
    VoteState? voteState,
  }) {
    return PollOptionEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      voters: voters ?? this.voters,
      voteState: voteState ?? this.voteState,
    );
  }
}

/// Data class representing a poll entry.
class PollRecordEntity {
  final String id;
  final String question;
  final List<PollOptionEntity> options;
  final bool allowMultipleVotes;
  final bool hasEnded;
  final String authorId;
  final String messageId;

  PollRecordEntity({
    required this.id,
    required this.question,
    required this.options,
    required this.allowMultipleVotes,
    required this.hasEnded,
    required this.authorId,
    required this.messageId,
  });
}

/// Tracks general information of a poll vote.
class PollVoteEntity {
  final String pollId;
  final String voterId;
  final String question;
  final int dateReceived;

  PollVoteEntity({
    required this.pollId,
    required this.voterId,
    required this.question,
    required this.dateReceived,
  });
}
