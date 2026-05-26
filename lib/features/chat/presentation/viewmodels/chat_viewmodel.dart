import 'package:flutter/material.dart';
import 'package:sigma/domain/entities/chat_entity.dart';
import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/domain/interactors/chat/send_message_interactor.dart';
import 'package:sigma/domain/interactors/chat/watch_chats_interactor.dart';
import 'package:sigma/domain/interactors/chat/watch_messages_interactor.dart';

class ChatViewModel extends ChangeNotifier {
  final WatchChatsInteractor _watchChatsInteractor;
  final WatchMessagesInteractor _watchMessagesInteractor;
  final SendMessageInteractor _sendMessageInteractor;

  ChatViewModel(
    this._watchChatsInteractor,
    this._watchMessagesInteractor,
    this._sendMessageInteractor,
  );

  Stream<List<ChatEntity>> get chats => _watchChatsInteractor.execute();

  Stream<List<MessageEntity>> watchMessages(String chatId) {
    return _watchMessagesInteractor.execute(chatId);
  }

  Future<void> sendMessage(String chatId, String senderId, String text) async {
    await _sendMessageInteractor.execute(
      chatId: chatId, 
      senderId: senderId, 
      text: text,
    );
  }
}
