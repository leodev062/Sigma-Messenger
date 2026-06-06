import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_database/src/recipient_database.dart';
import 'package:sigma_database/src/thread_table.dart';
import 'package:sigma_core/sigma_core.dart' hide Reaction;

part 'message_table.g.dart';

class ListStringConverter extends TypeConverter<List<String>, String> {
  const ListStringConverter();
  @override
  List<String> fromSql(String fromDb) {
    return (json.decode(fromDb) as List).cast<String>();
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}

class Messages extends Table {
  TextColumn get id => text()();
  IntColumn get threadId => integer().references(Threads, #id)();
  TextColumn get chatId => text()();
  TextColumn get senderRecipientId => text().references(Recipients, #id)();
  TextColumn get textContent => text()();
  IntColumn get type => intEnum<MessageTypeDb>().withDefault(Constant(MessageTypeDb.text.index))();
  
  TextColumn get attachmentUrl => text().nullable()();
  TextColumn get attachmentAesKey => text().nullable()();
  TextColumn get attachmentIv => text().nullable()();
  TextColumn get attachmentMacKey => text().nullable()();
  
  IntColumn get timestamp => integer()();
  IntColumn get status => intEnum<MessageStatusDb>().withDefault(Constant(MessageStatusDb.pending.index))();
  BoolColumn get isFromMe => boolean()();

  // Localização
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  // Enquetes
  TextColumn get pollQuestion => text().nullable()();
  TextColumn get pollOptions => text().map(const ListStringConverter()).nullable()();
  BoolColumn get allowMultipleVotes => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  List<Index> get indexes => [
    // Otimização crucial para milhares de mensagens: Busca e ordenação ultra-rápida.
    Index('messages_by_thread_and_time', 'CREATE INDEX messages_by_thread_and_time ON messages (thread_id, timestamp DESC);'),
  ];
}

// Tabelas de Criptografia Signal Protocol
class SignalSessions extends Table {
  TextColumn get addressName => text()();
  IntColumn get deviceId => integer()();
  BlobColumn get sessionRecord => blob()();
  @override Set<Column> get primaryKey => {addressName, deviceId};
}

class SignalPreKeys extends Table {
  IntColumn get preKeyId => integer()();
  BlobColumn get preKeyRecord => blob()();
  @override Set<Column> get primaryKey => {preKeyId};
}

class SignalSignedPreKeys extends Table {
  IntColumn get signedPreKeyId => integer()();
  BlobColumn get signedPreKeyRecord => blob()();
  @override Set<Column> get primaryKey => {signedPreKeyId};
}

class SignalIdentities extends Table {
  TextColumn get addressName => text()();
  IntColumn get registrationId => integer()();
  BlobColumn get identityKey => blob().nullable()();
  @override Set<Column> get primaryKey => {addressName};
}

// Tabela Virtual para Busca Global (FTS5) - Performance Profissional
class MessageSearch extends Table {
  @override
  String get tableName => 'message_search';

  // Propriedade para o drift_dev reconhecer como virtual (sem override se causar erro)
  bool get useFts5 => true;

  // Drift vincula automaticamente ao ID da mensagem se usarmos um mapeamento
  TextColumn get id => text()();
  TextColumn get textContent => text()();
}

// Tabela de Reações - Padrão ReactionTable.kt do Signal
class Reactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get messageId => text().references(Messages, #id)();
  TextColumn get authorId => text().references(Recipients, #id)();
  TextColumn get emoji => text()();
  IntColumn get dateSent => integer()();
  IntColumn get dateReceived => integer()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {messageId, authorId} // Um usuário só pode ter uma reação por mensagem (Signal logic)
  ];
}

// Tabela de Recibos (Receipts) - Detalhes de entrega para Grupos e 1:1
class MessageReceipts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get messageId => text().references(Messages, #id)();
  TextColumn get recipientId => text().references(Recipients, #id)();
  IntColumn get status => intEnum<MessageStatusDb>()();
  IntColumn get timestamp => integer()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {messageId, recipientId, status}
  ];
}

class MessageWithReactions {
  final Message message;
  final List<Reaction> reactions;
  MessageWithReactions(this.message, this.reactions);
}

@DriftAccessor(tables: [Messages, Threads, Recipients, MessageSearch, Reactions, MessageReceipts])
class MessageTable extends DatabaseAccessor<SigmaDatabase> with _$MessageTableMixin, Loggable {
  MessageTable(super.db);

  /// Salva uma mensagem e atualiza os metadados da conversa de forma atômica.
  /// POO: Encapsula a regra de incremento de mensagens não lidas.
  Future<void> saveMessageAndUpdateThread({
    required String chatId,
    required MessagesCompanion message,
    required String snippet,
  }) async {
    logD("Transação iniciada para salvar mensagem: \${message.id.value}");
    try {
      await transaction(() async {
        // 1. Garantir que o destinatário existe
        await db.recipientDatabase.getOrCreateRecipient(chatId);

        // 2. Buscar ou criar a Thread
        final threadTable = db.threadTable;
        var thread = await threadTable.getThreadByRecipientId(chatId);

        // Regra de negócio: Só incrementa unreadCount se a mensagem não for minha
        final bool shouldIncrement = !(message.isFromMe.value);

        int threadId;
        if (thread == null) {
          threadId = await into(threads).insert(ThreadsCompanion.insert(
            recipientId: chatId,
            date: message.timestamp.value,
            snippet: Value(snippet),
            unreadCount: Value(shouldIncrement ? 1 : 0),
          ));
        } else {
          threadId = thread.id;
          await (update(threads)..where((t) => t.id.equals(threadId))).write(
            ThreadsCompanion(
              snippet: Value(snippet),
              date: message.timestamp,
              unreadCount: Value(shouldIncrement ? thread.unreadCount + 1 : thread.unreadCount),
            ),
          );
        }

        // 3. Inserir a mensagem vinculada à thread
        await into(messages).insertOnConflictUpdate(
          message.copyWith(threadId: Value(threadId)),
        );

        // 4. Sincronizar FTS5 para busca instantânea
        if (message.textContent.present) {
          final content = message.textContent.value;
          // CAA/Fix: FTS5 não suporta ON CONFLICT. Usamos insert normal dentro de try-catch.
          try {
            await into(messageSearch).insert(
              MessageSearchCompanion(
                id: message.id,
                textContent: Value(content),
              ),
            );
          } catch (e) {
            logW("Erro ao inserir no FTS5 (conflito ignorado): \$e");
          }
        }
      });
      logD("Transação finalizada com sucesso: \${message.id.value}");
    } catch (e) {
      logE("ERRO NA TRANSAÇÃO: \$e");
      rethrow;
    }
  }

  /// Busca Global Otimizada usando FTS5 (SQLite Virtual Table)
  Future<List<Message>> searchMessagesGlobal(String query) async {
    final rows = await customSelect(
      'SELECT id FROM message_search WHERE text_content MATCH ?',
      variables: [Variable(query)],
      readsFrom: {messageSearch},
    ).get();
    
    if (rows.isEmpty) return [];

    final ids = rows.map((r) => r.read<String>('id')).toList();
    return (select(messages)..where((t) => t.id.isIn(ids))).get();
  }

  Future<void> markThreadAsRead(int threadId) async {
    await (update(threads)..where((t) => t.id.equals(threadId))).write(
      const ThreadsCompanion(unreadCount: Value(0)),
    );
  }

  Future<Message?> getMessage(String id) {
    return (select(messages)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<Message?> getMessageByMetadata(String authorAci, int sentTimestamp) {
    return (select(messages)
      ..where((t) => t.senderRecipientId.equals(authorAci))
      ..where((t) => t.timestamp.equals(sentTimestamp))
    ).getSingleOrNull();
  }

  Future<void> updateMessageStatus(String messageId, MessageStatusDb status) {
    return (update(messages)..where((t) => t.id.equals(messageId)))
        .write(MessagesCompanion(status: Value(status)));
  }

  Stream<List<Message>> watchMessages(int threadId, {int limit = 50}) {
    final query = select(messages)
      ..where((t) => t.threadId.equals(threadId))
      ..orderBy([(t) => OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc)])
      ..limit(limit);

    return query.watch();
  }

  /// Nova consulta otimizada que traz mensagens e reações em um único stream.
  /// Resolve o problema N+1 no Repositório.
  Stream<List<MessageWithReactions>> watchMessagesWithReactions(int threadId, {int limit = 50}) {
    final query = select(messages).join([
      leftOuterJoin(reactions, reactions.messageId.equalsExp(messages.id)),
    ])
      ..where(messages.threadId.equals(threadId))
      ..orderBy([OrderingTerm(expression: messages.timestamp, mode: OrderingMode.desc)])
      ..limit(limit);

    return query.watch().map((rows) {
      final Map<String, Message> messageMap = {};
      final Map<String, List<Reaction>> reactionsMap = {};

      for (final row in rows) {
        final message = row.readTable(messages);
        final reaction = row.readTableOrNull(reactions);

        messageMap.putIfAbsent(message.id, () => message);
        if (reaction != null) {
          reactionsMap.putIfAbsent(message.id, () => []).add(reaction);
        }
      }

      return messageMap.values.map((m) {
        return MessageWithReactions(m, reactionsMap[m.id] ?? []);
      }).toList();
    });
  }

  Future<void> saveMessage(MessagesCompanion message) {
    return into(messages).insertOnConflictUpdate(message);
  }

  Future<void> deleteMessage(String messageId) {
    return (delete(messages)..where((t) => t.id.equals(messageId))).go();
  }

  Future<void> deleteMessagesByThreadId(int threadId) {
    return (delete(messages)..where((t) => t.threadId.equals(threadId))).go();
  }

  // --- Reações (Signal Logic) ---
  
  Future<void> upsertReaction(ReactionsCompanion reaction) {
    return into(reactions).insertOnConflictUpdate(reaction);
  }

  Future<void> deleteReaction(String messageId, String authorId) {
    return (delete(reactions)
      ..where((t) => t.messageId.equals(messageId))
      ..where((t) => t.authorId.equals(authorId)))
    .go();
  }

  Stream<List<Reaction>> watchReactionsForMessage(String messageId) {
    return (select(reactions)..where((t) => t.messageId.equals(messageId))).watch();
  }

  // --- Recibos (Receipts Logic) ---

  Future<void> saveReceipt(MessageReceiptsCompanion receipt) {
    return into(messageReceipts).insertOnConflictUpdate(receipt);
  }

  Future<List<MessageReceipt>> getReceiptsForMessage(String messageId) {
    return (select(messageReceipts)..where((t) => t.messageId.equals(messageId))).get();
  }
}
