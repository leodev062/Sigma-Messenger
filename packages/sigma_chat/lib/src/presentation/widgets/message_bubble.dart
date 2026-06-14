import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_ui/sigma_ui.dart';
import '../models/chat_ui_item.dart';
import 'package:flutter/services.dart';
import '../viewmodels/chat_viewmodel.dart';
import 'message_context_menu.dart';
import 'package:sigma_settings/sigma_settings.dart';
import 'package:sigma_profile/sigma_profile.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../pages/message_details_screen.dart';
import '../pages/forward_recipient_picker.dart';
import 'poll_component.dart';
import '../pages/poll_votes_screen.dart';

/// Signal-Style Bubble Tail Painter
class BubbleTailPainter extends CustomPainter {
  final Color color;
  final bool isMe;
  final double radius;
  final Color? strokeColor;
  final double strokeWidth;

  BubbleTailPainter({
    required this.color,
    required this.isMe,
    this.radius = 3.0,
    this.strokeColor,
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor ?? color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
    final r = radius.clamp(0.0, (w / 2));

    final path = Path();

    if (isMe) {
      path.moveTo(w, 0);
      path.lineTo(r, 0);
      path.quadraticBezierTo(0, 0, 0, r);
      path.lineTo(0, h);
      path.quadraticBezierTo(0, h, r, h);
      path.quadraticBezierTo(w * 0.65, h, w, h * 0.25);
      path.close();
    } else {
      path.moveTo(0, 0);
      path.lineTo(w - r, 0);
      path.quadraticBezierTo(w, 0, w, r);
      path.lineTo(w, h);
      path.quadraticBezierTo(w, h, w - r, h);
      path.quadraticBezierTo(w * 0.35, h, 0, h * 0.25);
      path.close();
    }

    canvas.drawPath(path, fillPaint);

    if (strokeColor != null) {
      canvas.drawPath(path, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant BubbleTailPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.isMe != isMe ||
      oldDelegate.radius != radius;
}

/// Implementação Pixel-Perfect e Otimizada do Signal.
class MessageBubble extends StatefulWidget {
  final MessageUiItem item;
  final Recipient? sender;

  const MessageBubble({required Key key, required this.item, this.sender})
    : super(key: key);

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  void _showContextMenu(BuildContext context, ChatViewModel viewModel) {
    MessageContextMenu.show(
      context,
      message: widget.item.message,
      onReact: (emoji) => viewModel.addReaction(widget.item.message.id, emoji),
      onReply: () {},
      onForward: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ForwardRecipientPicker(message: widget.item.message),
        ),
      ),
      onCopy: () {
        Clipboard.setData(ClipboardData(text: widget.item.message.textContent));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Copiado"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      onSelect: () => viewModel.toggleMessageSelection(widget.item.message.id),
      onInfo: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              MessageDetailsScreen(messageId: widget.item.message.id),
        ),
      ),
      onDelete: () => _confirmDelete(context, viewModel),
    );
  }

  void _confirmDelete(BuildContext context, ChatViewModel viewModel) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Apagar mensagem?"),
        content: const Text("Esta mensagem será apagada apenas para você."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("CANCELAR"),
          ),
          TextButton(
            onPressed: () {
              viewModel.deleteMessage(widget.item.message.id);
              Navigator.pop(ctx);
            },
            child: const Text("APAGAR", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isMe = widget.item.message.isFromMe;
    final viewModel = context.read<ChatViewModel>();
    final resolveProfile = context.read<ResolveProfileInteractor>();

    return RepaintBoundary(
      child: Selector<ChatViewModel, bool>(
        selector: (_, vm) =>
            vm.state.selectedMessageIds.contains(widget.item.message.id),
        builder: (context, isSelected, child) {
          final content = InkWell(
            onLongPress: () {
              HapticFeedback.mediumImpact();
              if (viewModel.state.isSelectionMode) {
                viewModel.toggleMessageSelection(widget.item.message.id);
              } else {
                _showContextMenu(context, viewModel);
              }
            },
            onTap: viewModel.state.isSelectionMode
                ? () => viewModel.toggleMessageSelection(widget.item.message.id)
                : null,
            child: Container(
              color: isSelected
                  ? Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.3)
                  : null,
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: widget.item.isFirstInGroup ? 4 : 1,
                bottom: widget.item.isLastInGroup ? 4 : 1,
              ),
              child: isMe
                  ? _buildRow(context, null)
                  : StreamBuilder<Recipient>(
                      stream: resolveProfile.watch(widget.item.message.senderId),
                      initialData: Recipient.createUnknown(widget.item.message.senderId),
                      builder: (context, snapshot) => _buildRow(context, snapshot.data),
                    ),
            ),
          );
          return content;
        },
      ),
    );
  }

  Widget _buildRow(BuildContext context, Recipient? sender) {
    final isMe = widget.item.message.isFromMe;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isMe && widget.item.showAvatar) ...[
          AvatarImageView(
            recipient: sender ?? Recipient.createUnknown(widget.item.message.senderId),
            size: 28,
          ),
          const SizedBox(width: 8),
        ] else if (!isMe && !widget.item.showAvatar) ...[
          const SizedBox(width: 36),
        ],
        Flexible(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildBubbleContent(context, sender),
              if (widget.item.message.reactions.isNotEmpty)
                Positioned(
                  bottom: -10,
                  right: isMe ? null : 0,
                  left: isMe ? 0 : null,
                  child: _buildReactionsDisplay(context),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReactionsDisplay(BuildContext context) {
    final theme = Theme.of(context);
    final Map<String, int> counts = {};
    for (var r in widget.item.message.reactions) {
      counts[r.emoji] = (counts[r.emoji] ?? 0) + 1;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: counts.entries
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  "${e.key}${e.value > 1 ? e.value : ''}",
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildBubbleContent(BuildContext context, Recipient? sender) {
    final theme = Theme.of(context);
    final settings = context.watch<SettingsViewModel>();
    final isMe = widget.item.message.isFromMe;
    final isDark = theme.brightness == Brightness.dark;

    final Color bubbleColor;
    final Color textColor;

    if (isMe) {
      bubbleColor = SigmaColors.signalBlue;
      textColor = Colors.white;
    } else {
      bubbleColor = isDark
          ? SigmaColors.incomingBubbleDark
          : SigmaColors.incomingBubbleLight;
      textColor = isDark ? Colors.white : Colors.black;
    }

    final metaColor = textColor.withValues(alpha: 0.6);

    return Stack(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      children: [
        if (widget.item.isFirstInGroup)
          Positioned(
            top: 0,
            right: isMe ? -6 : null,
            left: !isMe ? -6 : null,
            child: CustomPaint(
              size: const Size(10, 12),
              painter: BubbleTailPainter(
                color: bubbleColor,
                isMe: isMe,
                radius: 3.0,
                strokeColor: bubbleColor.withValues(alpha: 0.25),
                strokeWidth: 0.8,
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: _getBorderRadius(settings.messageBorderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.item.showName && !isMe)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    sender?.computedDisplayName ?? "Carregando...",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
              _buildMessageBody(context, textColor, settings),
              const SizedBox(height: 2),
              _buildMetadata(context, metaColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBody(
    BuildContext context,
    Color textColor,
    SettingsViewModel settings,
  ) {
    final message = widget.item.message;

    switch (message.type) {
      case MessageTypeEntity.location:
        return _LocationMessageBody(message: message, textColor: textColor);
      case MessageTypeEntity.poll:
        return _PollMessageBody(message: message, textColor: textColor);
      default:
        return Text(
          message.textContent,
          style: TextStyle(
            color: textColor,
            fontSize: settings.messageFontSize,
          ),
        );
    }
  }

  Widget _buildMetadata(BuildContext context, Color color) {
    final timeStr = TimeOfDay.fromDateTime(
      DateTime.fromMillisecondsSinceEpoch(widget.item.message.timestamp),
    ).format(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(timeStr, style: TextStyle(fontSize: 11, color: color)),
        if (widget.item.message.isFromMe) ...[
          const SizedBox(width: 4),
          _buildStatusIcon(context, color),
        ],
      ],
    );
  }

  Widget _buildStatusIcon(BuildContext context, Color color) {
    final status = widget.item.message.status;
    final theme = Theme.of(context);

    switch (status) {
      case MessageStatusEntity.pending:
        return Icon(Icons.access_time, size: 12, color: color);
      case MessageStatusEntity.sent:
        return Icon(Icons.check, size: 14, color: color);
      case MessageStatusEntity.delivered:
        return Icon(Icons.done_all, size: 14, color: color);
      case MessageStatusEntity.read:
        return Icon(
          Icons.done_all,
          size: 14,
          color: theme.brightness == Brightness.light
              ? Colors.white
              : SigmaColors.signalBlue,
        );
      case MessageStatusEntity.failed:
        return Icon(Icons.error_outline, size: 14, color: Colors.red);
    }
  }

  BorderRadius _getBorderRadius(double radius) {
    final isMe = widget.item.message.isFromMe;
    final double rLarge = radius;
    const double rSmall = 4.0;

    if (isMe) {
      return BorderRadius.only(
        topLeft: Radius.circular(rLarge),
        bottomLeft: Radius.circular(rLarge),
        topRight: Radius.circular(widget.item.isFirstInGroup ? rSmall : rLarge),
        bottomRight: Radius.circular(
          widget.item.isLastInGroup ? rSmall : rLarge,
        ),
      );
    } else {
      return BorderRadius.only(
        topRight: Radius.circular(rLarge),
        bottomRight: Radius.circular(rLarge),
        topLeft: Radius.circular(widget.item.isFirstInGroup ? rSmall : rLarge),
        bottomLeft: Radius.circular(
          widget.item.isLastInGroup ? rSmall : rLarge,
        ),
      );
    }
  }
}

class _LocationMessageBody extends StatelessWidget {
  final MessageEntity message;
  final Color textColor;

  const _LocationMessageBody({required this.message, required this.textColor});

  @override
  Widget build(BuildContext context) {
    final lat = message.latitude ?? 0.0;
    final lon = message.longitude ?? 0.0;
    final mapUrl = "https://www.google.com/maps/search/?api=1&query=$lat,$lon";

    return InkWell(
      onTap: () => url_launcher.launchUrl(
        Uri.parse(mapUrl),
        mode: url_launcher.LaunchMode.externalApplication,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black.withValues(alpha: 0.1),
                child: Stack(
                  children: [
                    const Center(
                      child: Icon(
                        Icons.map_rounded,
                        size: 48,
                        color: Colors.black26,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: const Text(
                          "Google",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              message.textContent,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
                height: 1.4,
                decoration: TextDecoration.underline,
                decorationColor: textColor.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PollMessageBody extends StatelessWidget {
  final MessageEntity message;
  final Color textColor;

  const _PollMessageBody({required this.message, required this.textColor});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ChatViewModel>();
    final isMe = message.isFromMe;

    return StreamBuilder<PollRecordEntity?>(
      stream: viewModel.watchPoll(message.id),
      builder: (context, snapshot) {
        final pollRecord = snapshot.data;
        
        if (pollRecord == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return PollComponent(
          poll: pollRecord,
          isOutgoing: isMe,
          chatColor: SigmaColors.signalBlue,
          fontSize: 16,
          onViewVotes: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PollVotesScreen(messageId: message.id),
              ),
            );
          },
          onToggleVote: (option, checked) {
            if (checked) {
              viewModel.voteInPoll(message.id, option.id.toString());
            }
          },
        );
      },
    );
  }
}
