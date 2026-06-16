import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'package:sigma_chat/src/domain/interactors/send_poll_interactor.dart';
import 'package:sigma_chat/src/data/jobs/chat/poll_vote_job.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sigma_chat/src/domain/services/live_location_manager.dart';
import 'state/chat_state.dart';

/// ChatViewModel - Arquitetura Profissional focada em performance (Padrão Signal).
class ChatViewModel extends ChangeNotifier {
  final WatchChatsInteractor _watchChatsInteractor;
  final WatchMessagesInteractor _watchMessagesInteractor;
  final SendMessageInteractor _sendMessageInteractor;
  final SendFileInteractor _sendFileInteractor;
  final SendLocationInteractor _sendLocationInteractor;
  final SendPollInteractor _sendPollInteractor;
  final SearchUsersInteractor _searchUsersInteractor;
  final DeleteMessageInteractor _deleteMessageInteractor;
  final DeleteThreadInteractor _deleteThreadInteractor;
  final AddReactionInteractor _addReactionInteractor;
  final ForwardMessageInteractor _forwardMessageInteractor;
  final GetMessageDetailsInteractor _getMessageDetailsInteractor;
  final ArchiveThreadInteractor _archiveThreadInteractor;
  final PinThreadInteractor _pinThreadInteractor;
  final MarkAsReadInteractor _markAsReadInteractor;
  final IChatRepository _chatRepository;
  final IRecipientRepository _recipientRepository;
  final IAuthRepository _authRepository;
  final SigmaJobManager _jobManager;
  final LocationService _locationService;
  final LiveLocationManager _liveLocationManager;

  ChatState _state = ChatState();
  ChatState get state => _state;

  StreamSubscription? _messagesSubscription;
  String? _currentConversationId;

  ChatViewModel(
    this._watchChatsInteractor,
    this._watchMessagesInteractor,
    this._sendMessageInteractor,
    this._sendFileInteractor,
    this._sendLocationInteractor,
    this._sendPollInteractor,
    this._searchUsersInteractor,
    this._deleteMessageInteractor,
    this._deleteThreadInteractor,
    this._addReactionInteractor,
    this._forwardMessageInteractor,
    this._getMessageDetailsInteractor,
    this._archiveThreadInteractor,
    this._pinThreadInteractor,
    this._markAsReadInteractor,
    this._chatRepository,
    this._recipientRepository,
    this._authRepository,
    this._jobManager,
    this._locationService,
    this._liveLocationManager,
    MediaPreviewService mediaPreviewService,
  ) {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = await _authRepository.getCurrentUser();
    _updateState(_state.copyWith(currentUser: user));
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    super.dispose();
  }

  void setupChat(String conversationId) async {
    if (_currentConversationId == conversationId) return;
    _currentConversationId = conversationId;
    
    // Fetch recipient type
    final thread = await _chatRepository.watchThread(conversationId).first;
    final recipientType = thread?.recipient.type ?? RecipientType.individual;

    _state = _state.copyWith(
      messageLimit: 50, 
      isLoadingMore: false,
      hasMore: true,
      uiItems: [],
      currentChatId: conversationId,
      isSelectionMode: false,
      selectedMessageIds: const {},
      currentRecipientType: recipientType,
    );
    notifyListeners();

    _subscribeToMessages();
    markAsRead(conversationId);
  }

  void _subscribeToMessages() {
    if (_currentConversationId == null) return;
    
    _messagesSubscription?.cancel();
    _messagesSubscription = _watchMessagesInteractor
        .execute(_currentConversationId!, limit: _state.messageLimit)
        .listen((messages) async {
      
      final uiItems = await compute<Map<String, dynamic>, List<ChatUiItem>>(
        MessageGroupProcessor.processInIsolate, 
        {
          'messages': messages,
          'currentUserId': Identity.currentUserId,
          'recipientType': _state.currentRecipientType,
        },
      );
      
      _updateState(_state.copyWith(
        uiItems: uiItems,
        isInitialLoading: false,
        isLoadingMore: false,
        hasMore: messages.length >= _state.messageLimit,
      ));
    });
  }

  /// Carregamento Infinito Otimizado.
  void loadMore() {
    if (_state.isLoadingMore || !_state.hasMore) return;
    
    _updateState(_state.copyWith(isLoadingMore: true));
    final newLimit = _state.messageLimit + 50;
    
    _state = _state.copyWith(messageLimit: newLimit);
    _subscribeToMessages();
    markAsRead(_currentConversationId!);
  }

  void jumpToBottom() {
    if (_state.messageLimit != 50) {
      _state = _state.copyWith(messageLimit: 50);
      _subscribeToMessages();
    }
  }

  Stream<List<ThreadEntity>> get threads => _watchChatsInteractor.execute();
  Stream<List<ThreadEntity>> get archivedThreads => _chatRepository.watchArchivedThreads();
  Stream<ThreadEntity?> watchThread(String threadId) => _chatRepository.watchThread(threadId);

  Future<void> sendMessage(String conversationId, String text) async {
    final currentUser = _state.currentUser;
    if (currentUser == null) return;

    final destType = _state.currentRecipientType.toDestinationType();

    _sendMessageInteractor.execute(
      conversationId,
      conversationId,
      currentUser.id,
      text,
      destinationType: destType,
    );
  }

  Future<void> sendFile(String conversationId, File file, MessageTypeEntity type) async {
    final currentUser = _state.currentUser;
    if (currentUser == null) return;
    await _sendFileInteractor.execute(
      chatId: conversationId,
      senderId: currentUser.id,
      file: file,
      type: type,
    );
  }

  Future<void> sendLocation(String conversationId, double lat, double lon, {double? accuracy, bool isLive = false}) async {
    final currentUser = _state.currentUser;
    if (currentUser == null) return;
    
    final destType = _state.currentRecipientType.toDestinationType();

    await _sendLocationInteractor.execute(
      conversationId: conversationId,
      senderId: currentUser.id,
      latitude: lat,
      longitude: lon,
      accuracy: accuracy,
      isLive: isLive,
      destinationType: destType,
    );
  }

  Future<void> sendCurrentLocation(String conversationId, {bool isLive = false, int durationMinutes = 15}) async {
    final position = await _locationService.getCurrentLocation();
    if (position != null) {
      if (isLive) {
        await startLiveLocation(conversationId, durationMinutes);
      } else {
        await sendLocation(conversationId, position.latitude, position.longitude, accuracy: position.accuracy);
      }
    }
  }

  Future<void> startLiveLocation(String chatId, int durationMinutes) async {
    final currentUser = _state.currentUser;
    if (currentUser == null) return;

    final position = await _locationService.getCurrentLocation();
    if (position == null) return;

    final destType = _state.currentRecipientType.toDestinationType();

    final message = await _sendLocationInteractor.execute(
      conversationId: chatId,
      senderId: currentUser.id,
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
      isLive: true,
      destinationType: destType,
    );

    await _liveLocationManager.startLiveLocation(
      chatId: chatId,
      messageId: message.id,
      durationMinutes: durationMinutes,
      destinationType: destType,
    );
  }

  void stopLiveLocation(String messageId) {
    _liveLocationManager.stopLiveLocation(messageId);
  }

  Future<void> sendPoll(String conversationId, String question, List<String> options, {bool allowMultipleVotes = false}) async {
    final currentUser = _state.currentUser;
    if (currentUser == null) {
      SigmaLog.e("ChatViewModel", "Falha ao enviar enquete: usuário não logado");
      return;
    }
    
    SigmaLog.i("ChatViewModel", "Iniciando envio de enquete: $question");
    await _sendPollInteractor.execute(
      conversationId: conversationId,
      chatId: conversationId,
      senderId: currentUser.id,
      question: question,
      options: options,
      allowMultipleVotes: allowMultipleVotes,
    );
  }

  Future<void> voteInPoll(String messageId, String optionId) async {
    final currentUser = _state.currentUser;
    if (currentUser == null) return;
    
    final message = await _chatRepository.getMessage(messageId);
    if (message == null) return;

    final pollId = "poll_$messageId";
    await _chatRepository.castVote(pollId, optionId, currentUser.id);

    final destType = _state.currentRecipientType.toDestinationType();

    _jobManager.add(PollVoteJob(
      messageId: messageId,
      optionIndexes: [int.tryParse(optionId) ?? 0],
      targetAuthorId: message.senderId,
      targetSentTimestamp: message.timestamp,
      voteCount: 1,
      destinationType: destType,
    ));
  }

  Stream<PollRecordEntity?> watchPoll(String messageId) {
    return _chatRepository.watchPoll(messageId);
  }

  Future<void> sendMediaAsset(String conversationId, AssetEntity asset) async {
    final file = await asset.file;
    if (file != null) {
      MessageTypeEntity type = MessageTypeEntity.image;
      if (asset.type == AssetType.video) type = MessageTypeEntity.video;
      if (asset.type == AssetType.audio) type = MessageTypeEntity.audio;
      
      await sendFile(conversationId, file, type);
    }
  }

  Future<void> markAsRead(String threadId) async => _markAsReadInteractor.execute(threadId);
  Future<void> archiveThread(String threadId, bool archived) async => _archiveThreadInteractor.execute(threadId, archived);
  Future<void> pinThread(String threadId, bool pinned) async => _pinThreadInteractor.execute(threadId, pinned);
  
  Future<void> deleteThread(String threadId) async {
    await _deleteThreadInteractor.execute(threadId);
  }

  Future<void> deleteMessage(String messageId) async {
    await _deleteMessageInteractor.execute(messageId);
  }

  Future<void> addReaction(String messageId, String emoji) async {
    final currentUser = _state.currentUser;
    if (currentUser == null) return;
    await _addReactionInteractor.execute(messageId, currentUser.id, emoji);
  }

  Future<void> forwardMessage(MessageEntity message, List<String> chatIds) async {
    final currentUser = _state.currentUser;
    if (currentUser == null) return;
    await _forwardMessageInteractor.execute(
      message: message, 
      targetChatIds: chatIds, 
      senderId: currentUser.id
    );
  }

  Future<MessageDetailsData?> getMessageDetails(String messageId) async {
    return await _getMessageDetailsInteractor.execute(messageId);
  }

  Future<void> search(String term) async {
    if (term.isEmpty) {
      _updateState(_state.copyWith(searchResults: [], isSearching: false));
      return;
    }
    _updateState(_state.copyWith(isSearching: true));
    try {
      final results = await _searchUsersInteractor.execute(term);
      _updateState(_state.copyWith(searchResults: results, isSearching: false));
    } catch (e) {
      _updateState(_state.copyWith(searchResults: [], isSearching: false, error: e.toString()));
    }
  }

  void clearSearch() => _updateState(_state.copyWith(searchResults: [], isSearching: false));

  Future<String> openChatWithRecipient(Recipient recipient) async {
    await _recipientRepository.saveRecipient(recipient);
    return await _chatRepository.getOrCreateThread(recipient.id);
  }

  void toggleMessageSelection(String messageId) {
    final newSelection = Set<String>.from(_state.selectedMessageIds);
    if (newSelection.contains(messageId)) {
      newSelection.remove(messageId);
    } else {
      newSelection.add(messageId);
    }
    
    _updateState(_state.copyWith(
      selectedMessageIds: newSelection,
      isSelectionMode: newSelection.isNotEmpty,
    ));
  }

  void clearSelection() {
    _updateState(_state.copyWith(
      isSelectionMode: false,
      selectedMessageIds: const {},
    ));
  }

  void _updateState(ChatState newState) {
    _state = newState;
    notifyListeners();
  }
}
