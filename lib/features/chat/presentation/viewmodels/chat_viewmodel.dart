import 'package:flutter/material.dart';
import 'package:sigma/domain/entities/chat_entity.dart';
import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/domain/interactors/chat/send_message_interactor.dart';
import 'package:sigma/domain/interactors/chat/watch_chats_interactor.dart';
import 'package:sigma/domain/interactors/chat/watch_messages_interactor.dart';
import 'package:sigma/domain/interactors/chat/search_users_interactor.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';
import 'package:sigma/domain/repositories/i_recipient_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final WatchChatsInteractor _watchChatsInteractor;
  final WatchMessagesInteractor _watchMessagesInteractor;
  final SendMessageInteractor _sendMessageInteractor;
  final SearchUsersInteractor _searchUsersInteractor;
  final IChatRepository _chatRepository;
  final IRecipientRepository _recipientRepository;

  List<UserEntity> _searchResults = [];
  List<UserEntity> get searchResults => _searchResults;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  ChatViewModel(
    this._watchChatsInteractor,
    this._watchMessagesInteractor,
    this._sendMessageInteractor,
    this._searchUsersInteractor,
    this._chatRepository,
    this._recipientRepository,
  );

  /// Stream reativa de conversas vinda direto do Banco de Dados (SSOT)
  Stream<List<ChatEntity>> get chats => _watchChatsInteractor.execute();

  /// Stream reativa de mensagens de um chat vinda direto do Banco de Dados (SSOT)
  Stream<List<MessageEntity>> watchMessages(String chatId) {
    return _watchMessagesInteractor.execute(chatId);
  }

  Stream<UserEntity?> watchRecipient(String id) {
    return _recipientRepository.getRecipient(id);
  }

  Future<void> search(String term) async {
    _isSearching = true;
    notifyListeners();
    try {
      _searchResults = await _searchUsersInteractor.execute(term);
    } catch (e) {
      _searchResults = [];
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }

  Future<void> openChatWithUser(UserEntity user) async {
    var chat = await _chatRepository.findPrivateChat(user.id);
    
    if (chat == null) {
      chat = ChatEntity(
        id: user.id,
        recipientId: user.id,
        title: user.name ?? user.username ?? user.phone,
        type: ChatTypeEntity.user,
        unreadCount: 0,
      );
      await _chatRepository.saveChat(chat);
      await _recipientRepository.saveRecipient(user);
    }
  }

  Future<void> sendMessage(String chatId, String senderId, String text) async {
    // O Interactor salva no banco e enfileira o Job.
    // A UI atualizará automaticamente via Stream.
    await _sendMessageInteractor.execute(
      chatId: chatId, 
      senderId: senderId, 
      text: text,
    );
  }
}
