import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'package:sigma/core/storage/database.dart';
import 'package:sigma/core/network/socket_manager.dart';
import 'package:sigma/core/crypto/crypto_manager.dart';
import 'package:sigma/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements IChatRepository {
  final AppDatabase _database;
  final SocketManager _socketManager;
  final CryptoManager _cryptoManager;

  ChatRepositoryImpl(
    this._database, 
    this._socketManager, 
    this._cryptoManager,
  ) {
    _initSocketListener();
  }

  void _initSocketListener() {
    _socketManager.messages.listen((data) {
      _handleIncomingSocketMessage(data);
    });
  }

  void _handleIncomingSocketMessage(dynamic data) async {
    try {
      if (data is! Map) return;

      if (data['type'] == 1 && data['request'] != null) {
        final request = data['request'];
        final verb = request['verb'];
        final path = request['path'];
        final body = request['body'];

        if (verb == "PUT" && path == "/api/v1/message") {
          final chatId = body['chat_id'];
          final senderId = body['sender_id'];
          final encryptedEnvelope = body['envelope'];

          await _cryptoManager.init();
          final cleanText = await _cryptoManager.decryptMessage(senderId, encryptedEnvelope);

          await saveReceivedMessage(
            chatId: chatId,
            senderId: senderId,
            text: cleanText,
          );

          _socketManager.sendRequest(
            verb: 'DELETE',
            path: '/api/v1/message',
            body: request['id'].toString(),
          );
        }
      }
    } catch (e) {
      debugPrint("Error handling/decrypting multiplexed message: $e");
    }
  }

  @override
  Stream<List<Chat>> watchChats() => _database.watchAllChats();
  
  @override
  Stream<List<Message>> watchMessages(String chatId) => _database.watchMessagesForChat(chatId);
  
  SocketStatus get connectionStatus => _socketManager.status;

  @override
  Future<void> sendMessage(String chatId, String senderId, String text) async {
    final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    
    await _database.insertMessage(MessagesCompanion(
      id: Value(messageId),
      chatId: Value(chatId),
      senderId: Value(senderId),
      textContent: Value(text),
      timestamp: Value(DateTime.now().millisecondsSinceEpoch),
      status: Value(MessageStatus.pending),
      isFromMe: Value(true),
    ));

    try {
      await _cryptoManager.init();
      final encryptedEnvelope = await _cryptoManager.encryptMessage(chatId, text);

      _socketManager.sendRequest(
        verb: 'PUT',
        path: '/api/v1/message',
        body: {
          "destination_id": chatId,
          "envelope": encryptedEnvelope,
        },
      );
    } catch (e) {
      debugPrint("Encryption Error: $e");
    }
  }

  Future<void> saveReceivedMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    await _database.insertMessage(MessagesCompanion(
      id: Value(DateTime.now().millisecondsSinceEpoch.toString()),
      chatId: Value(chatId),
      senderId: Value(senderId),
      textContent: Value(text),
      timestamp: Value(DateTime.now().millisecondsSinceEpoch),
      status: Value(MessageStatus.read),
      isFromMe: Value(false),
    ));
    
    await _database.upsertChat(ChatsCompanion(
      id: Value(chatId),
      lastMessage: Value(text),
      lastMessageTimestamp: Value(DateTime.now().millisecondsSinceEpoch),
    ));
  }
}
