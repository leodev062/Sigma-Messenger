import 'package:sigma/core/storage/database.dart';
import 'package:sigma/data/models/chat_dtos.dart';

abstract class ChatLocalDataSource {
  Stream<List<ChatDto>> watchChats();
  Stream<List<MessageDto>> watchMessages(String chatId);
  Future<MessageDto?> getMessage(String id);
  Future<void> saveMessage(MessagesCompanion message);
  Future<void> saveChat(ChatsCompanion chat);
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final AppDatabase _db;

  ChatLocalDataSourceImpl(this._db);

  @override
  Stream<List<ChatDto>> watchChats() {
    return _db.watchAllChats().map(
      (list) => list.map((c) => ChatDto.fromDrift(c)).toList(),
    );
  }

  @override
  Stream<List<MessageDto>> watchMessages(String chatId) {
    return _db.watchMessagesForChat(chatId).map(
      (list) => list.map((m) => MessageDto.fromDrift(m)).toList(),
    );
  }

  @override
  Future<MessageDto?> getMessage(String id) async {
    final query = _db.select(_db.messages)..where((t) => t.id.equals(id));
    final result = await query.getSingleOrNull();
    return result != null ? MessageDto.fromDrift(result) : null;
  }

  @override
  Future<void> saveMessage(MessagesCompanion message) => _db.into(_db.messages).insertOnConflictUpdate(message);

  @override
  Future<void> saveChat(ChatsCompanion chat) => _db.upsertChat(chat);
}
