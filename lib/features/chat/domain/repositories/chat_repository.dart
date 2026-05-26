import 'package:sigma/core/storage/database.dart';

abstract class IChatRepository {
  Stream<List<Chat>> watchChats();
  Stream<List<Message>> watchMessages(String chatId);
  Future<void> sendMessage(String chatId, String senderId, String text);
}
