import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';

class PollComponent extends StatelessWidget {
  final PollRecordEntity poll;
  final bool isOutgoing;
  final Color chatColor;
  final VoidCallback onViewVotes;
  final Function(PollOptionEntity, bool) onToggleVote;
  final double fontSize;

  const PollComponent({
    super.key,
    required this.poll,
    required this.isOutgoing,
    required this.chatColor,
    required this.onViewVotes,
    required this.onToggleVote,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalVoters = poll.options
        .expand((opt) => opt.voters.map((v) => v.id))
        .toSet()
        .length;

    String caption;
    if (poll.hasEnded) {
      caption = "Resultados finais";
    } else if (poll.allowMultipleVotes) {
      caption = "Selecione um ou mais";
    } else {
      caption = "Selecione um";
    }

    final pollColors = isOutgoing
        ? PollColors.outgoing(chatColor)
        : PollColors.incoming(theme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Text(
            poll.question,
            style: TextStyle(
              color: pollColors.text,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Text(
            caption,
            style: TextStyle(
              color: pollColors.caption,
              fontSize: fontSize * 0.8,
            ),
          ),
        ),
        ...poll.options.map((option) => PollOptionWidget(
              option: option,
              totalVoters: totalVoters,
              hasEnded: poll.hasEnded,
              onToggleVote: onToggleVote,
              pollColors: pollColors,
              fontSize: fontSize,
            )),
        const SizedBox(height: 16),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: pollColors.buttonBackground,
                  foregroundColor: pollColors.button,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: totalVoters > 0 ? onViewVotes : null,
                child: Text(
                  totalVoters == 0
                      ? "Nenhum voto"
                      : (poll.hasEnded ? "Ver resultados" : "Ver votos"),
                  style: TextStyle(fontSize: fontSize * 0.8),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}

class PollOptionWidget extends StatelessWidget {
  final PollOptionEntity option;
  final int totalVoters;
  final bool hasEnded;
  final Function(PollOptionEntity, bool) onToggleVote;
  final PollColors pollColors;
  final double fontSize;

  const PollOptionWidget({
    super.key,
    required this.option,
    required this.totalVoters,
    required this.hasEnded,
    required this.onToggleVote,
    required this.pollColors,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalVoters > 0 ? option.voters.length / totalVoters : 0.0;
    final isSelected = option.voteState == VoteState.added ||
        option.voteState == VoteState.pendingAdd;

    return InkWell(
      onTap: hasEnded
          ? null
          : () {
              final currentlyAdded = option.voteState == VoteState.added ||
                  option.voteState == VoteState.pendingAdd;
              onToggleVote(option, !currentlyAdded);
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!hasEnded) _buildCheckbox(isSelected),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          option.text,
                          style: TextStyle(
                            color: pollColors.text,
                            fontSize: fontSize,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (hasEnded && isSelected)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Icon(Icons.check_circle,
                              size: 16, color: pollColors.checkboxBackground),
                        ),
                      Text(
                        option.voters.length.toString(),
                        style: TextStyle(
                          color: pollColors.text,
                          fontSize: fontSize * 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      height: 8,
                      width: double.infinity,
                      color: pollColors.progressBackground,
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          color: pollColors.progress,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(bool isSelected) {
    if (option.voteState == VoteState.pendingAdd ||
        option.voteState == VoteState.pendingRemove) {
      return Container(
        margin: const EdgeInsets.only(top: 4, right: 8),
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation<Color>(pollColors.checkbox),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 4, right: 8),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: pollColors.checkbox, width: 2),
        color: isSelected ? pollColors.checkboxBackground : Colors.transparent,
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 16, color: Colors.white)
          : null,
    );
  }
}

class PollColors {
  final Color text;
  final Color caption;
  final Color progress;
  final Color progressBackground;
  final Color checkbox;
  final Color checkboxBackground;
  final Color button;
  final Color buttonBackground;

  PollColors({
    required this.text,
    required this.caption,
    required this.progress,
    required this.progressBackground,
    required this.checkbox,
    required this.checkboxBackground,
    required this.button,
    required this.buttonBackground,
  });

  factory PollColors.outgoing(Color chatColor) {
    return PollColors(
      text: Colors.white,
      caption: Colors.white.withValues(alpha: 0.7),
      progress: Colors.white,
      progressBackground: Colors.white.withValues(alpha: 0.2),
      checkbox: Colors.white.withValues(alpha: 0.7),
      checkboxBackground: Colors.white,
      button: chatColor,
      buttonBackground: Colors.white,
    );
  }

  factory PollColors.incoming(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return PollColors(
      text: theme.colorScheme.onSurface,
      caption: theme.colorScheme.onSurfaceVariant,
      progress: theme.colorScheme.primary,
      progressBackground: isDark ? Colors.white10 : Colors.black12,
      checkbox: theme.colorScheme.outline,
      checkboxBackground: theme.colorScheme.primary,
      button: theme.colorScheme.onPrimaryContainer,
      buttonBackground: theme.colorScheme.primaryContainer,
    );
  }
}
