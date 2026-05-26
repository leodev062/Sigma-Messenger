// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isMeMeta = const VerificationMeta('isMe');
  @override
  late final GeneratedColumn<bool> isMe = GeneratedColumn<bool>(
    'is_me',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_me" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    username,
    phone,
    avatarUrl,
    isMe,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('is_me')) {
      context.handle(
        _isMeMeta,
        isMe.isAcceptableOrUnknown(data['is_me']!, _isMeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      isMe: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_me'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String? name;
  final String? username;
  final String phone;
  final String? avatarUrl;
  final bool isMe;
  const User({
    required this.id,
    this.name,
    this.username,
    required this.phone,
    this.avatarUrl,
    required this.isMe,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['is_me'] = Variable<bool>(isMe);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      phone: Value(phone),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      isMe: Value(isMe),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      username: serializer.fromJson<String?>(json['username']),
      phone: serializer.fromJson<String>(json['phone']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      isMe: serializer.fromJson<bool>(json['isMe']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'username': serializer.toJson<String?>(username),
      'phone': serializer.toJson<String>(phone),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'isMe': serializer.toJson<bool>(isMe),
    };
  }

  User copyWith({
    String? id,
    Value<String?> name = const Value.absent(),
    Value<String?> username = const Value.absent(),
    String? phone,
    Value<String?> avatarUrl = const Value.absent(),
    bool? isMe,
  }) => User(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    username: username.present ? username.value : this.username,
    phone: phone ?? this.phone,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    isMe: isMe ?? this.isMe,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      username: data.username.present ? data.username.value : this.username,
      phone: data.phone.present ? data.phone.value : this.phone,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      isMe: data.isMe.present ? data.isMe.value : this.isMe,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('phone: $phone, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('isMe: $isMe')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, username, phone, avatarUrl, isMe);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.username == this.username &&
          other.phone == this.phone &&
          other.avatarUrl == this.avatarUrl &&
          other.isMe == this.isMe);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> username;
  final Value<String> phone;
  final Value<String?> avatarUrl;
  final Value<bool> isMe;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.phone = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.isMe = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    required String phone,
    this.avatarUrl = const Value.absent(),
    this.isMe = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phone = Value(phone);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? username,
    Expression<String>? phone,
    Expression<String>? avatarUrl,
    Expression<bool>? isMe,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (phone != null) 'phone': phone,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (isMe != null) 'is_me': isMe,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String?>? name,
    Value<String?>? username,
    Value<String>? phone,
    Value<String?>? avatarUrl,
    Value<bool>? isMe,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isMe: isMe ?? this.isMe,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (isMe.present) {
      map['is_me'] = Variable<bool>(isMe.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('phone: $phone, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('isMe: $isMe, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatsTable extends Chats with TableInfo<$ChatsTable, Chat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
    'contact_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ChatType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(ChatType.user.index),
      ).withConverter<ChatType>($ChatsTable.$convertertype);
  static const VerificationMeta _lastMessageMeta = const VerificationMeta(
    'lastMessage',
  );
  @override
  late final GeneratedColumn<String> lastMessage = GeneratedColumn<String>(
    'last_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageTimestampMeta =
      const VerificationMeta('lastMessageTimestamp');
  @override
  late final GeneratedColumn<int> lastMessageTimestamp = GeneratedColumn<int>(
    'last_message_timestamp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta(
    'unreadCount',
  );
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isPinnedMeta = const VerificationMeta(
    'isPinned',
  );
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
    'is_pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pinned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    contactId,
    title,
    type,
    lastMessage,
    lastMessageTimestamp,
    unreadCount,
    isVerified,
    isPinned,
    isArchived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chats';
  @override
  VerificationContext validateIntegrity(
    Insertable<Chat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('last_message')) {
      context.handle(
        _lastMessageMeta,
        lastMessage.isAcceptableOrUnknown(
          data['last_message']!,
          _lastMessageMeta,
        ),
      );
    }
    if (data.containsKey('last_message_timestamp')) {
      context.handle(
        _lastMessageTimestampMeta,
        lastMessageTimestamp.isAcceptableOrUnknown(
          data['last_message_timestamp']!,
          _lastMessageTimestampMeta,
        ),
      );
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(
          data['unread_count']!,
          _unreadCountMeta,
        ),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    }
    if (data.containsKey('is_pinned')) {
      context.handle(
        _isPinnedMeta,
        isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chat(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      type: $ChatsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      lastMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message'],
      ),
      lastMessageTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_message_timestamp'],
      ),
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
      isPinned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pinned'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
    );
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ChatType, int, int> $convertertype =
      const EnumIndexConverter<ChatType>(ChatType.values);
}

class Chat extends DataClass implements Insertable<Chat> {
  final String id;
  final String? contactId;
  final String? title;
  final ChatType type;
  final String? lastMessage;
  final int? lastMessageTimestamp;
  final int unreadCount;
  final bool isVerified;
  final bool isPinned;
  final bool isArchived;
  const Chat({
    required this.id,
    this.contactId,
    this.title,
    required this.type,
    this.lastMessage,
    this.lastMessageTimestamp,
    required this.unreadCount,
    required this.isVerified,
    required this.isPinned,
    required this.isArchived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || contactId != null) {
      map['contact_id'] = Variable<String>(contactId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    {
      map['type'] = Variable<int>($ChatsTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || lastMessage != null) {
      map['last_message'] = Variable<String>(lastMessage);
    }
    if (!nullToAbsent || lastMessageTimestamp != null) {
      map['last_message_timestamp'] = Variable<int>(lastMessageTimestamp);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    map['is_verified'] = Variable<bool>(isVerified);
    map['is_pinned'] = Variable<bool>(isPinned);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      id: Value(id),
      contactId: contactId == null && nullToAbsent
          ? const Value.absent()
          : Value(contactId),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      type: Value(type),
      lastMessage: lastMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessage),
      lastMessageTimestamp: lastMessageTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageTimestamp),
      unreadCount: Value(unreadCount),
      isVerified: Value(isVerified),
      isPinned: Value(isPinned),
      isArchived: Value(isArchived),
    );
  }

  factory Chat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chat(
      id: serializer.fromJson<String>(json['id']),
      contactId: serializer.fromJson<String?>(json['contactId']),
      title: serializer.fromJson<String?>(json['title']),
      type: $ChatsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      lastMessage: serializer.fromJson<String?>(json['lastMessage']),
      lastMessageTimestamp: serializer.fromJson<int?>(
        json['lastMessageTimestamp'],
      ),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'contactId': serializer.toJson<String?>(contactId),
      'title': serializer.toJson<String?>(title),
      'type': serializer.toJson<int>($ChatsTable.$convertertype.toJson(type)),
      'lastMessage': serializer.toJson<String?>(lastMessage),
      'lastMessageTimestamp': serializer.toJson<int?>(lastMessageTimestamp),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'isVerified': serializer.toJson<bool>(isVerified),
      'isPinned': serializer.toJson<bool>(isPinned),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  Chat copyWith({
    String? id,
    Value<String?> contactId = const Value.absent(),
    Value<String?> title = const Value.absent(),
    ChatType? type,
    Value<String?> lastMessage = const Value.absent(),
    Value<int?> lastMessageTimestamp = const Value.absent(),
    int? unreadCount,
    bool? isVerified,
    bool? isPinned,
    bool? isArchived,
  }) => Chat(
    id: id ?? this.id,
    contactId: contactId.present ? contactId.value : this.contactId,
    title: title.present ? title.value : this.title,
    type: type ?? this.type,
    lastMessage: lastMessage.present ? lastMessage.value : this.lastMessage,
    lastMessageTimestamp: lastMessageTimestamp.present
        ? lastMessageTimestamp.value
        : this.lastMessageTimestamp,
    unreadCount: unreadCount ?? this.unreadCount,
    isVerified: isVerified ?? this.isVerified,
    isPinned: isPinned ?? this.isPinned,
    isArchived: isArchived ?? this.isArchived,
  );
  Chat copyWithCompanion(ChatsCompanion data) {
    return Chat(
      id: data.id.present ? data.id.value : this.id,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      lastMessage: data.lastMessage.present
          ? data.lastMessage.value
          : this.lastMessage,
      lastMessageTimestamp: data.lastMessageTimestamp.present
          ? data.lastMessageTimestamp.value
          : this.lastMessageTimestamp,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chat(')
          ..write('id: $id, ')
          ..write('contactId: $contactId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('lastMessageTimestamp: $lastMessageTimestamp, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isVerified: $isVerified, ')
          ..write('isPinned: $isPinned, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    contactId,
    title,
    type,
    lastMessage,
    lastMessageTimestamp,
    unreadCount,
    isVerified,
    isPinned,
    isArchived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          other.id == this.id &&
          other.contactId == this.contactId &&
          other.title == this.title &&
          other.type == this.type &&
          other.lastMessage == this.lastMessage &&
          other.lastMessageTimestamp == this.lastMessageTimestamp &&
          other.unreadCount == this.unreadCount &&
          other.isVerified == this.isVerified &&
          other.isPinned == this.isPinned &&
          other.isArchived == this.isArchived);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<String> id;
  final Value<String?> contactId;
  final Value<String?> title;
  final Value<ChatType> type;
  final Value<String?> lastMessage;
  final Value<int?> lastMessageTimestamp;
  final Value<int> unreadCount;
  final Value<bool> isVerified;
  final Value<bool> isPinned;
  final Value<bool> isArchived;
  final Value<int> rowid;
  const ChatsCompanion({
    this.id = const Value.absent(),
    this.contactId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.lastMessage = const Value.absent(),
    this.lastMessageTimestamp = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatsCompanion.insert({
    required String id,
    this.contactId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.lastMessage = const Value.absent(),
    this.lastMessageTimestamp = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Chat> custom({
    Expression<String>? id,
    Expression<String>? contactId,
    Expression<String>? title,
    Expression<int>? type,
    Expression<String>? lastMessage,
    Expression<int>? lastMessageTimestamp,
    Expression<int>? unreadCount,
    Expression<bool>? isVerified,
    Expression<bool>? isPinned,
    Expression<bool>? isArchived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contactId != null) 'contact_id': contactId,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (lastMessage != null) 'last_message': lastMessage,
      if (lastMessageTimestamp != null)
        'last_message_timestamp': lastMessageTimestamp,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (isVerified != null) 'is_verified': isVerified,
      if (isPinned != null) 'is_pinned': isPinned,
      if (isArchived != null) 'is_archived': isArchived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatsCompanion copyWith({
    Value<String>? id,
    Value<String?>? contactId,
    Value<String?>? title,
    Value<ChatType>? type,
    Value<String?>? lastMessage,
    Value<int?>? lastMessageTimestamp,
    Value<int>? unreadCount,
    Value<bool>? isVerified,
    Value<bool>? isPinned,
    Value<bool>? isArchived,
    Value<int>? rowid,
  }) {
    return ChatsCompanion(
      id: id ?? this.id,
      contactId: contactId ?? this.contactId,
      title: title ?? this.title,
      type: type ?? this.type,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      unreadCount: unreadCount ?? this.unreadCount,
      isVerified: isVerified ?? this.isVerified,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<int>($ChatsTable.$convertertype.toSql(type.value));
    }
    if (lastMessage.present) {
      map['last_message'] = Variable<String>(lastMessage.value);
    }
    if (lastMessageTimestamp.present) {
      map['last_message_timestamp'] = Variable<int>(lastMessageTimestamp.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatsCompanion(')
          ..write('id: $id, ')
          ..write('contactId: $contactId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('lastMessageTimestamp: $lastMessageTimestamp, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isVerified: $isVerified, ')
          ..write('isPinned: $isPinned, ')
          ..write('isArchived: $isArchived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<String> chatId = GeneratedColumn<String>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chats (id)',
    ),
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MessageType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(MessageType.text.index),
      ).withConverter<MessageType>($MessagesTable.$convertertype);
  static const VerificationMeta _attachmentUrlMeta = const VerificationMeta(
    'attachmentUrl',
  );
  @override
  late final GeneratedColumn<String> attachmentUrl = GeneratedColumn<String>(
    'attachment_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attachmentAesKeyMeta = const VerificationMeta(
    'attachmentAesKey',
  );
  @override
  late final GeneratedColumn<String> attachmentAesKey = GeneratedColumn<String>(
    'attachment_aes_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attachmentMacKeyMeta = const VerificationMeta(
    'attachmentMacKey',
  );
  @override
  late final GeneratedColumn<String> attachmentMacKey = GeneratedColumn<String>(
    'attachment_mac_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MessageStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(MessageStatus.pending.index),
      ).withConverter<MessageStatus>($MessagesTable.$converterstatus);
  static const VerificationMeta _isFromMeMeta = const VerificationMeta(
    'isFromMe',
  );
  @override
  late final GeneratedColumn<bool> isFromMe = GeneratedColumn<bool>(
    'is_from_me',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_from_me" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    chatId,
    senderId,
    textContent,
    type,
    attachmentUrl,
    attachmentAesKey,
    attachmentMacKey,
    timestamp,
    status,
    isFromMe,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Message> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('text_content')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(
          data['text_content']!,
          _textContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    if (data.containsKey('attachment_url')) {
      context.handle(
        _attachmentUrlMeta,
        attachmentUrl.isAcceptableOrUnknown(
          data['attachment_url']!,
          _attachmentUrlMeta,
        ),
      );
    }
    if (data.containsKey('attachment_aes_key')) {
      context.handle(
        _attachmentAesKeyMeta,
        attachmentAesKey.isAcceptableOrUnknown(
          data['attachment_aes_key']!,
          _attachmentAesKeyMeta,
        ),
      );
    }
    if (data.containsKey('attachment_mac_key')) {
      context.handle(
        _attachmentMacKeyMeta,
        attachmentMacKey.isAcceptableOrUnknown(
          data['attachment_mac_key']!,
          _attachmentMacKeyMeta,
        ),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('is_from_me')) {
      context.handle(
        _isFromMeMeta,
        isFromMe.isAcceptableOrUnknown(data['is_from_me']!, _isFromMeMeta),
      );
    } else if (isInserting) {
      context.missing(_isFromMeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chat_id'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      )!,
      type: $MessagesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      attachmentUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_url'],
      ),
      attachmentAesKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_aes_key'],
      ),
      attachmentMacKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_mac_key'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      status: $MessagesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      isFromMe: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_from_me'],
      )!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MessageType, int, int> $convertertype =
      const EnumIndexConverter<MessageType>(MessageType.values);
  static JsonTypeConverter2<MessageStatus, int, int> $converterstatus =
      const EnumIndexConverter<MessageStatus>(MessageStatus.values);
}

class Message extends DataClass implements Insertable<Message> {
  final String id;
  final String chatId;
  final String senderId;
  final String textContent;
  final MessageType type;
  final String? attachmentUrl;
  final String? attachmentAesKey;
  final String? attachmentMacKey;
  final int timestamp;
  final MessageStatus status;
  final bool isFromMe;
  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.textContent,
    required this.type,
    this.attachmentUrl,
    this.attachmentAesKey,
    this.attachmentMacKey,
    required this.timestamp,
    required this.status,
    required this.isFromMe,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['chat_id'] = Variable<String>(chatId);
    map['sender_id'] = Variable<String>(senderId);
    map['text_content'] = Variable<String>(textContent);
    {
      map['type'] = Variable<int>($MessagesTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || attachmentUrl != null) {
      map['attachment_url'] = Variable<String>(attachmentUrl);
    }
    if (!nullToAbsent || attachmentAesKey != null) {
      map['attachment_aes_key'] = Variable<String>(attachmentAesKey);
    }
    if (!nullToAbsent || attachmentMacKey != null) {
      map['attachment_mac_key'] = Variable<String>(attachmentMacKey);
    }
    map['timestamp'] = Variable<int>(timestamp);
    {
      map['status'] = Variable<int>(
        $MessagesTable.$converterstatus.toSql(status),
      );
    }
    map['is_from_me'] = Variable<bool>(isFromMe);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      chatId: Value(chatId),
      senderId: Value(senderId),
      textContent: Value(textContent),
      type: Value(type),
      attachmentUrl: attachmentUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentUrl),
      attachmentAesKey: attachmentAesKey == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentAesKey),
      attachmentMacKey: attachmentMacKey == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentMacKey),
      timestamp: Value(timestamp),
      status: Value(status),
      isFromMe: Value(isFromMe),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<String>(json['id']),
      chatId: serializer.fromJson<String>(json['chatId']),
      senderId: serializer.fromJson<String>(json['senderId']),
      textContent: serializer.fromJson<String>(json['textContent']),
      type: $MessagesTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      attachmentUrl: serializer.fromJson<String?>(json['attachmentUrl']),
      attachmentAesKey: serializer.fromJson<String?>(json['attachmentAesKey']),
      attachmentMacKey: serializer.fromJson<String?>(json['attachmentMacKey']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      status: $MessagesTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      isFromMe: serializer.fromJson<bool>(json['isFromMe']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'chatId': serializer.toJson<String>(chatId),
      'senderId': serializer.toJson<String>(senderId),
      'textContent': serializer.toJson<String>(textContent),
      'type': serializer.toJson<int>(
        $MessagesTable.$convertertype.toJson(type),
      ),
      'attachmentUrl': serializer.toJson<String?>(attachmentUrl),
      'attachmentAesKey': serializer.toJson<String?>(attachmentAesKey),
      'attachmentMacKey': serializer.toJson<String?>(attachmentMacKey),
      'timestamp': serializer.toJson<int>(timestamp),
      'status': serializer.toJson<int>(
        $MessagesTable.$converterstatus.toJson(status),
      ),
      'isFromMe': serializer.toJson<bool>(isFromMe),
    };
  }

  Message copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? textContent,
    MessageType? type,
    Value<String?> attachmentUrl = const Value.absent(),
    Value<String?> attachmentAesKey = const Value.absent(),
    Value<String?> attachmentMacKey = const Value.absent(),
    int? timestamp,
    MessageStatus? status,
    bool? isFromMe,
  }) => Message(
    id: id ?? this.id,
    chatId: chatId ?? this.chatId,
    senderId: senderId ?? this.senderId,
    textContent: textContent ?? this.textContent,
    type: type ?? this.type,
    attachmentUrl: attachmentUrl.present
        ? attachmentUrl.value
        : this.attachmentUrl,
    attachmentAesKey: attachmentAesKey.present
        ? attachmentAesKey.value
        : this.attachmentAesKey,
    attachmentMacKey: attachmentMacKey.present
        ? attachmentMacKey.value
        : this.attachmentMacKey,
    timestamp: timestamp ?? this.timestamp,
    status: status ?? this.status,
    isFromMe: isFromMe ?? this.isFromMe,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      type: data.type.present ? data.type.value : this.type,
      attachmentUrl: data.attachmentUrl.present
          ? data.attachmentUrl.value
          : this.attachmentUrl,
      attachmentAesKey: data.attachmentAesKey.present
          ? data.attachmentAesKey.value
          : this.attachmentAesKey,
      attachmentMacKey: data.attachmentMacKey.present
          ? data.attachmentMacKey.value
          : this.attachmentMacKey,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      status: data.status.present ? data.status.value : this.status,
      isFromMe: data.isFromMe.present ? data.isFromMe.value : this.isFromMe,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('senderId: $senderId, ')
          ..write('textContent: $textContent, ')
          ..write('type: $type, ')
          ..write('attachmentUrl: $attachmentUrl, ')
          ..write('attachmentAesKey: $attachmentAesKey, ')
          ..write('attachmentMacKey: $attachmentMacKey, ')
          ..write('timestamp: $timestamp, ')
          ..write('status: $status, ')
          ..write('isFromMe: $isFromMe')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    chatId,
    senderId,
    textContent,
    type,
    attachmentUrl,
    attachmentAesKey,
    attachmentMacKey,
    timestamp,
    status,
    isFromMe,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.chatId == this.chatId &&
          other.senderId == this.senderId &&
          other.textContent == this.textContent &&
          other.type == this.type &&
          other.attachmentUrl == this.attachmentUrl &&
          other.attachmentAesKey == this.attachmentAesKey &&
          other.attachmentMacKey == this.attachmentMacKey &&
          other.timestamp == this.timestamp &&
          other.status == this.status &&
          other.isFromMe == this.isFromMe);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> id;
  final Value<String> chatId;
  final Value<String> senderId;
  final Value<String> textContent;
  final Value<MessageType> type;
  final Value<String?> attachmentUrl;
  final Value<String?> attachmentAesKey;
  final Value<String?> attachmentMacKey;
  final Value<int> timestamp;
  final Value<MessageStatus> status;
  final Value<bool> isFromMe;
  final Value<int> rowid;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.textContent = const Value.absent(),
    this.type = const Value.absent(),
    this.attachmentUrl = const Value.absent(),
    this.attachmentAesKey = const Value.absent(),
    this.attachmentMacKey = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.status = const Value.absent(),
    this.isFromMe = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String id,
    required String chatId,
    required String senderId,
    required String textContent,
    this.type = const Value.absent(),
    this.attachmentUrl = const Value.absent(),
    this.attachmentAesKey = const Value.absent(),
    this.attachmentMacKey = const Value.absent(),
    required int timestamp,
    this.status = const Value.absent(),
    required bool isFromMe,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       chatId = Value(chatId),
       senderId = Value(senderId),
       textContent = Value(textContent),
       timestamp = Value(timestamp),
       isFromMe = Value(isFromMe);
  static Insertable<Message> custom({
    Expression<String>? id,
    Expression<String>? chatId,
    Expression<String>? senderId,
    Expression<String>? textContent,
    Expression<int>? type,
    Expression<String>? attachmentUrl,
    Expression<String>? attachmentAesKey,
    Expression<String>? attachmentMacKey,
    Expression<int>? timestamp,
    Expression<int>? status,
    Expression<bool>? isFromMe,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatId != null) 'chat_id': chatId,
      if (senderId != null) 'sender_id': senderId,
      if (textContent != null) 'text_content': textContent,
      if (type != null) 'type': type,
      if (attachmentUrl != null) 'attachment_url': attachmentUrl,
      if (attachmentAesKey != null) 'attachment_aes_key': attachmentAesKey,
      if (attachmentMacKey != null) 'attachment_mac_key': attachmentMacKey,
      if (timestamp != null) 'timestamp': timestamp,
      if (status != null) 'status': status,
      if (isFromMe != null) 'is_from_me': isFromMe,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? chatId,
    Value<String>? senderId,
    Value<String>? textContent,
    Value<MessageType>? type,
    Value<String?>? attachmentUrl,
    Value<String?>? attachmentAesKey,
    Value<String?>? attachmentMacKey,
    Value<int>? timestamp,
    Value<MessageStatus>? status,
    Value<bool>? isFromMe,
    Value<int>? rowid,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      textContent: textContent ?? this.textContent,
      type: type ?? this.type,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      attachmentAesKey: attachmentAesKey ?? this.attachmentAesKey,
      attachmentMacKey: attachmentMacKey ?? this.attachmentMacKey,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      isFromMe: isFromMe ?? this.isFromMe,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<String>(chatId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $MessagesTable.$convertertype.toSql(type.value),
      );
    }
    if (attachmentUrl.present) {
      map['attachment_url'] = Variable<String>(attachmentUrl.value);
    }
    if (attachmentAesKey.present) {
      map['attachment_aes_key'] = Variable<String>(attachmentAesKey.value);
    }
    if (attachmentMacKey.present) {
      map['attachment_mac_key'] = Variable<String>(attachmentMacKey.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $MessagesTable.$converterstatus.toSql(status.value),
      );
    }
    if (isFromMe.present) {
      map['is_from_me'] = Variable<bool>(isFromMe.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('senderId: $senderId, ')
          ..write('textContent: $textContent, ')
          ..write('type: $type, ')
          ..write('attachmentUrl: $attachmentUrl, ')
          ..write('attachmentAesKey: $attachmentAesKey, ')
          ..write('attachmentMacKey: $attachmentMacKey, ')
          ..write('timestamp: $timestamp, ')
          ..write('status: $status, ')
          ..write('isFromMe: $isFromMe, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SignalSessionsTable extends SignalSessions
    with TableInfo<$SignalSessionsTable, SignalSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SignalSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _addressNameMeta = const VerificationMeta(
    'addressName',
  );
  @override
  late final GeneratedColumn<String> addressName = GeneratedColumn<String>(
    'address_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<int> deviceId = GeneratedColumn<int>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionRecordMeta = const VerificationMeta(
    'sessionRecord',
  );
  @override
  late final GeneratedColumn<Uint8List> sessionRecord =
      GeneratedColumn<Uint8List>(
        'session_record',
        aliasedName,
        false,
        type: DriftSqlType.blob,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [addressName, deviceId, sessionRecord];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'signal_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SignalSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('address_name')) {
      context.handle(
        _addressNameMeta,
        addressName.isAcceptableOrUnknown(
          data['address_name']!,
          _addressNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_addressNameMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('session_record')) {
      context.handle(
        _sessionRecordMeta,
        sessionRecord.isAcceptableOrUnknown(
          data['session_record']!,
          _sessionRecordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionRecordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {addressName, deviceId};
  @override
  SignalSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SignalSession(
      addressName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_name'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}device_id'],
      )!,
      sessionRecord: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}session_record'],
      )!,
    );
  }

  @override
  $SignalSessionsTable createAlias(String alias) {
    return $SignalSessionsTable(attachedDatabase, alias);
  }
}

class SignalSession extends DataClass implements Insertable<SignalSession> {
  final String addressName;
  final int deviceId;
  final Uint8List sessionRecord;
  const SignalSession({
    required this.addressName,
    required this.deviceId,
    required this.sessionRecord,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['address_name'] = Variable<String>(addressName);
    map['device_id'] = Variable<int>(deviceId);
    map['session_record'] = Variable<Uint8List>(sessionRecord);
    return map;
  }

  SignalSessionsCompanion toCompanion(bool nullToAbsent) {
    return SignalSessionsCompanion(
      addressName: Value(addressName),
      deviceId: Value(deviceId),
      sessionRecord: Value(sessionRecord),
    );
  }

  factory SignalSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SignalSession(
      addressName: serializer.fromJson<String>(json['addressName']),
      deviceId: serializer.fromJson<int>(json['deviceId']),
      sessionRecord: serializer.fromJson<Uint8List>(json['sessionRecord']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'addressName': serializer.toJson<String>(addressName),
      'deviceId': serializer.toJson<int>(deviceId),
      'sessionRecord': serializer.toJson<Uint8List>(sessionRecord),
    };
  }

  SignalSession copyWith({
    String? addressName,
    int? deviceId,
    Uint8List? sessionRecord,
  }) => SignalSession(
    addressName: addressName ?? this.addressName,
    deviceId: deviceId ?? this.deviceId,
    sessionRecord: sessionRecord ?? this.sessionRecord,
  );
  SignalSession copyWithCompanion(SignalSessionsCompanion data) {
    return SignalSession(
      addressName: data.addressName.present
          ? data.addressName.value
          : this.addressName,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      sessionRecord: data.sessionRecord.present
          ? data.sessionRecord.value
          : this.sessionRecord,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SignalSession(')
          ..write('addressName: $addressName, ')
          ..write('deviceId: $deviceId, ')
          ..write('sessionRecord: $sessionRecord')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    addressName,
    deviceId,
    $driftBlobEquality.hash(sessionRecord),
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignalSession &&
          other.addressName == this.addressName &&
          other.deviceId == this.deviceId &&
          $driftBlobEquality.equals(other.sessionRecord, this.sessionRecord));
}

class SignalSessionsCompanion extends UpdateCompanion<SignalSession> {
  final Value<String> addressName;
  final Value<int> deviceId;
  final Value<Uint8List> sessionRecord;
  final Value<int> rowid;
  const SignalSessionsCompanion({
    this.addressName = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.sessionRecord = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SignalSessionsCompanion.insert({
    required String addressName,
    required int deviceId,
    required Uint8List sessionRecord,
    this.rowid = const Value.absent(),
  }) : addressName = Value(addressName),
       deviceId = Value(deviceId),
       sessionRecord = Value(sessionRecord);
  static Insertable<SignalSession> custom({
    Expression<String>? addressName,
    Expression<int>? deviceId,
    Expression<Uint8List>? sessionRecord,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (addressName != null) 'address_name': addressName,
      if (deviceId != null) 'device_id': deviceId,
      if (sessionRecord != null) 'session_record': sessionRecord,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SignalSessionsCompanion copyWith({
    Value<String>? addressName,
    Value<int>? deviceId,
    Value<Uint8List>? sessionRecord,
    Value<int>? rowid,
  }) {
    return SignalSessionsCompanion(
      addressName: addressName ?? this.addressName,
      deviceId: deviceId ?? this.deviceId,
      sessionRecord: sessionRecord ?? this.sessionRecord,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (addressName.present) {
      map['address_name'] = Variable<String>(addressName.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<int>(deviceId.value);
    }
    if (sessionRecord.present) {
      map['session_record'] = Variable<Uint8List>(sessionRecord.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SignalSessionsCompanion(')
          ..write('addressName: $addressName, ')
          ..write('deviceId: $deviceId, ')
          ..write('sessionRecord: $sessionRecord, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SignalPreKeysTable extends SignalPreKeys
    with TableInfo<$SignalPreKeysTable, SignalPreKey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SignalPreKeysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _preKeyIdMeta = const VerificationMeta(
    'preKeyId',
  );
  @override
  late final GeneratedColumn<int> preKeyId = GeneratedColumn<int>(
    'pre_key_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preKeyRecordMeta = const VerificationMeta(
    'preKeyRecord',
  );
  @override
  late final GeneratedColumn<Uint8List> preKeyRecord =
      GeneratedColumn<Uint8List>(
        'pre_key_record',
        aliasedName,
        false,
        type: DriftSqlType.blob,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [preKeyId, preKeyRecord];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'signal_pre_keys';
  @override
  VerificationContext validateIntegrity(
    Insertable<SignalPreKey> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pre_key_id')) {
      context.handle(
        _preKeyIdMeta,
        preKeyId.isAcceptableOrUnknown(data['pre_key_id']!, _preKeyIdMeta),
      );
    }
    if (data.containsKey('pre_key_record')) {
      context.handle(
        _preKeyRecordMeta,
        preKeyRecord.isAcceptableOrUnknown(
          data['pre_key_record']!,
          _preKeyRecordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preKeyRecordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {preKeyId};
  @override
  SignalPreKey map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SignalPreKey(
      preKeyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pre_key_id'],
      )!,
      preKeyRecord: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}pre_key_record'],
      )!,
    );
  }

  @override
  $SignalPreKeysTable createAlias(String alias) {
    return $SignalPreKeysTable(attachedDatabase, alias);
  }
}

class SignalPreKey extends DataClass implements Insertable<SignalPreKey> {
  final int preKeyId;
  final Uint8List preKeyRecord;
  const SignalPreKey({required this.preKeyId, required this.preKeyRecord});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pre_key_id'] = Variable<int>(preKeyId);
    map['pre_key_record'] = Variable<Uint8List>(preKeyRecord);
    return map;
  }

  SignalPreKeysCompanion toCompanion(bool nullToAbsent) {
    return SignalPreKeysCompanion(
      preKeyId: Value(preKeyId),
      preKeyRecord: Value(preKeyRecord),
    );
  }

  factory SignalPreKey.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SignalPreKey(
      preKeyId: serializer.fromJson<int>(json['preKeyId']),
      preKeyRecord: serializer.fromJson<Uint8List>(json['preKeyRecord']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'preKeyId': serializer.toJson<int>(preKeyId),
      'preKeyRecord': serializer.toJson<Uint8List>(preKeyRecord),
    };
  }

  SignalPreKey copyWith({int? preKeyId, Uint8List? preKeyRecord}) =>
      SignalPreKey(
        preKeyId: preKeyId ?? this.preKeyId,
        preKeyRecord: preKeyRecord ?? this.preKeyRecord,
      );
  SignalPreKey copyWithCompanion(SignalPreKeysCompanion data) {
    return SignalPreKey(
      preKeyId: data.preKeyId.present ? data.preKeyId.value : this.preKeyId,
      preKeyRecord: data.preKeyRecord.present
          ? data.preKeyRecord.value
          : this.preKeyRecord,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SignalPreKey(')
          ..write('preKeyId: $preKeyId, ')
          ..write('preKeyRecord: $preKeyRecord')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(preKeyId, $driftBlobEquality.hash(preKeyRecord));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignalPreKey &&
          other.preKeyId == this.preKeyId &&
          $driftBlobEquality.equals(other.preKeyRecord, this.preKeyRecord));
}

class SignalPreKeysCompanion extends UpdateCompanion<SignalPreKey> {
  final Value<int> preKeyId;
  final Value<Uint8List> preKeyRecord;
  const SignalPreKeysCompanion({
    this.preKeyId = const Value.absent(),
    this.preKeyRecord = const Value.absent(),
  });
  SignalPreKeysCompanion.insert({
    this.preKeyId = const Value.absent(),
    required Uint8List preKeyRecord,
  }) : preKeyRecord = Value(preKeyRecord);
  static Insertable<SignalPreKey> custom({
    Expression<int>? preKeyId,
    Expression<Uint8List>? preKeyRecord,
  }) {
    return RawValuesInsertable({
      if (preKeyId != null) 'pre_key_id': preKeyId,
      if (preKeyRecord != null) 'pre_key_record': preKeyRecord,
    });
  }

  SignalPreKeysCompanion copyWith({
    Value<int>? preKeyId,
    Value<Uint8List>? preKeyRecord,
  }) {
    return SignalPreKeysCompanion(
      preKeyId: preKeyId ?? this.preKeyId,
      preKeyRecord: preKeyRecord ?? this.preKeyRecord,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (preKeyId.present) {
      map['pre_key_id'] = Variable<int>(preKeyId.value);
    }
    if (preKeyRecord.present) {
      map['pre_key_record'] = Variable<Uint8List>(preKeyRecord.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SignalPreKeysCompanion(')
          ..write('preKeyId: $preKeyId, ')
          ..write('preKeyRecord: $preKeyRecord')
          ..write(')'))
        .toString();
  }
}

class $SignalSignedPreKeysTable extends SignalSignedPreKeys
    with TableInfo<$SignalSignedPreKeysTable, SignalSignedPreKey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SignalSignedPreKeysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _signedPreKeyIdMeta = const VerificationMeta(
    'signedPreKeyId',
  );
  @override
  late final GeneratedColumn<int> signedPreKeyId = GeneratedColumn<int>(
    'signed_pre_key_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _signedPreKeyRecordMeta =
      const VerificationMeta('signedPreKeyRecord');
  @override
  late final GeneratedColumn<Uint8List> signedPreKeyRecord =
      GeneratedColumn<Uint8List>(
        'signed_pre_key_record',
        aliasedName,
        false,
        type: DriftSqlType.blob,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [signedPreKeyId, signedPreKeyRecord];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'signal_signed_pre_keys';
  @override
  VerificationContext validateIntegrity(
    Insertable<SignalSignedPreKey> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('signed_pre_key_id')) {
      context.handle(
        _signedPreKeyIdMeta,
        signedPreKeyId.isAcceptableOrUnknown(
          data['signed_pre_key_id']!,
          _signedPreKeyIdMeta,
        ),
      );
    }
    if (data.containsKey('signed_pre_key_record')) {
      context.handle(
        _signedPreKeyRecordMeta,
        signedPreKeyRecord.isAcceptableOrUnknown(
          data['signed_pre_key_record']!,
          _signedPreKeyRecordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_signedPreKeyRecordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {signedPreKeyId};
  @override
  SignalSignedPreKey map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SignalSignedPreKey(
      signedPreKeyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}signed_pre_key_id'],
      )!,
      signedPreKeyRecord: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}signed_pre_key_record'],
      )!,
    );
  }

  @override
  $SignalSignedPreKeysTable createAlias(String alias) {
    return $SignalSignedPreKeysTable(attachedDatabase, alias);
  }
}

class SignalSignedPreKey extends DataClass
    implements Insertable<SignalSignedPreKey> {
  final int signedPreKeyId;
  final Uint8List signedPreKeyRecord;
  const SignalSignedPreKey({
    required this.signedPreKeyId,
    required this.signedPreKeyRecord,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['signed_pre_key_id'] = Variable<int>(signedPreKeyId);
    map['signed_pre_key_record'] = Variable<Uint8List>(signedPreKeyRecord);
    return map;
  }

  SignalSignedPreKeysCompanion toCompanion(bool nullToAbsent) {
    return SignalSignedPreKeysCompanion(
      signedPreKeyId: Value(signedPreKeyId),
      signedPreKeyRecord: Value(signedPreKeyRecord),
    );
  }

  factory SignalSignedPreKey.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SignalSignedPreKey(
      signedPreKeyId: serializer.fromJson<int>(json['signedPreKeyId']),
      signedPreKeyRecord: serializer.fromJson<Uint8List>(
        json['signedPreKeyRecord'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'signedPreKeyId': serializer.toJson<int>(signedPreKeyId),
      'signedPreKeyRecord': serializer.toJson<Uint8List>(signedPreKeyRecord),
    };
  }

  SignalSignedPreKey copyWith({
    int? signedPreKeyId,
    Uint8List? signedPreKeyRecord,
  }) => SignalSignedPreKey(
    signedPreKeyId: signedPreKeyId ?? this.signedPreKeyId,
    signedPreKeyRecord: signedPreKeyRecord ?? this.signedPreKeyRecord,
  );
  SignalSignedPreKey copyWithCompanion(SignalSignedPreKeysCompanion data) {
    return SignalSignedPreKey(
      signedPreKeyId: data.signedPreKeyId.present
          ? data.signedPreKeyId.value
          : this.signedPreKeyId,
      signedPreKeyRecord: data.signedPreKeyRecord.present
          ? data.signedPreKeyRecord.value
          : this.signedPreKeyRecord,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SignalSignedPreKey(')
          ..write('signedPreKeyId: $signedPreKeyId, ')
          ..write('signedPreKeyRecord: $signedPreKeyRecord')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(signedPreKeyId, $driftBlobEquality.hash(signedPreKeyRecord));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignalSignedPreKey &&
          other.signedPreKeyId == this.signedPreKeyId &&
          $driftBlobEquality.equals(
            other.signedPreKeyRecord,
            this.signedPreKeyRecord,
          ));
}

class SignalSignedPreKeysCompanion extends UpdateCompanion<SignalSignedPreKey> {
  final Value<int> signedPreKeyId;
  final Value<Uint8List> signedPreKeyRecord;
  const SignalSignedPreKeysCompanion({
    this.signedPreKeyId = const Value.absent(),
    this.signedPreKeyRecord = const Value.absent(),
  });
  SignalSignedPreKeysCompanion.insert({
    this.signedPreKeyId = const Value.absent(),
    required Uint8List signedPreKeyRecord,
  }) : signedPreKeyRecord = Value(signedPreKeyRecord);
  static Insertable<SignalSignedPreKey> custom({
    Expression<int>? signedPreKeyId,
    Expression<Uint8List>? signedPreKeyRecord,
  }) {
    return RawValuesInsertable({
      if (signedPreKeyId != null) 'signed_pre_key_id': signedPreKeyId,
      if (signedPreKeyRecord != null)
        'signed_pre_key_record': signedPreKeyRecord,
    });
  }

  SignalSignedPreKeysCompanion copyWith({
    Value<int>? signedPreKeyId,
    Value<Uint8List>? signedPreKeyRecord,
  }) {
    return SignalSignedPreKeysCompanion(
      signedPreKeyId: signedPreKeyId ?? this.signedPreKeyId,
      signedPreKeyRecord: signedPreKeyRecord ?? this.signedPreKeyRecord,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (signedPreKeyId.present) {
      map['signed_pre_key_id'] = Variable<int>(signedPreKeyId.value);
    }
    if (signedPreKeyRecord.present) {
      map['signed_pre_key_record'] = Variable<Uint8List>(
        signedPreKeyRecord.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SignalSignedPreKeysCompanion(')
          ..write('signedPreKeyId: $signedPreKeyId, ')
          ..write('signedPreKeyRecord: $signedPreKeyRecord')
          ..write(')'))
        .toString();
  }
}

class $SignalIdentitiesTable extends SignalIdentities
    with TableInfo<$SignalIdentitiesTable, SignalIdentity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SignalIdentitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _addressNameMeta = const VerificationMeta(
    'addressName',
  );
  @override
  late final GeneratedColumn<String> addressName = GeneratedColumn<String>(
    'address_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _registrationIdMeta = const VerificationMeta(
    'registrationId',
  );
  @override
  late final GeneratedColumn<int> registrationId = GeneratedColumn<int>(
    'registration_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _identityKeyMeta = const VerificationMeta(
    'identityKey',
  );
  @override
  late final GeneratedColumn<Uint8List> identityKey =
      GeneratedColumn<Uint8List>(
        'identity_key',
        aliasedName,
        true,
        type: DriftSqlType.blob,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    addressName,
    registrationId,
    identityKey,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'signal_identities';
  @override
  VerificationContext validateIntegrity(
    Insertable<SignalIdentity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('address_name')) {
      context.handle(
        _addressNameMeta,
        addressName.isAcceptableOrUnknown(
          data['address_name']!,
          _addressNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_addressNameMeta);
    }
    if (data.containsKey('registration_id')) {
      context.handle(
        _registrationIdMeta,
        registrationId.isAcceptableOrUnknown(
          data['registration_id']!,
          _registrationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_registrationIdMeta);
    }
    if (data.containsKey('identity_key')) {
      context.handle(
        _identityKeyMeta,
        identityKey.isAcceptableOrUnknown(
          data['identity_key']!,
          _identityKeyMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {addressName};
  @override
  SignalIdentity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SignalIdentity(
      addressName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_name'],
      )!,
      registrationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}registration_id'],
      )!,
      identityKey: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}identity_key'],
      ),
    );
  }

  @override
  $SignalIdentitiesTable createAlias(String alias) {
    return $SignalIdentitiesTable(attachedDatabase, alias);
  }
}

class SignalIdentity extends DataClass implements Insertable<SignalIdentity> {
  final String addressName;
  final int registrationId;
  final Uint8List? identityKey;
  const SignalIdentity({
    required this.addressName,
    required this.registrationId,
    this.identityKey,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['address_name'] = Variable<String>(addressName);
    map['registration_id'] = Variable<int>(registrationId);
    if (!nullToAbsent || identityKey != null) {
      map['identity_key'] = Variable<Uint8List>(identityKey);
    }
    return map;
  }

  SignalIdentitiesCompanion toCompanion(bool nullToAbsent) {
    return SignalIdentitiesCompanion(
      addressName: Value(addressName),
      registrationId: Value(registrationId),
      identityKey: identityKey == null && nullToAbsent
          ? const Value.absent()
          : Value(identityKey),
    );
  }

  factory SignalIdentity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SignalIdentity(
      addressName: serializer.fromJson<String>(json['addressName']),
      registrationId: serializer.fromJson<int>(json['registrationId']),
      identityKey: serializer.fromJson<Uint8List?>(json['identityKey']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'addressName': serializer.toJson<String>(addressName),
      'registrationId': serializer.toJson<int>(registrationId),
      'identityKey': serializer.toJson<Uint8List?>(identityKey),
    };
  }

  SignalIdentity copyWith({
    String? addressName,
    int? registrationId,
    Value<Uint8List?> identityKey = const Value.absent(),
  }) => SignalIdentity(
    addressName: addressName ?? this.addressName,
    registrationId: registrationId ?? this.registrationId,
    identityKey: identityKey.present ? identityKey.value : this.identityKey,
  );
  SignalIdentity copyWithCompanion(SignalIdentitiesCompanion data) {
    return SignalIdentity(
      addressName: data.addressName.present
          ? data.addressName.value
          : this.addressName,
      registrationId: data.registrationId.present
          ? data.registrationId.value
          : this.registrationId,
      identityKey: data.identityKey.present
          ? data.identityKey.value
          : this.identityKey,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SignalIdentity(')
          ..write('addressName: $addressName, ')
          ..write('registrationId: $registrationId, ')
          ..write('identityKey: $identityKey')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    addressName,
    registrationId,
    $driftBlobEquality.hash(identityKey),
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignalIdentity &&
          other.addressName == this.addressName &&
          other.registrationId == this.registrationId &&
          $driftBlobEquality.equals(other.identityKey, this.identityKey));
}

class SignalIdentitiesCompanion extends UpdateCompanion<SignalIdentity> {
  final Value<String> addressName;
  final Value<int> registrationId;
  final Value<Uint8List?> identityKey;
  final Value<int> rowid;
  const SignalIdentitiesCompanion({
    this.addressName = const Value.absent(),
    this.registrationId = const Value.absent(),
    this.identityKey = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SignalIdentitiesCompanion.insert({
    required String addressName,
    required int registrationId,
    this.identityKey = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : addressName = Value(addressName),
       registrationId = Value(registrationId);
  static Insertable<SignalIdentity> custom({
    Expression<String>? addressName,
    Expression<int>? registrationId,
    Expression<Uint8List>? identityKey,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (addressName != null) 'address_name': addressName,
      if (registrationId != null) 'registration_id': registrationId,
      if (identityKey != null) 'identity_key': identityKey,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SignalIdentitiesCompanion copyWith({
    Value<String>? addressName,
    Value<int>? registrationId,
    Value<Uint8List?>? identityKey,
    Value<int>? rowid,
  }) {
    return SignalIdentitiesCompanion(
      addressName: addressName ?? this.addressName,
      registrationId: registrationId ?? this.registrationId,
      identityKey: identityKey ?? this.identityKey,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (addressName.present) {
      map['address_name'] = Variable<String>(addressName.value);
    }
    if (registrationId.present) {
      map['registration_id'] = Variable<int>(registrationId.value);
    }
    if (identityKey.present) {
      map['identity_key'] = Variable<Uint8List>(identityKey.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SignalIdentitiesCompanion(')
          ..write('addressName: $addressName, ')
          ..write('registrationId: $registrationId, ')
          ..write('identityKey: $identityKey, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ChatsTable chats = $ChatsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $SignalSessionsTable signalSessions = $SignalSessionsTable(this);
  late final $SignalPreKeysTable signalPreKeys = $SignalPreKeysTable(this);
  late final $SignalSignedPreKeysTable signalSignedPreKeys =
      $SignalSignedPreKeysTable(this);
  late final $SignalIdentitiesTable signalIdentities = $SignalIdentitiesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    chats,
    messages,
    signalSessions,
    signalPreKeys,
    signalSignedPreKeys,
    signalIdentities,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      Value<String?> name,
      Value<String?> username,
      required String phone,
      Value<String?> avatarUrl,
      Value<bool> isMe,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String?> name,
      Value<String?> username,
      Value<String> phone,
      Value<String?> avatarUrl,
      Value<bool> isMe,
      Value<int> rowid,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChatsTable, List<Chat>> _chatsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.chats,
    aliasName: $_aliasNameGenerator(db.users.id, db.chats.contactId),
  );

  $$ChatsTableProcessedTableManager get chatsRefs {
    final manager = $$ChatsTableTableManager(
      $_db,
      $_db.chats,
    ).filter((f) => f.contactId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MessagesTable, List<Message>> _messagesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.messages,
    aliasName: $_aliasNameGenerator(db.users.id, db.messages.senderId),
  );

  $$MessagesTableProcessedTableManager get messagesRefs {
    final manager = $$MessagesTableTableManager(
      $_db,
      $_db.messages,
    ).filter((f) => f.senderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_messagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMe => $composableBuilder(
    column: $table.isMe,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> chatsRefs(
    Expression<bool> Function($$ChatsTableFilterComposer f) f,
  ) {
    final $$ChatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chats,
      getReferencedColumn: (t) => t.contactId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableFilterComposer(
            $db: $db,
            $table: $db.chats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> messagesRefs(
    Expression<bool> Function($$MessagesTableFilterComposer f) f,
  ) {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.senderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableFilterComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMe => $composableBuilder(
    column: $table.isMe,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<bool> get isMe =>
      $composableBuilder(column: $table.isMe, builder: (column) => column);

  Expression<T> chatsRefs<T extends Object>(
    Expression<T> Function($$ChatsTableAnnotationComposer a) f,
  ) {
    final $$ChatsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chats,
      getReferencedColumn: (t) => t.contactId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableAnnotationComposer(
            $db: $db,
            $table: $db.chats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> messagesRefs<T extends Object>(
    Expression<T> Function($$MessagesTableAnnotationComposer a) f,
  ) {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.senderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool chatsRefs, bool messagesRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<bool> isMe = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                username: username,
                phone: phone,
                avatarUrl: avatarUrl,
                isMe: isMe,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> name = const Value.absent(),
                Value<String?> username = const Value.absent(),
                required String phone,
                Value<String?> avatarUrl = const Value.absent(),
                Value<bool> isMe = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                username: username,
                phone: phone,
                avatarUrl: avatarUrl,
                isMe: isMe,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({chatsRefs = false, messagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (chatsRefs) db.chats,
                if (messagesRefs) db.messages,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chatsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Chat>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences._chatsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).chatsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.contactId == item.id),
                      typedResults: items,
                    ),
                  if (messagesRefs)
                    await $_getPrefetchedData<User, $UsersTable, Message>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._messagesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).messagesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.senderId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool chatsRefs, bool messagesRefs})
    >;
typedef $$ChatsTableCreateCompanionBuilder =
    ChatsCompanion Function({
      required String id,
      Value<String?> contactId,
      Value<String?> title,
      Value<ChatType> type,
      Value<String?> lastMessage,
      Value<int?> lastMessageTimestamp,
      Value<int> unreadCount,
      Value<bool> isVerified,
      Value<bool> isPinned,
      Value<bool> isArchived,
      Value<int> rowid,
    });
typedef $$ChatsTableUpdateCompanionBuilder =
    ChatsCompanion Function({
      Value<String> id,
      Value<String?> contactId,
      Value<String?> title,
      Value<ChatType> type,
      Value<String?> lastMessage,
      Value<int?> lastMessageTimestamp,
      Value<int> unreadCount,
      Value<bool> isVerified,
      Value<bool> isPinned,
      Value<bool> isArchived,
      Value<int> rowid,
    });

final class $$ChatsTableReferences
    extends BaseReferences<_$AppDatabase, $ChatsTable, Chat> {
  $$ChatsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _contactIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.chats.contactId, db.users.id),
  );

  $$UsersTableProcessedTableManager? get contactId {
    final $_column = $_itemColumn<String>('contact_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MessagesTable, List<Message>> _messagesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.messages,
    aliasName: $_aliasNameGenerator(db.chats.id, db.messages.chatId),
  );

  $$MessagesTableProcessedTableManager get messagesRefs {
    final manager = $$MessagesTableTableManager(
      $_db,
      $_db.messages,
    ).filter((f) => f.chatId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_messagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChatsTableFilterComposer extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ChatType, ChatType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastMessageTimestamp => $composableBuilder(
    column: $table.lastMessageTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get contactId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> messagesRefs(
    Expression<bool> Function($$MessagesTableFilterComposer f) f,
  ) {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.chatId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableFilterComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChatsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastMessageTimestamp => $composableBuilder(
    column: $table.lastMessageTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get contactId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ChatType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastMessageTimestamp => $composableBuilder(
    column: $table.lastMessageTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get contactId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> messagesRefs<T extends Object>(
    Expression<T> Function($$MessagesTableAnnotationComposer a) f,
  ) {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.chatId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatsTable,
          Chat,
          $$ChatsTableFilterComposer,
          $$ChatsTableOrderingComposer,
          $$ChatsTableAnnotationComposer,
          $$ChatsTableCreateCompanionBuilder,
          $$ChatsTableUpdateCompanionBuilder,
          (Chat, $$ChatsTableReferences),
          Chat,
          PrefetchHooks Function({bool contactId, bool messagesRefs})
        > {
  $$ChatsTableTableManager(_$AppDatabase db, $ChatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> contactId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<ChatType> type = const Value.absent(),
                Value<String?> lastMessage = const Value.absent(),
                Value<int?> lastMessageTimestamp = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<bool> isPinned = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatsCompanion(
                id: id,
                contactId: contactId,
                title: title,
                type: type,
                lastMessage: lastMessage,
                lastMessageTimestamp: lastMessageTimestamp,
                unreadCount: unreadCount,
                isVerified: isVerified,
                isPinned: isPinned,
                isArchived: isArchived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> contactId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<ChatType> type = const Value.absent(),
                Value<String?> lastMessage = const Value.absent(),
                Value<int?> lastMessageTimestamp = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<bool> isPinned = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatsCompanion.insert(
                id: id,
                contactId: contactId,
                title: title,
                type: type,
                lastMessage: lastMessage,
                lastMessageTimestamp: lastMessageTimestamp,
                unreadCount: unreadCount,
                isVerified: isVerified,
                isPinned: isPinned,
                isArchived: isArchived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ChatsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({contactId = false, messagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (messagesRefs) db.messages],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (contactId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.contactId,
                                referencedTable: $$ChatsTableReferences
                                    ._contactIdTable(db),
                                referencedColumn: $$ChatsTableReferences
                                    ._contactIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (messagesRefs)
                    await $_getPrefetchedData<Chat, $ChatsTable, Message>(
                      currentTable: table,
                      referencedTable: $$ChatsTableReferences
                          ._messagesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ChatsTableReferences(db, table, p0).messagesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.chatId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ChatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatsTable,
      Chat,
      $$ChatsTableFilterComposer,
      $$ChatsTableOrderingComposer,
      $$ChatsTableAnnotationComposer,
      $$ChatsTableCreateCompanionBuilder,
      $$ChatsTableUpdateCompanionBuilder,
      (Chat, $$ChatsTableReferences),
      Chat,
      PrefetchHooks Function({bool contactId, bool messagesRefs})
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      required String id,
      required String chatId,
      required String senderId,
      required String textContent,
      Value<MessageType> type,
      Value<String?> attachmentUrl,
      Value<String?> attachmentAesKey,
      Value<String?> attachmentMacKey,
      required int timestamp,
      Value<MessageStatus> status,
      required bool isFromMe,
      Value<int> rowid,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<String> id,
      Value<String> chatId,
      Value<String> senderId,
      Value<String> textContent,
      Value<MessageType> type,
      Value<String?> attachmentUrl,
      Value<String?> attachmentAesKey,
      Value<String?> attachmentMacKey,
      Value<int> timestamp,
      Value<MessageStatus> status,
      Value<bool> isFromMe,
      Value<int> rowid,
    });

final class $$MessagesTableReferences
    extends BaseReferences<_$AppDatabase, $MessagesTable, Message> {
  $$MessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChatsTable _chatIdTable(_$AppDatabase db) => db.chats.createAlias(
    $_aliasNameGenerator(db.messages.chatId, db.chats.id),
  );

  $$ChatsTableProcessedTableManager get chatId {
    final $_column = $_itemColumn<String>('chat_id')!;

    final manager = $$ChatsTableTableManager(
      $_db,
      $_db.chats,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _senderIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.messages.senderId, db.users.id),
  );

  $$UsersTableProcessedTableManager get senderId {
    final $_column = $_itemColumn<String>('sender_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_senderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MessageType, MessageType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get attachmentUrl => $composableBuilder(
    column: $table.attachmentUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentAesKey => $composableBuilder(
    column: $table.attachmentAesKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentMacKey => $composableBuilder(
    column: $table.attachmentMacKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MessageStatus, MessageStatus, int>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isFromMe => $composableBuilder(
    column: $table.isFromMe,
    builder: (column) => ColumnFilters(column),
  );

  $$ChatsTableFilterComposer get chatId {
    final $$ChatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableFilterComposer(
            $db: $db,
            $table: $db.chats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get senderId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senderId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentUrl => $composableBuilder(
    column: $table.attachmentUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentAesKey => $composableBuilder(
    column: $table.attachmentAesKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentMacKey => $composableBuilder(
    column: $table.attachmentMacKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFromMe => $composableBuilder(
    column: $table.isFromMe,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChatsTableOrderingComposer get chatId {
    final $$ChatsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableOrderingComposer(
            $db: $db,
            $table: $db.chats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get senderId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senderId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<MessageType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get attachmentUrl => $composableBuilder(
    column: $table.attachmentUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachmentAesKey => $composableBuilder(
    column: $table.attachmentAesKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachmentMacKey => $composableBuilder(
    column: $table.attachmentMacKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MessageStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isFromMe =>
      $composableBuilder(column: $table.isFromMe, builder: (column) => column);

  $$ChatsTableAnnotationComposer get chatId {
    final $$ChatsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chatId,
      referencedTable: $db.chats,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableAnnotationComposer(
            $db: $db,
            $table: $db.chats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get senderId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senderId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, $$MessagesTableReferences),
          Message,
          PrefetchHooks Function({bool chatId, bool senderId})
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> chatId = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<MessageType> type = const Value.absent(),
                Value<String?> attachmentUrl = const Value.absent(),
                Value<String?> attachmentAesKey = const Value.absent(),
                Value<String?> attachmentMacKey = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<MessageStatus> status = const Value.absent(),
                Value<bool> isFromMe = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                chatId: chatId,
                senderId: senderId,
                textContent: textContent,
                type: type,
                attachmentUrl: attachmentUrl,
                attachmentAesKey: attachmentAesKey,
                attachmentMacKey: attachmentMacKey,
                timestamp: timestamp,
                status: status,
                isFromMe: isFromMe,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String chatId,
                required String senderId,
                required String textContent,
                Value<MessageType> type = const Value.absent(),
                Value<String?> attachmentUrl = const Value.absent(),
                Value<String?> attachmentAesKey = const Value.absent(),
                Value<String?> attachmentMacKey = const Value.absent(),
                required int timestamp,
                Value<MessageStatus> status = const Value.absent(),
                required bool isFromMe,
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                chatId: chatId,
                senderId: senderId,
                textContent: textContent,
                type: type,
                attachmentUrl: attachmentUrl,
                attachmentAesKey: attachmentAesKey,
                attachmentMacKey: attachmentMacKey,
                timestamp: timestamp,
                status: status,
                isFromMe: isFromMe,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({chatId = false, senderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (chatId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.chatId,
                                referencedTable: $$MessagesTableReferences
                                    ._chatIdTable(db),
                                referencedColumn: $$MessagesTableReferences
                                    ._chatIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (senderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.senderId,
                                referencedTable: $$MessagesTableReferences
                                    ._senderIdTable(db),
                                referencedColumn: $$MessagesTableReferences
                                    ._senderIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, $$MessagesTableReferences),
      Message,
      PrefetchHooks Function({bool chatId, bool senderId})
    >;
typedef $$SignalSessionsTableCreateCompanionBuilder =
    SignalSessionsCompanion Function({
      required String addressName,
      required int deviceId,
      required Uint8List sessionRecord,
      Value<int> rowid,
    });
typedef $$SignalSessionsTableUpdateCompanionBuilder =
    SignalSessionsCompanion Function({
      Value<String> addressName,
      Value<int> deviceId,
      Value<Uint8List> sessionRecord,
      Value<int> rowid,
    });

class $$SignalSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SignalSessionsTable> {
  $$SignalSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get addressName => $composableBuilder(
    column: $table.addressName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get sessionRecord => $composableBuilder(
    column: $table.sessionRecord,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SignalSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SignalSessionsTable> {
  $$SignalSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get addressName => $composableBuilder(
    column: $table.addressName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get sessionRecord => $composableBuilder(
    column: $table.sessionRecord,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SignalSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SignalSessionsTable> {
  $$SignalSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get addressName => $composableBuilder(
    column: $table.addressName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<Uint8List> get sessionRecord => $composableBuilder(
    column: $table.sessionRecord,
    builder: (column) => column,
  );
}

class $$SignalSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SignalSessionsTable,
          SignalSession,
          $$SignalSessionsTableFilterComposer,
          $$SignalSessionsTableOrderingComposer,
          $$SignalSessionsTableAnnotationComposer,
          $$SignalSessionsTableCreateCompanionBuilder,
          $$SignalSessionsTableUpdateCompanionBuilder,
          (
            SignalSession,
            BaseReferences<_$AppDatabase, $SignalSessionsTable, SignalSession>,
          ),
          SignalSession,
          PrefetchHooks Function()
        > {
  $$SignalSessionsTableTableManager(
    _$AppDatabase db,
    $SignalSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SignalSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SignalSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SignalSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> addressName = const Value.absent(),
                Value<int> deviceId = const Value.absent(),
                Value<Uint8List> sessionRecord = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SignalSessionsCompanion(
                addressName: addressName,
                deviceId: deviceId,
                sessionRecord: sessionRecord,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String addressName,
                required int deviceId,
                required Uint8List sessionRecord,
                Value<int> rowid = const Value.absent(),
              }) => SignalSessionsCompanion.insert(
                addressName: addressName,
                deviceId: deviceId,
                sessionRecord: sessionRecord,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SignalSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SignalSessionsTable,
      SignalSession,
      $$SignalSessionsTableFilterComposer,
      $$SignalSessionsTableOrderingComposer,
      $$SignalSessionsTableAnnotationComposer,
      $$SignalSessionsTableCreateCompanionBuilder,
      $$SignalSessionsTableUpdateCompanionBuilder,
      (
        SignalSession,
        BaseReferences<_$AppDatabase, $SignalSessionsTable, SignalSession>,
      ),
      SignalSession,
      PrefetchHooks Function()
    >;
typedef $$SignalPreKeysTableCreateCompanionBuilder =
    SignalPreKeysCompanion Function({
      Value<int> preKeyId,
      required Uint8List preKeyRecord,
    });
typedef $$SignalPreKeysTableUpdateCompanionBuilder =
    SignalPreKeysCompanion Function({
      Value<int> preKeyId,
      Value<Uint8List> preKeyRecord,
    });

class $$SignalPreKeysTableFilterComposer
    extends Composer<_$AppDatabase, $SignalPreKeysTable> {
  $$SignalPreKeysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get preKeyId => $composableBuilder(
    column: $table.preKeyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get preKeyRecord => $composableBuilder(
    column: $table.preKeyRecord,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SignalPreKeysTableOrderingComposer
    extends Composer<_$AppDatabase, $SignalPreKeysTable> {
  $$SignalPreKeysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get preKeyId => $composableBuilder(
    column: $table.preKeyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get preKeyRecord => $composableBuilder(
    column: $table.preKeyRecord,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SignalPreKeysTableAnnotationComposer
    extends Composer<_$AppDatabase, $SignalPreKeysTable> {
  $$SignalPreKeysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get preKeyId =>
      $composableBuilder(column: $table.preKeyId, builder: (column) => column);

  GeneratedColumn<Uint8List> get preKeyRecord => $composableBuilder(
    column: $table.preKeyRecord,
    builder: (column) => column,
  );
}

class $$SignalPreKeysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SignalPreKeysTable,
          SignalPreKey,
          $$SignalPreKeysTableFilterComposer,
          $$SignalPreKeysTableOrderingComposer,
          $$SignalPreKeysTableAnnotationComposer,
          $$SignalPreKeysTableCreateCompanionBuilder,
          $$SignalPreKeysTableUpdateCompanionBuilder,
          (
            SignalPreKey,
            BaseReferences<_$AppDatabase, $SignalPreKeysTable, SignalPreKey>,
          ),
          SignalPreKey,
          PrefetchHooks Function()
        > {
  $$SignalPreKeysTableTableManager(_$AppDatabase db, $SignalPreKeysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SignalPreKeysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SignalPreKeysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SignalPreKeysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> preKeyId = const Value.absent(),
                Value<Uint8List> preKeyRecord = const Value.absent(),
              }) => SignalPreKeysCompanion(
                preKeyId: preKeyId,
                preKeyRecord: preKeyRecord,
              ),
          createCompanionCallback:
              ({
                Value<int> preKeyId = const Value.absent(),
                required Uint8List preKeyRecord,
              }) => SignalPreKeysCompanion.insert(
                preKeyId: preKeyId,
                preKeyRecord: preKeyRecord,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SignalPreKeysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SignalPreKeysTable,
      SignalPreKey,
      $$SignalPreKeysTableFilterComposer,
      $$SignalPreKeysTableOrderingComposer,
      $$SignalPreKeysTableAnnotationComposer,
      $$SignalPreKeysTableCreateCompanionBuilder,
      $$SignalPreKeysTableUpdateCompanionBuilder,
      (
        SignalPreKey,
        BaseReferences<_$AppDatabase, $SignalPreKeysTable, SignalPreKey>,
      ),
      SignalPreKey,
      PrefetchHooks Function()
    >;
typedef $$SignalSignedPreKeysTableCreateCompanionBuilder =
    SignalSignedPreKeysCompanion Function({
      Value<int> signedPreKeyId,
      required Uint8List signedPreKeyRecord,
    });
typedef $$SignalSignedPreKeysTableUpdateCompanionBuilder =
    SignalSignedPreKeysCompanion Function({
      Value<int> signedPreKeyId,
      Value<Uint8List> signedPreKeyRecord,
    });

class $$SignalSignedPreKeysTableFilterComposer
    extends Composer<_$AppDatabase, $SignalSignedPreKeysTable> {
  $$SignalSignedPreKeysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get signedPreKeyId => $composableBuilder(
    column: $table.signedPreKeyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get signedPreKeyRecord => $composableBuilder(
    column: $table.signedPreKeyRecord,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SignalSignedPreKeysTableOrderingComposer
    extends Composer<_$AppDatabase, $SignalSignedPreKeysTable> {
  $$SignalSignedPreKeysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get signedPreKeyId => $composableBuilder(
    column: $table.signedPreKeyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get signedPreKeyRecord => $composableBuilder(
    column: $table.signedPreKeyRecord,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SignalSignedPreKeysTableAnnotationComposer
    extends Composer<_$AppDatabase, $SignalSignedPreKeysTable> {
  $$SignalSignedPreKeysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get signedPreKeyId => $composableBuilder(
    column: $table.signedPreKeyId,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get signedPreKeyRecord => $composableBuilder(
    column: $table.signedPreKeyRecord,
    builder: (column) => column,
  );
}

class $$SignalSignedPreKeysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SignalSignedPreKeysTable,
          SignalSignedPreKey,
          $$SignalSignedPreKeysTableFilterComposer,
          $$SignalSignedPreKeysTableOrderingComposer,
          $$SignalSignedPreKeysTableAnnotationComposer,
          $$SignalSignedPreKeysTableCreateCompanionBuilder,
          $$SignalSignedPreKeysTableUpdateCompanionBuilder,
          (
            SignalSignedPreKey,
            BaseReferences<
              _$AppDatabase,
              $SignalSignedPreKeysTable,
              SignalSignedPreKey
            >,
          ),
          SignalSignedPreKey,
          PrefetchHooks Function()
        > {
  $$SignalSignedPreKeysTableTableManager(
    _$AppDatabase db,
    $SignalSignedPreKeysTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SignalSignedPreKeysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SignalSignedPreKeysTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SignalSignedPreKeysTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> signedPreKeyId = const Value.absent(),
                Value<Uint8List> signedPreKeyRecord = const Value.absent(),
              }) => SignalSignedPreKeysCompanion(
                signedPreKeyId: signedPreKeyId,
                signedPreKeyRecord: signedPreKeyRecord,
              ),
          createCompanionCallback:
              ({
                Value<int> signedPreKeyId = const Value.absent(),
                required Uint8List signedPreKeyRecord,
              }) => SignalSignedPreKeysCompanion.insert(
                signedPreKeyId: signedPreKeyId,
                signedPreKeyRecord: signedPreKeyRecord,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SignalSignedPreKeysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SignalSignedPreKeysTable,
      SignalSignedPreKey,
      $$SignalSignedPreKeysTableFilterComposer,
      $$SignalSignedPreKeysTableOrderingComposer,
      $$SignalSignedPreKeysTableAnnotationComposer,
      $$SignalSignedPreKeysTableCreateCompanionBuilder,
      $$SignalSignedPreKeysTableUpdateCompanionBuilder,
      (
        SignalSignedPreKey,
        BaseReferences<
          _$AppDatabase,
          $SignalSignedPreKeysTable,
          SignalSignedPreKey
        >,
      ),
      SignalSignedPreKey,
      PrefetchHooks Function()
    >;
typedef $$SignalIdentitiesTableCreateCompanionBuilder =
    SignalIdentitiesCompanion Function({
      required String addressName,
      required int registrationId,
      Value<Uint8List?> identityKey,
      Value<int> rowid,
    });
typedef $$SignalIdentitiesTableUpdateCompanionBuilder =
    SignalIdentitiesCompanion Function({
      Value<String> addressName,
      Value<int> registrationId,
      Value<Uint8List?> identityKey,
      Value<int> rowid,
    });

class $$SignalIdentitiesTableFilterComposer
    extends Composer<_$AppDatabase, $SignalIdentitiesTable> {
  $$SignalIdentitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get addressName => $composableBuilder(
    column: $table.addressName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get registrationId => $composableBuilder(
    column: $table.registrationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SignalIdentitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $SignalIdentitiesTable> {
  $$SignalIdentitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get addressName => $composableBuilder(
    column: $table.addressName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get registrationId => $composableBuilder(
    column: $table.registrationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SignalIdentitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SignalIdentitiesTable> {
  $$SignalIdentitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get addressName => $composableBuilder(
    column: $table.addressName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get registrationId => $composableBuilder(
    column: $table.registrationId,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => column,
  );
}

class $$SignalIdentitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SignalIdentitiesTable,
          SignalIdentity,
          $$SignalIdentitiesTableFilterComposer,
          $$SignalIdentitiesTableOrderingComposer,
          $$SignalIdentitiesTableAnnotationComposer,
          $$SignalIdentitiesTableCreateCompanionBuilder,
          $$SignalIdentitiesTableUpdateCompanionBuilder,
          (
            SignalIdentity,
            BaseReferences<
              _$AppDatabase,
              $SignalIdentitiesTable,
              SignalIdentity
            >,
          ),
          SignalIdentity,
          PrefetchHooks Function()
        > {
  $$SignalIdentitiesTableTableManager(
    _$AppDatabase db,
    $SignalIdentitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SignalIdentitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SignalIdentitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SignalIdentitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> addressName = const Value.absent(),
                Value<int> registrationId = const Value.absent(),
                Value<Uint8List?> identityKey = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SignalIdentitiesCompanion(
                addressName: addressName,
                registrationId: registrationId,
                identityKey: identityKey,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String addressName,
                required int registrationId,
                Value<Uint8List?> identityKey = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SignalIdentitiesCompanion.insert(
                addressName: addressName,
                registrationId: registrationId,
                identityKey: identityKey,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SignalIdentitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SignalIdentitiesTable,
      SignalIdentity,
      $$SignalIdentitiesTableFilterComposer,
      $$SignalIdentitiesTableOrderingComposer,
      $$SignalIdentitiesTableAnnotationComposer,
      $$SignalIdentitiesTableCreateCompanionBuilder,
      $$SignalIdentitiesTableUpdateCompanionBuilder,
      (
        SignalIdentity,
        BaseReferences<_$AppDatabase, $SignalIdentitiesTable, SignalIdentity>,
      ),
      SignalIdentity,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ChatsTableTableManager get chats =>
      $$ChatsTableTableManager(_db, _db.chats);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$SignalSessionsTableTableManager get signalSessions =>
      $$SignalSessionsTableTableManager(_db, _db.signalSessions);
  $$SignalPreKeysTableTableManager get signalPreKeys =>
      $$SignalPreKeysTableTableManager(_db, _db.signalPreKeys);
  $$SignalSignedPreKeysTableTableManager get signalSignedPreKeys =>
      $$SignalSignedPreKeysTableTableManager(_db, _db.signalSignedPreKeys);
  $$SignalIdentitiesTableTableManager get signalIdentities =>
      $$SignalIdentitiesTableTableManager(_db, _db.signalIdentities);
}
