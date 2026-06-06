import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_ui/sigma_ui.dart';
import '../viewmodels/chat_viewmodel.dart';
import '../widgets/message_bubble.dart';
import '../models/chat_ui_item.dart';
import 'package:sigma_profile/sigma_profile.dart';
import '../widgets/date_separator.dart';
import '../widgets/attachment_bottom_sheet.dart';

/// Tela de Chat - Seguindo Padrões Signal-Android (Performance & OOP)
class ChatScreen extends StatefulWidget {
  final String chatId; 
  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  
  final ValueNotifier<bool> _showScrollToBottom = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isWriting = ValueNotifier<bool>(false);
  
  late final int _threadId;

  @override
  void initState() {
    super.initState();
    _threadId = int.tryParse(widget.chatId) ?? 0;
    
    // Inicia o carregamento instantâneo do banco de dados (Sem atrasos)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatViewModel>().setupChat(_threadId);
    });

    _scrollController.addListener(_onScroll);
    _messageController.addListener(() {
      _isWriting.value = _messageController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    // CAA/Performance: Trigger preloading earlier (700px before end) for "infinite" feel
    final bool shouldShow = _scrollController.hasClients && _scrollController.offset > 300;
    if (_showScrollToBottom.value != shouldShow) {
      _showScrollToBottom.value = shouldShow;
    }

    if (_scrollController.hasClients && 
        _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 800) {
      context.read<ChatViewModel>().loadMore();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    
    context.read<ChatViewModel>().sendMessage(_threadId, text);

    _messageController.clear();
    _scrollToBottom();
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => AttachmentBottomSheet(
        onMediaSelected: (asset) {
          context.read<ChatViewModel>().sendMediaAsset(_threadId, asset);
        },
        onLocationRequested: () {
          Navigator.pop(bottomSheetContext);
          context.read<ChatViewModel>().sendCurrentLocation(_threadId);
        },
        onPollCreated: (question, options, allowMultiple) {
          print("DEBUG: ChatScreen.onPollCreated callback triggered");
          try {
            // Usando 'context' da ChatScreen, não o do BottomSheet que foi fechado
            final vm = context.read<ChatViewModel>();
            print("DEBUG: ChatScreen.onPollCreated - ViewModel obtained, calling sendPoll");
            vm.sendPoll(_threadId, question, options, allowMultipleVotes: allowMultiple);
          } catch (e) {
            print("DEBUG: ChatScreen.onPollCreated - ERROR: $e");
          }
        },
        onFileRequested: () {
          Navigator.pop(bottomSheetContext);
          // TODO: Implementar file picker interactor
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatViewModel = context.read<ChatViewModel>();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      // CAA/MVI: AppBar reativa ao modo de seleção
      appBar: _buildDynamicAppBar(context, chatViewModel),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildMessagesList(),
                _buildScrollToBottomButton(),
              ],
            ),
          ),
          _buildSignalInputPanel(theme),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildDynamicAppBar(BuildContext context, ChatViewModel vm) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Selector<ChatViewModel, bool>(
        selector: (_, vm) => vm.state.isSelectionMode,
        builder: (context, isSelectionMode, child) {
          if (isSelectionMode) {
            return _buildSelectionAppBar(vm);
          }
          return _buildSignalAppBar(vm);
        },
      ),
    );
  }

  PreferredSizeWidget _buildSelectionAppBar(ChatViewModel vm) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: vm.clearSelection,
      ),
      title: Selector<ChatViewModel, int>(
        selector: (_, vm) => vm.state.selectedMessageIds.length,
        builder: (context, count, _) => Text(count.toString()),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.reply), onPressed: () {}),
        IconButton(icon: const Icon(Icons.copy), onPressed: () {}),
        IconButton(icon: const Icon(Icons.delete_outline), onPressed: () {}),
      ],
    );
  }

  PreferredSizeWidget _buildSignalAppBar(ChatViewModel vm) {
    final theme = Theme.of(context);
    return AppBar(
      titleSpacing: 0,
      scrolledUnderElevation: 2,
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surface,
      title: StreamBuilder<ThreadEntity?>(
        stream: vm.watchThread(_threadId),
        builder: (context, snapshot) {
          final recipient = snapshot.data?.recipient;
          if (recipient == null) return const SizedBox.shrink();

          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RecipientProfileView(recipient: recipient)),
            ),
            child: Row(
              children: [
                AvatarImageView(recipient: recipient, size: 36),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipient.computedDisplayName,
                        style: TextStyle(
                          fontSize: 17, 
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        recipient.isOnline ? context.translate('online') : context.translate('click_for_info'),
                        style: TextStyle(
                          fontSize: 12, 
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.videocam_outlined, color: theme.colorScheme.onSurface), 
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.call_outlined, color: theme.colorScheme.onSurface), 
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert, color: theme.colorScheme.onSurface),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMessagesList() {
    return Selector<ChatViewModel, List<ChatUiItem>>(
      selector: (_, vm) => vm.state.uiItems,
      builder: (context, uiItems, child) {
        return Selector<ChatViewModel, bool>(
          selector: (_, vm) => vm.state.isLoadingMore,
          builder: (context, isLoadingMore, child) {
            // ListView.custom com SliverChildBuilderDelegate para performance máxima
            return ListView.custom(
              controller: _scrollController,
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              // cacheExtent ajuda a pre-renderizar itens antes de entrarem na tela (smooth scroll)
              cacheExtent: 1000, 
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == uiItems.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  }

                  final item = uiItems[index];
                  if (item is MessageUiItem) {
                    return MessageBubble(
                      key: ValueKey(item.message.id), 
                      item: item,
                    );
                  } else if (item is DateSeparatorUiItem) {
                    return DateSeparator(timestamp: item.timestamp);
                  }
                  return const SizedBox.shrink();
                },
                childCount: uiItems.length + (isLoadingMore ? 1 : 0),
                // findChildIndexCallback ajuda o Flutter a reciclar widgets corretamente
                findChildIndexCallback: (Key key) {
                  if (key is ValueKey<String>) {
                    final id = key.value;
                    final index = uiItems.indexWhere((item) => item is MessageUiItem && item.message.id == id);
                    return index != -1 ? index : null;
                  }
                  return null;
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSignalInputPanel(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
      color: theme.colorScheme.surface,
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: _showAttachmentOptions,
              icon: Icon(Icons.add, color: isDark ? Colors.white70 : Colors.black54, size: 28),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2E2E2E) : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.sentiment_satisfied_alt_outlined, color: isDark ? Colors.white70 : Colors.black54),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        focusNode: _focusNode,
                        maxLines: 1,
                        minLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: context.translate('message_hint'),
                          hintStyle: TextStyle(color: isDark ? Colors.white38 : Colors.black38),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt_outlined, color: isDark ? Colors.white70 : Colors.black54),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            ValueListenableBuilder<bool>(
              valueListenable: _isWriting,
              builder: (context, writing, child) => GestureDetector(
                onTap: _sendMessage,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: writing ? SigmaColors.signalBlue : (isDark ? const Color(0xFF2E2E2E) : const Color(0xFFF2F2F2)),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    writing ? Icons.send : Icons.mic_none_outlined,
                    color: writing ? Colors.white : (isDark ? Colors.white70 : Colors.black54),
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildScrollToBottomButton() {
    return ValueListenableBuilder<bool>(
      valueListenable: _showScrollToBottom,
      builder: (context, visible, child) => visible ? Positioned(
        right: 16, bottom: 16,
        child: FloatingActionButton.small(
          onPressed: _scrollToBottom,
          child: const Icon(Icons.keyboard_arrow_down, size: 24),
        ),
      ) : const SizedBox.shrink(),
    );
  }
}
