import 'package:drift/drift.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_database/src/model/recipient_record.dart';

part 'recipient_database.g.dart';

@DataClassName('RecipientData')
class Recipients extends Table {
  TextColumn get id => text()(); // Internal Sigma ID (UUID or ACI)
  
  // Signal 2024 identifiers
  TextColumn get aci => text().nullable().unique()(); // Account Connection Identifier
  TextColumn get pni => text().nullable().unique()(); // Phone Number Identity
  
  IntColumn get type => intEnum<RecipientTypeDb>()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get username => text().nullable()();
  
  // Profile info
  TextColumn get displayName => text().nullable()();
  TextColumn get systemDisplayName => text().nullable()(); // Name from phone contacts
  TextColumn get profileName => text().nullable()(); // Name from Sigma profile
  
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get bio => text().nullable()();
  TextColumn get country => text().nullable()();
  
  // Relatives
  TextColumn get relativeName => text().nullable()();
  TextColumn get relativeId => text().nullable()();

  // Keys & Crypto
  TextColumn get identityKey => text().nullable()();
  IntColumn get signedPreKeyId => integer().nullable()();
  TextColumn get signedPreKeyPublic => text().nullable()();
  TextColumn get signedPreKeySignature => text().nullable()();
  Int64Column get registrationId => int64().nullable()();
  TextColumn get preKeys => text().nullable()(); // JSON String
  
  BoolColumn get isPrivate => boolean().withDefault(const Constant(false))();

  // Profile Key (Signal uses this to allow profile decryption)
  TextColumn get profileKey => text().nullable()();
  
  BoolColumn get isOnline => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastSeen => dateTime().nullable()();
  TextColumn get fallbackColor => text()();
  
  // Safety Number verification status
  IntColumn get identityStatus => integer().withDefault(const Constant(0))(); // 0: unverified, 1: verified, 2: changed

  @override
  Set<Column> get primaryKey => {id};

  List<Index> get indexes => [
    Index('recipients_phone', 'CREATE INDEX recipients_phone ON recipients (phone);'),
    Index('recipients_username', 'CREATE INDEX recipients_username ON recipients (username);'),
  ];
}

@DriftAccessor(tables: [Recipients])
class RecipientDatabase extends DatabaseAccessor<SigmaDatabase> with _$RecipientDatabaseMixin {
  RecipientDatabase(super.db);

  final Map<String, RecipientRecord> _cache = {};

  Future<RecipientRecord?> getRecipient(String id) async {
    if (_cache.containsKey(id)) return _cache[id];

    final data = await (select(recipients)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (data == null) return null;

    final record = RecipientRecord(data);
    _cache[id] = record;
    return record;
  }

  /// Padrão Signal: Busca ou cria um "stub" do destinatário.
  Future<RecipientRecord> getOrCreateRecipient(String id) async {
    final existing = await getRecipient(id);
    if (existing != null) return existing;

    await into(recipients).insertOnConflictUpdate(RecipientsCompanion.insert(
      id: id,
      type: RecipientTypeDb.individual,
      fallbackColor: "#FF1E88E5",
      displayName: const Value("Unknown"),
    ));

    final record = (await getRecipient(id))!;
    return record;
  }

  Stream<RecipientRecord?> watchRecipient(String id) {
    return (select(recipients)..where((t) => t.id.equals(id)))
        .watchSingleOrNull()
        .map((data) => data != null ? RecipientRecord(data) : null);
  }

  Future<void> upsertRecipient(RecipientsCompanion recipient) async {
    await into(recipients).insertOnConflictUpdate(recipient);
    if (recipient.id.present) {
      _cache.remove(recipient.id.value);
    }
  }

  Future<void> setProfileName(String id, String? name) async {
    await (update(recipients)..where((t) => t.id.equals(id))).write(RecipientsCompanion(profileName: Value(name)));
    _cache.remove(id);
  }

  Future<void> setAbout(String id, String? bio) async {
    await (update(recipients)..where((t) => t.id.equals(id))).write(RecipientsCompanion(bio: Value(bio)));
    _cache.remove(id);
  }

  Future<void> setAvatarUrl(String id, String? avatarUrl) async {
    await (update(recipients)..where((t) => t.id.equals(id))).write(RecipientsCompanion(avatarUrl: Value(avatarUrl)));
    _cache.remove(id);
  }

  Future<void> setUsername(String id, String? username) async {
    await (update(recipients)..where((t) => t.id.equals(id))).write(RecipientsCompanion(username: Value(username)));
    _cache.remove(id);
  }

  Future<List<RecipientData>> searchRecipients(String term) {
    final query = '%$term%';
    return (select(recipients)
          ..where((t) =>
              t.displayName.like(query) |
              t.profileName.like(query) |
              t.username.like(query) |
              t.phone.like(query)))
        .get();
  }

  Future<List<RecipientData>> getAllRecipients() => select(recipients).get();

  Stream<List<RecipientData>> watchAllRecipients() => select(recipients).watch();
}
