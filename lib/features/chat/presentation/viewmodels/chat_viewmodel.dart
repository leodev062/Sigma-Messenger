import 'package:flutter/material.dart';
import 'package:sigma/features/chat/domain/repositories/chat_repository.dart';
import 'package:sigma/core/storage/database.dart';

class ChatViewModel extends ChangeNotifier {
  final IChatRepository _chatRepository;

  ChatViewModel(this._chatRepository);

  Stream<List<Chat>> get chats => _chatRepository.watchChats();

  Stream<List<Message>> watchMessages(String chatId) {
    return _chatRepository.watchMessages(chatId);
  }

  Future<void> sendMessage(String chatId, String senderId, String text) async {
    await _chatRepository.sendMessage(chatId, senderId, text);
  }
}
