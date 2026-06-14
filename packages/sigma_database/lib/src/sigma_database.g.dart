// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sigma_database.dart';

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
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _isBotMeta = const VerificationMeta('isBot');
  @override
  late final GeneratedColumn<bool> isBot = GeneratedColumn<bool>(
    'is_bot',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_bot" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phone,
    name,
    username,
    email,
    bio,
    avatarUrl,
    isBot,
    createdAt,
    updatedAt,
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
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
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
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('bio')) {
      context.handle(
        _bioMeta,
        bio.isAcceptableOrUnknown(data['bio']!, _bioMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('is_bot')) {
      context.handle(
        _isBotMeta,
        isBot.isAcceptableOrUnknown(data['is_bot']!, _isBotMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
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
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      isBot: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_bot'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String? phone;
  final String? name;
  final String? username;
  final String? email;
  final String? bio;
  final String? avatarUrl;
  final bool isBot;
  final int? createdAt;
  final int? updatedAt;
  const User({
    required this.id,
    this.phone,
    this.name,
    this.username,
    this.email,
    this.bio,
    this.avatarUrl,
    required this.isBot,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['is_bot'] = Variable<bool>(isBot);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      isBot: Value(isBot),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      phone: serializer.fromJson<String?>(json['phone']),
      name: serializer.fromJson<String?>(json['name']),
      username: serializer.fromJson<String?>(json['username']),
      email: serializer.fromJson<String?>(json['email']),
      bio: serializer.fromJson<String?>(json['bio']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      isBot: serializer.fromJson<bool>(json['isBot']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phone': serializer.toJson<String?>(phone),
      'name': serializer.toJson<String?>(name),
      'username': serializer.toJson<String?>(username),
      'email': serializer.toJson<String?>(email),
      'bio': serializer.toJson<String?>(bio),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'isBot': serializer.toJson<bool>(isBot),
      'createdAt': serializer.toJson<int?>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  User copyWith({
    String? id,
    Value<String?> phone = const Value.absent(),
    Value<String?> name = const Value.absent(),
    Value<String?> username = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> bio = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    bool? isBot,
    Value<int?> createdAt = const Value.absent(),
    Value<int?> updatedAt = const Value.absent(),
  }) => User(
    id: id ?? this.id,
    phone: phone.present ? phone.value : this.phone,
    name: name.present ? name.value : this.name,
    username: username.present ? username.value : this.username,
    email: email.present ? email.value : this.email,
    bio: bio.present ? bio.value : this.bio,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    isBot: isBot ?? this.isBot,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      phone: data.phone.present ? data.phone.value : this.phone,
      name: data.name.present ? data.name.value : this.name,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      bio: data.bio.present ? data.bio.value : this.bio,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      isBot: data.isBot.present ? data.isBot.value : this.isBot,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('phone: $phone, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('bio: $bio, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('isBot: $isBot, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phone,
    name,
    username,
    email,
    bio,
    avatarUrl,
    isBot,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.phone == this.phone &&
          other.name == this.name &&
          other.username == this.username &&
          other.email == this.email &&
          other.bio == this.bio &&
          other.avatarUrl == this.avatarUrl &&
          other.isBot == this.isBot &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String?> phone;
  final Value<String?> name;
  final Value<String?> username;
  final Value<String?> email;
  final Value<String?> bio;
  final Value<String?> avatarUrl;
  final Value<bool> isBot;
  final Value<int?> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.phone = const Value.absent(),
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.bio = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.isBot = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.phone = const Value.absent(),
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.bio = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.isBot = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? phone,
    Expression<String>? name,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? bio,
    Expression<String>? avatarUrl,
    Expression<bool>? isBot,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phone != null) 'phone': phone,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (bio != null) 'bio': bio,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (isBot != null) 'is_bot': isBot,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String?>? phone,
    Value<String?>? name,
    Value<String?>? username,
    Value<String?>? email,
    Value<String?>? bio,
    Value<String?>? avatarUrl,
    Value<bool>? isBot,
    Value<int?>? createdAt,
    Value<int?>? updatedAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isBot: isBot ?? this.isBot,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (isBot.present) {
      map['is_bot'] = Variable<bool>(isBot.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
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
          ..write('phone: $phone, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('bio: $bio, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('isBot: $isBot, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    email,
    passwordHash,
    isVerified,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      ),
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final String id;
  final String? userId;
  final String? email;
  final String? passwordHash;
  final bool isVerified;
  final int? createdAt;
  const Account({
    required this.id,
    this.userId,
    this.email,
    this.passwordHash,
    required this.isVerified,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || passwordHash != null) {
      map['password_hash'] = Variable<String>(passwordHash);
    }
    map['is_verified'] = Variable<bool>(isVerified);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      passwordHash: passwordHash == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordHash),
      isVerified: Value(isVerified),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory Account.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      email: serializer.fromJson<String?>(json['email']),
      passwordHash: serializer.fromJson<String?>(json['passwordHash']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'email': serializer.toJson<String?>(email),
      'passwordHash': serializer.toJson<String?>(passwordHash),
      'isVerified': serializer.toJson<bool>(isVerified),
      'createdAt': serializer.toJson<int?>(createdAt),
    };
  }

  Account copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> passwordHash = const Value.absent(),
    bool? isVerified,
    Value<int?> createdAt = const Value.absent(),
  }) => Account(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    email: email.present ? email.value : this.email,
    passwordHash: passwordHash.present ? passwordHash.value : this.passwordHash,
    isVerified: isVerified ?? this.isVerified,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, email, passwordHash, isVerified, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.isVerified == this.isVerified &&
          other.createdAt == this.createdAt);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<String?> email;
  final Value<String?> passwordHash;
  final Value<bool> isVerified;
  final Value<int?> createdAt;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Account> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<bool>? isVerified,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (isVerified != null) 'is_verified': isVerified,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<String?>? email,
    Value<String?>? passwordHash,
    Value<bool>? isVerified,
    Value<int?>? createdAt,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DevicesTable extends Devices with TableInfo<$DevicesTable, Device> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceNameMeta = const VerificationMeta(
    'deviceName',
  );
  @override
  late final GeneratedColumn<String> deviceName = GeneratedColumn<String>(
    'device_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceTypeMeta = const VerificationMeta(
    'deviceType',
  );
  @override
  late final GeneratedColumn<String> deviceType = GeneratedColumn<String>(
    'device_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _osMeta = const VerificationMeta('os');
  @override
  late final GeneratedColumn<String> os = GeneratedColumn<String>(
    'os',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pushTokenMeta = const VerificationMeta(
    'pushToken',
  );
  @override
  late final GeneratedColumn<String> pushToken = GeneratedColumn<String>(
    'push_token',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSeenMeta = const VerificationMeta(
    'lastSeen',
  );
  @override
  late final GeneratedColumn<int> lastSeen = GeneratedColumn<int>(
    'last_seen',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    deviceName,
    deviceType,
    os,
    pushToken,
    lastSeen,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Device> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('device_name')) {
      context.handle(
        _deviceNameMeta,
        deviceName.isAcceptableOrUnknown(data['device_name']!, _deviceNameMeta),
      );
    }
    if (data.containsKey('device_type')) {
      context.handle(
        _deviceTypeMeta,
        deviceType.isAcceptableOrUnknown(data['device_type']!, _deviceTypeMeta),
      );
    }
    if (data.containsKey('os')) {
      context.handle(_osMeta, os.isAcceptableOrUnknown(data['os']!, _osMeta));
    }
    if (data.containsKey('push_token')) {
      context.handle(
        _pushTokenMeta,
        pushToken.isAcceptableOrUnknown(data['push_token']!, _pushTokenMeta),
      );
    }
    if (data.containsKey('last_seen')) {
      context.handle(
        _lastSeenMeta,
        lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Device map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Device(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      deviceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_name'],
      ),
      deviceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_type'],
      ),
      os: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}os'],
      ),
      pushToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}push_token'],
      ),
      lastSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_seen'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $DevicesTable createAlias(String alias) {
    return $DevicesTable(attachedDatabase, alias);
  }
}

class Device extends DataClass implements Insertable<Device> {
  final String id;
  final String? userId;
  final String? deviceName;
  final String? deviceType;
  final String? os;
  final String? pushToken;
  final int? lastSeen;
  final bool isActive;
  final int? createdAt;
  const Device({
    required this.id,
    this.userId,
    this.deviceName,
    this.deviceType,
    this.os,
    this.pushToken,
    this.lastSeen,
    required this.isActive,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || deviceName != null) {
      map['device_name'] = Variable<String>(deviceName);
    }
    if (!nullToAbsent || deviceType != null) {
      map['device_type'] = Variable<String>(deviceType);
    }
    if (!nullToAbsent || os != null) {
      map['os'] = Variable<String>(os);
    }
    if (!nullToAbsent || pushToken != null) {
      map['push_token'] = Variable<String>(pushToken);
    }
    if (!nullToAbsent || lastSeen != null) {
      map['last_seen'] = Variable<int>(lastSeen);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    return map;
  }

  DevicesCompanion toCompanion(bool nullToAbsent) {
    return DevicesCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      deviceName: deviceName == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceName),
      deviceType: deviceType == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceType),
      os: os == null && nullToAbsent ? const Value.absent() : Value(os),
      pushToken: pushToken == null && nullToAbsent
          ? const Value.absent()
          : Value(pushToken),
      lastSeen: lastSeen == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeen),
      isActive: Value(isActive),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory Device.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Device(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      deviceName: serializer.fromJson<String?>(json['deviceName']),
      deviceType: serializer.fromJson<String?>(json['deviceType']),
      os: serializer.fromJson<String?>(json['os']),
      pushToken: serializer.fromJson<String?>(json['pushToken']),
      lastSeen: serializer.fromJson<int?>(json['lastSeen']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'deviceName': serializer.toJson<String?>(deviceName),
      'deviceType': serializer.toJson<String?>(deviceType),
      'os': serializer.toJson<String?>(os),
      'pushToken': serializer.toJson<String?>(pushToken),
      'lastSeen': serializer.toJson<int?>(lastSeen),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<int?>(createdAt),
    };
  }

  Device copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    Value<String?> deviceName = const Value.absent(),
    Value<String?> deviceType = const Value.absent(),
    Value<String?> os = const Value.absent(),
    Value<String?> pushToken = const Value.absent(),
    Value<int?> lastSeen = const Value.absent(),
    bool? isActive,
    Value<int?> createdAt = const Value.absent(),
  }) => Device(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    deviceName: deviceName.present ? deviceName.value : this.deviceName,
    deviceType: deviceType.present ? deviceType.value : this.deviceType,
    os: os.present ? os.value : this.os,
    pushToken: pushToken.present ? pushToken.value : this.pushToken,
    lastSeen: lastSeen.present ? lastSeen.value : this.lastSeen,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  Device copyWithCompanion(DevicesCompanion data) {
    return Device(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      deviceName: data.deviceName.present
          ? data.deviceName.value
          : this.deviceName,
      deviceType: data.deviceType.present
          ? data.deviceType.value
          : this.deviceType,
      os: data.os.present ? data.os.value : this.os,
      pushToken: data.pushToken.present ? data.pushToken.value : this.pushToken,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Device(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('deviceName: $deviceName, ')
          ..write('deviceType: $deviceType, ')
          ..write('os: $os, ')
          ..write('pushToken: $pushToken, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    deviceName,
    deviceType,
    os,
    pushToken,
    lastSeen,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Device &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.deviceName == this.deviceName &&
          other.deviceType == this.deviceType &&
          other.os == this.os &&
          other.pushToken == this.pushToken &&
          other.lastSeen == this.lastSeen &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class DevicesCompanion extends UpdateCompanion<Device> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<String?> deviceName;
  final Value<String?> deviceType;
  final Value<String?> os;
  final Value<String?> pushToken;
  final Value<int?> lastSeen;
  final Value<bool> isActive;
  final Value<int?> createdAt;
  final Value<int> rowid;
  const DevicesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.deviceType = const Value.absent(),
    this.os = const Value.absent(),
    this.pushToken = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DevicesCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.deviceType = const Value.absent(),
    this.os = const Value.absent(),
    this.pushToken = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Device> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? deviceName,
    Expression<String>? deviceType,
    Expression<String>? os,
    Expression<String>? pushToken,
    Expression<int>? lastSeen,
    Expression<bool>? isActive,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (deviceName != null) 'device_name': deviceName,
      if (deviceType != null) 'device_type': deviceType,
      if (os != null) 'os': os,
      if (pushToken != null) 'push_token': pushToken,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DevicesCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<String?>? deviceName,
    Value<String?>? deviceType,
    Value<String?>? os,
    Value<String?>? pushToken,
    Value<int?>? lastSeen,
    Value<bool>? isActive,
    Value<int?>? createdAt,
    Value<int>? rowid,
  }) {
    return DevicesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      deviceName: deviceName ?? this.deviceName,
      deviceType: deviceType ?? this.deviceType,
      os: os ?? this.os,
      pushToken: pushToken ?? this.pushToken,
      lastSeen: lastSeen ?? this.lastSeen,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (deviceName.present) {
      map['device_name'] = Variable<String>(deviceName.value);
    }
    if (deviceType.present) {
      map['device_type'] = Variable<String>(deviceType.value);
    }
    if (os.present) {
      map['os'] = Variable<String>(os.value);
    }
    if (pushToken.present) {
      map['push_token'] = Variable<String>(pushToken.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<int>(lastSeen.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('deviceName: $deviceName, ')
          ..write('deviceType: $deviceType, ')
          ..write('os: $os, ')
          ..write('pushToken: $pushToken, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConversationsTable extends Conversations
    with TableInfo<$ConversationsTable, Conversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageIdMeta = const VerificationMeta(
    'lastMessageId',
  );
  @override
  late final GeneratedColumn<String> lastMessageId = GeneratedColumn<String>(
    'last_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isMutedMeta = const VerificationMeta(
    'isMuted',
  );
  @override
  late final GeneratedColumn<bool> isMuted = GeneratedColumn<bool>(
    'is_muted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_muted" IN (0, 1))',
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
    type,
    title,
    avatar,
    lastMessageId,
    unreadCount,
    updatedAt,
    isMuted,
    isPinned,
    isArchived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Conversation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('avatar')) {
      context.handle(
        _avatarMeta,
        avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta),
      );
    }
    if (data.containsKey('last_message_id')) {
      context.handle(
        _lastMessageIdMeta,
        lastMessageId.isAcceptableOrUnknown(
          data['last_message_id']!,
          _lastMessageIdMeta,
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
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_muted')) {
      context.handle(
        _isMutedMeta,
        isMuted.isAcceptableOrUnknown(data['is_muted']!, _isMutedMeta),
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
  Conversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Conversation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      ),
      lastMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_id'],
      ),
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      ),
      isMuted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_muted'],
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
  $ConversationsTable createAlias(String alias) {
    return $ConversationsTable(attachedDatabase, alias);
  }
}

class Conversation extends DataClass implements Insertable<Conversation> {
  final String id;
  final String? type;
  final String? title;
  final String? avatar;
  final String? lastMessageId;
  final int unreadCount;
  final int? updatedAt;
  final bool isMuted;
  final bool isPinned;
  final bool isArchived;
  const Conversation({
    required this.id,
    this.type,
    this.title,
    this.avatar,
    this.lastMessageId,
    required this.unreadCount,
    this.updatedAt,
    required this.isMuted,
    required this.isPinned,
    required this.isArchived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    if (!nullToAbsent || lastMessageId != null) {
      map['last_message_id'] = Variable<String>(lastMessageId);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    map['is_muted'] = Variable<bool>(isMuted);
    map['is_pinned'] = Variable<bool>(isPinned);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  ConversationsCompanion toCompanion(bool nullToAbsent) {
    return ConversationsCompanion(
      id: Value(id),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      avatar: avatar == null && nullToAbsent
          ? const Value.absent()
          : Value(avatar),
      lastMessageId: lastMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageId),
      unreadCount: Value(unreadCount),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isMuted: Value(isMuted),
      isPinned: Value(isPinned),
      isArchived: Value(isArchived),
    );
  }

  factory Conversation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Conversation(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String?>(json['type']),
      title: serializer.fromJson<String?>(json['title']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      lastMessageId: serializer.fromJson<String?>(json['lastMessageId']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
      isMuted: serializer.fromJson<bool>(json['isMuted']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String?>(type),
      'title': serializer.toJson<String?>(title),
      'avatar': serializer.toJson<String?>(avatar),
      'lastMessageId': serializer.toJson<String?>(lastMessageId),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'updatedAt': serializer.toJson<int?>(updatedAt),
      'isMuted': serializer.toJson<bool>(isMuted),
      'isPinned': serializer.toJson<bool>(isPinned),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  Conversation copyWith({
    String? id,
    Value<String?> type = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<String?> avatar = const Value.absent(),
    Value<String?> lastMessageId = const Value.absent(),
    int? unreadCount,
    Value<int?> updatedAt = const Value.absent(),
    bool? isMuted,
    bool? isPinned,
    bool? isArchived,
  }) => Conversation(
    id: id ?? this.id,
    type: type.present ? type.value : this.type,
    title: title.present ? title.value : this.title,
    avatar: avatar.present ? avatar.value : this.avatar,
    lastMessageId: lastMessageId.present
        ? lastMessageId.value
        : this.lastMessageId,
    unreadCount: unreadCount ?? this.unreadCount,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    isMuted: isMuted ?? this.isMuted,
    isPinned: isPinned ?? this.isPinned,
    isArchived: isArchived ?? this.isArchived,
  );
  Conversation copyWithCompanion(ConversationsCompanion data) {
    return Conversation(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      lastMessageId: data.lastMessageId.present
          ? data.lastMessageId.value
          : this.lastMessageId,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isMuted: data.isMuted.present ? data.isMuted.value : this.isMuted,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Conversation(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('avatar: $avatar, ')
          ..write('lastMessageId: $lastMessageId, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isMuted: $isMuted, ')
          ..write('isPinned: $isPinned, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    title,
    avatar,
    lastMessageId,
    unreadCount,
    updatedAt,
    isMuted,
    isPinned,
    isArchived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Conversation &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.avatar == this.avatar &&
          other.lastMessageId == this.lastMessageId &&
          other.unreadCount == this.unreadCount &&
          other.updatedAt == this.updatedAt &&
          other.isMuted == this.isMuted &&
          other.isPinned == this.isPinned &&
          other.isArchived == this.isArchived);
}

class ConversationsCompanion extends UpdateCompanion<Conversation> {
  final Value<String> id;
  final Value<String?> type;
  final Value<String?> title;
  final Value<String?> avatar;
  final Value<String?> lastMessageId;
  final Value<int> unreadCount;
  final Value<int?> updatedAt;
  final Value<bool> isMuted;
  final Value<bool> isPinned;
  final Value<bool> isArchived;
  final Value<int> rowid;
  const ConversationsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.avatar = const Value.absent(),
    this.lastMessageId = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isMuted = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationsCompanion.insert({
    required String id,
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.avatar = const Value.absent(),
    this.lastMessageId = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isMuted = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Conversation> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? avatar,
    Expression<String>? lastMessageId,
    Expression<int>? unreadCount,
    Expression<int>? updatedAt,
    Expression<bool>? isMuted,
    Expression<bool>? isPinned,
    Expression<bool>? isArchived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (avatar != null) 'avatar': avatar,
      if (lastMessageId != null) 'last_message_id': lastMessageId,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isMuted != null) 'is_muted': isMuted,
      if (isPinned != null) 'is_pinned': isPinned,
      if (isArchived != null) 'is_archived': isArchived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationsCompanion copyWith({
    Value<String>? id,
    Value<String?>? type,
    Value<String?>? title,
    Value<String?>? avatar,
    Value<String?>? lastMessageId,
    Value<int>? unreadCount,
    Value<int?>? updatedAt,
    Value<bool>? isMuted,
    Value<bool>? isPinned,
    Value<bool>? isArchived,
    Value<int>? rowid,
  }) {
    return ConversationsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      avatar: avatar ?? this.avatar,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      unreadCount: unreadCount ?? this.unreadCount,
      updatedAt: updatedAt ?? this.updatedAt,
      isMuted: isMuted ?? this.isMuted,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (lastMessageId.present) {
      map['last_message_id'] = Variable<String>(lastMessageId.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (isMuted.present) {
      map['is_muted'] = Variable<bool>(isMuted.value);
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
    return (StringBuffer('ConversationsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('avatar: $avatar, ')
          ..write('lastMessageId: $lastMessageId, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isMuted: $isMuted, ')
          ..write('isPinned: $isPinned, ')
          ..write('isArchived: $isArchived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConversationMembersTable extends ConversationMembers
    with TableInfo<$ConversationMembersTable, ConversationMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _joinedAtMeta = const VerificationMeta(
    'joinedAt',
  );
  @override
  late final GeneratedColumn<int> joinedAt = GeneratedColumn<int>(
    'joined_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conversationId,
    userId,
    role,
    joinedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversation_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConversationMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('joined_at')) {
      context.handle(
        _joinedAtMeta,
        joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConversationMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConversationMember(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      ),
      joinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}joined_at'],
      ),
    );
  }

  @override
  $ConversationMembersTable createAlias(String alias) {
    return $ConversationMembersTable(attachedDatabase, alias);
  }
}

class ConversationMember extends DataClass
    implements Insertable<ConversationMember> {
  final String id;
  final String? conversationId;
  final String? userId;
  final String? role;
  final int? joinedAt;
  const ConversationMember({
    required this.id,
    this.conversationId,
    this.userId,
    this.role,
    this.joinedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || conversationId != null) {
      map['conversation_id'] = Variable<String>(conversationId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    if (!nullToAbsent || joinedAt != null) {
      map['joined_at'] = Variable<int>(joinedAt);
    }
    return map;
  }

  ConversationMembersCompanion toCompanion(bool nullToAbsent) {
    return ConversationMembersCompanion(
      id: Value(id),
      conversationId: conversationId == null && nullToAbsent
          ? const Value.absent()
          : Value(conversationId),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      joinedAt: joinedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(joinedAt),
    );
  }

  factory ConversationMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConversationMember(
      id: serializer.fromJson<String>(json['id']),
      conversationId: serializer.fromJson<String?>(json['conversationId']),
      userId: serializer.fromJson<String?>(json['userId']),
      role: serializer.fromJson<String?>(json['role']),
      joinedAt: serializer.fromJson<int?>(json['joinedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conversationId': serializer.toJson<String?>(conversationId),
      'userId': serializer.toJson<String?>(userId),
      'role': serializer.toJson<String?>(role),
      'joinedAt': serializer.toJson<int?>(joinedAt),
    };
  }

  ConversationMember copyWith({
    String? id,
    Value<String?> conversationId = const Value.absent(),
    Value<String?> userId = const Value.absent(),
    Value<String?> role = const Value.absent(),
    Value<int?> joinedAt = const Value.absent(),
  }) => ConversationMember(
    id: id ?? this.id,
    conversationId: conversationId.present
        ? conversationId.value
        : this.conversationId,
    userId: userId.present ? userId.value : this.userId,
    role: role.present ? role.value : this.role,
    joinedAt: joinedAt.present ? joinedAt.value : this.joinedAt,
  );
  ConversationMember copyWithCompanion(ConversationMembersCompanion data) {
    return ConversationMember(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConversationMember(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, conversationId, userId, role, joinedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversationMember &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.userId == this.userId &&
          other.role == this.role &&
          other.joinedAt == this.joinedAt);
}

class ConversationMembersCompanion extends UpdateCompanion<ConversationMember> {
  final Value<String> id;
  final Value<String?> conversationId;
  final Value<String?> userId;
  final Value<String?> role;
  final Value<int?> joinedAt;
  final Value<int> rowid;
  const ConversationMembersCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationMembersCompanion.insert({
    required String id,
    this.conversationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<ConversationMember> custom({
    Expression<String>? id,
    Expression<String>? conversationId,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<int>? joinedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationMembersCompanion copyWith({
    Value<String>? id,
    Value<String?>? conversationId,
    Value<String?>? userId,
    Value<String?>? role,
    Value<int?>? joinedAt,
    Value<int>? rowid,
  }) {
    return ConversationMembersCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<int>(joinedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationMembersCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt, ')
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
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _replyToMessageIdMeta = const VerificationMeta(
    'replyToMessageId',
  );
  @override
  late final GeneratedColumn<String> replyToMessageId = GeneratedColumn<String>(
    'reply_to_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conversationId,
    senderId,
    type,
    content,
    status,
    replyToMessageId,
    createdAt,
    updatedAt,
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
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('reply_to_message_id')) {
      context.handle(
        _replyToMessageIdMeta,
        replyToMessageId.isAcceptableOrUnknown(
          data['reply_to_message_id']!,
          _replyToMessageIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
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
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      ),
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      ),
      replyToMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reply_to_message_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final String id;
  final String? conversationId;
  final String? senderId;
  final String? type;
  final String? content;
  final String? status;
  final String? replyToMessageId;
  final int? createdAt;
  final int? updatedAt;
  const Message({
    required this.id,
    this.conversationId,
    this.senderId,
    this.type,
    this.content,
    this.status,
    this.replyToMessageId,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || conversationId != null) {
      map['conversation_id'] = Variable<String>(conversationId);
    }
    if (!nullToAbsent || senderId != null) {
      map['sender_id'] = Variable<String>(senderId);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || replyToMessageId != null) {
      map['reply_to_message_id'] = Variable<String>(replyToMessageId);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      conversationId: conversationId == null && nullToAbsent
          ? const Value.absent()
          : Value(conversationId),
      senderId: senderId == null && nullToAbsent
          ? const Value.absent()
          : Value(senderId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      status: status == null && nullToAbsent
          ? const Value.absent()
          : Value(status),
      replyToMessageId: replyToMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(replyToMessageId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<String>(json['id']),
      conversationId: serializer.fromJson<String?>(json['conversationId']),
      senderId: serializer.fromJson<String?>(json['senderId']),
      type: serializer.fromJson<String?>(json['type']),
      content: serializer.fromJson<String?>(json['content']),
      status: serializer.fromJson<String?>(json['status']),
      replyToMessageId: serializer.fromJson<String?>(json['replyToMessageId']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conversationId': serializer.toJson<String?>(conversationId),
      'senderId': serializer.toJson<String?>(senderId),
      'type': serializer.toJson<String?>(type),
      'content': serializer.toJson<String?>(content),
      'status': serializer.toJson<String?>(status),
      'replyToMessageId': serializer.toJson<String?>(replyToMessageId),
      'createdAt': serializer.toJson<int?>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  Message copyWith({
    String? id,
    Value<String?> conversationId = const Value.absent(),
    Value<String?> senderId = const Value.absent(),
    Value<String?> type = const Value.absent(),
    Value<String?> content = const Value.absent(),
    Value<String?> status = const Value.absent(),
    Value<String?> replyToMessageId = const Value.absent(),
    Value<int?> createdAt = const Value.absent(),
    Value<int?> updatedAt = const Value.absent(),
  }) => Message(
    id: id ?? this.id,
    conversationId: conversationId.present
        ? conversationId.value
        : this.conversationId,
    senderId: senderId.present ? senderId.value : this.senderId,
    type: type.present ? type.value : this.type,
    content: content.present ? content.value : this.content,
    status: status.present ? status.value : this.status,
    replyToMessageId: replyToMessageId.present
        ? replyToMessageId.value
        : this.replyToMessageId,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      status: data.status.present ? data.status.value : this.status,
      replyToMessageId: data.replyToMessageId.present
          ? data.replyToMessageId.value
          : this.replyToMessageId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('senderId: $senderId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('status: $status, ')
          ..write('replyToMessageId: $replyToMessageId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    conversationId,
    senderId,
    type,
    content,
    status,
    replyToMessageId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.senderId == this.senderId &&
          other.type == this.type &&
          other.content == this.content &&
          other.status == this.status &&
          other.replyToMessageId == this.replyToMessageId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> id;
  final Value<String?> conversationId;
  final Value<String?> senderId;
  final Value<String?> type;
  final Value<String?> content;
  final Value<String?> status;
  final Value<String?> replyToMessageId;
  final Value<int?> createdAt;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.status = const Value.absent(),
    this.replyToMessageId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String id,
    this.conversationId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.status = const Value.absent(),
    this.replyToMessageId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Message> custom({
    Expression<String>? id,
    Expression<String>? conversationId,
    Expression<String>? senderId,
    Expression<String>? type,
    Expression<String>? content,
    Expression<String>? status,
    Expression<String>? replyToMessageId,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (senderId != null) 'sender_id': senderId,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (status != null) 'status': status,
      if (replyToMessageId != null) 'reply_to_message_id': replyToMessageId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith({
    Value<String>? id,
    Value<String?>? conversationId,
    Value<String?>? senderId,
    Value<String?>? type,
    Value<String?>? content,
    Value<String?>? status,
    Value<String?>? replyToMessageId,
    Value<int?>? createdAt,
    Value<int?>? updatedAt,
    Value<int>? rowid,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      type: type ?? this.type,
      content: content ?? this.content,
      status: status ?? this.status,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (replyToMessageId.present) {
      map['reply_to_message_id'] = Variable<String>(replyToMessageId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
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
          ..write('conversationId: $conversationId, ')
          ..write('senderId: $senderId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('status: $status, ')
          ..write('replyToMessageId: $replyToMessageId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReactionsTable extends Reactions
    with TableInfo<$ReactionsTable, Reaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
    'emoji',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    userId,
    emoji,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('emoji')) {
      context.handle(
        _emojiMeta,
        emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      emoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emoji'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $ReactionsTable createAlias(String alias) {
    return $ReactionsTable(attachedDatabase, alias);
  }
}

class Reaction extends DataClass implements Insertable<Reaction> {
  final String id;
  final String? messageId;
  final String? userId;
  final String? emoji;
  final int? createdAt;
  const Reaction({
    required this.id,
    this.messageId,
    this.userId,
    this.emoji,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || messageId != null) {
      map['message_id'] = Variable<String>(messageId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || emoji != null) {
      map['emoji'] = Variable<String>(emoji);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    return map;
  }

  ReactionsCompanion toCompanion(bool nullToAbsent) {
    return ReactionsCompanion(
      id: Value(id),
      messageId: messageId == null && nullToAbsent
          ? const Value.absent()
          : Value(messageId),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      emoji: emoji == null && nullToAbsent
          ? const Value.absent()
          : Value(emoji),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory Reaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reaction(
      id: serializer.fromJson<String>(json['id']),
      messageId: serializer.fromJson<String?>(json['messageId']),
      userId: serializer.fromJson<String?>(json['userId']),
      emoji: serializer.fromJson<String?>(json['emoji']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'messageId': serializer.toJson<String?>(messageId),
      'userId': serializer.toJson<String?>(userId),
      'emoji': serializer.toJson<String?>(emoji),
      'createdAt': serializer.toJson<int?>(createdAt),
    };
  }

  Reaction copyWith({
    String? id,
    Value<String?> messageId = const Value.absent(),
    Value<String?> userId = const Value.absent(),
    Value<String?> emoji = const Value.absent(),
    Value<int?> createdAt = const Value.absent(),
  }) => Reaction(
    id: id ?? this.id,
    messageId: messageId.present ? messageId.value : this.messageId,
    userId: userId.present ? userId.value : this.userId,
    emoji: emoji.present ? emoji.value : this.emoji,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  Reaction copyWithCompanion(ReactionsCompanion data) {
    return Reaction(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      userId: data.userId.present ? data.userId.value : this.userId,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reaction(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('userId: $userId, ')
          ..write('emoji: $emoji, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, messageId, userId, emoji, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reaction &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.userId == this.userId &&
          other.emoji == this.emoji &&
          other.createdAt == this.createdAt);
}

class ReactionsCompanion extends UpdateCompanion<Reaction> {
  final Value<String> id;
  final Value<String?> messageId;
  final Value<String?> userId;
  final Value<String?> emoji;
  final Value<int?> createdAt;
  final Value<int> rowid;
  const ReactionsCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.userId = const Value.absent(),
    this.emoji = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReactionsCompanion.insert({
    required String id,
    this.messageId = const Value.absent(),
    this.userId = const Value.absent(),
    this.emoji = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Reaction> custom({
    Expression<String>? id,
    Expression<String>? messageId,
    Expression<String>? userId,
    Expression<String>? emoji,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (userId != null) 'user_id': userId,
      if (emoji != null) 'emoji': emoji,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReactionsCompanion copyWith({
    Value<String>? id,
    Value<String?>? messageId,
    Value<String?>? userId,
    Value<String?>? emoji,
    Value<int?>? createdAt,
    Value<int>? rowid,
  }) {
    return ReactionsCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      userId: userId ?? this.userId,
      emoji: emoji ?? this.emoji,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReactionsCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('userId: $userId, ')
          ..write('emoji: $emoji, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessageLocationsTable extends MessageLocations
    with TableInfo<$MessageLocationsTable, MessageLocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageLocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<double> accuracy = GeneratedColumn<double>(
    'accuracy',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isLiveMeta = const VerificationMeta('isLive');
  @override
  late final GeneratedColumn<bool> isLive = GeneratedColumn<bool>(
    'is_live',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_live" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    messageId,
    latitude,
    longitude,
    accuracy,
    isLive,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_locations';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageLocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    }
    if (data.containsKey('is_live')) {
      context.handle(
        _isLiveMeta,
        isLive.isAcceptableOrUnknown(data['is_live']!, _isLiveMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {messageId};
  @override
  MessageLocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageLocation(
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy'],
      ),
      isLive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_live'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $MessageLocationsTable createAlias(String alias) {
    return $MessageLocationsTable(attachedDatabase, alias);
  }
}

class MessageLocation extends DataClass implements Insertable<MessageLocation> {
  final String messageId;
  final double? latitude;
  final double? longitude;
  final double? accuracy;
  final bool isLive;
  final int? updatedAt;
  const MessageLocation({
    required this.messageId,
    this.latitude,
    this.longitude,
    this.accuracy,
    required this.isLive,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['message_id'] = Variable<String>(messageId);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<double>(accuracy);
    }
    map['is_live'] = Variable<bool>(isLive);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  MessageLocationsCompanion toCompanion(bool nullToAbsent) {
    return MessageLocationsCompanion(
      messageId: Value(messageId),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      isLive: Value(isLive),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory MessageLocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageLocation(
      messageId: serializer.fromJson<String>(json['messageId']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      accuracy: serializer.fromJson<double?>(json['accuracy']),
      isLive: serializer.fromJson<bool>(json['isLive']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'messageId': serializer.toJson<String>(messageId),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'accuracy': serializer.toJson<double?>(accuracy),
      'isLive': serializer.toJson<bool>(isLive),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  MessageLocation copyWith({
    String? messageId,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<double?> accuracy = const Value.absent(),
    bool? isLive,
    Value<int?> updatedAt = const Value.absent(),
  }) => MessageLocation(
    messageId: messageId ?? this.messageId,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    accuracy: accuracy.present ? accuracy.value : this.accuracy,
    isLive: isLive ?? this.isLive,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  MessageLocation copyWithCompanion(MessageLocationsCompanion data) {
    return MessageLocation(
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      isLive: data.isLive.present ? data.isLive.value : this.isLive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageLocation(')
          ..write('messageId: $messageId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('isLive: $isLive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(messageId, latitude, longitude, accuracy, isLive, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageLocation &&
          other.messageId == this.messageId &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accuracy == this.accuracy &&
          other.isLive == this.isLive &&
          other.updatedAt == this.updatedAt);
}

class MessageLocationsCompanion extends UpdateCompanion<MessageLocation> {
  final Value<String> messageId;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<double?> accuracy;
  final Value<bool> isLive;
  final Value<int?> updatedAt;
  final Value<int> rowid;
  const MessageLocationsCompanion({
    this.messageId = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.isLive = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessageLocationsCompanion.insert({
    required String messageId,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.isLive = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : messageId = Value(messageId);
  static Insertable<MessageLocation> custom({
    Expression<String>? messageId,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? accuracy,
    Expression<bool>? isLive,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (messageId != null) 'message_id': messageId,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (isLive != null) 'is_live': isLive,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessageLocationsCompanion copyWith({
    Value<String>? messageId,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<double?>? accuracy,
    Value<bool>? isLive,
    Value<int?>? updatedAt,
    Value<int>? rowid,
  }) {
    return MessageLocationsCompanion(
      messageId: messageId ?? this.messageId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      isLive: isLive ?? this.isLive,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<double>(accuracy.value);
    }
    if (isLive.present) {
      map['is_live'] = Variable<bool>(isLive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageLocationsCompanion(')
          ..write('messageId: $messageId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('isLive: $isLive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeliveryLogsTable extends DeliveryLogs
    with TableInfo<$DeliveryLogsTable, DeliveryLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeliveryLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
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
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    userId,
    status,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'delivery_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeliveryLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeliveryLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeliveryLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      ),
    );
  }

  @override
  $DeliveryLogsTable createAlias(String alias) {
    return $DeliveryLogsTable(attachedDatabase, alias);
  }
}

class DeliveryLog extends DataClass implements Insertable<DeliveryLog> {
  final String id;
  final String? messageId;
  final String? userId;
  final String? status;
  final int? timestamp;
  const DeliveryLog({
    required this.id,
    this.messageId,
    this.userId,
    this.status,
    this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || messageId != null) {
      map['message_id'] = Variable<String>(messageId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<int>(timestamp);
    }
    return map;
  }

  DeliveryLogsCompanion toCompanion(bool nullToAbsent) {
    return DeliveryLogsCompanion(
      id: Value(id),
      messageId: messageId == null && nullToAbsent
          ? const Value.absent()
          : Value(messageId),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      status: status == null && nullToAbsent
          ? const Value.absent()
          : Value(status),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
    );
  }

  factory DeliveryLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeliveryLog(
      id: serializer.fromJson<String>(json['id']),
      messageId: serializer.fromJson<String?>(json['messageId']),
      userId: serializer.fromJson<String?>(json['userId']),
      status: serializer.fromJson<String?>(json['status']),
      timestamp: serializer.fromJson<int?>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'messageId': serializer.toJson<String?>(messageId),
      'userId': serializer.toJson<String?>(userId),
      'status': serializer.toJson<String?>(status),
      'timestamp': serializer.toJson<int?>(timestamp),
    };
  }

  DeliveryLog copyWith({
    String? id,
    Value<String?> messageId = const Value.absent(),
    Value<String?> userId = const Value.absent(),
    Value<String?> status = const Value.absent(),
    Value<int?> timestamp = const Value.absent(),
  }) => DeliveryLog(
    id: id ?? this.id,
    messageId: messageId.present ? messageId.value : this.messageId,
    userId: userId.present ? userId.value : this.userId,
    status: status.present ? status.value : this.status,
    timestamp: timestamp.present ? timestamp.value : this.timestamp,
  );
  DeliveryLog copyWithCompanion(DeliveryLogsCompanion data) {
    return DeliveryLog(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      userId: data.userId.present ? data.userId.value : this.userId,
      status: data.status.present ? data.status.value : this.status,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryLog(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('userId: $userId, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, messageId, userId, status, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeliveryLog &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.userId == this.userId &&
          other.status == this.status &&
          other.timestamp == this.timestamp);
}

class DeliveryLogsCompanion extends UpdateCompanion<DeliveryLog> {
  final Value<String> id;
  final Value<String?> messageId;
  final Value<String?> userId;
  final Value<String?> status;
  final Value<int?> timestamp;
  final Value<int> rowid;
  const DeliveryLogsCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.userId = const Value.absent(),
    this.status = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeliveryLogsCompanion.insert({
    required String id,
    this.messageId = const Value.absent(),
    this.userId = const Value.absent(),
    this.status = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<DeliveryLog> custom({
    Expression<String>? id,
    Expression<String>? messageId,
    Expression<String>? userId,
    Expression<String>? status,
    Expression<int>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (userId != null) 'user_id': userId,
      if (status != null) 'status': status,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeliveryLogsCompanion copyWith({
    Value<String>? id,
    Value<String?>? messageId,
    Value<String?>? userId,
    Value<String?>? status,
    Value<int?>? timestamp,
    Value<int>? rowid,
  }) {
    return DeliveryLogsCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryLogsCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('userId: $userId, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PollsTable extends Polls with TableInfo<$PollsTable, Poll> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PollsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _multipleChoiceMeta = const VerificationMeta(
    'multipleChoice',
  );
  @override
  late final GeneratedColumn<bool> multipleChoice = GeneratedColumn<bool>(
    'multiple_choice',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("multiple_choice" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    question,
    multipleChoice,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'polls';
  @override
  VerificationContext validateIntegrity(
    Insertable<Poll> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    }
    if (data.containsKey('multiple_choice')) {
      context.handle(
        _multipleChoiceMeta,
        multipleChoice.isAcceptableOrUnknown(
          data['multiple_choice']!,
          _multipleChoiceMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Poll map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Poll(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      ),
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      ),
      multipleChoice: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}multiple_choice'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $PollsTable createAlias(String alias) {
    return $PollsTable(attachedDatabase, alias);
  }
}

class Poll extends DataClass implements Insertable<Poll> {
  final String id;
  final String? messageId;
  final String? question;
  final bool multipleChoice;
  final int? createdAt;
  const Poll({
    required this.id,
    this.messageId,
    this.question,
    required this.multipleChoice,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || messageId != null) {
      map['message_id'] = Variable<String>(messageId);
    }
    if (!nullToAbsent || question != null) {
      map['question'] = Variable<String>(question);
    }
    map['multiple_choice'] = Variable<bool>(multipleChoice);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    return map;
  }

  PollsCompanion toCompanion(bool nullToAbsent) {
    return PollsCompanion(
      id: Value(id),
      messageId: messageId == null && nullToAbsent
          ? const Value.absent()
          : Value(messageId),
      question: question == null && nullToAbsent
          ? const Value.absent()
          : Value(question),
      multipleChoice: Value(multipleChoice),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory Poll.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Poll(
      id: serializer.fromJson<String>(json['id']),
      messageId: serializer.fromJson<String?>(json['messageId']),
      question: serializer.fromJson<String?>(json['question']),
      multipleChoice: serializer.fromJson<bool>(json['multipleChoice']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'messageId': serializer.toJson<String?>(messageId),
      'question': serializer.toJson<String?>(question),
      'multipleChoice': serializer.toJson<bool>(multipleChoice),
      'createdAt': serializer.toJson<int?>(createdAt),
    };
  }

  Poll copyWith({
    String? id,
    Value<String?> messageId = const Value.absent(),
    Value<String?> question = const Value.absent(),
    bool? multipleChoice,
    Value<int?> createdAt = const Value.absent(),
  }) => Poll(
    id: id ?? this.id,
    messageId: messageId.present ? messageId.value : this.messageId,
    question: question.present ? question.value : this.question,
    multipleChoice: multipleChoice ?? this.multipleChoice,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  Poll copyWithCompanion(PollsCompanion data) {
    return Poll(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      question: data.question.present ? data.question.value : this.question,
      multipleChoice: data.multipleChoice.present
          ? data.multipleChoice.value
          : this.multipleChoice,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Poll(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('question: $question, ')
          ..write('multipleChoice: $multipleChoice, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, messageId, question, multipleChoice, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Poll &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.question == this.question &&
          other.multipleChoice == this.multipleChoice &&
          other.createdAt == this.createdAt);
}

class PollsCompanion extends UpdateCompanion<Poll> {
  final Value<String> id;
  final Value<String?> messageId;
  final Value<String?> question;
  final Value<bool> multipleChoice;
  final Value<int?> createdAt;
  final Value<int> rowid;
  const PollsCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.question = const Value.absent(),
    this.multipleChoice = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PollsCompanion.insert({
    required String id,
    this.messageId = const Value.absent(),
    this.question = const Value.absent(),
    this.multipleChoice = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Poll> custom({
    Expression<String>? id,
    Expression<String>? messageId,
    Expression<String>? question,
    Expression<bool>? multipleChoice,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (question != null) 'question': question,
      if (multipleChoice != null) 'multiple_choice': multipleChoice,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PollsCompanion copyWith({
    Value<String>? id,
    Value<String?>? messageId,
    Value<String?>? question,
    Value<bool>? multipleChoice,
    Value<int?>? createdAt,
    Value<int>? rowid,
  }) {
    return PollsCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      question: question ?? this.question,
      multipleChoice: multipleChoice ?? this.multipleChoice,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (multipleChoice.present) {
      map['multiple_choice'] = Variable<bool>(multipleChoice.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PollsCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('question: $question, ')
          ..write('multipleChoice: $multipleChoice, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PollOptionsTable extends PollOptions
    with TableInfo<$PollOptionsTable, PollOption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PollOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pollIdMeta = const VerificationMeta('pollId');
  @override
  late final GeneratedColumn<String> pollId = GeneratedColumn<String>(
    'poll_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text_content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voteCountMeta = const VerificationMeta(
    'voteCount',
  );
  @override
  late final GeneratedColumn<int> voteCount = GeneratedColumn<int>(
    'vote_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, pollId, textContent, voteCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'poll_options';
  @override
  VerificationContext validateIntegrity(
    Insertable<PollOption> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('poll_id')) {
      context.handle(
        _pollIdMeta,
        pollId.isAcceptableOrUnknown(data['poll_id']!, _pollIdMeta),
      );
    }
    if (data.containsKey('text_content')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(
          data['text_content']!,
          _textContentMeta,
        ),
      );
    }
    if (data.containsKey('vote_count')) {
      context.handle(
        _voteCountMeta,
        voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PollOption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PollOption(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pollId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poll_id'],
      ),
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      ),
      voteCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vote_count'],
      )!,
    );
  }

  @override
  $PollOptionsTable createAlias(String alias) {
    return $PollOptionsTable(attachedDatabase, alias);
  }
}

class PollOption extends DataClass implements Insertable<PollOption> {
  final String id;
  final String? pollId;
  final String? textContent;
  final int voteCount;
  const PollOption({
    required this.id,
    this.pollId,
    this.textContent,
    required this.voteCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || pollId != null) {
      map['poll_id'] = Variable<String>(pollId);
    }
    if (!nullToAbsent || textContent != null) {
      map['text_content'] = Variable<String>(textContent);
    }
    map['vote_count'] = Variable<int>(voteCount);
    return map;
  }

  PollOptionsCompanion toCompanion(bool nullToAbsent) {
    return PollOptionsCompanion(
      id: Value(id),
      pollId: pollId == null && nullToAbsent
          ? const Value.absent()
          : Value(pollId),
      textContent: textContent == null && nullToAbsent
          ? const Value.absent()
          : Value(textContent),
      voteCount: Value(voteCount),
    );
  }

  factory PollOption.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PollOption(
      id: serializer.fromJson<String>(json['id']),
      pollId: serializer.fromJson<String?>(json['pollId']),
      textContent: serializer.fromJson<String?>(json['textContent']),
      voteCount: serializer.fromJson<int>(json['voteCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pollId': serializer.toJson<String?>(pollId),
      'textContent': serializer.toJson<String?>(textContent),
      'voteCount': serializer.toJson<int>(voteCount),
    };
  }

  PollOption copyWith({
    String? id,
    Value<String?> pollId = const Value.absent(),
    Value<String?> textContent = const Value.absent(),
    int? voteCount,
  }) => PollOption(
    id: id ?? this.id,
    pollId: pollId.present ? pollId.value : this.pollId,
    textContent: textContent.present ? textContent.value : this.textContent,
    voteCount: voteCount ?? this.voteCount,
  );
  PollOption copyWithCompanion(PollOptionsCompanion data) {
    return PollOption(
      id: data.id.present ? data.id.value : this.id,
      pollId: data.pollId.present ? data.pollId.value : this.pollId,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      voteCount: data.voteCount.present ? data.voteCount.value : this.voteCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PollOption(')
          ..write('id: $id, ')
          ..write('pollId: $pollId, ')
          ..write('textContent: $textContent, ')
          ..write('voteCount: $voteCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pollId, textContent, voteCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PollOption &&
          other.id == this.id &&
          other.pollId == this.pollId &&
          other.textContent == this.textContent &&
          other.voteCount == this.voteCount);
}

class PollOptionsCompanion extends UpdateCompanion<PollOption> {
  final Value<String> id;
  final Value<String?> pollId;
  final Value<String?> textContent;
  final Value<int> voteCount;
  final Value<int> rowid;
  const PollOptionsCompanion({
    this.id = const Value.absent(),
    this.pollId = const Value.absent(),
    this.textContent = const Value.absent(),
    this.voteCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PollOptionsCompanion.insert({
    required String id,
    this.pollId = const Value.absent(),
    this.textContent = const Value.absent(),
    this.voteCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<PollOption> custom({
    Expression<String>? id,
    Expression<String>? pollId,
    Expression<String>? textContent,
    Expression<int>? voteCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pollId != null) 'poll_id': pollId,
      if (textContent != null) 'text_content': textContent,
      if (voteCount != null) 'vote_count': voteCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PollOptionsCompanion copyWith({
    Value<String>? id,
    Value<String?>? pollId,
    Value<String?>? textContent,
    Value<int>? voteCount,
    Value<int>? rowid,
  }) {
    return PollOptionsCompanion(
      id: id ?? this.id,
      pollId: pollId ?? this.pollId,
      textContent: textContent ?? this.textContent,
      voteCount: voteCount ?? this.voteCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pollId.present) {
      map['poll_id'] = Variable<String>(pollId.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PollOptionsCompanion(')
          ..write('id: $id, ')
          ..write('pollId: $pollId, ')
          ..write('textContent: $textContent, ')
          ..write('voteCount: $voteCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PollVotesTable extends PollVotes
    with TableInfo<$PollVotesTable, PollVote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PollVotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pollIdMeta = const VerificationMeta('pollId');
  @override
  late final GeneratedColumn<String> pollId = GeneratedColumn<String>(
    'poll_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _optionIdMeta = const VerificationMeta(
    'optionId',
  );
  @override
  late final GeneratedColumn<String> optionId = GeneratedColumn<String>(
    'option_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pollId,
    optionId,
    userId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'poll_votes';
  @override
  VerificationContext validateIntegrity(
    Insertable<PollVote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('poll_id')) {
      context.handle(
        _pollIdMeta,
        pollId.isAcceptableOrUnknown(data['poll_id']!, _pollIdMeta),
      );
    }
    if (data.containsKey('option_id')) {
      context.handle(
        _optionIdMeta,
        optionId.isAcceptableOrUnknown(data['option_id']!, _optionIdMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PollVote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PollVote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pollId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poll_id'],
      ),
      optionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}option_id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $PollVotesTable createAlias(String alias) {
    return $PollVotesTable(attachedDatabase, alias);
  }
}

class PollVote extends DataClass implements Insertable<PollVote> {
  final String id;
  final String? pollId;
  final String? optionId;
  final String? userId;
  final int? createdAt;
  const PollVote({
    required this.id,
    this.pollId,
    this.optionId,
    this.userId,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || pollId != null) {
      map['poll_id'] = Variable<String>(pollId);
    }
    if (!nullToAbsent || optionId != null) {
      map['option_id'] = Variable<String>(optionId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    return map;
  }

  PollVotesCompanion toCompanion(bool nullToAbsent) {
    return PollVotesCompanion(
      id: Value(id),
      pollId: pollId == null && nullToAbsent
          ? const Value.absent()
          : Value(pollId),
      optionId: optionId == null && nullToAbsent
          ? const Value.absent()
          : Value(optionId),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory PollVote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PollVote(
      id: serializer.fromJson<String>(json['id']),
      pollId: serializer.fromJson<String?>(json['pollId']),
      optionId: serializer.fromJson<String?>(json['optionId']),
      userId: serializer.fromJson<String?>(json['userId']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pollId': serializer.toJson<String?>(pollId),
      'optionId': serializer.toJson<String?>(optionId),
      'userId': serializer.toJson<String?>(userId),
      'createdAt': serializer.toJson<int?>(createdAt),
    };
  }

  PollVote copyWith({
    String? id,
    Value<String?> pollId = const Value.absent(),
    Value<String?> optionId = const Value.absent(),
    Value<String?> userId = const Value.absent(),
    Value<int?> createdAt = const Value.absent(),
  }) => PollVote(
    id: id ?? this.id,
    pollId: pollId.present ? pollId.value : this.pollId,
    optionId: optionId.present ? optionId.value : this.optionId,
    userId: userId.present ? userId.value : this.userId,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  PollVote copyWithCompanion(PollVotesCompanion data) {
    return PollVote(
      id: data.id.present ? data.id.value : this.id,
      pollId: data.pollId.present ? data.pollId.value : this.pollId,
      optionId: data.optionId.present ? data.optionId.value : this.optionId,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PollVote(')
          ..write('id: $id, ')
          ..write('pollId: $pollId, ')
          ..write('optionId: $optionId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pollId, optionId, userId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PollVote &&
          other.id == this.id &&
          other.pollId == this.pollId &&
          other.optionId == this.optionId &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt);
}

class PollVotesCompanion extends UpdateCompanion<PollVote> {
  final Value<String> id;
  final Value<String?> pollId;
  final Value<String?> optionId;
  final Value<String?> userId;
  final Value<int?> createdAt;
  final Value<int> rowid;
  const PollVotesCompanion({
    this.id = const Value.absent(),
    this.pollId = const Value.absent(),
    this.optionId = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PollVotesCompanion.insert({
    required String id,
    this.pollId = const Value.absent(),
    this.optionId = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<PollVote> custom({
    Expression<String>? id,
    Expression<String>? pollId,
    Expression<String>? optionId,
    Expression<String>? userId,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pollId != null) 'poll_id': pollId,
      if (optionId != null) 'option_id': optionId,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PollVotesCompanion copyWith({
    Value<String>? id,
    Value<String?>? pollId,
    Value<String?>? optionId,
    Value<String?>? userId,
    Value<int?>? createdAt,
    Value<int>? rowid,
  }) {
    return PollVotesCompanion(
      id: id ?? this.id,
      pollId: pollId ?? this.pollId,
      optionId: optionId ?? this.optionId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pollId.present) {
      map['poll_id'] = Variable<String>(pollId.value);
    }
    if (optionId.present) {
      map['option_id'] = Variable<String>(optionId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PollVotesCompanion(')
          ..write('id: $id, ')
          ..write('pollId: $pollId, ')
          ..write('optionId: $optionId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutboxQueueTable extends OutboxQueue
    with TableInfo<$OutboxQueueTable, OutboxQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    payload,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutboxQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboxQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      ),
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $OutboxQueueTable createAlias(String alias) {
    return $OutboxQueueTable(attachedDatabase, alias);
  }
}

class OutboxQueueData extends DataClass implements Insertable<OutboxQueueData> {
  final String id;
  final String? messageId;
  final String? payload;
  final String? status;
  final int? createdAt;
  const OutboxQueueData({
    required this.id,
    this.messageId,
    this.payload,
    this.status,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || messageId != null) {
      map['message_id'] = Variable<String>(messageId);
    }
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    return map;
  }

  OutboxQueueCompanion toCompanion(bool nullToAbsent) {
    return OutboxQueueCompanion(
      id: Value(id),
      messageId: messageId == null && nullToAbsent
          ? const Value.absent()
          : Value(messageId),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
      status: status == null && nullToAbsent
          ? const Value.absent()
          : Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory OutboxQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxQueueData(
      id: serializer.fromJson<String>(json['id']),
      messageId: serializer.fromJson<String?>(json['messageId']),
      payload: serializer.fromJson<String?>(json['payload']),
      status: serializer.fromJson<String?>(json['status']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'messageId': serializer.toJson<String?>(messageId),
      'payload': serializer.toJson<String?>(payload),
      'status': serializer.toJson<String?>(status),
      'createdAt': serializer.toJson<int?>(createdAt),
    };
  }

  OutboxQueueData copyWith({
    String? id,
    Value<String?> messageId = const Value.absent(),
    Value<String?> payload = const Value.absent(),
    Value<String?> status = const Value.absent(),
    Value<int?> createdAt = const Value.absent(),
  }) => OutboxQueueData(
    id: id ?? this.id,
    messageId: messageId.present ? messageId.value : this.messageId,
    payload: payload.present ? payload.value : this.payload,
    status: status.present ? status.value : this.status,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  OutboxQueueData copyWithCompanion(OutboxQueueCompanion data) {
    return OutboxQueueData(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      payload: data.payload.present ? data.payload.value : this.payload,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxQueueData(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, messageId, payload, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxQueueData &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.payload == this.payload &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class OutboxQueueCompanion extends UpdateCompanion<OutboxQueueData> {
  final Value<String> id;
  final Value<String?> messageId;
  final Value<String?> payload;
  final Value<String?> status;
  final Value<int?> createdAt;
  final Value<int> rowid;
  const OutboxQueueCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OutboxQueueCompanion.insert({
    required String id,
    this.messageId = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<OutboxQueueData> custom({
    Expression<String>? id,
    Expression<String>? messageId,
    Expression<String>? payload,
    Expression<String>? status,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (payload != null) 'payload': payload,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OutboxQueueCompanion copyWith({
    Value<String>? id,
    Value<String?>? messageId,
    Value<String?>? payload,
    Value<String?>? status,
    Value<int?>? createdAt,
    Value<int>? rowid,
  }) {
    return OutboxQueueCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxQueueCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KeyValuesTable extends KeyValues
    with TableInfo<$KeyValuesTable, KeyValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeyValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'key_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<KeyValue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  KeyValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeyValue(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
    );
  }

  @override
  $KeyValuesTable createAlias(String alias) {
    return $KeyValuesTable(attachedDatabase, alias);
  }
}

class KeyValue extends DataClass implements Insertable<KeyValue> {
  final String key;
  final String? value;
  const KeyValue({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  KeyValuesCompanion toCompanion(bool nullToAbsent) {
    return KeyValuesCompanion(
      key: Value(key),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
    );
  }

  factory KeyValue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeyValue(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
    };
  }

  KeyValue copyWith({
    String? key,
    Value<String?> value = const Value.absent(),
  }) => KeyValue(
    key: key ?? this.key,
    value: value.present ? value.value : this.value,
  );
  KeyValue copyWithCompanion(KeyValuesCompanion data) {
    return KeyValue(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeyValue(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KeyValue && other.key == this.key && other.value == this.value);
}

class KeyValuesCompanion extends UpdateCompanion<KeyValue> {
  final Value<String> key;
  final Value<String?> value;
  final Value<int> rowid;
  const KeyValuesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeyValuesCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<KeyValue> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KeyValuesCompanion copyWith({
    Value<String>? key,
    Value<String?>? value,
    Value<int>? rowid,
  }) {
    return KeyValuesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeyValuesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JobsTable extends Jobs with TableInfo<$JobsTable, JobRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _factoryKeyMeta = const VerificationMeta(
    'factoryKey',
  );
  @override
  late final GeneratedColumn<String> factoryKey = GeneratedColumn<String>(
    'factory_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queueKeyMeta = const VerificationMeta(
    'queueKey',
  );
  @override
  late final GeneratedColumn<String> queueKey = GeneratedColumn<String>(
    'queue_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _runAttemptMeta = const VerificationMeta(
    'runAttempt',
  );
  @override
  late final GeneratedColumn<int> runAttempt = GeneratedColumn<int>(
    'run_attempt',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createTimeMeta = const VerificationMeta(
    'createTime',
  );
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
    'create_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextRunAttemptTimeMeta =
      const VerificationMeta('nextRunAttemptTime');
  @override
  late final GeneratedColumn<int> nextRunAttemptTime = GeneratedColumn<int>(
    'next_run_attempt_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isRunningMeta = const VerificationMeta(
    'isRunning',
  );
  @override
  late final GeneratedColumn<bool> isRunning = GeneratedColumn<bool>(
    'is_running',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_running" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    factoryKey,
    queueKey,
    data,
    priority,
    runAttempt,
    createTime,
    nextRunAttemptTime,
    isRunning,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('factory_key')) {
      context.handle(
        _factoryKeyMeta,
        factoryKey.isAcceptableOrUnknown(data['factory_key']!, _factoryKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_factoryKeyMeta);
    }
    if (data.containsKey('queue_key')) {
      context.handle(
        _queueKeyMeta,
        queueKey.isAcceptableOrUnknown(data['queue_key']!, _queueKeyMeta),
      );
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('run_attempt')) {
      context.handle(
        _runAttemptMeta,
        runAttempt.isAcceptableOrUnknown(data['run_attempt']!, _runAttemptMeta),
      );
    }
    if (data.containsKey('create_time')) {
      context.handle(
        _createTimeMeta,
        createTime.isAcceptableOrUnknown(data['create_time']!, _createTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('next_run_attempt_time')) {
      context.handle(
        _nextRunAttemptTimeMeta,
        nextRunAttemptTime.isAcceptableOrUnknown(
          data['next_run_attempt_time']!,
          _nextRunAttemptTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextRunAttemptTimeMeta);
    }
    if (data.containsKey('is_running')) {
      context.handle(
        _isRunningMeta,
        isRunning.isAcceptableOrUnknown(data['is_running']!, _isRunningMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JobRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      factoryKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}factory_key'],
      )!,
      queueKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}queue_key'],
      ),
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      runAttempt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}run_attempt'],
      )!,
      createTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}create_time'],
      )!,
      nextRunAttemptTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_run_attempt_time'],
      )!,
      isRunning: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_running'],
      )!,
    );
  }

  @override
  $JobsTable createAlias(String alias) {
    return $JobsTable(attachedDatabase, alias);
  }
}

class JobRecord extends DataClass implements Insertable<JobRecord> {
  final int id;
  final String factoryKey;
  final String? queueKey;
  final String data;
  final int priority;
  final int runAttempt;
  final int createTime;
  final int nextRunAttemptTime;
  final bool isRunning;
  const JobRecord({
    required this.id,
    required this.factoryKey,
    this.queueKey,
    required this.data,
    required this.priority,
    required this.runAttempt,
    required this.createTime,
    required this.nextRunAttemptTime,
    required this.isRunning,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['factory_key'] = Variable<String>(factoryKey);
    if (!nullToAbsent || queueKey != null) {
      map['queue_key'] = Variable<String>(queueKey);
    }
    map['data'] = Variable<String>(data);
    map['priority'] = Variable<int>(priority);
    map['run_attempt'] = Variable<int>(runAttempt);
    map['create_time'] = Variable<int>(createTime);
    map['next_run_attempt_time'] = Variable<int>(nextRunAttemptTime);
    map['is_running'] = Variable<bool>(isRunning);
    return map;
  }

  JobsCompanion toCompanion(bool nullToAbsent) {
    return JobsCompanion(
      id: Value(id),
      factoryKey: Value(factoryKey),
      queueKey: queueKey == null && nullToAbsent
          ? const Value.absent()
          : Value(queueKey),
      data: Value(data),
      priority: Value(priority),
      runAttempt: Value(runAttempt),
      createTime: Value(createTime),
      nextRunAttemptTime: Value(nextRunAttemptTime),
      isRunning: Value(isRunning),
    );
  }

  factory JobRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobRecord(
      id: serializer.fromJson<int>(json['id']),
      factoryKey: serializer.fromJson<String>(json['factoryKey']),
      queueKey: serializer.fromJson<String?>(json['queueKey']),
      data: serializer.fromJson<String>(json['data']),
      priority: serializer.fromJson<int>(json['priority']),
      runAttempt: serializer.fromJson<int>(json['runAttempt']),
      createTime: serializer.fromJson<int>(json['createTime']),
      nextRunAttemptTime: serializer.fromJson<int>(json['nextRunAttemptTime']),
      isRunning: serializer.fromJson<bool>(json['isRunning']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'factoryKey': serializer.toJson<String>(factoryKey),
      'queueKey': serializer.toJson<String?>(queueKey),
      'data': serializer.toJson<String>(data),
      'priority': serializer.toJson<int>(priority),
      'runAttempt': serializer.toJson<int>(runAttempt),
      'createTime': serializer.toJson<int>(createTime),
      'nextRunAttemptTime': serializer.toJson<int>(nextRunAttemptTime),
      'isRunning': serializer.toJson<bool>(isRunning),
    };
  }

  JobRecord copyWith({
    int? id,
    String? factoryKey,
    Value<String?> queueKey = const Value.absent(),
    String? data,
    int? priority,
    int? runAttempt,
    int? createTime,
    int? nextRunAttemptTime,
    bool? isRunning,
  }) => JobRecord(
    id: id ?? this.id,
    factoryKey: factoryKey ?? this.factoryKey,
    queueKey: queueKey.present ? queueKey.value : this.queueKey,
    data: data ?? this.data,
    priority: priority ?? this.priority,
    runAttempt: runAttempt ?? this.runAttempt,
    createTime: createTime ?? this.createTime,
    nextRunAttemptTime: nextRunAttemptTime ?? this.nextRunAttemptTime,
    isRunning: isRunning ?? this.isRunning,
  );
  JobRecord copyWithCompanion(JobsCompanion data) {
    return JobRecord(
      id: data.id.present ? data.id.value : this.id,
      factoryKey: data.factoryKey.present
          ? data.factoryKey.value
          : this.factoryKey,
      queueKey: data.queueKey.present ? data.queueKey.value : this.queueKey,
      data: data.data.present ? data.data.value : this.data,
      priority: data.priority.present ? data.priority.value : this.priority,
      runAttempt: data.runAttempt.present
          ? data.runAttempt.value
          : this.runAttempt,
      createTime: data.createTime.present
          ? data.createTime.value
          : this.createTime,
      nextRunAttemptTime: data.nextRunAttemptTime.present
          ? data.nextRunAttemptTime.value
          : this.nextRunAttemptTime,
      isRunning: data.isRunning.present ? data.isRunning.value : this.isRunning,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobRecord(')
          ..write('id: $id, ')
          ..write('factoryKey: $factoryKey, ')
          ..write('queueKey: $queueKey, ')
          ..write('data: $data, ')
          ..write('priority: $priority, ')
          ..write('runAttempt: $runAttempt, ')
          ..write('createTime: $createTime, ')
          ..write('nextRunAttemptTime: $nextRunAttemptTime, ')
          ..write('isRunning: $isRunning')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    factoryKey,
    queueKey,
    data,
    priority,
    runAttempt,
    createTime,
    nextRunAttemptTime,
    isRunning,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobRecord &&
          other.id == this.id &&
          other.factoryKey == this.factoryKey &&
          other.queueKey == this.queueKey &&
          other.data == this.data &&
          other.priority == this.priority &&
          other.runAttempt == this.runAttempt &&
          other.createTime == this.createTime &&
          other.nextRunAttemptTime == this.nextRunAttemptTime &&
          other.isRunning == this.isRunning);
}

class JobsCompanion extends UpdateCompanion<JobRecord> {
  final Value<int> id;
  final Value<String> factoryKey;
  final Value<String?> queueKey;
  final Value<String> data;
  final Value<int> priority;
  final Value<int> runAttempt;
  final Value<int> createTime;
  final Value<int> nextRunAttemptTime;
  final Value<bool> isRunning;
  const JobsCompanion({
    this.id = const Value.absent(),
    this.factoryKey = const Value.absent(),
    this.queueKey = const Value.absent(),
    this.data = const Value.absent(),
    this.priority = const Value.absent(),
    this.runAttempt = const Value.absent(),
    this.createTime = const Value.absent(),
    this.nextRunAttemptTime = const Value.absent(),
    this.isRunning = const Value.absent(),
  });
  JobsCompanion.insert({
    this.id = const Value.absent(),
    required String factoryKey,
    this.queueKey = const Value.absent(),
    required String data,
    this.priority = const Value.absent(),
    this.runAttempt = const Value.absent(),
    required int createTime,
    required int nextRunAttemptTime,
    this.isRunning = const Value.absent(),
  }) : factoryKey = Value(factoryKey),
       data = Value(data),
       createTime = Value(createTime),
       nextRunAttemptTime = Value(nextRunAttemptTime);
  static Insertable<JobRecord> custom({
    Expression<int>? id,
    Expression<String>? factoryKey,
    Expression<String>? queueKey,
    Expression<String>? data,
    Expression<int>? priority,
    Expression<int>? runAttempt,
    Expression<int>? createTime,
    Expression<int>? nextRunAttemptTime,
    Expression<bool>? isRunning,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (factoryKey != null) 'factory_key': factoryKey,
      if (queueKey != null) 'queue_key': queueKey,
      if (data != null) 'data': data,
      if (priority != null) 'priority': priority,
      if (runAttempt != null) 'run_attempt': runAttempt,
      if (createTime != null) 'create_time': createTime,
      if (nextRunAttemptTime != null)
        'next_run_attempt_time': nextRunAttemptTime,
      if (isRunning != null) 'is_running': isRunning,
    });
  }

  JobsCompanion copyWith({
    Value<int>? id,
    Value<String>? factoryKey,
    Value<String?>? queueKey,
    Value<String>? data,
    Value<int>? priority,
    Value<int>? runAttempt,
    Value<int>? createTime,
    Value<int>? nextRunAttemptTime,
    Value<bool>? isRunning,
  }) {
    return JobsCompanion(
      id: id ?? this.id,
      factoryKey: factoryKey ?? this.factoryKey,
      queueKey: queueKey ?? this.queueKey,
      data: data ?? this.data,
      priority: priority ?? this.priority,
      runAttempt: runAttempt ?? this.runAttempt,
      createTime: createTime ?? this.createTime,
      nextRunAttemptTime: nextRunAttemptTime ?? this.nextRunAttemptTime,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (factoryKey.present) {
      map['factory_key'] = Variable<String>(factoryKey.value);
    }
    if (queueKey.present) {
      map['queue_key'] = Variable<String>(queueKey.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (runAttempt.present) {
      map['run_attempt'] = Variable<int>(runAttempt.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (nextRunAttemptTime.present) {
      map['next_run_attempt_time'] = Variable<int>(nextRunAttemptTime.value);
    }
    if (isRunning.present) {
      map['is_running'] = Variable<bool>(isRunning.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobsCompanion(')
          ..write('id: $id, ')
          ..write('factoryKey: $factoryKey, ')
          ..write('queueKey: $queueKey, ')
          ..write('data: $data, ')
          ..write('priority: $priority, ')
          ..write('runAttempt: $runAttempt, ')
          ..write('createTime: $createTime, ')
          ..write('nextRunAttemptTime: $nextRunAttemptTime, ')
          ..write('isRunning: $isRunning')
          ..write(')'))
        .toString();
  }
}

abstract class _$SigmaDatabase extends GeneratedDatabase {
  _$SigmaDatabase(QueryExecutor e) : super(e);
  $SigmaDatabaseManager get managers => $SigmaDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $DevicesTable devices = $DevicesTable(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  late final $ConversationMembersTable conversationMembers =
      $ConversationMembersTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $ReactionsTable reactions = $ReactionsTable(this);
  late final $MessageLocationsTable messageLocations = $MessageLocationsTable(
    this,
  );
  late final $DeliveryLogsTable deliveryLogs = $DeliveryLogsTable(this);
  late final $PollsTable polls = $PollsTable(this);
  late final $PollOptionsTable pollOptions = $PollOptionsTable(this);
  late final $PollVotesTable pollVotes = $PollVotesTable(this);
  late final $OutboxQueueTable outboxQueue = $OutboxQueueTable(this);
  late final $KeyValuesTable keyValues = $KeyValuesTable(this);
  late final $JobsTable jobs = $JobsTable(this);
  late final UserDao userDao = UserDao(this as SigmaDatabase);
  late final ConversationDao conversationDao = ConversationDao(
    this as SigmaDatabase,
  );
  late final MessageDao messageDao = MessageDao(this as SigmaDatabase);
  late final PollDao pollDao = PollDao(this as SigmaDatabase);
  late final KeyValueDao keyValueDao = KeyValueDao(this as SigmaDatabase);
  late final JobDao jobDao = JobDao(this as SigmaDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    accounts,
    devices,
    conversations,
    conversationMembers,
    messages,
    reactions,
    messageLocations,
    deliveryLogs,
    polls,
    pollOptions,
    pollVotes,
    outboxQueue,
    keyValues,
    jobs,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      Value<String?> phone,
      Value<String?> name,
      Value<String?> username,
      Value<String?> email,
      Value<String?> bio,
      Value<String?> avatarUrl,
      Value<bool> isBot,
      Value<int?> createdAt,
      Value<int?> updatedAt,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String?> phone,
      Value<String?> name,
      Value<String?> username,
      Value<String?> email,
      Value<String?> bio,
      Value<String?> avatarUrl,
      Value<bool> isBot,
      Value<int?> createdAt,
      Value<int?> updatedAt,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer
    extends Composer<_$SigmaDatabase, $UsersTable> {
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

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
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

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBot => $composableBuilder(
    column: $table.isBot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$SigmaDatabase, $UsersTable> {
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

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
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

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBot => $composableBuilder(
    column: $table.isBot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<bool> get isBot =>
      $composableBuilder(column: $table.isBot, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$SigmaDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$SigmaDatabase db, $UsersTable table)
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
                Value<String?> phone = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<bool> isBot = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                phone: phone,
                name: name,
                username: username,
                email: email,
                bio: bio,
                avatarUrl: avatarUrl,
                isBot: isBot,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> phone = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<bool> isBot = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                phone: phone,
                name: name,
                username: username,
                email: email,
                bio: bio,
                avatarUrl: avatarUrl,
                isBot: isBot,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$SigmaDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$AccountsTableCreateCompanionBuilder =
    AccountsCompanion Function({
      required String id,
      Value<String?> userId,
      Value<String?> email,
      Value<String?> passwordHash,
      Value<bool> isVerified,
      Value<int?> createdAt,
      Value<int> rowid,
    });
typedef $$AccountsTableUpdateCompanionBuilder =
    AccountsCompanion Function({
      Value<String> id,
      Value<String?> userId,
      Value<String?> email,
      Value<String?> passwordHash,
      Value<bool> isVerified,
      Value<int?> createdAt,
      Value<int> rowid,
    });

class $$AccountsTableFilterComposer
    extends Composer<_$SigmaDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
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

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccountsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
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

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $AccountsTable,
          Account,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (Account, BaseReferences<_$SigmaDatabase, $AccountsTable, Account>),
          Account,
          PrefetchHooks Function()
        > {
  $$AccountsTableTableManager(_$SigmaDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                userId: userId,
                email: email,
                passwordHash: passwordHash,
                isVerified: isVerified,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> userId = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                userId: userId,
                email: email,
                passwordHash: passwordHash,
                isVerified: isVerified,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $AccountsTable,
      Account,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (Account, BaseReferences<_$SigmaDatabase, $AccountsTable, Account>),
      Account,
      PrefetchHooks Function()
    >;
typedef $$DevicesTableCreateCompanionBuilder =
    DevicesCompanion Function({
      required String id,
      Value<String?> userId,
      Value<String?> deviceName,
      Value<String?> deviceType,
      Value<String?> os,
      Value<String?> pushToken,
      Value<int?> lastSeen,
      Value<bool> isActive,
      Value<int?> createdAt,
      Value<int> rowid,
    });
typedef $$DevicesTableUpdateCompanionBuilder =
    DevicesCompanion Function({
      Value<String> id,
      Value<String?> userId,
      Value<String?> deviceName,
      Value<String?> deviceType,
      Value<String?> os,
      Value<String?> pushToken,
      Value<int?> lastSeen,
      Value<bool> isActive,
      Value<int?> createdAt,
      Value<int> rowid,
    });

class $$DevicesTableFilterComposer
    extends Composer<_$SigmaDatabase, $DevicesTable> {
  $$DevicesTableFilterComposer({
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

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceType => $composableBuilder(
    column: $table.deviceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get os => $composableBuilder(
    column: $table.os,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pushToken => $composableBuilder(
    column: $table.pushToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DevicesTableOrderingComposer
    extends Composer<_$SigmaDatabase, $DevicesTable> {
  $$DevicesTableOrderingComposer({
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

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceType => $composableBuilder(
    column: $table.deviceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get os => $composableBuilder(
    column: $table.os,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pushToken => $composableBuilder(
    column: $table.pushToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DevicesTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $DevicesTable> {
  $$DevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceType => $composableBuilder(
    column: $table.deviceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get os =>
      $composableBuilder(column: $table.os, builder: (column) => column);

  GeneratedColumn<String> get pushToken =>
      $composableBuilder(column: $table.pushToken, builder: (column) => column);

  GeneratedColumn<int> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DevicesTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $DevicesTable,
          Device,
          $$DevicesTableFilterComposer,
          $$DevicesTableOrderingComposer,
          $$DevicesTableAnnotationComposer,
          $$DevicesTableCreateCompanionBuilder,
          $$DevicesTableUpdateCompanionBuilder,
          (Device, BaseReferences<_$SigmaDatabase, $DevicesTable, Device>),
          Device,
          PrefetchHooks Function()
        > {
  $$DevicesTableTableManager(_$SigmaDatabase db, $DevicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> deviceName = const Value.absent(),
                Value<String?> deviceType = const Value.absent(),
                Value<String?> os = const Value.absent(),
                Value<String?> pushToken = const Value.absent(),
                Value<int?> lastSeen = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion(
                id: id,
                userId: userId,
                deviceName: deviceName,
                deviceType: deviceType,
                os: os,
                pushToken: pushToken,
                lastSeen: lastSeen,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> userId = const Value.absent(),
                Value<String?> deviceName = const Value.absent(),
                Value<String?> deviceType = const Value.absent(),
                Value<String?> os = const Value.absent(),
                Value<String?> pushToken = const Value.absent(),
                Value<int?> lastSeen = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DevicesCompanion.insert(
                id: id,
                userId: userId,
                deviceName: deviceName,
                deviceType: deviceType,
                os: os,
                pushToken: pushToken,
                lastSeen: lastSeen,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DevicesTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $DevicesTable,
      Device,
      $$DevicesTableFilterComposer,
      $$DevicesTableOrderingComposer,
      $$DevicesTableAnnotationComposer,
      $$DevicesTableCreateCompanionBuilder,
      $$DevicesTableUpdateCompanionBuilder,
      (Device, BaseReferences<_$SigmaDatabase, $DevicesTable, Device>),
      Device,
      PrefetchHooks Function()
    >;
typedef $$ConversationsTableCreateCompanionBuilder =
    ConversationsCompanion Function({
      required String id,
      Value<String?> type,
      Value<String?> title,
      Value<String?> avatar,
      Value<String?> lastMessageId,
      Value<int> unreadCount,
      Value<int?> updatedAt,
      Value<bool> isMuted,
      Value<bool> isPinned,
      Value<bool> isArchived,
      Value<int> rowid,
    });
typedef $$ConversationsTableUpdateCompanionBuilder =
    ConversationsCompanion Function({
      Value<String> id,
      Value<String?> type,
      Value<String?> title,
      Value<String?> avatar,
      Value<String?> lastMessageId,
      Value<int> unreadCount,
      Value<int?> updatedAt,
      Value<bool> isMuted,
      Value<bool> isPinned,
      Value<bool> isArchived,
      Value<int> rowid,
    });

class $$ConversationsTableFilterComposer
    extends Composer<_$SigmaDatabase, $ConversationsTable> {
  $$ConversationsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMuted => $composableBuilder(
    column: $table.isMuted,
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
}

class $$ConversationsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $ConversationsTable> {
  $$ConversationsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMuted => $composableBuilder(
    column: $table.isMuted,
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
}

class $$ConversationsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $ConversationsTable> {
  $$ConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isMuted =>
      $composableBuilder(column: $table.isMuted, builder: (column) => column);

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );
}

class $$ConversationsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $ConversationsTable,
          Conversation,
          $$ConversationsTableFilterComposer,
          $$ConversationsTableOrderingComposer,
          $$ConversationsTableAnnotationComposer,
          $$ConversationsTableCreateCompanionBuilder,
          $$ConversationsTableUpdateCompanionBuilder,
          (
            Conversation,
            BaseReferences<_$SigmaDatabase, $ConversationsTable, Conversation>,
          ),
          Conversation,
          PrefetchHooks Function()
        > {
  $$ConversationsTableTableManager(
    _$SigmaDatabase db,
    $ConversationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConversationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConversationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<String?> lastMessageId = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<bool> isMuted = const Value.absent(),
                Value<bool> isPinned = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConversationsCompanion(
                id: id,
                type: type,
                title: title,
                avatar: avatar,
                lastMessageId: lastMessageId,
                unreadCount: unreadCount,
                updatedAt: updatedAt,
                isMuted: isMuted,
                isPinned: isPinned,
                isArchived: isArchived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> type = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<String?> lastMessageId = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<bool> isMuted = const Value.absent(),
                Value<bool> isPinned = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConversationsCompanion.insert(
                id: id,
                type: type,
                title: title,
                avatar: avatar,
                lastMessageId: lastMessageId,
                unreadCount: unreadCount,
                updatedAt: updatedAt,
                isMuted: isMuted,
                isPinned: isPinned,
                isArchived: isArchived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConversationsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $ConversationsTable,
      Conversation,
      $$ConversationsTableFilterComposer,
      $$ConversationsTableOrderingComposer,
      $$ConversationsTableAnnotationComposer,
      $$ConversationsTableCreateCompanionBuilder,
      $$ConversationsTableUpdateCompanionBuilder,
      (
        Conversation,
        BaseReferences<_$SigmaDatabase, $ConversationsTable, Conversation>,
      ),
      Conversation,
      PrefetchHooks Function()
    >;
typedef $$ConversationMembersTableCreateCompanionBuilder =
    ConversationMembersCompanion Function({
      required String id,
      Value<String?> conversationId,
      Value<String?> userId,
      Value<String?> role,
      Value<int?> joinedAt,
      Value<int> rowid,
    });
typedef $$ConversationMembersTableUpdateCompanionBuilder =
    ConversationMembersCompanion Function({
      Value<String> id,
      Value<String?> conversationId,
      Value<String?> userId,
      Value<String?> role,
      Value<int?> joinedAt,
      Value<int> rowid,
    });

class $$ConversationMembersTableFilterComposer
    extends Composer<_$SigmaDatabase, $ConversationMembersTable> {
  $$ConversationMembersTableFilterComposer({
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

  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConversationMembersTableOrderingComposer
    extends Composer<_$SigmaDatabase, $ConversationMembersTable> {
  $$ConversationMembersTableOrderingComposer({
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

  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConversationMembersTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $ConversationMembersTable> {
  $$ConversationMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<int> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);
}

class $$ConversationMembersTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $ConversationMembersTable,
          ConversationMember,
          $$ConversationMembersTableFilterComposer,
          $$ConversationMembersTableOrderingComposer,
          $$ConversationMembersTableAnnotationComposer,
          $$ConversationMembersTableCreateCompanionBuilder,
          $$ConversationMembersTableUpdateCompanionBuilder,
          (
            ConversationMember,
            BaseReferences<
              _$SigmaDatabase,
              $ConversationMembersTable,
              ConversationMember
            >,
          ),
          ConversationMember,
          PrefetchHooks Function()
        > {
  $$ConversationMembersTableTableManager(
    _$SigmaDatabase db,
    $ConversationMembersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversationMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConversationMembersTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ConversationMembersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> conversationId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> role = const Value.absent(),
                Value<int?> joinedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConversationMembersCompanion(
                id: id,
                conversationId: conversationId,
                userId: userId,
                role: role,
                joinedAt: joinedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> conversationId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> role = const Value.absent(),
                Value<int?> joinedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConversationMembersCompanion.insert(
                id: id,
                conversationId: conversationId,
                userId: userId,
                role: role,
                joinedAt: joinedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConversationMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $ConversationMembersTable,
      ConversationMember,
      $$ConversationMembersTableFilterComposer,
      $$ConversationMembersTableOrderingComposer,
      $$ConversationMembersTableAnnotationComposer,
      $$ConversationMembersTableCreateCompanionBuilder,
      $$ConversationMembersTableUpdateCompanionBuilder,
      (
        ConversationMember,
        BaseReferences<
          _$SigmaDatabase,
          $ConversationMembersTable,
          ConversationMember
        >,
      ),
      ConversationMember,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      required String id,
      Value<String?> conversationId,
      Value<String?> senderId,
      Value<String?> type,
      Value<String?> content,
      Value<String?> status,
      Value<String?> replyToMessageId,
      Value<int?> createdAt,
      Value<int?> updatedAt,
      Value<int> rowid,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<String> id,
      Value<String?> conversationId,
      Value<String?> senderId,
      Value<String?> type,
      Value<String?> content,
      Value<String?> status,
      Value<String?> replyToMessageId,
      Value<int?> createdAt,
      Value<int?> updatedAt,
      Value<int> rowid,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$SigmaDatabase, $MessagesTable> {
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

  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replyToMessageId => $composableBuilder(
    column: $table.replyToMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$SigmaDatabase, $MessagesTable> {
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

  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replyToMessageId => $composableBuilder(
    column: $table.replyToMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get replyToMessageId => $composableBuilder(
    column: $table.replyToMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, BaseReferences<_$SigmaDatabase, $MessagesTable, Message>),
          Message,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$SigmaDatabase db, $MessagesTable table)
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
                Value<String?> conversationId = const Value.absent(),
                Value<String?> senderId = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String?> replyToMessageId = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                conversationId: conversationId,
                senderId: senderId,
                type: type,
                content: content,
                status: status,
                replyToMessageId: replyToMessageId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> conversationId = const Value.absent(),
                Value<String?> senderId = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String?> replyToMessageId = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                conversationId: conversationId,
                senderId: senderId,
                type: type,
                content: content,
                status: status,
                replyToMessageId: replyToMessageId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, BaseReferences<_$SigmaDatabase, $MessagesTable, Message>),
      Message,
      PrefetchHooks Function()
    >;
typedef $$ReactionsTableCreateCompanionBuilder =
    ReactionsCompanion Function({
      required String id,
      Value<String?> messageId,
      Value<String?> userId,
      Value<String?> emoji,
      Value<int?> createdAt,
      Value<int> rowid,
    });
typedef $$ReactionsTableUpdateCompanionBuilder =
    ReactionsCompanion Function({
      Value<String> id,
      Value<String?> messageId,
      Value<String?> userId,
      Value<String?> emoji,
      Value<int?> createdAt,
      Value<int> rowid,
    });

class $$ReactionsTableFilterComposer
    extends Composer<_$SigmaDatabase, $ReactionsTable> {
  $$ReactionsTableFilterComposer({
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

  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReactionsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $ReactionsTable> {
  $$ReactionsTableOrderingComposer({
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

  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReactionsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $ReactionsTable> {
  $$ReactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ReactionsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $ReactionsTable,
          Reaction,
          $$ReactionsTableFilterComposer,
          $$ReactionsTableOrderingComposer,
          $$ReactionsTableAnnotationComposer,
          $$ReactionsTableCreateCompanionBuilder,
          $$ReactionsTableUpdateCompanionBuilder,
          (
            Reaction,
            BaseReferences<_$SigmaDatabase, $ReactionsTable, Reaction>,
          ),
          Reaction,
          PrefetchHooks Function()
        > {
  $$ReactionsTableTableManager(_$SigmaDatabase db, $ReactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> messageId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> emoji = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReactionsCompanion(
                id: id,
                messageId: messageId,
                userId: userId,
                emoji: emoji,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> messageId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> emoji = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReactionsCompanion.insert(
                id: id,
                messageId: messageId,
                userId: userId,
                emoji: emoji,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $ReactionsTable,
      Reaction,
      $$ReactionsTableFilterComposer,
      $$ReactionsTableOrderingComposer,
      $$ReactionsTableAnnotationComposer,
      $$ReactionsTableCreateCompanionBuilder,
      $$ReactionsTableUpdateCompanionBuilder,
      (Reaction, BaseReferences<_$SigmaDatabase, $ReactionsTable, Reaction>),
      Reaction,
      PrefetchHooks Function()
    >;
typedef $$MessageLocationsTableCreateCompanionBuilder =
    MessageLocationsCompanion Function({
      required String messageId,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> accuracy,
      Value<bool> isLive,
      Value<int?> updatedAt,
      Value<int> rowid,
    });
typedef $$MessageLocationsTableUpdateCompanionBuilder =
    MessageLocationsCompanion Function({
      Value<String> messageId,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> accuracy,
      Value<bool> isLive,
      Value<int?> updatedAt,
      Value<int> rowid,
    });

class $$MessageLocationsTableFilterComposer
    extends Composer<_$SigmaDatabase, $MessageLocationsTable> {
  $$MessageLocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLive => $composableBuilder(
    column: $table.isLive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessageLocationsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $MessageLocationsTable> {
  $$MessageLocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLive => $composableBuilder(
    column: $table.isLive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessageLocationsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $MessageLocationsTable> {
  $$MessageLocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<bool> get isLive =>
      $composableBuilder(column: $table.isLive, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MessageLocationsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $MessageLocationsTable,
          MessageLocation,
          $$MessageLocationsTableFilterComposer,
          $$MessageLocationsTableOrderingComposer,
          $$MessageLocationsTableAnnotationComposer,
          $$MessageLocationsTableCreateCompanionBuilder,
          $$MessageLocationsTableUpdateCompanionBuilder,
          (
            MessageLocation,
            BaseReferences<
              _$SigmaDatabase,
              $MessageLocationsTable,
              MessageLocation
            >,
          ),
          MessageLocation,
          PrefetchHooks Function()
        > {
  $$MessageLocationsTableTableManager(
    _$SigmaDatabase db,
    $MessageLocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessageLocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessageLocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessageLocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> messageId = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> accuracy = const Value.absent(),
                Value<bool> isLive = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessageLocationsCompanion(
                messageId: messageId,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                isLive: isLive,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String messageId,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> accuracy = const Value.absent(),
                Value<bool> isLive = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessageLocationsCompanion.insert(
                messageId: messageId,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                isLive: isLive,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessageLocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $MessageLocationsTable,
      MessageLocation,
      $$MessageLocationsTableFilterComposer,
      $$MessageLocationsTableOrderingComposer,
      $$MessageLocationsTableAnnotationComposer,
      $$MessageLocationsTableCreateCompanionBuilder,
      $$MessageLocationsTableUpdateCompanionBuilder,
      (
        MessageLocation,
        BaseReferences<
          _$SigmaDatabase,
          $MessageLocationsTable,
          MessageLocation
        >,
      ),
      MessageLocation,
      PrefetchHooks Function()
    >;
typedef $$DeliveryLogsTableCreateCompanionBuilder =
    DeliveryLogsCompanion Function({
      required String id,
      Value<String?> messageId,
      Value<String?> userId,
      Value<String?> status,
      Value<int?> timestamp,
      Value<int> rowid,
    });
typedef $$DeliveryLogsTableUpdateCompanionBuilder =
    DeliveryLogsCompanion Function({
      Value<String> id,
      Value<String?> messageId,
      Value<String?> userId,
      Value<String?> status,
      Value<int?> timestamp,
      Value<int> rowid,
    });

class $$DeliveryLogsTableFilterComposer
    extends Composer<_$SigmaDatabase, $DeliveryLogsTable> {
  $$DeliveryLogsTableFilterComposer({
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

  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeliveryLogsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $DeliveryLogsTable> {
  $$DeliveryLogsTableOrderingComposer({
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

  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeliveryLogsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $DeliveryLogsTable> {
  $$DeliveryLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$DeliveryLogsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $DeliveryLogsTable,
          DeliveryLog,
          $$DeliveryLogsTableFilterComposer,
          $$DeliveryLogsTableOrderingComposer,
          $$DeliveryLogsTableAnnotationComposer,
          $$DeliveryLogsTableCreateCompanionBuilder,
          $$DeliveryLogsTableUpdateCompanionBuilder,
          (
            DeliveryLog,
            BaseReferences<_$SigmaDatabase, $DeliveryLogsTable, DeliveryLog>,
          ),
          DeliveryLog,
          PrefetchHooks Function()
        > {
  $$DeliveryLogsTableTableManager(_$SigmaDatabase db, $DeliveryLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeliveryLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeliveryLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeliveryLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> messageId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<int?> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeliveryLogsCompanion(
                id: id,
                messageId: messageId,
                userId: userId,
                status: status,
                timestamp: timestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> messageId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<int?> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeliveryLogsCompanion.insert(
                id: id,
                messageId: messageId,
                userId: userId,
                status: status,
                timestamp: timestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeliveryLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $DeliveryLogsTable,
      DeliveryLog,
      $$DeliveryLogsTableFilterComposer,
      $$DeliveryLogsTableOrderingComposer,
      $$DeliveryLogsTableAnnotationComposer,
      $$DeliveryLogsTableCreateCompanionBuilder,
      $$DeliveryLogsTableUpdateCompanionBuilder,
      (
        DeliveryLog,
        BaseReferences<_$SigmaDatabase, $DeliveryLogsTable, DeliveryLog>,
      ),
      DeliveryLog,
      PrefetchHooks Function()
    >;
typedef $$PollsTableCreateCompanionBuilder =
    PollsCompanion Function({
      required String id,
      Value<String?> messageId,
      Value<String?> question,
      Value<bool> multipleChoice,
      Value<int?> createdAt,
      Value<int> rowid,
    });
typedef $$PollsTableUpdateCompanionBuilder =
    PollsCompanion Function({
      Value<String> id,
      Value<String?> messageId,
      Value<String?> question,
      Value<bool> multipleChoice,
      Value<int?> createdAt,
      Value<int> rowid,
    });

class $$PollsTableFilterComposer
    extends Composer<_$SigmaDatabase, $PollsTable> {
  $$PollsTableFilterComposer({
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

  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get multipleChoice => $composableBuilder(
    column: $table.multipleChoice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PollsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $PollsTable> {
  $$PollsTableOrderingComposer({
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

  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get multipleChoice => $composableBuilder(
    column: $table.multipleChoice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PollsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $PollsTable> {
  $$PollsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<bool> get multipleChoice => $composableBuilder(
    column: $table.multipleChoice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PollsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $PollsTable,
          Poll,
          $$PollsTableFilterComposer,
          $$PollsTableOrderingComposer,
          $$PollsTableAnnotationComposer,
          $$PollsTableCreateCompanionBuilder,
          $$PollsTableUpdateCompanionBuilder,
          (Poll, BaseReferences<_$SigmaDatabase, $PollsTable, Poll>),
          Poll,
          PrefetchHooks Function()
        > {
  $$PollsTableTableManager(_$SigmaDatabase db, $PollsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PollsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PollsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PollsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> messageId = const Value.absent(),
                Value<String?> question = const Value.absent(),
                Value<bool> multipleChoice = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PollsCompanion(
                id: id,
                messageId: messageId,
                question: question,
                multipleChoice: multipleChoice,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> messageId = const Value.absent(),
                Value<String?> question = const Value.absent(),
                Value<bool> multipleChoice = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PollsCompanion.insert(
                id: id,
                messageId: messageId,
                question: question,
                multipleChoice: multipleChoice,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PollsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $PollsTable,
      Poll,
      $$PollsTableFilterComposer,
      $$PollsTableOrderingComposer,
      $$PollsTableAnnotationComposer,
      $$PollsTableCreateCompanionBuilder,
      $$PollsTableUpdateCompanionBuilder,
      (Poll, BaseReferences<_$SigmaDatabase, $PollsTable, Poll>),
      Poll,
      PrefetchHooks Function()
    >;
typedef $$PollOptionsTableCreateCompanionBuilder =
    PollOptionsCompanion Function({
      required String id,
      Value<String?> pollId,
      Value<String?> textContent,
      Value<int> voteCount,
      Value<int> rowid,
    });
typedef $$PollOptionsTableUpdateCompanionBuilder =
    PollOptionsCompanion Function({
      Value<String> id,
      Value<String?> pollId,
      Value<String?> textContent,
      Value<int> voteCount,
      Value<int> rowid,
    });

class $$PollOptionsTableFilterComposer
    extends Composer<_$SigmaDatabase, $PollOptionsTable> {
  $$PollOptionsTableFilterComposer({
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

  ColumnFilters<String> get pollId => $composableBuilder(
    column: $table.pollId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PollOptionsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $PollOptionsTable> {
  $$PollOptionsTableOrderingComposer({
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

  ColumnOrderings<String> get pollId => $composableBuilder(
    column: $table.pollId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get voteCount => $composableBuilder(
    column: $table.voteCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PollOptionsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $PollOptionsTable> {
  $$PollOptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pollId =>
      $composableBuilder(column: $table.pollId, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get voteCount =>
      $composableBuilder(column: $table.voteCount, builder: (column) => column);
}

class $$PollOptionsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $PollOptionsTable,
          PollOption,
          $$PollOptionsTableFilterComposer,
          $$PollOptionsTableOrderingComposer,
          $$PollOptionsTableAnnotationComposer,
          $$PollOptionsTableCreateCompanionBuilder,
          $$PollOptionsTableUpdateCompanionBuilder,
          (
            PollOption,
            BaseReferences<_$SigmaDatabase, $PollOptionsTable, PollOption>,
          ),
          PollOption,
          PrefetchHooks Function()
        > {
  $$PollOptionsTableTableManager(_$SigmaDatabase db, $PollOptionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PollOptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PollOptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PollOptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> pollId = const Value.absent(),
                Value<String?> textContent = const Value.absent(),
                Value<int> voteCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PollOptionsCompanion(
                id: id,
                pollId: pollId,
                textContent: textContent,
                voteCount: voteCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> pollId = const Value.absent(),
                Value<String?> textContent = const Value.absent(),
                Value<int> voteCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PollOptionsCompanion.insert(
                id: id,
                pollId: pollId,
                textContent: textContent,
                voteCount: voteCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PollOptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $PollOptionsTable,
      PollOption,
      $$PollOptionsTableFilterComposer,
      $$PollOptionsTableOrderingComposer,
      $$PollOptionsTableAnnotationComposer,
      $$PollOptionsTableCreateCompanionBuilder,
      $$PollOptionsTableUpdateCompanionBuilder,
      (
        PollOption,
        BaseReferences<_$SigmaDatabase, $PollOptionsTable, PollOption>,
      ),
      PollOption,
      PrefetchHooks Function()
    >;
typedef $$PollVotesTableCreateCompanionBuilder =
    PollVotesCompanion Function({
      required String id,
      Value<String?> pollId,
      Value<String?> optionId,
      Value<String?> userId,
      Value<int?> createdAt,
      Value<int> rowid,
    });
typedef $$PollVotesTableUpdateCompanionBuilder =
    PollVotesCompanion Function({
      Value<String> id,
      Value<String?> pollId,
      Value<String?> optionId,
      Value<String?> userId,
      Value<int?> createdAt,
      Value<int> rowid,
    });

class $$PollVotesTableFilterComposer
    extends Composer<_$SigmaDatabase, $PollVotesTable> {
  $$PollVotesTableFilterComposer({
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

  ColumnFilters<String> get pollId => $composableBuilder(
    column: $table.pollId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionId => $composableBuilder(
    column: $table.optionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PollVotesTableOrderingComposer
    extends Composer<_$SigmaDatabase, $PollVotesTable> {
  $$PollVotesTableOrderingComposer({
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

  ColumnOrderings<String> get pollId => $composableBuilder(
    column: $table.pollId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionId => $composableBuilder(
    column: $table.optionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PollVotesTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $PollVotesTable> {
  $$PollVotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pollId =>
      $composableBuilder(column: $table.pollId, builder: (column) => column);

  GeneratedColumn<String> get optionId =>
      $composableBuilder(column: $table.optionId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PollVotesTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $PollVotesTable,
          PollVote,
          $$PollVotesTableFilterComposer,
          $$PollVotesTableOrderingComposer,
          $$PollVotesTableAnnotationComposer,
          $$PollVotesTableCreateCompanionBuilder,
          $$PollVotesTableUpdateCompanionBuilder,
          (
            PollVote,
            BaseReferences<_$SigmaDatabase, $PollVotesTable, PollVote>,
          ),
          PollVote,
          PrefetchHooks Function()
        > {
  $$PollVotesTableTableManager(_$SigmaDatabase db, $PollVotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PollVotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PollVotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PollVotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> pollId = const Value.absent(),
                Value<String?> optionId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PollVotesCompanion(
                id: id,
                pollId: pollId,
                optionId: optionId,
                userId: userId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> pollId = const Value.absent(),
                Value<String?> optionId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PollVotesCompanion.insert(
                id: id,
                pollId: pollId,
                optionId: optionId,
                userId: userId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PollVotesTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $PollVotesTable,
      PollVote,
      $$PollVotesTableFilterComposer,
      $$PollVotesTableOrderingComposer,
      $$PollVotesTableAnnotationComposer,
      $$PollVotesTableCreateCompanionBuilder,
      $$PollVotesTableUpdateCompanionBuilder,
      (PollVote, BaseReferences<_$SigmaDatabase, $PollVotesTable, PollVote>),
      PollVote,
      PrefetchHooks Function()
    >;
typedef $$OutboxQueueTableCreateCompanionBuilder =
    OutboxQueueCompanion Function({
      required String id,
      Value<String?> messageId,
      Value<String?> payload,
      Value<String?> status,
      Value<int?> createdAt,
      Value<int> rowid,
    });
typedef $$OutboxQueueTableUpdateCompanionBuilder =
    OutboxQueueCompanion Function({
      Value<String> id,
      Value<String?> messageId,
      Value<String?> payload,
      Value<String?> status,
      Value<int?> createdAt,
      Value<int> rowid,
    });

class $$OutboxQueueTableFilterComposer
    extends Composer<_$SigmaDatabase, $OutboxQueueTable> {
  $$OutboxQueueTableFilterComposer({
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

  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OutboxQueueTableOrderingComposer
    extends Composer<_$SigmaDatabase, $OutboxQueueTable> {
  $$OutboxQueueTableOrderingComposer({
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

  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OutboxQueueTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $OutboxQueueTable> {
  $$OutboxQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OutboxQueueTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $OutboxQueueTable,
          OutboxQueueData,
          $$OutboxQueueTableFilterComposer,
          $$OutboxQueueTableOrderingComposer,
          $$OutboxQueueTableAnnotationComposer,
          $$OutboxQueueTableCreateCompanionBuilder,
          $$OutboxQueueTableUpdateCompanionBuilder,
          (
            OutboxQueueData,
            BaseReferences<_$SigmaDatabase, $OutboxQueueTable, OutboxQueueData>,
          ),
          OutboxQueueData,
          PrefetchHooks Function()
        > {
  $$OutboxQueueTableTableManager(_$SigmaDatabase db, $OutboxQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> messageId = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OutboxQueueCompanion(
                id: id,
                messageId: messageId,
                payload: payload,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> messageId = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OutboxQueueCompanion.insert(
                id: id,
                messageId: messageId,
                payload: payload,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OutboxQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $OutboxQueueTable,
      OutboxQueueData,
      $$OutboxQueueTableFilterComposer,
      $$OutboxQueueTableOrderingComposer,
      $$OutboxQueueTableAnnotationComposer,
      $$OutboxQueueTableCreateCompanionBuilder,
      $$OutboxQueueTableUpdateCompanionBuilder,
      (
        OutboxQueueData,
        BaseReferences<_$SigmaDatabase, $OutboxQueueTable, OutboxQueueData>,
      ),
      OutboxQueueData,
      PrefetchHooks Function()
    >;
typedef $$KeyValuesTableCreateCompanionBuilder =
    KeyValuesCompanion Function({
      required String key,
      Value<String?> value,
      Value<int> rowid,
    });
typedef $$KeyValuesTableUpdateCompanionBuilder =
    KeyValuesCompanion Function({
      Value<String> key,
      Value<String?> value,
      Value<int> rowid,
    });

class $$KeyValuesTableFilterComposer
    extends Composer<_$SigmaDatabase, $KeyValuesTable> {
  $$KeyValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KeyValuesTableOrderingComposer
    extends Composer<_$SigmaDatabase, $KeyValuesTable> {
  $$KeyValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KeyValuesTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $KeyValuesTable> {
  $$KeyValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$KeyValuesTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $KeyValuesTable,
          KeyValue,
          $$KeyValuesTableFilterComposer,
          $$KeyValuesTableOrderingComposer,
          $$KeyValuesTableAnnotationComposer,
          $$KeyValuesTableCreateCompanionBuilder,
          $$KeyValuesTableUpdateCompanionBuilder,
          (
            KeyValue,
            BaseReferences<_$SigmaDatabase, $KeyValuesTable, KeyValue>,
          ),
          KeyValue,
          PrefetchHooks Function()
        > {
  $$KeyValuesTableTableManager(_$SigmaDatabase db, $KeyValuesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KeyValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KeyValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KeyValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KeyValuesCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KeyValuesCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KeyValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $KeyValuesTable,
      KeyValue,
      $$KeyValuesTableFilterComposer,
      $$KeyValuesTableOrderingComposer,
      $$KeyValuesTableAnnotationComposer,
      $$KeyValuesTableCreateCompanionBuilder,
      $$KeyValuesTableUpdateCompanionBuilder,
      (KeyValue, BaseReferences<_$SigmaDatabase, $KeyValuesTable, KeyValue>),
      KeyValue,
      PrefetchHooks Function()
    >;
typedef $$JobsTableCreateCompanionBuilder =
    JobsCompanion Function({
      Value<int> id,
      required String factoryKey,
      Value<String?> queueKey,
      required String data,
      Value<int> priority,
      Value<int> runAttempt,
      required int createTime,
      required int nextRunAttemptTime,
      Value<bool> isRunning,
    });
typedef $$JobsTableUpdateCompanionBuilder =
    JobsCompanion Function({
      Value<int> id,
      Value<String> factoryKey,
      Value<String?> queueKey,
      Value<String> data,
      Value<int> priority,
      Value<int> runAttempt,
      Value<int> createTime,
      Value<int> nextRunAttemptTime,
      Value<bool> isRunning,
    });

class $$JobsTableFilterComposer extends Composer<_$SigmaDatabase, $JobsTable> {
  $$JobsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get factoryKey => $composableBuilder(
    column: $table.factoryKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get queueKey => $composableBuilder(
    column: $table.queueKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get runAttempt => $composableBuilder(
    column: $table.runAttempt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextRunAttemptTime => $composableBuilder(
    column: $table.nextRunAttemptTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRunning => $composableBuilder(
    column: $table.isRunning,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JobsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $JobsTable> {
  $$JobsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get factoryKey => $composableBuilder(
    column: $table.factoryKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get queueKey => $composableBuilder(
    column: $table.queueKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get runAttempt => $composableBuilder(
    column: $table.runAttempt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextRunAttemptTime => $composableBuilder(
    column: $table.nextRunAttemptTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRunning => $composableBuilder(
    column: $table.isRunning,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JobsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $JobsTable> {
  $$JobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get factoryKey => $composableBuilder(
    column: $table.factoryKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get queueKey =>
      $composableBuilder(column: $table.queueKey, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get runAttempt => $composableBuilder(
    column: $table.runAttempt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextRunAttemptTime => $composableBuilder(
    column: $table.nextRunAttemptTime,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRunning =>
      $composableBuilder(column: $table.isRunning, builder: (column) => column);
}

class $$JobsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $JobsTable,
          JobRecord,
          $$JobsTableFilterComposer,
          $$JobsTableOrderingComposer,
          $$JobsTableAnnotationComposer,
          $$JobsTableCreateCompanionBuilder,
          $$JobsTableUpdateCompanionBuilder,
          (JobRecord, BaseReferences<_$SigmaDatabase, $JobsTable, JobRecord>),
          JobRecord,
          PrefetchHooks Function()
        > {
  $$JobsTableTableManager(_$SigmaDatabase db, $JobsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> factoryKey = const Value.absent(),
                Value<String?> queueKey = const Value.absent(),
                Value<String> data = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> runAttempt = const Value.absent(),
                Value<int> createTime = const Value.absent(),
                Value<int> nextRunAttemptTime = const Value.absent(),
                Value<bool> isRunning = const Value.absent(),
              }) => JobsCompanion(
                id: id,
                factoryKey: factoryKey,
                queueKey: queueKey,
                data: data,
                priority: priority,
                runAttempt: runAttempt,
                createTime: createTime,
                nextRunAttemptTime: nextRunAttemptTime,
                isRunning: isRunning,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String factoryKey,
                Value<String?> queueKey = const Value.absent(),
                required String data,
                Value<int> priority = const Value.absent(),
                Value<int> runAttempt = const Value.absent(),
                required int createTime,
                required int nextRunAttemptTime,
                Value<bool> isRunning = const Value.absent(),
              }) => JobsCompanion.insert(
                id: id,
                factoryKey: factoryKey,
                queueKey: queueKey,
                data: data,
                priority: priority,
                runAttempt: runAttempt,
                createTime: createTime,
                nextRunAttemptTime: nextRunAttemptTime,
                isRunning: isRunning,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JobsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $JobsTable,
      JobRecord,
      $$JobsTableFilterComposer,
      $$JobsTableOrderingComposer,
      $$JobsTableAnnotationComposer,
      $$JobsTableCreateCompanionBuilder,
      $$JobsTableUpdateCompanionBuilder,
      (JobRecord, BaseReferences<_$SigmaDatabase, $JobsTable, JobRecord>),
      JobRecord,
      PrefetchHooks Function()
    >;

class $SigmaDatabaseManager {
  final _$SigmaDatabase _db;
  $SigmaDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$DevicesTableTableManager get devices =>
      $$DevicesTableTableManager(_db, _db.devices);
  $$ConversationsTableTableManager get conversations =>
      $$ConversationsTableTableManager(_db, _db.conversations);
  $$ConversationMembersTableTableManager get conversationMembers =>
      $$ConversationMembersTableTableManager(_db, _db.conversationMembers);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$ReactionsTableTableManager get reactions =>
      $$ReactionsTableTableManager(_db, _db.reactions);
  $$MessageLocationsTableTableManager get messageLocations =>
      $$MessageLocationsTableTableManager(_db, _db.messageLocations);
  $$DeliveryLogsTableTableManager get deliveryLogs =>
      $$DeliveryLogsTableTableManager(_db, _db.deliveryLogs);
  $$PollsTableTableManager get polls =>
      $$PollsTableTableManager(_db, _db.polls);
  $$PollOptionsTableTableManager get pollOptions =>
      $$PollOptionsTableTableManager(_db, _db.pollOptions);
  $$PollVotesTableTableManager get pollVotes =>
      $$PollVotesTableTableManager(_db, _db.pollVotes);
  $$OutboxQueueTableTableManager get outboxQueue =>
      $$OutboxQueueTableTableManager(_db, _db.outboxQueue);
  $$KeyValuesTableTableManager get keyValues =>
      $$KeyValuesTableTableManager(_db, _db.keyValues);
  $$JobsTableTableManager get jobs => $$JobsTableTableManager(_db, _db.jobs);
}
