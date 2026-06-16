import 'package:sigma_core/sigma_core.dart';
import '../../models/chat_ui_item.dart';

class ChatState {
  final List<Recipient> searchResults;
  final bool isSearching;
  final String? error;
  final Recipient? currentUser;
  final String? currentChatId;
  final List<ChatUiItem> uiItems; 
  final int messageLimit;
  final bool isInitialLoading; 
  final bool isLoadingMore;
  final bool hasMore;
  final bool isSelectionMode;
  final Set<String> selectedMessageIds;
  final bool isTyping;
  final RecipientType currentRecipientType;

  ChatState({
    this.searchResults = const [],
    this.isSearching = false,
    this.error,
    this.currentUser,
    this.currentChatId,
    this.uiItems = const [],
    this.messageLimit = 50,
    this.isInitialLoading = true,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.isSelectionMode = false,
    this.selectedMessageIds = const {},
    this.isTyping = false,
    this.currentRecipientType = RecipientType.individual,
  });

  ChatState copyWith({
    List<Recipient>? searchResults,
    bool? isSearching,
    String? error,
    Recipient? currentUser,
    String? currentChatId,
    List<ChatUiItem>? uiItems,
    int? messageLimit,
    bool? isInitialLoading,
    bool? isLoadingMore,
    bool? hasMore,
    bool? isSelectionMode,
    Set<String>? selectedMessageIds,
    bool? isTyping,
    RecipientType? currentRecipientType,
  }) {
    return ChatState(
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
      error: error ?? this.error,
      currentUser: currentUser ?? this.currentUser,
      currentChatId: currentChatId ?? this.currentChatId,
      uiItems: uiItems ?? this.uiItems,
      messageLimit: messageLimit ?? this.messageLimit,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      selectedMessageIds: selectedMessageIds ?? this.selectedMessageIds,
      isTyping: isTyping ?? this.isTyping,
      currentRecipientType: currentRecipientType ?? this.currentRecipientType,
    );
  }
}
