import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'package:sigma_chat/src/domain/interactors/send_poll_interactor.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../data/jobs/chat/poll_vote_job.dart';
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
  final LocationService _locationService;

  ChatState _state = ChatState();
  ChatState get state => _state;

  StreamSubscription? _messagesSubscription;
  int? _currentThreadId;

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
    this._locationService,
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

  void setupChat(int threadId) {
    if (_currentThreadId == threadId) return;
    _currentThreadId = threadId;
    
    // CAA/MVI: Reinício de estado completo e atômico
    _state = _state.copyWith(
      messageLimit: 50, 
      isLoadingMore: false,
      hasMore: true,
      uiItems: [],
      currentChatId: null,
      isSelectionMode: false,
      selectedMessageIds: const {},
    );
    notifyListeners();

    _loadCurrentChatId(threadId);
    _subscribeToMessages();
  }

  Future<void> _loadCurrentChatId(int threadId) async {
    final thread = await _chatRepository.watchThread(threadId).first;
    if (thread != null) {
      _updateState(_state.copyWith(currentChatId: thread.recipient.id));
    }
  }

  void _subscribeToMessages() {
    if (_currentThreadId == null) return;
    
    _messagesSubscription?.cancel();
    _messagesSubscription = _watchMessagesInteractor
        .execute(_currentThreadId!, limit: _state.messageLimit)
        .listen((messages) async {
      
      // CAA/Performance: Processamento em Isolate para manter UI a 60FPS
      // O 'compute' move a lógica de agrupamento para uma Worker Thread.
      final uiItems = await compute(MessageGroupProcessor.processInIsolate, messages);
      
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
    
    // Atualiza o limite e re-assina o stream do Drift (Fonte Única de Verdade)
    _state = _state.copyWith(messageLimit: newLimit);
    _subscribeToMessages();
  }

  void jumpToBottom() {
    if (_state.messageLimit != 50) {
      _state = _state.copyWith(messageLimit: 50);
      _subscribeToMessages();
    }
  }

  Stream<List<ThreadEntity>> get threads => _watchChatsInteractor.execute();
  Stream<List<ThreadEntity>> get archivedThreads => _chatRepository.watchArchivedThreads();
  Stream<ThreadEntity?> watchThread(int threadId) => _chatRepository.watchThread(threadId);

  Future<void> sendMessage(int threadId, String text) async {
    final currentUser = _state.currentUser;
    final chatId = _state.currentChatId;
    
    if (currentUser == null || chatId == null) return;

    // CAA/Performance: Envio imediato sem await excessivo
    _sendMessageInteractor.execute(threadId, chatId, currentUser.id, text);
  }

  Future<void> sendFile(int threadId, File file, MessageTypeEntity type) async {
    final currentUser = _state.currentUser;
    if (currentUser == null) return;
    final thread = await _chatRepository.watchThread(threadId).first;
    if (thread != null) {
      await _sendFileInteractor.execute(
        chatId: thread.recipient.id,
        senderId: currentUser.id,
        file: file,
        type: type,
      );
    }
  }

  Future<void> sendLocation(int threadId, double lat, double lon) async {
    final currentUser = _state.currentUser;
    if (currentUser == null) return;
    final thread = await _chatRepository.watchThread(threadId).first;
    if (thread != null) {
      await _sendLocationInteractor.execute(
        threadId: threadId,
        chatId: thread.recipient.id,
        senderId: currentUser.id,
        latitude: lat,
        longitude: lon,
      );
    }
  }

  Future<void> sendCurrentLocation(int threadId) async {
    final position = await _locationService.getCurrentLocation();
    if (position != null) {
      await sendLocation(threadId, position.latitude, position.longitude);
    }
  }

  Future<void> sendPoll(int threadId, String question, List<String> options, {bool allowMultipleVotes = false}) async {
    print("DEBUG: ChatViewModel.sendPoll called for thread $threadId");
    final currentUser = _state.currentUser;
    if (currentUser == null) {
      print("DEBUG: ChatViewModel.sendPoll - currentUser is NULL");
      SigmaLog.e("ChatViewModel", "Falha ao enviar enquete: usuário não logado");
      return;
    }
    
    final thread = await _chatRepository.watchThread(threadId).first;
    if (thread != null) {
      print("DEBUG: ChatViewModel.sendPoll - thread found, executing interactor");
      SigmaLog.i("ChatViewModel", "Iniciando envio de enquete: $question");
      await _sendPollInteractor.execute(
        threadId: threadId,
        chatId: thread.recipient.id,
        senderId: currentUser.id,
        question: question,
        options: options,
        allowMultipleVotes: allowMultipleVotes,
      );
      print("DEBUG: ChatViewModel.sendPoll - interactor executed");
    } else {
      print("DEBUG: ChatViewModel.sendPoll - thread $threadId NOT FOUND");
      SigmaLog.e("ChatViewModel", "Falha ao enviar enquete: thread $threadId não encontrada");
    }
  }

  Future<void> voteInPoll(String messageId, int optionId) async {
    final currentUser = _state.currentUser;
    if (currentUser == null) return;
    
    final message = await _chatRepository.getMessage(messageId);
    if (message == null) return;

    final pollId = "poll_$messageId";
    await _chatRepository.castVote(pollId, optionId, currentUser.id);

    // Criar e agendar o Job de voto para sincronização com o servidor
    final voteJob = PollVoteJob(
      messageId: messageId,
      optionIndexes: [optionId],
      targetAuthorId: message.senderRecipientId,
      targetSentTimestamp: message.timestamp,
      voteCount: 1,
    );

    SigmaLog.i("ChatViewModel", "Voto local computado e Job agendado para $pollId");
    await locator<SigmaJobManager>().add(voteJob);
  }

  Stream<PollRecordEntity?> watchPoll(String messageId) {
    return _chatRepository.watchPoll(messageId);
  }

  Future<void> sendMediaAsset(int threadId, AssetEntity asset) async {
    final file = await asset.file;
    if (file != null) {
      MessageTypeEntity type = MessageTypeEntity.image;
      if (asset.type == AssetType.video) type = MessageTypeEntity.video;
      if (asset.type == AssetType.audio) type = MessageTypeEntity.audio;
      
      await sendFile(threadId, file, type);
    }
  }

  Future<void> markAsRead(int threadId) async => _markAsReadInteractor.execute(threadId);
  Future<void> archiveThread(int threadId, bool archived) async => _archiveThreadInteractor.execute(threadId, archived);
  Future<void> pinThread(int threadId, bool pinned) async => _pinThreadInteractor.execute(threadId, pinned);
  
  Future<void> deleteThread(int threadId) async {
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

  Future<int> openChatWithRecipient(Recipient recipient) async {
    await _recipientRepository.saveRecipient(recipient);
    return await _chatRepository.getOrCreateThread(recipient.id);
  }

  /// MVI: Gestão de seleção de mensagens
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
