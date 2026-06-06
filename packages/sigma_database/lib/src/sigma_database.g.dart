// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sigma_database.dart';

// ignore_for_file: type=lint
class $RecipientsTable extends Recipients
    with TableInfo<$RecipientsTable, RecipientData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aciMeta = const VerificationMeta('aci');
  @override
  late final GeneratedColumn<String> aci = GeneratedColumn<String>(
    'aci',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _pniMeta = const VerificationMeta('pni');
  @override
  late final GeneratedColumn<String> pni = GeneratedColumn<String>(
    'pni',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RecipientTypeDb, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<RecipientTypeDb>($RecipientsTable.$convertertype);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
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
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _systemDisplayNameMeta = const VerificationMeta(
    'systemDisplayName',
  );
  @override
  late final GeneratedColumn<String> systemDisplayName =
      GeneratedColumn<String>(
        'system_display_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _profileNameMeta = const VerificationMeta(
    'profileName',
  );
  @override
  late final GeneratedColumn<String> profileName = GeneratedColumn<String>(
    'profile_name',
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
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relativeNameMeta = const VerificationMeta(
    'relativeName',
  );
  @override
  late final GeneratedColumn<String> relativeName = GeneratedColumn<String>(
    'relative_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relativeIdMeta = const VerificationMeta(
    'relativeId',
  );
  @override
  late final GeneratedColumn<String> relativeId = GeneratedColumn<String>(
    'relative_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _identityKeyMeta = const VerificationMeta(
    'identityKey',
  );
  @override
  late final GeneratedColumn<String> identityKey = GeneratedColumn<String>(
    'identity_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _signedPreKeyIdMeta = const VerificationMeta(
    'signedPreKeyId',
  );
  @override
  late final GeneratedColumn<int> signedPreKeyId = GeneratedColumn<int>(
    'signed_pre_key_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _signedPreKeyPublicMeta =
      const VerificationMeta('signedPreKeyPublic');
  @override
  late final GeneratedColumn<String> signedPreKeyPublic =
      GeneratedColumn<String>(
        'signed_pre_key_public',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _signedPreKeySignatureMeta =
      const VerificationMeta('signedPreKeySignature');
  @override
  late final GeneratedColumn<String> signedPreKeySignature =
      GeneratedColumn<String>(
        'signed_pre_key_signature',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _registrationIdMeta = const VerificationMeta(
    'registrationId',
  );
  @override
  late final GeneratedColumn<BigInt> registrationId = GeneratedColumn<BigInt>(
    'registration_id',
    aliasedName,
    true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preKeysMeta = const VerificationMeta(
    'preKeys',
  );
  @override
  late final GeneratedColumn<String> preKeys = GeneratedColumn<String>(
    'pre_keys',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPrivateMeta = const VerificationMeta(
    'isPrivate',
  );
  @override
  late final GeneratedColumn<bool> isPrivate = GeneratedColumn<bool>(
    'is_private',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_private" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _profileKeyMeta = const VerificationMeta(
    'profileKey',
  );
  @override
  late final GeneratedColumn<String> profileKey = GeneratedColumn<String>(
    'profile_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isOnlineMeta = const VerificationMeta(
    'isOnline',
  );
  @override
  late final GeneratedColumn<bool> isOnline = GeneratedColumn<bool>(
    'is_online',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_online" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastSeenMeta = const VerificationMeta(
    'lastSeen',
  );
  @override
  late final GeneratedColumn<DateTime> lastSeen = GeneratedColumn<DateTime>(
    'last_seen',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fallbackColorMeta = const VerificationMeta(
    'fallbackColor',
  );
  @override
  late final GeneratedColumn<String> fallbackColor = GeneratedColumn<String>(
    'fallback_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _identityStatusMeta = const VerificationMeta(
    'identityStatus',
  );
  @override
  late final GeneratedColumn<int> identityStatus = GeneratedColumn<int>(
    'identity_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    aci,
    pni,
    type,
    phone,
    email,
    username,
    displayName,
    systemDisplayName,
    profileName,
    avatarUrl,
    bio,
    country,
    relativeName,
    relativeId,
    identityKey,
    signedPreKeyId,
    signedPreKeyPublic,
    signedPreKeySignature,
    registrationId,
    preKeys,
    isPrivate,
    profileKey,
    isOnline,
    lastSeen,
    fallbackColor,
    identityStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipients';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipientData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('aci')) {
      context.handle(
        _aciMeta,
        aci.isAcceptableOrUnknown(data['aci']!, _aciMeta),
      );
    }
    if (data.containsKey('pni')) {
      context.handle(
        _pniMeta,
        pni.isAcceptableOrUnknown(data['pni']!, _pniMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('system_display_name')) {
      context.handle(
        _systemDisplayNameMeta,
        systemDisplayName.isAcceptableOrUnknown(
          data['system_display_name']!,
          _systemDisplayNameMeta,
        ),
      );
    }
    if (data.containsKey('profile_name')) {
      context.handle(
        _profileNameMeta,
        profileName.isAcceptableOrUnknown(
          data['profile_name']!,
          _profileNameMeta,
        ),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('bio')) {
      context.handle(
        _bioMeta,
        bio.isAcceptableOrUnknown(data['bio']!, _bioMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('relative_name')) {
      context.handle(
        _relativeNameMeta,
        relativeName.isAcceptableOrUnknown(
          data['relative_name']!,
          _relativeNameMeta,
        ),
      );
    }
    if (data.containsKey('relative_id')) {
      context.handle(
        _relativeIdMeta,
        relativeId.isAcceptableOrUnknown(data['relative_id']!, _relativeIdMeta),
      );
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
    if (data.containsKey('signed_pre_key_id')) {
      context.handle(
        _signedPreKeyIdMeta,
        signedPreKeyId.isAcceptableOrUnknown(
          data['signed_pre_key_id']!,
          _signedPreKeyIdMeta,
        ),
      );
    }
    if (data.containsKey('signed_pre_key_public')) {
      context.handle(
        _signedPreKeyPublicMeta,
        signedPreKeyPublic.isAcceptableOrUnknown(
          data['signed_pre_key_public']!,
          _signedPreKeyPublicMeta,
        ),
      );
    }
    if (data.containsKey('signed_pre_key_signature')) {
      context.handle(
        _signedPreKeySignatureMeta,
        signedPreKeySignature.isAcceptableOrUnknown(
          data['signed_pre_key_signature']!,
          _signedPreKeySignatureMeta,
        ),
      );
    }
    if (data.containsKey('registration_id')) {
      context.handle(
        _registrationIdMeta,
        registrationId.isAcceptableOrUnknown(
          data['registration_id']!,
          _registrationIdMeta,
        ),
      );
    }
    if (data.containsKey('pre_keys')) {
      context.handle(
        _preKeysMeta,
        preKeys.isAcceptableOrUnknown(data['pre_keys']!, _preKeysMeta),
      );
    }
    if (data.containsKey('is_private')) {
      context.handle(
        _isPrivateMeta,
        isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta),
      );
    }
    if (data.containsKey('profile_key')) {
      context.handle(
        _profileKeyMeta,
        profileKey.isAcceptableOrUnknown(data['profile_key']!, _profileKeyMeta),
      );
    }
    if (data.containsKey('is_online')) {
      context.handle(
        _isOnlineMeta,
        isOnline.isAcceptableOrUnknown(data['is_online']!, _isOnlineMeta),
      );
    }
    if (data.containsKey('last_seen')) {
      context.handle(
        _lastSeenMeta,
        lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta),
      );
    }
    if (data.containsKey('fallback_color')) {
      context.handle(
        _fallbackColorMeta,
        fallbackColor.isAcceptableOrUnknown(
          data['fallback_color']!,
          _fallbackColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fallbackColorMeta);
    }
    if (data.containsKey('identity_status')) {
      context.handle(
        _identityStatusMeta,
        identityStatus.isAcceptableOrUnknown(
          data['identity_status']!,
          _identityStatusMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipientData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipientData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      aci: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aci'],
      ),
      pni: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pni'],
      ),
      type: $RecipientsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      systemDisplayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_display_name'],
      ),
      profileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_name'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      relativeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_name'],
      ),
      relativeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_id'],
      ),
      identityKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identity_key'],
      ),
      signedPreKeyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}signed_pre_key_id'],
      ),
      signedPreKeyPublic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signed_pre_key_public'],
      ),
      signedPreKeySignature: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signed_pre_key_signature'],
      ),
      registrationId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}registration_id'],
      ),
      preKeys: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pre_keys'],
      ),
      isPrivate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_private'],
      )!,
      profileKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_key'],
      ),
      isOnline: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_online'],
      )!,
      lastSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen'],
      ),
      fallbackColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fallback_color'],
      )!,
      identityStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}identity_status'],
      )!,
    );
  }

  @override
  $RecipientsTable createAlias(String alias) {
    return $RecipientsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecipientTypeDb, int, int> $convertertype =
      const EnumIndexConverter<RecipientTypeDb>(RecipientTypeDb.values);
}

class RecipientData extends DataClass implements Insertable<RecipientData> {
  final String id;
  final String? aci;
  final String? pni;
  final RecipientTypeDb type;
  final String? phone;
  final String? email;
  final String? username;
  final String? displayName;
  final String? systemDisplayName;
  final String? profileName;
  final String? avatarUrl;
  final String? bio;
  final String? country;
  final String? relativeName;
  final String? relativeId;
  final String? identityKey;
  final int? signedPreKeyId;
  final String? signedPreKeyPublic;
  final String? signedPreKeySignature;
  final BigInt? registrationId;
  final String? preKeys;
  final bool isPrivate;
  final String? profileKey;
  final bool isOnline;
  final DateTime? lastSeen;
  final String fallbackColor;
  final int identityStatus;
  const RecipientData({
    required this.id,
    this.aci,
    this.pni,
    required this.type,
    this.phone,
    this.email,
    this.username,
    this.displayName,
    this.systemDisplayName,
    this.profileName,
    this.avatarUrl,
    this.bio,
    this.country,
    this.relativeName,
    this.relativeId,
    this.identityKey,
    this.signedPreKeyId,
    this.signedPreKeyPublic,
    this.signedPreKeySignature,
    this.registrationId,
    this.preKeys,
    required this.isPrivate,
    this.profileKey,
    required this.isOnline,
    this.lastSeen,
    required this.fallbackColor,
    required this.identityStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || aci != null) {
      map['aci'] = Variable<String>(aci);
    }
    if (!nullToAbsent || pni != null) {
      map['pni'] = Variable<String>(pni);
    }
    {
      map['type'] = Variable<int>($RecipientsTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || systemDisplayName != null) {
      map['system_display_name'] = Variable<String>(systemDisplayName);
    }
    if (!nullToAbsent || profileName != null) {
      map['profile_name'] = Variable<String>(profileName);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || relativeName != null) {
      map['relative_name'] = Variable<String>(relativeName);
    }
    if (!nullToAbsent || relativeId != null) {
      map['relative_id'] = Variable<String>(relativeId);
    }
    if (!nullToAbsent || identityKey != null) {
      map['identity_key'] = Variable<String>(identityKey);
    }
    if (!nullToAbsent || signedPreKeyId != null) {
      map['signed_pre_key_id'] = Variable<int>(signedPreKeyId);
    }
    if (!nullToAbsent || signedPreKeyPublic != null) {
      map['signed_pre_key_public'] = Variable<String>(signedPreKeyPublic);
    }
    if (!nullToAbsent || signedPreKeySignature != null) {
      map['signed_pre_key_signature'] = Variable<String>(signedPreKeySignature);
    }
    if (!nullToAbsent || registrationId != null) {
      map['registration_id'] = Variable<BigInt>(registrationId);
    }
    if (!nullToAbsent || preKeys != null) {
      map['pre_keys'] = Variable<String>(preKeys);
    }
    map['is_private'] = Variable<bool>(isPrivate);
    if (!nullToAbsent || profileKey != null) {
      map['profile_key'] = Variable<String>(profileKey);
    }
    map['is_online'] = Variable<bool>(isOnline);
    if (!nullToAbsent || lastSeen != null) {
      map['last_seen'] = Variable<DateTime>(lastSeen);
    }
    map['fallback_color'] = Variable<String>(fallbackColor);
    map['identity_status'] = Variable<int>(identityStatus);
    return map;
  }

  RecipientsCompanion toCompanion(bool nullToAbsent) {
    return RecipientsCompanion(
      id: Value(id),
      aci: aci == null && nullToAbsent ? const Value.absent() : Value(aci),
      pni: pni == null && nullToAbsent ? const Value.absent() : Value(pni),
      type: Value(type),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      systemDisplayName: systemDisplayName == null && nullToAbsent
          ? const Value.absent()
          : Value(systemDisplayName),
      profileName: profileName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileName),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      relativeName: relativeName == null && nullToAbsent
          ? const Value.absent()
          : Value(relativeName),
      relativeId: relativeId == null && nullToAbsent
          ? const Value.absent()
          : Value(relativeId),
      identityKey: identityKey == null && nullToAbsent
          ? const Value.absent()
          : Value(identityKey),
      signedPreKeyId: signedPreKeyId == null && nullToAbsent
          ? const Value.absent()
          : Value(signedPreKeyId),
      signedPreKeyPublic: signedPreKeyPublic == null && nullToAbsent
          ? const Value.absent()
          : Value(signedPreKeyPublic),
      signedPreKeySignature: signedPreKeySignature == null && nullToAbsent
          ? const Value.absent()
          : Value(signedPreKeySignature),
      registrationId: registrationId == null && nullToAbsent
          ? const Value.absent()
          : Value(registrationId),
      preKeys: preKeys == null && nullToAbsent
          ? const Value.absent()
          : Value(preKeys),
      isPrivate: Value(isPrivate),
      profileKey: profileKey == null && nullToAbsent
          ? const Value.absent()
          : Value(profileKey),
      isOnline: Value(isOnline),
      lastSeen: lastSeen == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeen),
      fallbackColor: Value(fallbackColor),
      identityStatus: Value(identityStatus),
    );
  }

  factory RecipientData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipientData(
      id: serializer.fromJson<String>(json['id']),
      aci: serializer.fromJson<String?>(json['aci']),
      pni: serializer.fromJson<String?>(json['pni']),
      type: $RecipientsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      username: serializer.fromJson<String?>(json['username']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      systemDisplayName: serializer.fromJson<String?>(
        json['systemDisplayName'],
      ),
      profileName: serializer.fromJson<String?>(json['profileName']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      bio: serializer.fromJson<String?>(json['bio']),
      country: serializer.fromJson<String?>(json['country']),
      relativeName: serializer.fromJson<String?>(json['relativeName']),
      relativeId: serializer.fromJson<String?>(json['relativeId']),
      identityKey: serializer.fromJson<String?>(json['identityKey']),
      signedPreKeyId: serializer.fromJson<int?>(json['signedPreKeyId']),
      signedPreKeyPublic: serializer.fromJson<String?>(
        json['signedPreKeyPublic'],
      ),
      signedPreKeySignature: serializer.fromJson<String?>(
        json['signedPreKeySignature'],
      ),
      registrationId: serializer.fromJson<BigInt?>(json['registrationId']),
      preKeys: serializer.fromJson<String?>(json['preKeys']),
      isPrivate: serializer.fromJson<bool>(json['isPrivate']),
      profileKey: serializer.fromJson<String?>(json['profileKey']),
      isOnline: serializer.fromJson<bool>(json['isOnline']),
      lastSeen: serializer.fromJson<DateTime?>(json['lastSeen']),
      fallbackColor: serializer.fromJson<String>(json['fallbackColor']),
      identityStatus: serializer.fromJson<int>(json['identityStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'aci': serializer.toJson<String?>(aci),
      'pni': serializer.toJson<String?>(pni),
      'type': serializer.toJson<int>(
        $RecipientsTable.$convertertype.toJson(type),
      ),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'username': serializer.toJson<String?>(username),
      'displayName': serializer.toJson<String?>(displayName),
      'systemDisplayName': serializer.toJson<String?>(systemDisplayName),
      'profileName': serializer.toJson<String?>(profileName),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'bio': serializer.toJson<String?>(bio),
      'country': serializer.toJson<String?>(country),
      'relativeName': serializer.toJson<String?>(relativeName),
      'relativeId': serializer.toJson<String?>(relativeId),
      'identityKey': serializer.toJson<String?>(identityKey),
      'signedPreKeyId': serializer.toJson<int?>(signedPreKeyId),
      'signedPreKeyPublic': serializer.toJson<String?>(signedPreKeyPublic),
      'signedPreKeySignature': serializer.toJson<String?>(
        signedPreKeySignature,
      ),
      'registrationId': serializer.toJson<BigInt?>(registrationId),
      'preKeys': serializer.toJson<String?>(preKeys),
      'isPrivate': serializer.toJson<bool>(isPrivate),
      'profileKey': serializer.toJson<String?>(profileKey),
      'isOnline': serializer.toJson<bool>(isOnline),
      'lastSeen': serializer.toJson<DateTime?>(lastSeen),
      'fallbackColor': serializer.toJson<String>(fallbackColor),
      'identityStatus': serializer.toJson<int>(identityStatus),
    };
  }

  RecipientData copyWith({
    String? id,
    Value<String?> aci = const Value.absent(),
    Value<String?> pni = const Value.absent(),
    RecipientTypeDb? type,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> username = const Value.absent(),
    Value<String?> displayName = const Value.absent(),
    Value<String?> systemDisplayName = const Value.absent(),
    Value<String?> profileName = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> bio = const Value.absent(),
    Value<String?> country = const Value.absent(),
    Value<String?> relativeName = const Value.absent(),
    Value<String?> relativeId = const Value.absent(),
    Value<String?> identityKey = const Value.absent(),
    Value<int?> signedPreKeyId = const Value.absent(),
    Value<String?> signedPreKeyPublic = const Value.absent(),
    Value<String?> signedPreKeySignature = const Value.absent(),
    Value<BigInt?> registrationId = const Value.absent(),
    Value<String?> preKeys = const Value.absent(),
    bool? isPrivate,
    Value<String?> profileKey = const Value.absent(),
    bool? isOnline,
    Value<DateTime?> lastSeen = const Value.absent(),
    String? fallbackColor,
    int? identityStatus,
  }) => RecipientData(
    id: id ?? this.id,
    aci: aci.present ? aci.value : this.aci,
    pni: pni.present ? pni.value : this.pni,
    type: type ?? this.type,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    username: username.present ? username.value : this.username,
    displayName: displayName.present ? displayName.value : this.displayName,
    systemDisplayName: systemDisplayName.present
        ? systemDisplayName.value
        : this.systemDisplayName,
    profileName: profileName.present ? profileName.value : this.profileName,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    bio: bio.present ? bio.value : this.bio,
    country: country.present ? country.value : this.country,
    relativeName: relativeName.present ? relativeName.value : this.relativeName,
    relativeId: relativeId.present ? relativeId.value : this.relativeId,
    identityKey: identityKey.present ? identityKey.value : this.identityKey,
    signedPreKeyId: signedPreKeyId.present
        ? signedPreKeyId.value
        : this.signedPreKeyId,
    signedPreKeyPublic: signedPreKeyPublic.present
        ? signedPreKeyPublic.value
        : this.signedPreKeyPublic,
    signedPreKeySignature: signedPreKeySignature.present
        ? signedPreKeySignature.value
        : this.signedPreKeySignature,
    registrationId: registrationId.present
        ? registrationId.value
        : this.registrationId,
    preKeys: preKeys.present ? preKeys.value : this.preKeys,
    isPrivate: isPrivate ?? this.isPrivate,
    profileKey: profileKey.present ? profileKey.value : this.profileKey,
    isOnline: isOnline ?? this.isOnline,
    lastSeen: lastSeen.present ? lastSeen.value : this.lastSeen,
    fallbackColor: fallbackColor ?? this.fallbackColor,
    identityStatus: identityStatus ?? this.identityStatus,
  );
  RecipientData copyWithCompanion(RecipientsCompanion data) {
    return RecipientData(
      id: data.id.present ? data.id.value : this.id,
      aci: data.aci.present ? data.aci.value : this.aci,
      pni: data.pni.present ? data.pni.value : this.pni,
      type: data.type.present ? data.type.value : this.type,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      username: data.username.present ? data.username.value : this.username,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      systemDisplayName: data.systemDisplayName.present
          ? data.systemDisplayName.value
          : this.systemDisplayName,
      profileName: data.profileName.present
          ? data.profileName.value
          : this.profileName,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      bio: data.bio.present ? data.bio.value : this.bio,
      country: data.country.present ? data.country.value : this.country,
      relativeName: data.relativeName.present
          ? data.relativeName.value
          : this.relativeName,
      relativeId: data.relativeId.present
          ? data.relativeId.value
          : this.relativeId,
      identityKey: data.identityKey.present
          ? data.identityKey.value
          : this.identityKey,
      signedPreKeyId: data.signedPreKeyId.present
          ? data.signedPreKeyId.value
          : this.signedPreKeyId,
      signedPreKeyPublic: data.signedPreKeyPublic.present
          ? data.signedPreKeyPublic.value
          : this.signedPreKeyPublic,
      signedPreKeySignature: data.signedPreKeySignature.present
          ? data.signedPreKeySignature.value
          : this.signedPreKeySignature,
      registrationId: data.registrationId.present
          ? data.registrationId.value
          : this.registrationId,
      preKeys: data.preKeys.present ? data.preKeys.value : this.preKeys,
      isPrivate: data.isPrivate.present ? data.isPrivate.value : this.isPrivate,
      profileKey: data.profileKey.present
          ? data.profileKey.value
          : this.profileKey,
      isOnline: data.isOnline.present ? data.isOnline.value : this.isOnline,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
      fallbackColor: data.fallbackColor.present
          ? data.fallbackColor.value
          : this.fallbackColor,
      identityStatus: data.identityStatus.present
          ? data.identityStatus.value
          : this.identityStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipientData(')
          ..write('id: $id, ')
          ..write('aci: $aci, ')
          ..write('pni: $pni, ')
          ..write('type: $type, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('systemDisplayName: $systemDisplayName, ')
          ..write('profileName: $profileName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('bio: $bio, ')
          ..write('country: $country, ')
          ..write('relativeName: $relativeName, ')
          ..write('relativeId: $relativeId, ')
          ..write('identityKey: $identityKey, ')
          ..write('signedPreKeyId: $signedPreKeyId, ')
          ..write('signedPreKeyPublic: $signedPreKeyPublic, ')
          ..write('signedPreKeySignature: $signedPreKeySignature, ')
          ..write('registrationId: $registrationId, ')
          ..write('preKeys: $preKeys, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('profileKey: $profileKey, ')
          ..write('isOnline: $isOnline, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('fallbackColor: $fallbackColor, ')
          ..write('identityStatus: $identityStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    aci,
    pni,
    type,
    phone,
    email,
    username,
    displayName,
    systemDisplayName,
    profileName,
    avatarUrl,
    bio,
    country,
    relativeName,
    relativeId,
    identityKey,
    signedPreKeyId,
    signedPreKeyPublic,
    signedPreKeySignature,
    registrationId,
    preKeys,
    isPrivate,
    profileKey,
    isOnline,
    lastSeen,
    fallbackColor,
    identityStatus,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipientData &&
          other.id == this.id &&
          other.aci == this.aci &&
          other.pni == this.pni &&
          other.type == this.type &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.username == this.username &&
          other.displayName == this.displayName &&
          other.systemDisplayName == this.systemDisplayName &&
          other.profileName == this.profileName &&
          other.avatarUrl == this.avatarUrl &&
          other.bio == this.bio &&
          other.country == this.country &&
          other.relativeName == this.relativeName &&
          other.relativeId == this.relativeId &&
          other.identityKey == this.identityKey &&
          other.signedPreKeyId == this.signedPreKeyId &&
          other.signedPreKeyPublic == this.signedPreKeyPublic &&
          other.signedPreKeySignature == this.signedPreKeySignature &&
          other.registrationId == this.registrationId &&
          other.preKeys == this.preKeys &&
          other.isPrivate == this.isPrivate &&
          other.profileKey == this.profileKey &&
          other.isOnline == this.isOnline &&
          other.lastSeen == this.lastSeen &&
          other.fallbackColor == this.fallbackColor &&
          other.identityStatus == this.identityStatus);
}

class RecipientsCompanion extends UpdateCompanion<RecipientData> {
  final Value<String> id;
  final Value<String?> aci;
  final Value<String?> pni;
  final Value<RecipientTypeDb> type;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> username;
  final Value<String?> displayName;
  final Value<String?> systemDisplayName;
  final Value<String?> profileName;
  final Value<String?> avatarUrl;
  final Value<String?> bio;
  final Value<String?> country;
  final Value<String?> relativeName;
  final Value<String?> relativeId;
  final Value<String?> identityKey;
  final Value<int?> signedPreKeyId;
  final Value<String?> signedPreKeyPublic;
  final Value<String?> signedPreKeySignature;
  final Value<BigInt?> registrationId;
  final Value<String?> preKeys;
  final Value<bool> isPrivate;
  final Value<String?> profileKey;
  final Value<bool> isOnline;
  final Value<DateTime?> lastSeen;
  final Value<String> fallbackColor;
  final Value<int> identityStatus;
  final Value<int> rowid;
  const RecipientsCompanion({
    this.id = const Value.absent(),
    this.aci = const Value.absent(),
    this.pni = const Value.absent(),
    this.type = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.username = const Value.absent(),
    this.displayName = const Value.absent(),
    this.systemDisplayName = const Value.absent(),
    this.profileName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.bio = const Value.absent(),
    this.country = const Value.absent(),
    this.relativeName = const Value.absent(),
    this.relativeId = const Value.absent(),
    this.identityKey = const Value.absent(),
    this.signedPreKeyId = const Value.absent(),
    this.signedPreKeyPublic = const Value.absent(),
    this.signedPreKeySignature = const Value.absent(),
    this.registrationId = const Value.absent(),
    this.preKeys = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.profileKey = const Value.absent(),
    this.isOnline = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.fallbackColor = const Value.absent(),
    this.identityStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipientsCompanion.insert({
    required String id,
    this.aci = const Value.absent(),
    this.pni = const Value.absent(),
    required RecipientTypeDb type,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.username = const Value.absent(),
    this.displayName = const Value.absent(),
    this.systemDisplayName = const Value.absent(),
    this.profileName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.bio = const Value.absent(),
    this.country = const Value.absent(),
    this.relativeName = const Value.absent(),
    this.relativeId = const Value.absent(),
    this.identityKey = const Value.absent(),
    this.signedPreKeyId = const Value.absent(),
    this.signedPreKeyPublic = const Value.absent(),
    this.signedPreKeySignature = const Value.absent(),
    this.registrationId = const Value.absent(),
    this.preKeys = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.profileKey = const Value.absent(),
    this.isOnline = const Value.absent(),
    this.lastSeen = const Value.absent(),
    required String fallbackColor,
    this.identityStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       fallbackColor = Value(fallbackColor);
  static Insertable<RecipientData> custom({
    Expression<String>? id,
    Expression<String>? aci,
    Expression<String>? pni,
    Expression<int>? type,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? username,
    Expression<String>? displayName,
    Expression<String>? systemDisplayName,
    Expression<String>? profileName,
    Expression<String>? avatarUrl,
    Expression<String>? bio,
    Expression<String>? country,
    Expression<String>? relativeName,
    Expression<String>? relativeId,
    Expression<String>? identityKey,
    Expression<int>? signedPreKeyId,
    Expression<String>? signedPreKeyPublic,
    Expression<String>? signedPreKeySignature,
    Expression<BigInt>? registrationId,
    Expression<String>? preKeys,
    Expression<bool>? isPrivate,
    Expression<String>? profileKey,
    Expression<bool>? isOnline,
    Expression<DateTime>? lastSeen,
    Expression<String>? fallbackColor,
    Expression<int>? identityStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (aci != null) 'aci': aci,
      if (pni != null) 'pni': pni,
      if (type != null) 'type': type,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (username != null) 'username': username,
      if (displayName != null) 'display_name': displayName,
      if (systemDisplayName != null) 'system_display_name': systemDisplayName,
      if (profileName != null) 'profile_name': profileName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (bio != null) 'bio': bio,
      if (country != null) 'country': country,
      if (relativeName != null) 'relative_name': relativeName,
      if (relativeId != null) 'relative_id': relativeId,
      if (identityKey != null) 'identity_key': identityKey,
      if (signedPreKeyId != null) 'signed_pre_key_id': signedPreKeyId,
      if (signedPreKeyPublic != null)
        'signed_pre_key_public': signedPreKeyPublic,
      if (signedPreKeySignature != null)
        'signed_pre_key_signature': signedPreKeySignature,
      if (registrationId != null) 'registration_id': registrationId,
      if (preKeys != null) 'pre_keys': preKeys,
      if (isPrivate != null) 'is_private': isPrivate,
      if (profileKey != null) 'profile_key': profileKey,
      if (isOnline != null) 'is_online': isOnline,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (fallbackColor != null) 'fallback_color': fallbackColor,
      if (identityStatus != null) 'identity_status': identityStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipientsCompanion copyWith({
    Value<String>? id,
    Value<String?>? aci,
    Value<String?>? pni,
    Value<RecipientTypeDb>? type,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? username,
    Value<String?>? displayName,
    Value<String?>? systemDisplayName,
    Value<String?>? profileName,
    Value<String?>? avatarUrl,
    Value<String?>? bio,
    Value<String?>? country,
    Value<String?>? relativeName,
    Value<String?>? relativeId,
    Value<String?>? identityKey,
    Value<int?>? signedPreKeyId,
    Value<String?>? signedPreKeyPublic,
    Value<String?>? signedPreKeySignature,
    Value<BigInt?>? registrationId,
    Value<String?>? preKeys,
    Value<bool>? isPrivate,
    Value<String?>? profileKey,
    Value<bool>? isOnline,
    Value<DateTime?>? lastSeen,
    Value<String>? fallbackColor,
    Value<int>? identityStatus,
    Value<int>? rowid,
  }) {
    return RecipientsCompanion(
      id: id ?? this.id,
      aci: aci ?? this.aci,
      pni: pni ?? this.pni,
      type: type ?? this.type,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      systemDisplayName: systemDisplayName ?? this.systemDisplayName,
      profileName: profileName ?? this.profileName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      country: country ?? this.country,
      relativeName: relativeName ?? this.relativeName,
      relativeId: relativeId ?? this.relativeId,
      identityKey: identityKey ?? this.identityKey,
      signedPreKeyId: signedPreKeyId ?? this.signedPreKeyId,
      signedPreKeyPublic: signedPreKeyPublic ?? this.signedPreKeyPublic,
      signedPreKeySignature:
          signedPreKeySignature ?? this.signedPreKeySignature,
      registrationId: registrationId ?? this.registrationId,
      preKeys: preKeys ?? this.preKeys,
      isPrivate: isPrivate ?? this.isPrivate,
      profileKey: profileKey ?? this.profileKey,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      fallbackColor: fallbackColor ?? this.fallbackColor,
      identityStatus: identityStatus ?? this.identityStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (aci.present) {
      map['aci'] = Variable<String>(aci.value);
    }
    if (pni.present) {
      map['pni'] = Variable<String>(pni.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $RecipientsTable.$convertertype.toSql(type.value),
      );
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (systemDisplayName.present) {
      map['system_display_name'] = Variable<String>(systemDisplayName.value);
    }
    if (profileName.present) {
      map['profile_name'] = Variable<String>(profileName.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (relativeName.present) {
      map['relative_name'] = Variable<String>(relativeName.value);
    }
    if (relativeId.present) {
      map['relative_id'] = Variable<String>(relativeId.value);
    }
    if (identityKey.present) {
      map['identity_key'] = Variable<String>(identityKey.value);
    }
    if (signedPreKeyId.present) {
      map['signed_pre_key_id'] = Variable<int>(signedPreKeyId.value);
    }
    if (signedPreKeyPublic.present) {
      map['signed_pre_key_public'] = Variable<String>(signedPreKeyPublic.value);
    }
    if (signedPreKeySignature.present) {
      map['signed_pre_key_signature'] = Variable<String>(
        signedPreKeySignature.value,
      );
    }
    if (registrationId.present) {
      map['registration_id'] = Variable<BigInt>(registrationId.value);
    }
    if (preKeys.present) {
      map['pre_keys'] = Variable<String>(preKeys.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (profileKey.present) {
      map['profile_key'] = Variable<String>(profileKey.value);
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<DateTime>(lastSeen.value);
    }
    if (fallbackColor.present) {
      map['fallback_color'] = Variable<String>(fallbackColor.value);
    }
    if (identityStatus.present) {
      map['identity_status'] = Variable<int>(identityStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipientsCompanion(')
          ..write('id: $id, ')
          ..write('aci: $aci, ')
          ..write('pni: $pni, ')
          ..write('type: $type, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('systemDisplayName: $systemDisplayName, ')
          ..write('profileName: $profileName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('bio: $bio, ')
          ..write('country: $country, ')
          ..write('relativeName: $relativeName, ')
          ..write('relativeId: $relativeId, ')
          ..write('identityKey: $identityKey, ')
          ..write('signedPreKeyId: $signedPreKeyId, ')
          ..write('signedPreKeyPublic: $signedPreKeyPublic, ')
          ..write('signedPreKeySignature: $signedPreKeySignature, ')
          ..write('registrationId: $registrationId, ')
          ..write('preKeys: $preKeys, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('profileKey: $profileKey, ')
          ..write('isOnline: $isOnline, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('fallbackColor: $fallbackColor, ')
          ..write('identityStatus: $identityStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThreadsTable extends Threads with TableInfo<$ThreadsTable, ThreadData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThreadsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _recipientIdMeta = const VerificationMeta(
    'recipientId',
  );
  @override
  late final GeneratedColumn<String> recipientId = GeneratedColumn<String>(
    'recipient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipients (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snippetMeta = const VerificationMeta(
    'snippet',
  );
  @override
  late final GeneratedColumn<String> snippet = GeneratedColumn<String>(
    'snippet',
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
  static const VerificationMeta _pinnedOrderMeta = const VerificationMeta(
    'pinnedOrder',
  );
  @override
  late final GeneratedColumn<int> pinnedOrder = GeneratedColumn<int>(
    'pinned_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _muteUntilMeta = const VerificationMeta(
    'muteUntil',
  );
  @override
  late final GeneratedColumn<int> muteUntil = GeneratedColumn<int>(
    'mute_until',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isMarkedUnreadMeta = const VerificationMeta(
    'isMarkedUnread',
  );
  @override
  late final GeneratedColumn<bool> isMarkedUnread = GeneratedColumn<bool>(
    'is_marked_unread',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_marked_unread" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipientId,
    date,
    snippet,
    unreadCount,
    isArchived,
    pinnedOrder,
    muteUntil,
    isMarkedUnread,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'threads';
  @override
  VerificationContext validateIntegrity(
    Insertable<ThreadData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipient_id')) {
      context.handle(
        _recipientIdMeta,
        recipientId.isAcceptableOrUnknown(
          data['recipient_id']!,
          _recipientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recipientIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('snippet')) {
      context.handle(
        _snippetMeta,
        snippet.isAcceptableOrUnknown(data['snippet']!, _snippetMeta),
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
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('pinned_order')) {
      context.handle(
        _pinnedOrderMeta,
        pinnedOrder.isAcceptableOrUnknown(
          data['pinned_order']!,
          _pinnedOrderMeta,
        ),
      );
    }
    if (data.containsKey('mute_until')) {
      context.handle(
        _muteUntilMeta,
        muteUntil.isAcceptableOrUnknown(data['mute_until']!, _muteUntilMeta),
      );
    }
    if (data.containsKey('is_marked_unread')) {
      context.handle(
        _isMarkedUnreadMeta,
        isMarkedUnread.isAcceptableOrUnknown(
          data['is_marked_unread']!,
          _isMarkedUnreadMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ThreadData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ThreadData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date'],
      )!,
      snippet: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snippet'],
      ),
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      pinnedOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pinned_order'],
      )!,
      muteUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mute_until'],
      )!,
      isMarkedUnread: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_marked_unread'],
      )!,
    );
  }

  @override
  $ThreadsTable createAlias(String alias) {
    return $ThreadsTable(attachedDatabase, alias);
  }
}

class ThreadData extends DataClass implements Insertable<ThreadData> {
  final int id;
  final String recipientId;
  final int date;
  final String? snippet;
  final int unreadCount;
  final bool isArchived;
  final int pinnedOrder;
  final int muteUntil;
  final bool isMarkedUnread;
  const ThreadData({
    required this.id,
    required this.recipientId,
    required this.date,
    this.snippet,
    required this.unreadCount,
    required this.isArchived,
    required this.pinnedOrder,
    required this.muteUntil,
    required this.isMarkedUnread,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipient_id'] = Variable<String>(recipientId);
    map['date'] = Variable<int>(date);
    if (!nullToAbsent || snippet != null) {
      map['snippet'] = Variable<String>(snippet);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    map['is_archived'] = Variable<bool>(isArchived);
    map['pinned_order'] = Variable<int>(pinnedOrder);
    map['mute_until'] = Variable<int>(muteUntil);
    map['is_marked_unread'] = Variable<bool>(isMarkedUnread);
    return map;
  }

  ThreadsCompanion toCompanion(bool nullToAbsent) {
    return ThreadsCompanion(
      id: Value(id),
      recipientId: Value(recipientId),
      date: Value(date),
      snippet: snippet == null && nullToAbsent
          ? const Value.absent()
          : Value(snippet),
      unreadCount: Value(unreadCount),
      isArchived: Value(isArchived),
      pinnedOrder: Value(pinnedOrder),
      muteUntil: Value(muteUntil),
      isMarkedUnread: Value(isMarkedUnread),
    );
  }

  factory ThreadData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ThreadData(
      id: serializer.fromJson<int>(json['id']),
      recipientId: serializer.fromJson<String>(json['recipientId']),
      date: serializer.fromJson<int>(json['date']),
      snippet: serializer.fromJson<String?>(json['snippet']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      pinnedOrder: serializer.fromJson<int>(json['pinnedOrder']),
      muteUntil: serializer.fromJson<int>(json['muteUntil']),
      isMarkedUnread: serializer.fromJson<bool>(json['isMarkedUnread']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipientId': serializer.toJson<String>(recipientId),
      'date': serializer.toJson<int>(date),
      'snippet': serializer.toJson<String?>(snippet),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'isArchived': serializer.toJson<bool>(isArchived),
      'pinnedOrder': serializer.toJson<int>(pinnedOrder),
      'muteUntil': serializer.toJson<int>(muteUntil),
      'isMarkedUnread': serializer.toJson<bool>(isMarkedUnread),
    };
  }

  ThreadData copyWith({
    int? id,
    String? recipientId,
    int? date,
    Value<String?> snippet = const Value.absent(),
    int? unreadCount,
    bool? isArchived,
    int? pinnedOrder,
    int? muteUntil,
    bool? isMarkedUnread,
  }) => ThreadData(
    id: id ?? this.id,
    recipientId: recipientId ?? this.recipientId,
    date: date ?? this.date,
    snippet: snippet.present ? snippet.value : this.snippet,
    unreadCount: unreadCount ?? this.unreadCount,
    isArchived: isArchived ?? this.isArchived,
    pinnedOrder: pinnedOrder ?? this.pinnedOrder,
    muteUntil: muteUntil ?? this.muteUntil,
    isMarkedUnread: isMarkedUnread ?? this.isMarkedUnread,
  );
  ThreadData copyWithCompanion(ThreadsCompanion data) {
    return ThreadData(
      id: data.id.present ? data.id.value : this.id,
      recipientId: data.recipientId.present
          ? data.recipientId.value
          : this.recipientId,
      date: data.date.present ? data.date.value : this.date,
      snippet: data.snippet.present ? data.snippet.value : this.snippet,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      pinnedOrder: data.pinnedOrder.present
          ? data.pinnedOrder.value
          : this.pinnedOrder,
      muteUntil: data.muteUntil.present ? data.muteUntil.value : this.muteUntil,
      isMarkedUnread: data.isMarkedUnread.present
          ? data.isMarkedUnread.value
          : this.isMarkedUnread,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ThreadData(')
          ..write('id: $id, ')
          ..write('recipientId: $recipientId, ')
          ..write('date: $date, ')
          ..write('snippet: $snippet, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isArchived: $isArchived, ')
          ..write('pinnedOrder: $pinnedOrder, ')
          ..write('muteUntil: $muteUntil, ')
          ..write('isMarkedUnread: $isMarkedUnread')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipientId,
    date,
    snippet,
    unreadCount,
    isArchived,
    pinnedOrder,
    muteUntil,
    isMarkedUnread,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThreadData &&
          other.id == this.id &&
          other.recipientId == this.recipientId &&
          other.date == this.date &&
          other.snippet == this.snippet &&
          other.unreadCount == this.unreadCount &&
          other.isArchived == this.isArchived &&
          other.pinnedOrder == this.pinnedOrder &&
          other.muteUntil == this.muteUntil &&
          other.isMarkedUnread == this.isMarkedUnread);
}

class ThreadsCompanion extends UpdateCompanion<ThreadData> {
  final Value<int> id;
  final Value<String> recipientId;
  final Value<int> date;
  final Value<String?> snippet;
  final Value<int> unreadCount;
  final Value<bool> isArchived;
  final Value<int> pinnedOrder;
  final Value<int> muteUntil;
  final Value<bool> isMarkedUnread;
  const ThreadsCompanion({
    this.id = const Value.absent(),
    this.recipientId = const Value.absent(),
    this.date = const Value.absent(),
    this.snippet = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.pinnedOrder = const Value.absent(),
    this.muteUntil = const Value.absent(),
    this.isMarkedUnread = const Value.absent(),
  });
  ThreadsCompanion.insert({
    this.id = const Value.absent(),
    required String recipientId,
    required int date,
    this.snippet = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.pinnedOrder = const Value.absent(),
    this.muteUntil = const Value.absent(),
    this.isMarkedUnread = const Value.absent(),
  }) : recipientId = Value(recipientId),
       date = Value(date);
  static Insertable<ThreadData> custom({
    Expression<int>? id,
    Expression<String>? recipientId,
    Expression<int>? date,
    Expression<String>? snippet,
    Expression<int>? unreadCount,
    Expression<bool>? isArchived,
    Expression<int>? pinnedOrder,
    Expression<int>? muteUntil,
    Expression<bool>? isMarkedUnread,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipientId != null) 'recipient_id': recipientId,
      if (date != null) 'date': date,
      if (snippet != null) 'snippet': snippet,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (isArchived != null) 'is_archived': isArchived,
      if (pinnedOrder != null) 'pinned_order': pinnedOrder,
      if (muteUntil != null) 'mute_until': muteUntil,
      if (isMarkedUnread != null) 'is_marked_unread': isMarkedUnread,
    });
  }

  ThreadsCompanion copyWith({
    Value<int>? id,
    Value<String>? recipientId,
    Value<int>? date,
    Value<String?>? snippet,
    Value<int>? unreadCount,
    Value<bool>? isArchived,
    Value<int>? pinnedOrder,
    Value<int>? muteUntil,
    Value<bool>? isMarkedUnread,
  }) {
    return ThreadsCompanion(
      id: id ?? this.id,
      recipientId: recipientId ?? this.recipientId,
      date: date ?? this.date,
      snippet: snippet ?? this.snippet,
      unreadCount: unreadCount ?? this.unreadCount,
      isArchived: isArchived ?? this.isArchived,
      pinnedOrder: pinnedOrder ?? this.pinnedOrder,
      muteUntil: muteUntil ?? this.muteUntil,
      isMarkedUnread: isMarkedUnread ?? this.isMarkedUnread,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipientId.present) {
      map['recipient_id'] = Variable<String>(recipientId.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (snippet.present) {
      map['snippet'] = Variable<String>(snippet.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (pinnedOrder.present) {
      map['pinned_order'] = Variable<int>(pinnedOrder.value);
    }
    if (muteUntil.present) {
      map['mute_until'] = Variable<int>(muteUntil.value);
    }
    if (isMarkedUnread.present) {
      map['is_marked_unread'] = Variable<bool>(isMarkedUnread.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThreadsCompanion(')
          ..write('id: $id, ')
          ..write('recipientId: $recipientId, ')
          ..write('date: $date, ')
          ..write('snippet: $snippet, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isArchived: $isArchived, ')
          ..write('pinnedOrder: $pinnedOrder, ')
          ..write('muteUntil: $muteUntil, ')
          ..write('isMarkedUnread: $isMarkedUnread')
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
  static const VerificationMeta _threadIdMeta = const VerificationMeta(
    'threadId',
  );
  @override
  late final GeneratedColumn<int> threadId = GeneratedColumn<int>(
    'thread_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES threads (id)',
    ),
  );
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<String> chatId = GeneratedColumn<String>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderRecipientIdMeta = const VerificationMeta(
    'senderRecipientId',
  );
  @override
  late final GeneratedColumn<String> senderRecipientId =
      GeneratedColumn<String>(
        'sender_recipient_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES recipients (id)',
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
  late final GeneratedColumnWithTypeConverter<MessageTypeDb, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(MessageTypeDb.text.index),
      ).withConverter<MessageTypeDb>($MessagesTable.$convertertype);
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
  static const VerificationMeta _attachmentIvMeta = const VerificationMeta(
    'attachmentIv',
  );
  @override
  late final GeneratedColumn<String> attachmentIv = GeneratedColumn<String>(
    'attachment_iv',
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
  late final GeneratedColumnWithTypeConverter<MessageStatusDb, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(MessageStatusDb.pending.index),
      ).withConverter<MessageStatusDb>($MessagesTable.$converterstatus);
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
  static const VerificationMeta _pollQuestionMeta = const VerificationMeta(
    'pollQuestion',
  );
  @override
  late final GeneratedColumn<String> pollQuestion = GeneratedColumn<String>(
    'poll_question',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String>
  pollOptions = GeneratedColumn<String>(
    'poll_options',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<String>?>($MessagesTable.$converterpollOptionsn);
  static const VerificationMeta _allowMultipleVotesMeta =
      const VerificationMeta('allowMultipleVotes');
  @override
  late final GeneratedColumn<bool> allowMultipleVotes = GeneratedColumn<bool>(
    'allow_multiple_votes',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("allow_multiple_votes" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    threadId,
    chatId,
    senderRecipientId,
    textContent,
    type,
    attachmentUrl,
    attachmentAesKey,
    attachmentIv,
    attachmentMacKey,
    timestamp,
    status,
    isFromMe,
    latitude,
    longitude,
    pollQuestion,
    pollOptions,
    allowMultipleVotes,
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
    if (data.containsKey('thread_id')) {
      context.handle(
        _threadIdMeta,
        threadId.isAcceptableOrUnknown(data['thread_id']!, _threadIdMeta),
      );
    } else if (isInserting) {
      context.missing(_threadIdMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('sender_recipient_id')) {
      context.handle(
        _senderRecipientIdMeta,
        senderRecipientId.isAcceptableOrUnknown(
          data['sender_recipient_id']!,
          _senderRecipientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_senderRecipientIdMeta);
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
    if (data.containsKey('attachment_iv')) {
      context.handle(
        _attachmentIvMeta,
        attachmentIv.isAcceptableOrUnknown(
          data['attachment_iv']!,
          _attachmentIvMeta,
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
    if (data.containsKey('poll_question')) {
      context.handle(
        _pollQuestionMeta,
        pollQuestion.isAcceptableOrUnknown(
          data['poll_question']!,
          _pollQuestionMeta,
        ),
      );
    }
    if (data.containsKey('allow_multiple_votes')) {
      context.handle(
        _allowMultipleVotesMeta,
        allowMultipleVotes.isAcceptableOrUnknown(
          data['allow_multiple_votes']!,
          _allowMultipleVotesMeta,
        ),
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
      threadId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}thread_id'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chat_id'],
      )!,
      senderRecipientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_recipient_id'],
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
      attachmentIv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_iv'],
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
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      pollQuestion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poll_question'],
      ),
      pollOptions: $MessagesTable.$converterpollOptionsn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}poll_options'],
        ),
      ),
      allowMultipleVotes: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}allow_multiple_votes'],
      ),
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MessageTypeDb, int, int> $convertertype =
      const EnumIndexConverter<MessageTypeDb>(MessageTypeDb.values);
  static JsonTypeConverter2<MessageStatusDb, int, int> $converterstatus =
      const EnumIndexConverter<MessageStatusDb>(MessageStatusDb.values);
  static TypeConverter<List<String>, String> $converterpollOptions =
      const ListStringConverter();
  static TypeConverter<List<String>?, String?> $converterpollOptionsn =
      NullAwareTypeConverter.wrap($converterpollOptions);
}

class Message extends DataClass implements Insertable<Message> {
  final String id;
  final int threadId;
  final String chatId;
  final String senderRecipientId;
  final String textContent;
  final MessageTypeDb type;
  final String? attachmentUrl;
  final String? attachmentAesKey;
  final String? attachmentIv;
  final String? attachmentMacKey;
  final int timestamp;
  final MessageStatusDb status;
  final bool isFromMe;
  final double? latitude;
  final double? longitude;
  final String? pollQuestion;
  final List<String>? pollOptions;
  final bool? allowMultipleVotes;
  const Message({
    required this.id,
    required this.threadId,
    required this.chatId,
    required this.senderRecipientId,
    required this.textContent,
    required this.type,
    this.attachmentUrl,
    this.attachmentAesKey,
    this.attachmentIv,
    this.attachmentMacKey,
    required this.timestamp,
    required this.status,
    required this.isFromMe,
    this.latitude,
    this.longitude,
    this.pollQuestion,
    this.pollOptions,
    this.allowMultipleVotes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['thread_id'] = Variable<int>(threadId);
    map['chat_id'] = Variable<String>(chatId);
    map['sender_recipient_id'] = Variable<String>(senderRecipientId);
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
    if (!nullToAbsent || attachmentIv != null) {
      map['attachment_iv'] = Variable<String>(attachmentIv);
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
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || pollQuestion != null) {
      map['poll_question'] = Variable<String>(pollQuestion);
    }
    if (!nullToAbsent || pollOptions != null) {
      map['poll_options'] = Variable<String>(
        $MessagesTable.$converterpollOptionsn.toSql(pollOptions),
      );
    }
    if (!nullToAbsent || allowMultipleVotes != null) {
      map['allow_multiple_votes'] = Variable<bool>(allowMultipleVotes);
    }
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      threadId: Value(threadId),
      chatId: Value(chatId),
      senderRecipientId: Value(senderRecipientId),
      textContent: Value(textContent),
      type: Value(type),
      attachmentUrl: attachmentUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentUrl),
      attachmentAesKey: attachmentAesKey == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentAesKey),
      attachmentIv: attachmentIv == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentIv),
      attachmentMacKey: attachmentMacKey == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentMacKey),
      timestamp: Value(timestamp),
      status: Value(status),
      isFromMe: Value(isFromMe),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      pollQuestion: pollQuestion == null && nullToAbsent
          ? const Value.absent()
          : Value(pollQuestion),
      pollOptions: pollOptions == null && nullToAbsent
          ? const Value.absent()
          : Value(pollOptions),
      allowMultipleVotes: allowMultipleVotes == null && nullToAbsent
          ? const Value.absent()
          : Value(allowMultipleVotes),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<String>(json['id']),
      threadId: serializer.fromJson<int>(json['threadId']),
      chatId: serializer.fromJson<String>(json['chatId']),
      senderRecipientId: serializer.fromJson<String>(json['senderRecipientId']),
      textContent: serializer.fromJson<String>(json['textContent']),
      type: $MessagesTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      attachmentUrl: serializer.fromJson<String?>(json['attachmentUrl']),
      attachmentAesKey: serializer.fromJson<String?>(json['attachmentAesKey']),
      attachmentIv: serializer.fromJson<String?>(json['attachmentIv']),
      attachmentMacKey: serializer.fromJson<String?>(json['attachmentMacKey']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      status: $MessagesTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      isFromMe: serializer.fromJson<bool>(json['isFromMe']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      pollQuestion: serializer.fromJson<String?>(json['pollQuestion']),
      pollOptions: serializer.fromJson<List<String>?>(json['pollOptions']),
      allowMultipleVotes: serializer.fromJson<bool?>(
        json['allowMultipleVotes'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'threadId': serializer.toJson<int>(threadId),
      'chatId': serializer.toJson<String>(chatId),
      'senderRecipientId': serializer.toJson<String>(senderRecipientId),
      'textContent': serializer.toJson<String>(textContent),
      'type': serializer.toJson<int>(
        $MessagesTable.$convertertype.toJson(type),
      ),
      'attachmentUrl': serializer.toJson<String?>(attachmentUrl),
      'attachmentAesKey': serializer.toJson<String?>(attachmentAesKey),
      'attachmentIv': serializer.toJson<String?>(attachmentIv),
      'attachmentMacKey': serializer.toJson<String?>(attachmentMacKey),
      'timestamp': serializer.toJson<int>(timestamp),
      'status': serializer.toJson<int>(
        $MessagesTable.$converterstatus.toJson(status),
      ),
      'isFromMe': serializer.toJson<bool>(isFromMe),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'pollQuestion': serializer.toJson<String?>(pollQuestion),
      'pollOptions': serializer.toJson<List<String>?>(pollOptions),
      'allowMultipleVotes': serializer.toJson<bool?>(allowMultipleVotes),
    };
  }

  Message copyWith({
    String? id,
    int? threadId,
    String? chatId,
    String? senderRecipientId,
    String? textContent,
    MessageTypeDb? type,
    Value<String?> attachmentUrl = const Value.absent(),
    Value<String?> attachmentAesKey = const Value.absent(),
    Value<String?> attachmentIv = const Value.absent(),
    Value<String?> attachmentMacKey = const Value.absent(),
    int? timestamp,
    MessageStatusDb? status,
    bool? isFromMe,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> pollQuestion = const Value.absent(),
    Value<List<String>?> pollOptions = const Value.absent(),
    Value<bool?> allowMultipleVotes = const Value.absent(),
  }) => Message(
    id: id ?? this.id,
    threadId: threadId ?? this.threadId,
    chatId: chatId ?? this.chatId,
    senderRecipientId: senderRecipientId ?? this.senderRecipientId,
    textContent: textContent ?? this.textContent,
    type: type ?? this.type,
    attachmentUrl: attachmentUrl.present
        ? attachmentUrl.value
        : this.attachmentUrl,
    attachmentAesKey: attachmentAesKey.present
        ? attachmentAesKey.value
        : this.attachmentAesKey,
    attachmentIv: attachmentIv.present ? attachmentIv.value : this.attachmentIv,
    attachmentMacKey: attachmentMacKey.present
        ? attachmentMacKey.value
        : this.attachmentMacKey,
    timestamp: timestamp ?? this.timestamp,
    status: status ?? this.status,
    isFromMe: isFromMe ?? this.isFromMe,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    pollQuestion: pollQuestion.present ? pollQuestion.value : this.pollQuestion,
    pollOptions: pollOptions.present ? pollOptions.value : this.pollOptions,
    allowMultipleVotes: allowMultipleVotes.present
        ? allowMultipleVotes.value
        : this.allowMultipleVotes,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      threadId: data.threadId.present ? data.threadId.value : this.threadId,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      senderRecipientId: data.senderRecipientId.present
          ? data.senderRecipientId.value
          : this.senderRecipientId,
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
      attachmentIv: data.attachmentIv.present
          ? data.attachmentIv.value
          : this.attachmentIv,
      attachmentMacKey: data.attachmentMacKey.present
          ? data.attachmentMacKey.value
          : this.attachmentMacKey,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      status: data.status.present ? data.status.value : this.status,
      isFromMe: data.isFromMe.present ? data.isFromMe.value : this.isFromMe,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      pollQuestion: data.pollQuestion.present
          ? data.pollQuestion.value
          : this.pollQuestion,
      pollOptions: data.pollOptions.present
          ? data.pollOptions.value
          : this.pollOptions,
      allowMultipleVotes: data.allowMultipleVotes.present
          ? data.allowMultipleVotes.value
          : this.allowMultipleVotes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('threadId: $threadId, ')
          ..write('chatId: $chatId, ')
          ..write('senderRecipientId: $senderRecipientId, ')
          ..write('textContent: $textContent, ')
          ..write('type: $type, ')
          ..write('attachmentUrl: $attachmentUrl, ')
          ..write('attachmentAesKey: $attachmentAesKey, ')
          ..write('attachmentIv: $attachmentIv, ')
          ..write('attachmentMacKey: $attachmentMacKey, ')
          ..write('timestamp: $timestamp, ')
          ..write('status: $status, ')
          ..write('isFromMe: $isFromMe, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('pollQuestion: $pollQuestion, ')
          ..write('pollOptions: $pollOptions, ')
          ..write('allowMultipleVotes: $allowMultipleVotes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    threadId,
    chatId,
    senderRecipientId,
    textContent,
    type,
    attachmentUrl,
    attachmentAesKey,
    attachmentIv,
    attachmentMacKey,
    timestamp,
    status,
    isFromMe,
    latitude,
    longitude,
    pollQuestion,
    pollOptions,
    allowMultipleVotes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.threadId == this.threadId &&
          other.chatId == this.chatId &&
          other.senderRecipientId == this.senderRecipientId &&
          other.textContent == this.textContent &&
          other.type == this.type &&
          other.attachmentUrl == this.attachmentUrl &&
          other.attachmentAesKey == this.attachmentAesKey &&
          other.attachmentIv == this.attachmentIv &&
          other.attachmentMacKey == this.attachmentMacKey &&
          other.timestamp == this.timestamp &&
          other.status == this.status &&
          other.isFromMe == this.isFromMe &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.pollQuestion == this.pollQuestion &&
          other.pollOptions == this.pollOptions &&
          other.allowMultipleVotes == this.allowMultipleVotes);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> id;
  final Value<int> threadId;
  final Value<String> chatId;
  final Value<String> senderRecipientId;
  final Value<String> textContent;
  final Value<MessageTypeDb> type;
  final Value<String?> attachmentUrl;
  final Value<String?> attachmentAesKey;
  final Value<String?> attachmentIv;
  final Value<String?> attachmentMacKey;
  final Value<int> timestamp;
  final Value<MessageStatusDb> status;
  final Value<bool> isFromMe;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> pollQuestion;
  final Value<List<String>?> pollOptions;
  final Value<bool?> allowMultipleVotes;
  final Value<int> rowid;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.threadId = const Value.absent(),
    this.chatId = const Value.absent(),
    this.senderRecipientId = const Value.absent(),
    this.textContent = const Value.absent(),
    this.type = const Value.absent(),
    this.attachmentUrl = const Value.absent(),
    this.attachmentAesKey = const Value.absent(),
    this.attachmentIv = const Value.absent(),
    this.attachmentMacKey = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.status = const Value.absent(),
    this.isFromMe = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.pollQuestion = const Value.absent(),
    this.pollOptions = const Value.absent(),
    this.allowMultipleVotes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String id,
    required int threadId,
    required String chatId,
    required String senderRecipientId,
    required String textContent,
    this.type = const Value.absent(),
    this.attachmentUrl = const Value.absent(),
    this.attachmentAesKey = const Value.absent(),
    this.attachmentIv = const Value.absent(),
    this.attachmentMacKey = const Value.absent(),
    required int timestamp,
    this.status = const Value.absent(),
    required bool isFromMe,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.pollQuestion = const Value.absent(),
    this.pollOptions = const Value.absent(),
    this.allowMultipleVotes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       threadId = Value(threadId),
       chatId = Value(chatId),
       senderRecipientId = Value(senderRecipientId),
       textContent = Value(textContent),
       timestamp = Value(timestamp),
       isFromMe = Value(isFromMe);
  static Insertable<Message> custom({
    Expression<String>? id,
    Expression<int>? threadId,
    Expression<String>? chatId,
    Expression<String>? senderRecipientId,
    Expression<String>? textContent,
    Expression<int>? type,
    Expression<String>? attachmentUrl,
    Expression<String>? attachmentAesKey,
    Expression<String>? attachmentIv,
    Expression<String>? attachmentMacKey,
    Expression<int>? timestamp,
    Expression<int>? status,
    Expression<bool>? isFromMe,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? pollQuestion,
    Expression<String>? pollOptions,
    Expression<bool>? allowMultipleVotes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (threadId != null) 'thread_id': threadId,
      if (chatId != null) 'chat_id': chatId,
      if (senderRecipientId != null) 'sender_recipient_id': senderRecipientId,
      if (textContent != null) 'text_content': textContent,
      if (type != null) 'type': type,
      if (attachmentUrl != null) 'attachment_url': attachmentUrl,
      if (attachmentAesKey != null) 'attachment_aes_key': attachmentAesKey,
      if (attachmentIv != null) 'attachment_iv': attachmentIv,
      if (attachmentMacKey != null) 'attachment_mac_key': attachmentMacKey,
      if (timestamp != null) 'timestamp': timestamp,
      if (status != null) 'status': status,
      if (isFromMe != null) 'is_from_me': isFromMe,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (pollQuestion != null) 'poll_question': pollQuestion,
      if (pollOptions != null) 'poll_options': pollOptions,
      if (allowMultipleVotes != null)
        'allow_multiple_votes': allowMultipleVotes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith({
    Value<String>? id,
    Value<int>? threadId,
    Value<String>? chatId,
    Value<String>? senderRecipientId,
    Value<String>? textContent,
    Value<MessageTypeDb>? type,
    Value<String?>? attachmentUrl,
    Value<String?>? attachmentAesKey,
    Value<String?>? attachmentIv,
    Value<String?>? attachmentMacKey,
    Value<int>? timestamp,
    Value<MessageStatusDb>? status,
    Value<bool>? isFromMe,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? pollQuestion,
    Value<List<String>?>? pollOptions,
    Value<bool?>? allowMultipleVotes,
    Value<int>? rowid,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      threadId: threadId ?? this.threadId,
      chatId: chatId ?? this.chatId,
      senderRecipientId: senderRecipientId ?? this.senderRecipientId,
      textContent: textContent ?? this.textContent,
      type: type ?? this.type,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      attachmentAesKey: attachmentAesKey ?? this.attachmentAesKey,
      attachmentIv: attachmentIv ?? this.attachmentIv,
      attachmentMacKey: attachmentMacKey ?? this.attachmentMacKey,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      isFromMe: isFromMe ?? this.isFromMe,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      pollQuestion: pollQuestion ?? this.pollQuestion,
      pollOptions: pollOptions ?? this.pollOptions,
      allowMultipleVotes: allowMultipleVotes ?? this.allowMultipleVotes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (threadId.present) {
      map['thread_id'] = Variable<int>(threadId.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<String>(chatId.value);
    }
    if (senderRecipientId.present) {
      map['sender_recipient_id'] = Variable<String>(senderRecipientId.value);
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
    if (attachmentIv.present) {
      map['attachment_iv'] = Variable<String>(attachmentIv.value);
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
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (pollQuestion.present) {
      map['poll_question'] = Variable<String>(pollQuestion.value);
    }
    if (pollOptions.present) {
      map['poll_options'] = Variable<String>(
        $MessagesTable.$converterpollOptionsn.toSql(pollOptions.value),
      );
    }
    if (allowMultipleVotes.present) {
      map['allow_multiple_votes'] = Variable<bool>(allowMultipleVotes.value);
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
          ..write('threadId: $threadId, ')
          ..write('chatId: $chatId, ')
          ..write('senderRecipientId: $senderRecipientId, ')
          ..write('textContent: $textContent, ')
          ..write('type: $type, ')
          ..write('attachmentUrl: $attachmentUrl, ')
          ..write('attachmentAesKey: $attachmentAesKey, ')
          ..write('attachmentIv: $attachmentIv, ')
          ..write('attachmentMacKey: $attachmentMacKey, ')
          ..write('timestamp: $timestamp, ')
          ..write('status: $status, ')
          ..write('isFromMe: $isFromMe, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('pollQuestion: $pollQuestion, ')
          ..write('pollOptions: $pollOptions, ')
          ..write('allowMultipleVotes: $allowMultipleVotes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessageSearchTable extends MessageSearch
    with TableInfo<$MessageSearchTable, MessageSearchData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageSearchTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  List<GeneratedColumn> get $columns => [id, textContent];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_search';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageSearchData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MessageSearchData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageSearchData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      )!,
    );
  }

  @override
  $MessageSearchTable createAlias(String alias) {
    return $MessageSearchTable(attachedDatabase, alias);
  }
}

class MessageSearchData extends DataClass
    implements Insertable<MessageSearchData> {
  final String id;
  final String textContent;
  const MessageSearchData({required this.id, required this.textContent});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['text_content'] = Variable<String>(textContent);
    return map;
  }

  MessageSearchCompanion toCompanion(bool nullToAbsent) {
    return MessageSearchCompanion(
      id: Value(id),
      textContent: Value(textContent),
    );
  }

  factory MessageSearchData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageSearchData(
      id: serializer.fromJson<String>(json['id']),
      textContent: serializer.fromJson<String>(json['textContent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'textContent': serializer.toJson<String>(textContent),
    };
  }

  MessageSearchData copyWith({String? id, String? textContent}) =>
      MessageSearchData(
        id: id ?? this.id,
        textContent: textContent ?? this.textContent,
      );
  MessageSearchData copyWithCompanion(MessageSearchCompanion data) {
    return MessageSearchData(
      id: data.id.present ? data.id.value : this.id,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageSearchData(')
          ..write('id: $id, ')
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, textContent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageSearchData &&
          other.id == this.id &&
          other.textContent == this.textContent);
}

class MessageSearchCompanion extends UpdateCompanion<MessageSearchData> {
  final Value<String> id;
  final Value<String> textContent;
  final Value<int> rowid;
  const MessageSearchCompanion({
    this.id = const Value.absent(),
    this.textContent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessageSearchCompanion.insert({
    required String id,
    required String textContent,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       textContent = Value(textContent);
  static Insertable<MessageSearchData> custom({
    Expression<String>? id,
    Expression<String>? textContent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (textContent != null) 'text_content': textContent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessageSearchCompanion copyWith({
    Value<String>? id,
    Value<String>? textContent,
    Value<int>? rowid,
  }) {
    return MessageSearchCompanion(
      id: id ?? this.id,
      textContent: textContent ?? this.textContent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageSearchCompanion(')
          ..write('id: $id, ')
          ..write('textContent: $textContent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JobsTable extends Jobs with TableInfo<$JobsTable, JobData> {
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
    defaultValue: const Constant(1),
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
    createTime,
    nextRunAttemptTime,
    runAttempt,
    isRunning,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobData> instance, {
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
    if (data.containsKey('run_attempt')) {
      context.handle(
        _runAttemptMeta,
        runAttempt.isAcceptableOrUnknown(data['run_attempt']!, _runAttemptMeta),
      );
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
  JobData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobData(
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
      createTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}create_time'],
      )!,
      nextRunAttemptTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_run_attempt_time'],
      )!,
      runAttempt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}run_attempt'],
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

class JobData extends DataClass implements Insertable<JobData> {
  final int id;
  final String factoryKey;
  final String? queueKey;
  final String data;
  final int priority;
  final int createTime;
  final int nextRunAttemptTime;
  final int runAttempt;
  final bool isRunning;
  const JobData({
    required this.id,
    required this.factoryKey,
    this.queueKey,
    required this.data,
    required this.priority,
    required this.createTime,
    required this.nextRunAttemptTime,
    required this.runAttempt,
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
    map['create_time'] = Variable<int>(createTime);
    map['next_run_attempt_time'] = Variable<int>(nextRunAttemptTime);
    map['run_attempt'] = Variable<int>(runAttempt);
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
      createTime: Value(createTime),
      nextRunAttemptTime: Value(nextRunAttemptTime),
      runAttempt: Value(runAttempt),
      isRunning: Value(isRunning),
    );
  }

  factory JobData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobData(
      id: serializer.fromJson<int>(json['id']),
      factoryKey: serializer.fromJson<String>(json['factoryKey']),
      queueKey: serializer.fromJson<String?>(json['queueKey']),
      data: serializer.fromJson<String>(json['data']),
      priority: serializer.fromJson<int>(json['priority']),
      createTime: serializer.fromJson<int>(json['createTime']),
      nextRunAttemptTime: serializer.fromJson<int>(json['nextRunAttemptTime']),
      runAttempt: serializer.fromJson<int>(json['runAttempt']),
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
      'createTime': serializer.toJson<int>(createTime),
      'nextRunAttemptTime': serializer.toJson<int>(nextRunAttemptTime),
      'runAttempt': serializer.toJson<int>(runAttempt),
      'isRunning': serializer.toJson<bool>(isRunning),
    };
  }

  JobData copyWith({
    int? id,
    String? factoryKey,
    Value<String?> queueKey = const Value.absent(),
    String? data,
    int? priority,
    int? createTime,
    int? nextRunAttemptTime,
    int? runAttempt,
    bool? isRunning,
  }) => JobData(
    id: id ?? this.id,
    factoryKey: factoryKey ?? this.factoryKey,
    queueKey: queueKey.present ? queueKey.value : this.queueKey,
    data: data ?? this.data,
    priority: priority ?? this.priority,
    createTime: createTime ?? this.createTime,
    nextRunAttemptTime: nextRunAttemptTime ?? this.nextRunAttemptTime,
    runAttempt: runAttempt ?? this.runAttempt,
    isRunning: isRunning ?? this.isRunning,
  );
  JobData copyWithCompanion(JobsCompanion data) {
    return JobData(
      id: data.id.present ? data.id.value : this.id,
      factoryKey: data.factoryKey.present
          ? data.factoryKey.value
          : this.factoryKey,
      queueKey: data.queueKey.present ? data.queueKey.value : this.queueKey,
      data: data.data.present ? data.data.value : this.data,
      priority: data.priority.present ? data.priority.value : this.priority,
      createTime: data.createTime.present
          ? data.createTime.value
          : this.createTime,
      nextRunAttemptTime: data.nextRunAttemptTime.present
          ? data.nextRunAttemptTime.value
          : this.nextRunAttemptTime,
      runAttempt: data.runAttempt.present
          ? data.runAttempt.value
          : this.runAttempt,
      isRunning: data.isRunning.present ? data.isRunning.value : this.isRunning,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobData(')
          ..write('id: $id, ')
          ..write('factoryKey: $factoryKey, ')
          ..write('queueKey: $queueKey, ')
          ..write('data: $data, ')
          ..write('priority: $priority, ')
          ..write('createTime: $createTime, ')
          ..write('nextRunAttemptTime: $nextRunAttemptTime, ')
          ..write('runAttempt: $runAttempt, ')
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
    createTime,
    nextRunAttemptTime,
    runAttempt,
    isRunning,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobData &&
          other.id == this.id &&
          other.factoryKey == this.factoryKey &&
          other.queueKey == this.queueKey &&
          other.data == this.data &&
          other.priority == this.priority &&
          other.createTime == this.createTime &&
          other.nextRunAttemptTime == this.nextRunAttemptTime &&
          other.runAttempt == this.runAttempt &&
          other.isRunning == this.isRunning);
}

class JobsCompanion extends UpdateCompanion<JobData> {
  final Value<int> id;
  final Value<String> factoryKey;
  final Value<String?> queueKey;
  final Value<String> data;
  final Value<int> priority;
  final Value<int> createTime;
  final Value<int> nextRunAttemptTime;
  final Value<int> runAttempt;
  final Value<bool> isRunning;
  const JobsCompanion({
    this.id = const Value.absent(),
    this.factoryKey = const Value.absent(),
    this.queueKey = const Value.absent(),
    this.data = const Value.absent(),
    this.priority = const Value.absent(),
    this.createTime = const Value.absent(),
    this.nextRunAttemptTime = const Value.absent(),
    this.runAttempt = const Value.absent(),
    this.isRunning = const Value.absent(),
  });
  JobsCompanion.insert({
    this.id = const Value.absent(),
    required String factoryKey,
    this.queueKey = const Value.absent(),
    required String data,
    this.priority = const Value.absent(),
    required int createTime,
    required int nextRunAttemptTime,
    this.runAttempt = const Value.absent(),
    this.isRunning = const Value.absent(),
  }) : factoryKey = Value(factoryKey),
       data = Value(data),
       createTime = Value(createTime),
       nextRunAttemptTime = Value(nextRunAttemptTime);
  static Insertable<JobData> custom({
    Expression<int>? id,
    Expression<String>? factoryKey,
    Expression<String>? queueKey,
    Expression<String>? data,
    Expression<int>? priority,
    Expression<int>? createTime,
    Expression<int>? nextRunAttemptTime,
    Expression<int>? runAttempt,
    Expression<bool>? isRunning,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (factoryKey != null) 'factory_key': factoryKey,
      if (queueKey != null) 'queue_key': queueKey,
      if (data != null) 'data': data,
      if (priority != null) 'priority': priority,
      if (createTime != null) 'create_time': createTime,
      if (nextRunAttemptTime != null)
        'next_run_attempt_time': nextRunAttemptTime,
      if (runAttempt != null) 'run_attempt': runAttempt,
      if (isRunning != null) 'is_running': isRunning,
    });
  }

  JobsCompanion copyWith({
    Value<int>? id,
    Value<String>? factoryKey,
    Value<String?>? queueKey,
    Value<String>? data,
    Value<int>? priority,
    Value<int>? createTime,
    Value<int>? nextRunAttemptTime,
    Value<int>? runAttempt,
    Value<bool>? isRunning,
  }) {
    return JobsCompanion(
      id: id ?? this.id,
      factoryKey: factoryKey ?? this.factoryKey,
      queueKey: queueKey ?? this.queueKey,
      data: data ?? this.data,
      priority: priority ?? this.priority,
      createTime: createTime ?? this.createTime,
      nextRunAttemptTime: nextRunAttemptTime ?? this.nextRunAttemptTime,
      runAttempt: runAttempt ?? this.runAttempt,
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
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (nextRunAttemptTime.present) {
      map['next_run_attempt_time'] = Variable<int>(nextRunAttemptTime.value);
    }
    if (runAttempt.present) {
      map['run_attempt'] = Variable<int>(runAttempt.value);
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
          ..write('createTime: $createTime, ')
          ..write('nextRunAttemptTime: $nextRunAttemptTime, ')
          ..write('runAttempt: $runAttempt, ')
          ..write('isRunning: $isRunning')
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

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, AttachmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES messages (id)',
    ),
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thumbnailPathMeta = const VerificationMeta(
    'thumbnailPath',
  );
  @override
  late final GeneratedColumn<String> thumbnailPath = GeneratedColumn<String>(
    'thumbnail_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aesKeyMeta = const VerificationMeta('aesKey');
  @override
  late final GeneratedColumn<String> aesKey = GeneratedColumn<String>(
    'aes_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ivMeta = const VerificationMeta('iv');
  @override
  late final GeneratedColumn<String> iv = GeneratedColumn<String>(
    'iv',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _digestMeta = const VerificationMeta('digest');
  @override
  late final GeneratedColumn<String> digest = GeneratedColumn<String>(
    'digest',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transferStateMeta = const VerificationMeta(
    'transferState',
  );
  @override
  late final GeneratedColumn<int> transferState = GeneratedColumn<int>(
    'transfer_state',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    contentType,
    fileName,
    size,
    localPath,
    thumbnailPath,
    remoteId,
    aesKey,
    iv,
    digest,
    transferState,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttachmentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
        _thumbnailPathMeta,
        thumbnailPath.isAcceptableOrUnknown(
          data['thumbnail_path']!,
          _thumbnailPathMeta,
        ),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('aes_key')) {
      context.handle(
        _aesKeyMeta,
        aesKey.isAcceptableOrUnknown(data['aes_key']!, _aesKeyMeta),
      );
    }
    if (data.containsKey('iv')) {
      context.handle(_ivMeta, iv.isAcceptableOrUnknown(data['iv']!, _ivMeta));
    }
    if (data.containsKey('digest')) {
      context.handle(
        _digestMeta,
        digest.isAcceptableOrUnknown(data['digest']!, _digestMeta),
      );
    }
    if (data.containsKey('transfer_state')) {
      context.handle(
        _transferStateMeta,
        transferState.isAcceptableOrUnknown(
          data['transfer_state']!,
          _transferStateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttachmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttachmentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      ),
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      thumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_path'],
      ),
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      aesKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aes_key'],
      ),
      iv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}iv'],
      ),
      digest: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}digest'],
      ),
      transferState: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transfer_state'],
      )!,
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }
}

class AttachmentData extends DataClass implements Insertable<AttachmentData> {
  final int id;
  final String messageId;
  final String contentType;
  final String? fileName;
  final int size;
  final String? localPath;
  final String? thumbnailPath;
  final String? remoteId;
  final String? aesKey;
  final String? iv;
  final String? digest;
  final int transferState;
  const AttachmentData({
    required this.id,
    required this.messageId,
    required this.contentType,
    this.fileName,
    required this.size,
    this.localPath,
    this.thumbnailPath,
    this.remoteId,
    this.aesKey,
    this.iv,
    this.digest,
    required this.transferState,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message_id'] = Variable<String>(messageId);
    map['content_type'] = Variable<String>(contentType);
    if (!nullToAbsent || fileName != null) {
      map['file_name'] = Variable<String>(fileName);
    }
    map['size'] = Variable<int>(size);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || thumbnailPath != null) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath);
    }
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || aesKey != null) {
      map['aes_key'] = Variable<String>(aesKey);
    }
    if (!nullToAbsent || iv != null) {
      map['iv'] = Variable<String>(iv);
    }
    if (!nullToAbsent || digest != null) {
      map['digest'] = Variable<String>(digest);
    }
    map['transfer_state'] = Variable<int>(transferState);
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      id: Value(id),
      messageId: Value(messageId),
      contentType: Value(contentType),
      fileName: fileName == null && nullToAbsent
          ? const Value.absent()
          : Value(fileName),
      size: Value(size),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      thumbnailPath: thumbnailPath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailPath),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      aesKey: aesKey == null && nullToAbsent
          ? const Value.absent()
          : Value(aesKey),
      iv: iv == null && nullToAbsent ? const Value.absent() : Value(iv),
      digest: digest == null && nullToAbsent
          ? const Value.absent()
          : Value(digest),
      transferState: Value(transferState),
    );
  }

  factory AttachmentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttachmentData(
      id: serializer.fromJson<int>(json['id']),
      messageId: serializer.fromJson<String>(json['messageId']),
      contentType: serializer.fromJson<String>(json['contentType']),
      fileName: serializer.fromJson<String?>(json['fileName']),
      size: serializer.fromJson<int>(json['size']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      thumbnailPath: serializer.fromJson<String?>(json['thumbnailPath']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      aesKey: serializer.fromJson<String?>(json['aesKey']),
      iv: serializer.fromJson<String?>(json['iv']),
      digest: serializer.fromJson<String?>(json['digest']),
      transferState: serializer.fromJson<int>(json['transferState']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageId': serializer.toJson<String>(messageId),
      'contentType': serializer.toJson<String>(contentType),
      'fileName': serializer.toJson<String?>(fileName),
      'size': serializer.toJson<int>(size),
      'localPath': serializer.toJson<String?>(localPath),
      'thumbnailPath': serializer.toJson<String?>(thumbnailPath),
      'remoteId': serializer.toJson<String?>(remoteId),
      'aesKey': serializer.toJson<String?>(aesKey),
      'iv': serializer.toJson<String?>(iv),
      'digest': serializer.toJson<String?>(digest),
      'transferState': serializer.toJson<int>(transferState),
    };
  }

  AttachmentData copyWith({
    int? id,
    String? messageId,
    String? contentType,
    Value<String?> fileName = const Value.absent(),
    int? size,
    Value<String?> localPath = const Value.absent(),
    Value<String?> thumbnailPath = const Value.absent(),
    Value<String?> remoteId = const Value.absent(),
    Value<String?> aesKey = const Value.absent(),
    Value<String?> iv = const Value.absent(),
    Value<String?> digest = const Value.absent(),
    int? transferState,
  }) => AttachmentData(
    id: id ?? this.id,
    messageId: messageId ?? this.messageId,
    contentType: contentType ?? this.contentType,
    fileName: fileName.present ? fileName.value : this.fileName,
    size: size ?? this.size,
    localPath: localPath.present ? localPath.value : this.localPath,
    thumbnailPath: thumbnailPath.present
        ? thumbnailPath.value
        : this.thumbnailPath,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    aesKey: aesKey.present ? aesKey.value : this.aesKey,
    iv: iv.present ? iv.value : this.iv,
    digest: digest.present ? digest.value : this.digest,
    transferState: transferState ?? this.transferState,
  );
  AttachmentData copyWithCompanion(AttachmentsCompanion data) {
    return AttachmentData(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      size: data.size.present ? data.size.value : this.size,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      thumbnailPath: data.thumbnailPath.present
          ? data.thumbnailPath.value
          : this.thumbnailPath,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      aesKey: data.aesKey.present ? data.aesKey.value : this.aesKey,
      iv: data.iv.present ? data.iv.value : this.iv,
      digest: data.digest.present ? data.digest.value : this.digest,
      transferState: data.transferState.present
          ? data.transferState.value
          : this.transferState,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentData(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('contentType: $contentType, ')
          ..write('fileName: $fileName, ')
          ..write('size: $size, ')
          ..write('localPath: $localPath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('remoteId: $remoteId, ')
          ..write('aesKey: $aesKey, ')
          ..write('iv: $iv, ')
          ..write('digest: $digest, ')
          ..write('transferState: $transferState')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    messageId,
    contentType,
    fileName,
    size,
    localPath,
    thumbnailPath,
    remoteId,
    aesKey,
    iv,
    digest,
    transferState,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachmentData &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.contentType == this.contentType &&
          other.fileName == this.fileName &&
          other.size == this.size &&
          other.localPath == this.localPath &&
          other.thumbnailPath == this.thumbnailPath &&
          other.remoteId == this.remoteId &&
          other.aesKey == this.aesKey &&
          other.iv == this.iv &&
          other.digest == this.digest &&
          other.transferState == this.transferState);
}

class AttachmentsCompanion extends UpdateCompanion<AttachmentData> {
  final Value<int> id;
  final Value<String> messageId;
  final Value<String> contentType;
  final Value<String?> fileName;
  final Value<int> size;
  final Value<String?> localPath;
  final Value<String?> thumbnailPath;
  final Value<String?> remoteId;
  final Value<String?> aesKey;
  final Value<String?> iv;
  final Value<String?> digest;
  final Value<int> transferState;
  const AttachmentsCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.contentType = const Value.absent(),
    this.fileName = const Value.absent(),
    this.size = const Value.absent(),
    this.localPath = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.aesKey = const Value.absent(),
    this.iv = const Value.absent(),
    this.digest = const Value.absent(),
    this.transferState = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    this.id = const Value.absent(),
    required String messageId,
    required String contentType,
    this.fileName = const Value.absent(),
    required int size,
    this.localPath = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.aesKey = const Value.absent(),
    this.iv = const Value.absent(),
    this.digest = const Value.absent(),
    this.transferState = const Value.absent(),
  }) : messageId = Value(messageId),
       contentType = Value(contentType),
       size = Value(size);
  static Insertable<AttachmentData> custom({
    Expression<int>? id,
    Expression<String>? messageId,
    Expression<String>? contentType,
    Expression<String>? fileName,
    Expression<int>? size,
    Expression<String>? localPath,
    Expression<String>? thumbnailPath,
    Expression<String>? remoteId,
    Expression<String>? aesKey,
    Expression<String>? iv,
    Expression<String>? digest,
    Expression<int>? transferState,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (contentType != null) 'content_type': contentType,
      if (fileName != null) 'file_name': fileName,
      if (size != null) 'size': size,
      if (localPath != null) 'local_path': localPath,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (remoteId != null) 'remote_id': remoteId,
      if (aesKey != null) 'aes_key': aesKey,
      if (iv != null) 'iv': iv,
      if (digest != null) 'digest': digest,
      if (transferState != null) 'transfer_state': transferState,
    });
  }

  AttachmentsCompanion copyWith({
    Value<int>? id,
    Value<String>? messageId,
    Value<String>? contentType,
    Value<String?>? fileName,
    Value<int>? size,
    Value<String?>? localPath,
    Value<String?>? thumbnailPath,
    Value<String?>? remoteId,
    Value<String?>? aesKey,
    Value<String?>? iv,
    Value<String?>? digest,
    Value<int>? transferState,
  }) {
    return AttachmentsCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      contentType: contentType ?? this.contentType,
      fileName: fileName ?? this.fileName,
      size: size ?? this.size,
      localPath: localPath ?? this.localPath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      remoteId: remoteId ?? this.remoteId,
      aesKey: aesKey ?? this.aesKey,
      iv: iv ?? this.iv,
      digest: digest ?? this.digest,
      transferState: transferState ?? this.transferState,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (aesKey.present) {
      map['aes_key'] = Variable<String>(aesKey.value);
    }
    if (iv.present) {
      map['iv'] = Variable<String>(iv.value);
    }
    if (digest.present) {
      map['digest'] = Variable<String>(digest.value);
    }
    if (transferState.present) {
      map['transfer_state'] = Variable<int>(transferState.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('contentType: $contentType, ')
          ..write('fileName: $fileName, ')
          ..write('size: $size, ')
          ..write('localPath: $localPath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('remoteId: $remoteId, ')
          ..write('aesKey: $aesKey, ')
          ..write('iv: $iv, ')
          ..write('digest: $digest, ')
          ..write('transferState: $transferState')
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES messages (id)',
    ),
  );
  static const VerificationMeta _authorIdMeta = const VerificationMeta(
    'authorId',
  );
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
    'author_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipients (id)',
    ),
  );
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
    'emoji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateSentMeta = const VerificationMeta(
    'dateSent',
  );
  @override
  late final GeneratedColumn<int> dateSent = GeneratedColumn<int>(
    'date_sent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateReceivedMeta = const VerificationMeta(
    'dateReceived',
  );
  @override
  late final GeneratedColumn<int> dateReceived = GeneratedColumn<int>(
    'date_received',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    authorId,
    emoji,
    dateSent,
    dateReceived,
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
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('author_id')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_authorIdMeta);
    }
    if (data.containsKey('emoji')) {
      context.handle(
        _emojiMeta,
        emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta),
      );
    } else if (isInserting) {
      context.missing(_emojiMeta);
    }
    if (data.containsKey('date_sent')) {
      context.handle(
        _dateSentMeta,
        dateSent.isAcceptableOrUnknown(data['date_sent']!, _dateSentMeta),
      );
    } else if (isInserting) {
      context.missing(_dateSentMeta);
    }
    if (data.containsKey('date_received')) {
      context.handle(
        _dateReceivedMeta,
        dateReceived.isAcceptableOrUnknown(
          data['date_received']!,
          _dateReceivedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateReceivedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {messageId, authorId},
  ];
  @override
  Reaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      authorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_id'],
      )!,
      emoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emoji'],
      )!,
      dateSent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_sent'],
      )!,
      dateReceived: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_received'],
      )!,
    );
  }

  @override
  $ReactionsTable createAlias(String alias) {
    return $ReactionsTable(attachedDatabase, alias);
  }
}

class Reaction extends DataClass implements Insertable<Reaction> {
  final int id;
  final String messageId;
  final String authorId;
  final String emoji;
  final int dateSent;
  final int dateReceived;
  const Reaction({
    required this.id,
    required this.messageId,
    required this.authorId,
    required this.emoji,
    required this.dateSent,
    required this.dateReceived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message_id'] = Variable<String>(messageId);
    map['author_id'] = Variable<String>(authorId);
    map['emoji'] = Variable<String>(emoji);
    map['date_sent'] = Variable<int>(dateSent);
    map['date_received'] = Variable<int>(dateReceived);
    return map;
  }

  ReactionsCompanion toCompanion(bool nullToAbsent) {
    return ReactionsCompanion(
      id: Value(id),
      messageId: Value(messageId),
      authorId: Value(authorId),
      emoji: Value(emoji),
      dateSent: Value(dateSent),
      dateReceived: Value(dateReceived),
    );
  }

  factory Reaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reaction(
      id: serializer.fromJson<int>(json['id']),
      messageId: serializer.fromJson<String>(json['messageId']),
      authorId: serializer.fromJson<String>(json['authorId']),
      emoji: serializer.fromJson<String>(json['emoji']),
      dateSent: serializer.fromJson<int>(json['dateSent']),
      dateReceived: serializer.fromJson<int>(json['dateReceived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageId': serializer.toJson<String>(messageId),
      'authorId': serializer.toJson<String>(authorId),
      'emoji': serializer.toJson<String>(emoji),
      'dateSent': serializer.toJson<int>(dateSent),
      'dateReceived': serializer.toJson<int>(dateReceived),
    };
  }

  Reaction copyWith({
    int? id,
    String? messageId,
    String? authorId,
    String? emoji,
    int? dateSent,
    int? dateReceived,
  }) => Reaction(
    id: id ?? this.id,
    messageId: messageId ?? this.messageId,
    authorId: authorId ?? this.authorId,
    emoji: emoji ?? this.emoji,
    dateSent: dateSent ?? this.dateSent,
    dateReceived: dateReceived ?? this.dateReceived,
  );
  Reaction copyWithCompanion(ReactionsCompanion data) {
    return Reaction(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      dateSent: data.dateSent.present ? data.dateSent.value : this.dateSent,
      dateReceived: data.dateReceived.present
          ? data.dateReceived.value
          : this.dateReceived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reaction(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('authorId: $authorId, ')
          ..write('emoji: $emoji, ')
          ..write('dateSent: $dateSent, ')
          ..write('dateReceived: $dateReceived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, messageId, authorId, emoji, dateSent, dateReceived);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reaction &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.authorId == this.authorId &&
          other.emoji == this.emoji &&
          other.dateSent == this.dateSent &&
          other.dateReceived == this.dateReceived);
}

class ReactionsCompanion extends UpdateCompanion<Reaction> {
  final Value<int> id;
  final Value<String> messageId;
  final Value<String> authorId;
  final Value<String> emoji;
  final Value<int> dateSent;
  final Value<int> dateReceived;
  const ReactionsCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.authorId = const Value.absent(),
    this.emoji = const Value.absent(),
    this.dateSent = const Value.absent(),
    this.dateReceived = const Value.absent(),
  });
  ReactionsCompanion.insert({
    this.id = const Value.absent(),
    required String messageId,
    required String authorId,
    required String emoji,
    required int dateSent,
    required int dateReceived,
  }) : messageId = Value(messageId),
       authorId = Value(authorId),
       emoji = Value(emoji),
       dateSent = Value(dateSent),
       dateReceived = Value(dateReceived);
  static Insertable<Reaction> custom({
    Expression<int>? id,
    Expression<String>? messageId,
    Expression<String>? authorId,
    Expression<String>? emoji,
    Expression<int>? dateSent,
    Expression<int>? dateReceived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (authorId != null) 'author_id': authorId,
      if (emoji != null) 'emoji': emoji,
      if (dateSent != null) 'date_sent': dateSent,
      if (dateReceived != null) 'date_received': dateReceived,
    });
  }

  ReactionsCompanion copyWith({
    Value<int>? id,
    Value<String>? messageId,
    Value<String>? authorId,
    Value<String>? emoji,
    Value<int>? dateSent,
    Value<int>? dateReceived,
  }) {
    return ReactionsCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      authorId: authorId ?? this.authorId,
      emoji: emoji ?? this.emoji,
      dateSent: dateSent ?? this.dateSent,
      dateReceived: dateReceived ?? this.dateReceived,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (dateSent.present) {
      map['date_sent'] = Variable<int>(dateSent.value);
    }
    if (dateReceived.present) {
      map['date_received'] = Variable<int>(dateReceived.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReactionsCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('authorId: $authorId, ')
          ..write('emoji: $emoji, ')
          ..write('dateSent: $dateSent, ')
          ..write('dateReceived: $dateReceived')
          ..write(')'))
        .toString();
  }
}

class $MessageReceiptsTable extends MessageReceipts
    with TableInfo<$MessageReceiptsTable, MessageReceipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageReceiptsTable(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES messages (id)',
    ),
  );
  static const VerificationMeta _recipientIdMeta = const VerificationMeta(
    'recipientId',
  );
  @override
  late final GeneratedColumn<String> recipientId = GeneratedColumn<String>(
    'recipient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipients (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MessageStatusDb, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<MessageStatusDb>($MessageReceiptsTable.$converterstatus);
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
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    recipientId,
    status,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageReceipt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('recipient_id')) {
      context.handle(
        _recipientIdMeta,
        recipientId.isAcceptableOrUnknown(
          data['recipient_id']!,
          _recipientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recipientIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {messageId, recipientId, status},
  ];
  @override
  MessageReceipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageReceipt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      recipientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient_id'],
      )!,
      status: $MessageReceiptsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $MessageReceiptsTable createAlias(String alias) {
    return $MessageReceiptsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MessageStatusDb, int, int> $converterstatus =
      const EnumIndexConverter<MessageStatusDb>(MessageStatusDb.values);
}

class MessageReceipt extends DataClass implements Insertable<MessageReceipt> {
  final int id;
  final String messageId;
  final String recipientId;
  final MessageStatusDb status;
  final int timestamp;
  const MessageReceipt({
    required this.id,
    required this.messageId,
    required this.recipientId,
    required this.status,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message_id'] = Variable<String>(messageId);
    map['recipient_id'] = Variable<String>(recipientId);
    {
      map['status'] = Variable<int>(
        $MessageReceiptsTable.$converterstatus.toSql(status),
      );
    }
    map['timestamp'] = Variable<int>(timestamp);
    return map;
  }

  MessageReceiptsCompanion toCompanion(bool nullToAbsent) {
    return MessageReceiptsCompanion(
      id: Value(id),
      messageId: Value(messageId),
      recipientId: Value(recipientId),
      status: Value(status),
      timestamp: Value(timestamp),
    );
  }

  factory MessageReceipt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageReceipt(
      id: serializer.fromJson<int>(json['id']),
      messageId: serializer.fromJson<String>(json['messageId']),
      recipientId: serializer.fromJson<String>(json['recipientId']),
      status: $MessageReceiptsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      timestamp: serializer.fromJson<int>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageId': serializer.toJson<String>(messageId),
      'recipientId': serializer.toJson<String>(recipientId),
      'status': serializer.toJson<int>(
        $MessageReceiptsTable.$converterstatus.toJson(status),
      ),
      'timestamp': serializer.toJson<int>(timestamp),
    };
  }

  MessageReceipt copyWith({
    int? id,
    String? messageId,
    String? recipientId,
    MessageStatusDb? status,
    int? timestamp,
  }) => MessageReceipt(
    id: id ?? this.id,
    messageId: messageId ?? this.messageId,
    recipientId: recipientId ?? this.recipientId,
    status: status ?? this.status,
    timestamp: timestamp ?? this.timestamp,
  );
  MessageReceipt copyWithCompanion(MessageReceiptsCompanion data) {
    return MessageReceipt(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      recipientId: data.recipientId.present
          ? data.recipientId.value
          : this.recipientId,
      status: data.status.present ? data.status.value : this.status,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageReceipt(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('recipientId: $recipientId, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, messageId, recipientId, status, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageReceipt &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.recipientId == this.recipientId &&
          other.status == this.status &&
          other.timestamp == this.timestamp);
}

class MessageReceiptsCompanion extends UpdateCompanion<MessageReceipt> {
  final Value<int> id;
  final Value<String> messageId;
  final Value<String> recipientId;
  final Value<MessageStatusDb> status;
  final Value<int> timestamp;
  const MessageReceiptsCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.recipientId = const Value.absent(),
    this.status = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  MessageReceiptsCompanion.insert({
    this.id = const Value.absent(),
    required String messageId,
    required String recipientId,
    required MessageStatusDb status,
    required int timestamp,
  }) : messageId = Value(messageId),
       recipientId = Value(recipientId),
       status = Value(status),
       timestamp = Value(timestamp);
  static Insertable<MessageReceipt> custom({
    Expression<int>? id,
    Expression<String>? messageId,
    Expression<String>? recipientId,
    Expression<int>? status,
    Expression<int>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (recipientId != null) 'recipient_id': recipientId,
      if (status != null) 'status': status,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  MessageReceiptsCompanion copyWith({
    Value<int>? id,
    Value<String>? messageId,
    Value<String>? recipientId,
    Value<MessageStatusDb>? status,
    Value<int>? timestamp,
  }) {
    return MessageReceiptsCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      recipientId: recipientId ?? this.recipientId,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (recipientId.present) {
      map['recipient_id'] = Variable<String>(recipientId.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $MessageReceiptsTable.$converterstatus.toSql(status.value),
      );
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('recipientId: $recipientId, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp')
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

class $PollsTable extends Polls with TableInfo<$PollsTable, PollDb> {
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
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allowMultipleVotesMeta =
      const VerificationMeta('allowMultipleVotes');
  @override
  late final GeneratedColumn<bool> allowMultipleVotes = GeneratedColumn<bool>(
    'allow_multiple_votes',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("allow_multiple_votes" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hasEndedMeta = const VerificationMeta(
    'hasEnded',
  );
  @override
  late final GeneratedColumn<bool> hasEnded = GeneratedColumn<bool>(
    'has_ended',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_ended" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _authorIdMeta = const VerificationMeta(
    'authorId',
  );
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
    'author_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES recipients(id)',
  );
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
    $customConstraints: 'NOT NULL REFERENCES messages(id)',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    question,
    allowMultipleVotes,
    hasEnded,
    authorId,
    messageId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'polls';
  @override
  VerificationContext validateIntegrity(
    Insertable<PollDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('allow_multiple_votes')) {
      context.handle(
        _allowMultipleVotesMeta,
        allowMultipleVotes.isAcceptableOrUnknown(
          data['allow_multiple_votes']!,
          _allowMultipleVotesMeta,
        ),
      );
    }
    if (data.containsKey('has_ended')) {
      context.handle(
        _hasEndedMeta,
        hasEnded.isAcceptableOrUnknown(data['has_ended']!, _hasEndedMeta),
      );
    }
    if (data.containsKey('author_id')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_authorIdMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PollDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PollDb(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      )!,
      allowMultipleVotes: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}allow_multiple_votes'],
      )!,
      hasEnded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_ended'],
      )!,
      authorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
    );
  }

  @override
  $PollsTable createAlias(String alias) {
    return $PollsTable(attachedDatabase, alias);
  }
}

class PollDb extends DataClass implements Insertable<PollDb> {
  final String id;
  final String question;
  final bool allowMultipleVotes;
  final bool hasEnded;
  final String authorId;
  final String messageId;
  const PollDb({
    required this.id,
    required this.question,
    required this.allowMultipleVotes,
    required this.hasEnded,
    required this.authorId,
    required this.messageId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['question'] = Variable<String>(question);
    map['allow_multiple_votes'] = Variable<bool>(allowMultipleVotes);
    map['has_ended'] = Variable<bool>(hasEnded);
    map['author_id'] = Variable<String>(authorId);
    map['message_id'] = Variable<String>(messageId);
    return map;
  }

  PollsCompanion toCompanion(bool nullToAbsent) {
    return PollsCompanion(
      id: Value(id),
      question: Value(question),
      allowMultipleVotes: Value(allowMultipleVotes),
      hasEnded: Value(hasEnded),
      authorId: Value(authorId),
      messageId: Value(messageId),
    );
  }

  factory PollDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PollDb(
      id: serializer.fromJson<String>(json['id']),
      question: serializer.fromJson<String>(json['question']),
      allowMultipleVotes: serializer.fromJson<bool>(json['allowMultipleVotes']),
      hasEnded: serializer.fromJson<bool>(json['hasEnded']),
      authorId: serializer.fromJson<String>(json['authorId']),
      messageId: serializer.fromJson<String>(json['messageId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'question': serializer.toJson<String>(question),
      'allowMultipleVotes': serializer.toJson<bool>(allowMultipleVotes),
      'hasEnded': serializer.toJson<bool>(hasEnded),
      'authorId': serializer.toJson<String>(authorId),
      'messageId': serializer.toJson<String>(messageId),
    };
  }

  PollDb copyWith({
    String? id,
    String? question,
    bool? allowMultipleVotes,
    bool? hasEnded,
    String? authorId,
    String? messageId,
  }) => PollDb(
    id: id ?? this.id,
    question: question ?? this.question,
    allowMultipleVotes: allowMultipleVotes ?? this.allowMultipleVotes,
    hasEnded: hasEnded ?? this.hasEnded,
    authorId: authorId ?? this.authorId,
    messageId: messageId ?? this.messageId,
  );
  PollDb copyWithCompanion(PollsCompanion data) {
    return PollDb(
      id: data.id.present ? data.id.value : this.id,
      question: data.question.present ? data.question.value : this.question,
      allowMultipleVotes: data.allowMultipleVotes.present
          ? data.allowMultipleVotes.value
          : this.allowMultipleVotes,
      hasEnded: data.hasEnded.present ? data.hasEnded.value : this.hasEnded,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PollDb(')
          ..write('id: $id, ')
          ..write('question: $question, ')
          ..write('allowMultipleVotes: $allowMultipleVotes, ')
          ..write('hasEnded: $hasEnded, ')
          ..write('authorId: $authorId, ')
          ..write('messageId: $messageId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    question,
    allowMultipleVotes,
    hasEnded,
    authorId,
    messageId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PollDb &&
          other.id == this.id &&
          other.question == this.question &&
          other.allowMultipleVotes == this.allowMultipleVotes &&
          other.hasEnded == this.hasEnded &&
          other.authorId == this.authorId &&
          other.messageId == this.messageId);
}

class PollsCompanion extends UpdateCompanion<PollDb> {
  final Value<String> id;
  final Value<String> question;
  final Value<bool> allowMultipleVotes;
  final Value<bool> hasEnded;
  final Value<String> authorId;
  final Value<String> messageId;
  final Value<int> rowid;
  const PollsCompanion({
    this.id = const Value.absent(),
    this.question = const Value.absent(),
    this.allowMultipleVotes = const Value.absent(),
    this.hasEnded = const Value.absent(),
    this.authorId = const Value.absent(),
    this.messageId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PollsCompanion.insert({
    required String id,
    required String question,
    this.allowMultipleVotes = const Value.absent(),
    this.hasEnded = const Value.absent(),
    required String authorId,
    required String messageId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       question = Value(question),
       authorId = Value(authorId),
       messageId = Value(messageId);
  static Insertable<PollDb> custom({
    Expression<String>? id,
    Expression<String>? question,
    Expression<bool>? allowMultipleVotes,
    Expression<bool>? hasEnded,
    Expression<String>? authorId,
    Expression<String>? messageId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (question != null) 'question': question,
      if (allowMultipleVotes != null)
        'allow_multiple_votes': allowMultipleVotes,
      if (hasEnded != null) 'has_ended': hasEnded,
      if (authorId != null) 'author_id': authorId,
      if (messageId != null) 'message_id': messageId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PollsCompanion copyWith({
    Value<String>? id,
    Value<String>? question,
    Value<bool>? allowMultipleVotes,
    Value<bool>? hasEnded,
    Value<String>? authorId,
    Value<String>? messageId,
    Value<int>? rowid,
  }) {
    return PollsCompanion(
      id: id ?? this.id,
      question: question ?? this.question,
      allowMultipleVotes: allowMultipleVotes ?? this.allowMultipleVotes,
      hasEnded: hasEnded ?? this.hasEnded,
      authorId: authorId ?? this.authorId,
      messageId: messageId ?? this.messageId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (allowMultipleVotes.present) {
      map['allow_multiple_votes'] = Variable<bool>(allowMultipleVotes.value);
    }
    if (hasEnded.present) {
      map['has_ended'] = Variable<bool>(hasEnded.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
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
          ..write('question: $question, ')
          ..write('allowMultipleVotes: $allowMultipleVotes, ')
          ..write('hasEnded: $hasEnded, ')
          ..write('authorId: $authorId, ')
          ..write('messageId: $messageId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PollOptionsTable extends PollOptions
    with TableInfo<$PollOptionsTable, PollOptionDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PollOptionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _pollIdMeta = const VerificationMeta('pollId');
  @override
  late final GeneratedColumn<String> pollId = GeneratedColumn<String>(
    'poll_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES polls(id)',
  );
  static const VerificationMeta _optionTextMeta = const VerificationMeta(
    'optionText',
  );
  @override
  late final GeneratedColumn<String> optionText = GeneratedColumn<String>(
    'option_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, pollId, optionText];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'poll_options';
  @override
  VerificationContext validateIntegrity(
    Insertable<PollOptionDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('poll_id')) {
      context.handle(
        _pollIdMeta,
        pollId.isAcceptableOrUnknown(data['poll_id']!, _pollIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pollIdMeta);
    }
    if (data.containsKey('option_text')) {
      context.handle(
        _optionTextMeta,
        optionText.isAcceptableOrUnknown(data['option_text']!, _optionTextMeta),
      );
    } else if (isInserting) {
      context.missing(_optionTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PollOptionDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PollOptionDb(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pollId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poll_id'],
      )!,
      optionText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}option_text'],
      )!,
    );
  }

  @override
  $PollOptionsTable createAlias(String alias) {
    return $PollOptionsTable(attachedDatabase, alias);
  }
}

class PollOptionDb extends DataClass implements Insertable<PollOptionDb> {
  final int id;
  final String pollId;
  final String optionText;
  const PollOptionDb({
    required this.id,
    required this.pollId,
    required this.optionText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['poll_id'] = Variable<String>(pollId);
    map['option_text'] = Variable<String>(optionText);
    return map;
  }

  PollOptionsCompanion toCompanion(bool nullToAbsent) {
    return PollOptionsCompanion(
      id: Value(id),
      pollId: Value(pollId),
      optionText: Value(optionText),
    );
  }

  factory PollOptionDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PollOptionDb(
      id: serializer.fromJson<int>(json['id']),
      pollId: serializer.fromJson<String>(json['pollId']),
      optionText: serializer.fromJson<String>(json['optionText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pollId': serializer.toJson<String>(pollId),
      'optionText': serializer.toJson<String>(optionText),
    };
  }

  PollOptionDb copyWith({int? id, String? pollId, String? optionText}) =>
      PollOptionDb(
        id: id ?? this.id,
        pollId: pollId ?? this.pollId,
        optionText: optionText ?? this.optionText,
      );
  PollOptionDb copyWithCompanion(PollOptionsCompanion data) {
    return PollOptionDb(
      id: data.id.present ? data.id.value : this.id,
      pollId: data.pollId.present ? data.pollId.value : this.pollId,
      optionText: data.optionText.present
          ? data.optionText.value
          : this.optionText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PollOptionDb(')
          ..write('id: $id, ')
          ..write('pollId: $pollId, ')
          ..write('optionText: $optionText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pollId, optionText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PollOptionDb &&
          other.id == this.id &&
          other.pollId == this.pollId &&
          other.optionText == this.optionText);
}

class PollOptionsCompanion extends UpdateCompanion<PollOptionDb> {
  final Value<int> id;
  final Value<String> pollId;
  final Value<String> optionText;
  const PollOptionsCompanion({
    this.id = const Value.absent(),
    this.pollId = const Value.absent(),
    this.optionText = const Value.absent(),
  });
  PollOptionsCompanion.insert({
    this.id = const Value.absent(),
    required String pollId,
    required String optionText,
  }) : pollId = Value(pollId),
       optionText = Value(optionText);
  static Insertable<PollOptionDb> custom({
    Expression<int>? id,
    Expression<String>? pollId,
    Expression<String>? optionText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pollId != null) 'poll_id': pollId,
      if (optionText != null) 'option_text': optionText,
    });
  }

  PollOptionsCompanion copyWith({
    Value<int>? id,
    Value<String>? pollId,
    Value<String>? optionText,
  }) {
    return PollOptionsCompanion(
      id: id ?? this.id,
      pollId: pollId ?? this.pollId,
      optionText: optionText ?? this.optionText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pollId.present) {
      map['poll_id'] = Variable<String>(pollId.value);
    }
    if (optionText.present) {
      map['option_text'] = Variable<String>(optionText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PollOptionsCompanion(')
          ..write('id: $id, ')
          ..write('pollId: $pollId, ')
          ..write('optionText: $optionText')
          ..write(')'))
        .toString();
  }
}

class $PollVotesTable extends PollVotes
    with TableInfo<$PollVotesTable, PollVoteDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PollVotesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _pollIdMeta = const VerificationMeta('pollId');
  @override
  late final GeneratedColumn<String> pollId = GeneratedColumn<String>(
    'poll_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES polls(id)',
  );
  static const VerificationMeta _optionIdMeta = const VerificationMeta(
    'optionId',
  );
  @override
  late final GeneratedColumn<int> optionId = GeneratedColumn<int>(
    'option_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES poll_options(id)',
  );
  static const VerificationMeta _voterIdMeta = const VerificationMeta(
    'voterId',
  );
  @override
  late final GeneratedColumn<String> voterId = GeneratedColumn<String>(
    'voter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES recipients(id)',
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
  List<GeneratedColumn> get $columns => [
    id,
    pollId,
    optionId,
    voterId,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'poll_votes';
  @override
  VerificationContext validateIntegrity(
    Insertable<PollVoteDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('poll_id')) {
      context.handle(
        _pollIdMeta,
        pollId.isAcceptableOrUnknown(data['poll_id']!, _pollIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pollIdMeta);
    }
    if (data.containsKey('option_id')) {
      context.handle(
        _optionIdMeta,
        optionId.isAcceptableOrUnknown(data['option_id']!, _optionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_optionIdMeta);
    }
    if (data.containsKey('voter_id')) {
      context.handle(
        _voterIdMeta,
        voterId.isAcceptableOrUnknown(data['voter_id']!, _voterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_voterIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {pollId, optionId, voterId},
  ];
  @override
  PollVoteDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PollVoteDb(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pollId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poll_id'],
      )!,
      optionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}option_id'],
      )!,
      voterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}voter_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $PollVotesTable createAlias(String alias) {
    return $PollVotesTable(attachedDatabase, alias);
  }
}

class PollVoteDb extends DataClass implements Insertable<PollVoteDb> {
  final int id;
  final String pollId;
  final int optionId;
  final String voterId;
  final int timestamp;
  const PollVoteDb({
    required this.id,
    required this.pollId,
    required this.optionId,
    required this.voterId,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['poll_id'] = Variable<String>(pollId);
    map['option_id'] = Variable<int>(optionId);
    map['voter_id'] = Variable<String>(voterId);
    map['timestamp'] = Variable<int>(timestamp);
    return map;
  }

  PollVotesCompanion toCompanion(bool nullToAbsent) {
    return PollVotesCompanion(
      id: Value(id),
      pollId: Value(pollId),
      optionId: Value(optionId),
      voterId: Value(voterId),
      timestamp: Value(timestamp),
    );
  }

  factory PollVoteDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PollVoteDb(
      id: serializer.fromJson<int>(json['id']),
      pollId: serializer.fromJson<String>(json['pollId']),
      optionId: serializer.fromJson<int>(json['optionId']),
      voterId: serializer.fromJson<String>(json['voterId']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pollId': serializer.toJson<String>(pollId),
      'optionId': serializer.toJson<int>(optionId),
      'voterId': serializer.toJson<String>(voterId),
      'timestamp': serializer.toJson<int>(timestamp),
    };
  }

  PollVoteDb copyWith({
    int? id,
    String? pollId,
    int? optionId,
    String? voterId,
    int? timestamp,
  }) => PollVoteDb(
    id: id ?? this.id,
    pollId: pollId ?? this.pollId,
    optionId: optionId ?? this.optionId,
    voterId: voterId ?? this.voterId,
    timestamp: timestamp ?? this.timestamp,
  );
  PollVoteDb copyWithCompanion(PollVotesCompanion data) {
    return PollVoteDb(
      id: data.id.present ? data.id.value : this.id,
      pollId: data.pollId.present ? data.pollId.value : this.pollId,
      optionId: data.optionId.present ? data.optionId.value : this.optionId,
      voterId: data.voterId.present ? data.voterId.value : this.voterId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PollVoteDb(')
          ..write('id: $id, ')
          ..write('pollId: $pollId, ')
          ..write('optionId: $optionId, ')
          ..write('voterId: $voterId, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pollId, optionId, voterId, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PollVoteDb &&
          other.id == this.id &&
          other.pollId == this.pollId &&
          other.optionId == this.optionId &&
          other.voterId == this.voterId &&
          other.timestamp == this.timestamp);
}

class PollVotesCompanion extends UpdateCompanion<PollVoteDb> {
  final Value<int> id;
  final Value<String> pollId;
  final Value<int> optionId;
  final Value<String> voterId;
  final Value<int> timestamp;
  const PollVotesCompanion({
    this.id = const Value.absent(),
    this.pollId = const Value.absent(),
    this.optionId = const Value.absent(),
    this.voterId = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  PollVotesCompanion.insert({
    this.id = const Value.absent(),
    required String pollId,
    required int optionId,
    required String voterId,
    required int timestamp,
  }) : pollId = Value(pollId),
       optionId = Value(optionId),
       voterId = Value(voterId),
       timestamp = Value(timestamp);
  static Insertable<PollVoteDb> custom({
    Expression<int>? id,
    Expression<String>? pollId,
    Expression<int>? optionId,
    Expression<String>? voterId,
    Expression<int>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pollId != null) 'poll_id': pollId,
      if (optionId != null) 'option_id': optionId,
      if (voterId != null) 'voter_id': voterId,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  PollVotesCompanion copyWith({
    Value<int>? id,
    Value<String>? pollId,
    Value<int>? optionId,
    Value<String>? voterId,
    Value<int>? timestamp,
  }) {
    return PollVotesCompanion(
      id: id ?? this.id,
      pollId: pollId ?? this.pollId,
      optionId: optionId ?? this.optionId,
      voterId: voterId ?? this.voterId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pollId.present) {
      map['poll_id'] = Variable<String>(pollId.value);
    }
    if (optionId.present) {
      map['option_id'] = Variable<int>(optionId.value);
    }
    if (voterId.present) {
      map['voter_id'] = Variable<String>(voterId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PollVotesCompanion(')
          ..write('id: $id, ')
          ..write('pollId: $pollId, ')
          ..write('optionId: $optionId, ')
          ..write('voterId: $voterId, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$SigmaDatabase extends GeneratedDatabase {
  _$SigmaDatabase(QueryExecutor e) : super(e);
  $SigmaDatabaseManager get managers => $SigmaDatabaseManager(this);
  late final $RecipientsTable recipients = $RecipientsTable(this);
  late final $ThreadsTable threads = $ThreadsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $MessageSearchTable messageSearch = $MessageSearchTable(this);
  late final $JobsTable jobs = $JobsTable(this);
  late final $KeyValuesTable keyValues = $KeyValuesTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  late final $ReactionsTable reactions = $ReactionsTable(this);
  late final $MessageReceiptsTable messageReceipts = $MessageReceiptsTable(
    this,
  );
  late final $SignalSessionsTable signalSessions = $SignalSessionsTable(this);
  late final $SignalPreKeysTable signalPreKeys = $SignalPreKeysTable(this);
  late final $SignalSignedPreKeysTable signalSignedPreKeys =
      $SignalSignedPreKeysTable(this);
  late final $SignalIdentitiesTable signalIdentities = $SignalIdentitiesTable(
    this,
  );
  late final $PollsTable polls = $PollsTable(this);
  late final $PollOptionsTable pollOptions = $PollOptionsTable(this);
  late final $PollVotesTable pollVotes = $PollVotesTable(this);
  late final RecipientDatabase recipientDatabase = RecipientDatabase(
    this as SigmaDatabase,
  );
  late final ThreadTable threadTable = ThreadTable(this as SigmaDatabase);
  late final MessageTable messageTable = MessageTable(this as SigmaDatabase);
  late final JobDatabase jobDatabase = JobDatabase(this as SigmaDatabase);
  late final KeyValueDatabase keyValueDatabase = KeyValueDatabase(
    this as SigmaDatabase,
  );
  late final AttachmentTable attachmentTable = AttachmentTable(
    this as SigmaDatabase,
  );
  late final PollTable pollTable = PollTable(this as SigmaDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    recipients,
    threads,
    messages,
    messageSearch,
    jobs,
    keyValues,
    attachments,
    reactions,
    messageReceipts,
    signalSessions,
    signalPreKeys,
    signalSignedPreKeys,
    signalIdentities,
    polls,
    pollOptions,
    pollVotes,
  ];
}

typedef $$RecipientsTableCreateCompanionBuilder =
    RecipientsCompanion Function({
      required String id,
      Value<String?> aci,
      Value<String?> pni,
      required RecipientTypeDb type,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> username,
      Value<String?> displayName,
      Value<String?> systemDisplayName,
      Value<String?> profileName,
      Value<String?> avatarUrl,
      Value<String?> bio,
      Value<String?> country,
      Value<String?> relativeName,
      Value<String?> relativeId,
      Value<String?> identityKey,
      Value<int?> signedPreKeyId,
      Value<String?> signedPreKeyPublic,
      Value<String?> signedPreKeySignature,
      Value<BigInt?> registrationId,
      Value<String?> preKeys,
      Value<bool> isPrivate,
      Value<String?> profileKey,
      Value<bool> isOnline,
      Value<DateTime?> lastSeen,
      required String fallbackColor,
      Value<int> identityStatus,
      Value<int> rowid,
    });
typedef $$RecipientsTableUpdateCompanionBuilder =
    RecipientsCompanion Function({
      Value<String> id,
      Value<String?> aci,
      Value<String?> pni,
      Value<RecipientTypeDb> type,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> username,
      Value<String?> displayName,
      Value<String?> systemDisplayName,
      Value<String?> profileName,
      Value<String?> avatarUrl,
      Value<String?> bio,
      Value<String?> country,
      Value<String?> relativeName,
      Value<String?> relativeId,
      Value<String?> identityKey,
      Value<int?> signedPreKeyId,
      Value<String?> signedPreKeyPublic,
      Value<String?> signedPreKeySignature,
      Value<BigInt?> registrationId,
      Value<String?> preKeys,
      Value<bool> isPrivate,
      Value<String?> profileKey,
      Value<bool> isOnline,
      Value<DateTime?> lastSeen,
      Value<String> fallbackColor,
      Value<int> identityStatus,
      Value<int> rowid,
    });

final class $$RecipientsTableReferences
    extends BaseReferences<_$SigmaDatabase, $RecipientsTable, RecipientData> {
  $$RecipientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ThreadsTable, List<ThreadData>> _threadsRefsTable(
    _$SigmaDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.threads,
    aliasName: $_aliasNameGenerator(db.recipients.id, db.threads.recipientId),
  );

  $$ThreadsTableProcessedTableManager get threadsRefs {
    final manager = $$ThreadsTableTableManager(
      $_db,
      $_db.threads,
    ).filter((f) => f.recipientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_threadsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MessagesTable, List<Message>> _messagesRefsTable(
    _$SigmaDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.messages,
    aliasName: $_aliasNameGenerator(
      db.recipients.id,
      db.messages.senderRecipientId,
    ),
  );

  $$MessagesTableProcessedTableManager get messagesRefs {
    final manager = $$MessagesTableTableManager($_db, $_db.messages).filter(
      (f) => f.senderRecipientId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_messagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReactionsTable, List<Reaction>>
  _reactionsRefsTable(_$SigmaDatabase db) => MultiTypedResultKey.fromTable(
    db.reactions,
    aliasName: $_aliasNameGenerator(db.recipients.id, db.reactions.authorId),
  );

  $$ReactionsTableProcessedTableManager get reactionsRefs {
    final manager = $$ReactionsTableTableManager(
      $_db,
      $_db.reactions,
    ).filter((f) => f.authorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MessageReceiptsTable, List<MessageReceipt>>
  _messageReceiptsRefsTable(_$SigmaDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.messageReceipts,
        aliasName: $_aliasNameGenerator(
          db.recipients.id,
          db.messageReceipts.recipientId,
        ),
      );

  $$MessageReceiptsTableProcessedTableManager get messageReceiptsRefs {
    final manager = $$MessageReceiptsTableTableManager(
      $_db,
      $_db.messageReceipts,
    ).filter((f) => f.recipientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _messageReceiptsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PollsTable, List<PollDb>> _pollsRefsTable(
    _$SigmaDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.polls,
    aliasName: $_aliasNameGenerator(db.recipients.id, db.polls.authorId),
  );

  $$PollsTableProcessedTableManager get pollsRefs {
    final manager = $$PollsTableTableManager(
      $_db,
      $_db.polls,
    ).filter((f) => f.authorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pollsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PollVotesTable, List<PollVoteDb>>
  _pollVotesRefsTable(_$SigmaDatabase db) => MultiTypedResultKey.fromTable(
    db.pollVotes,
    aliasName: $_aliasNameGenerator(db.recipients.id, db.pollVotes.voterId),
  );

  $$PollVotesTableProcessedTableManager get pollVotesRefs {
    final manager = $$PollVotesTableTableManager(
      $_db,
      $_db.pollVotes,
    ).filter((f) => f.voterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pollVotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecipientsTableFilterComposer
    extends Composer<_$SigmaDatabase, $RecipientsTable> {
  $$RecipientsTableFilterComposer({
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

  ColumnFilters<String> get aci => $composableBuilder(
    column: $table.aci,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pni => $composableBuilder(
    column: $table.pni,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RecipientTypeDb, RecipientTypeDb, int>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemDisplayName => $composableBuilder(
    column: $table.systemDisplayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileName => $composableBuilder(
    column: $table.profileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativeName => $composableBuilder(
    column: $table.relativeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativeId => $composableBuilder(
    column: $table.relativeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get signedPreKeyId => $composableBuilder(
    column: $table.signedPreKeyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signedPreKeyPublic => $composableBuilder(
    column: $table.signedPreKeyPublic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signedPreKeySignature => $composableBuilder(
    column: $table.signedPreKeySignature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get registrationId => $composableBuilder(
    column: $table.registrationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preKeys => $composableBuilder(
    column: $table.preKeys,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileKey => $composableBuilder(
    column: $table.profileKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOnline => $composableBuilder(
    column: $table.isOnline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fallbackColor => $composableBuilder(
    column: $table.fallbackColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get identityStatus => $composableBuilder(
    column: $table.identityStatus,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> threadsRefs(
    Expression<bool> Function($$ThreadsTableFilterComposer f) f,
  ) {
    final $$ThreadsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.threads,
      getReferencedColumn: (t) => t.recipientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThreadsTableFilterComposer(
            $db: $db,
            $table: $db.threads,
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
      getReferencedColumn: (t) => t.senderRecipientId,
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

  Expression<bool> reactionsRefs(
    Expression<bool> Function($$ReactionsTableFilterComposer f) f,
  ) {
    final $$ReactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reactions,
      getReferencedColumn: (t) => t.authorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReactionsTableFilterComposer(
            $db: $db,
            $table: $db.reactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> messageReceiptsRefs(
    Expression<bool> Function($$MessageReceiptsTableFilterComposer f) f,
  ) {
    final $$MessageReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messageReceipts,
      getReferencedColumn: (t) => t.recipientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessageReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.messageReceipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pollsRefs(
    Expression<bool> Function($$PollsTableFilterComposer f) f,
  ) {
    final $$PollsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.polls,
      getReferencedColumn: (t) => t.authorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollsTableFilterComposer(
            $db: $db,
            $table: $db.polls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pollVotesRefs(
    Expression<bool> Function($$PollVotesTableFilterComposer f) f,
  ) {
    final $$PollVotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pollVotes,
      getReferencedColumn: (t) => t.voterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollVotesTableFilterComposer(
            $db: $db,
            $table: $db.pollVotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipientsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $RecipientsTable> {
  $$RecipientsTableOrderingComposer({
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

  ColumnOrderings<String> get aci => $composableBuilder(
    column: $table.aci,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pni => $composableBuilder(
    column: $table.pni,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemDisplayName => $composableBuilder(
    column: $table.systemDisplayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileName => $composableBuilder(
    column: $table.profileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativeName => $composableBuilder(
    column: $table.relativeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativeId => $composableBuilder(
    column: $table.relativeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get signedPreKeyId => $composableBuilder(
    column: $table.signedPreKeyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signedPreKeyPublic => $composableBuilder(
    column: $table.signedPreKeyPublic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signedPreKeySignature => $composableBuilder(
    column: $table.signedPreKeySignature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get registrationId => $composableBuilder(
    column: $table.registrationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preKeys => $composableBuilder(
    column: $table.preKeys,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileKey => $composableBuilder(
    column: $table.profileKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOnline => $composableBuilder(
    column: $table.isOnline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fallbackColor => $composableBuilder(
    column: $table.fallbackColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get identityStatus => $composableBuilder(
    column: $table.identityStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipientsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $RecipientsTable> {
  $$RecipientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get aci =>
      $composableBuilder(column: $table.aci, builder: (column) => column);

  GeneratedColumn<String> get pni =>
      $composableBuilder(column: $table.pni, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecipientTypeDb, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get systemDisplayName => $composableBuilder(
    column: $table.systemDisplayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get profileName => $composableBuilder(
    column: $table.profileName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get relativeName => $composableBuilder(
    column: $table.relativeName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relativeId => $composableBuilder(
    column: $table.relativeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get identityKey => $composableBuilder(
    column: $table.identityKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get signedPreKeyId => $composableBuilder(
    column: $table.signedPreKeyId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get signedPreKeyPublic => $composableBuilder(
    column: $table.signedPreKeyPublic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get signedPreKeySignature => $composableBuilder(
    column: $table.signedPreKeySignature,
    builder: (column) => column,
  );

  GeneratedColumn<BigInt> get registrationId => $composableBuilder(
    column: $table.registrationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preKeys =>
      $composableBuilder(column: $table.preKeys, builder: (column) => column);

  GeneratedColumn<bool> get isPrivate =>
      $composableBuilder(column: $table.isPrivate, builder: (column) => column);

  GeneratedColumn<String> get profileKey => $composableBuilder(
    column: $table.profileKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isOnline =>
      $composableBuilder(column: $table.isOnline, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);

  GeneratedColumn<String> get fallbackColor => $composableBuilder(
    column: $table.fallbackColor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get identityStatus => $composableBuilder(
    column: $table.identityStatus,
    builder: (column) => column,
  );

  Expression<T> threadsRefs<T extends Object>(
    Expression<T> Function($$ThreadsTableAnnotationComposer a) f,
  ) {
    final $$ThreadsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.threads,
      getReferencedColumn: (t) => t.recipientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThreadsTableAnnotationComposer(
            $db: $db,
            $table: $db.threads,
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
      getReferencedColumn: (t) => t.senderRecipientId,
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

  Expression<T> reactionsRefs<T extends Object>(
    Expression<T> Function($$ReactionsTableAnnotationComposer a) f,
  ) {
    final $$ReactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reactions,
      getReferencedColumn: (t) => t.authorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.reactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> messageReceiptsRefs<T extends Object>(
    Expression<T> Function($$MessageReceiptsTableAnnotationComposer a) f,
  ) {
    final $$MessageReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messageReceipts,
      getReferencedColumn: (t) => t.recipientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessageReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.messageReceipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pollsRefs<T extends Object>(
    Expression<T> Function($$PollsTableAnnotationComposer a) f,
  ) {
    final $$PollsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.polls,
      getReferencedColumn: (t) => t.authorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollsTableAnnotationComposer(
            $db: $db,
            $table: $db.polls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pollVotesRefs<T extends Object>(
    Expression<T> Function($$PollVotesTableAnnotationComposer a) f,
  ) {
    final $$PollVotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pollVotes,
      getReferencedColumn: (t) => t.voterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollVotesTableAnnotationComposer(
            $db: $db,
            $table: $db.pollVotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipientsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $RecipientsTable,
          RecipientData,
          $$RecipientsTableFilterComposer,
          $$RecipientsTableOrderingComposer,
          $$RecipientsTableAnnotationComposer,
          $$RecipientsTableCreateCompanionBuilder,
          $$RecipientsTableUpdateCompanionBuilder,
          (RecipientData, $$RecipientsTableReferences),
          RecipientData,
          PrefetchHooks Function({
            bool threadsRefs,
            bool messagesRefs,
            bool reactionsRefs,
            bool messageReceiptsRefs,
            bool pollsRefs,
            bool pollVotesRefs,
          })
        > {
  $$RecipientsTableTableManager(_$SigmaDatabase db, $RecipientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> aci = const Value.absent(),
                Value<String?> pni = const Value.absent(),
                Value<RecipientTypeDb> type = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> systemDisplayName = const Value.absent(),
                Value<String?> profileName = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> relativeName = const Value.absent(),
                Value<String?> relativeId = const Value.absent(),
                Value<String?> identityKey = const Value.absent(),
                Value<int?> signedPreKeyId = const Value.absent(),
                Value<String?> signedPreKeyPublic = const Value.absent(),
                Value<String?> signedPreKeySignature = const Value.absent(),
                Value<BigInt?> registrationId = const Value.absent(),
                Value<String?> preKeys = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                Value<String?> profileKey = const Value.absent(),
                Value<bool> isOnline = const Value.absent(),
                Value<DateTime?> lastSeen = const Value.absent(),
                Value<String> fallbackColor = const Value.absent(),
                Value<int> identityStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipientsCompanion(
                id: id,
                aci: aci,
                pni: pni,
                type: type,
                phone: phone,
                email: email,
                username: username,
                displayName: displayName,
                systemDisplayName: systemDisplayName,
                profileName: profileName,
                avatarUrl: avatarUrl,
                bio: bio,
                country: country,
                relativeName: relativeName,
                relativeId: relativeId,
                identityKey: identityKey,
                signedPreKeyId: signedPreKeyId,
                signedPreKeyPublic: signedPreKeyPublic,
                signedPreKeySignature: signedPreKeySignature,
                registrationId: registrationId,
                preKeys: preKeys,
                isPrivate: isPrivate,
                profileKey: profileKey,
                isOnline: isOnline,
                lastSeen: lastSeen,
                fallbackColor: fallbackColor,
                identityStatus: identityStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> aci = const Value.absent(),
                Value<String?> pni = const Value.absent(),
                required RecipientTypeDb type,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> systemDisplayName = const Value.absent(),
                Value<String?> profileName = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> relativeName = const Value.absent(),
                Value<String?> relativeId = const Value.absent(),
                Value<String?> identityKey = const Value.absent(),
                Value<int?> signedPreKeyId = const Value.absent(),
                Value<String?> signedPreKeyPublic = const Value.absent(),
                Value<String?> signedPreKeySignature = const Value.absent(),
                Value<BigInt?> registrationId = const Value.absent(),
                Value<String?> preKeys = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                Value<String?> profileKey = const Value.absent(),
                Value<bool> isOnline = const Value.absent(),
                Value<DateTime?> lastSeen = const Value.absent(),
                required String fallbackColor,
                Value<int> identityStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipientsCompanion.insert(
                id: id,
                aci: aci,
                pni: pni,
                type: type,
                phone: phone,
                email: email,
                username: username,
                displayName: displayName,
                systemDisplayName: systemDisplayName,
                profileName: profileName,
                avatarUrl: avatarUrl,
                bio: bio,
                country: country,
                relativeName: relativeName,
                relativeId: relativeId,
                identityKey: identityKey,
                signedPreKeyId: signedPreKeyId,
                signedPreKeyPublic: signedPreKeyPublic,
                signedPreKeySignature: signedPreKeySignature,
                registrationId: registrationId,
                preKeys: preKeys,
                isPrivate: isPrivate,
                profileKey: profileKey,
                isOnline: isOnline,
                lastSeen: lastSeen,
                fallbackColor: fallbackColor,
                identityStatus: identityStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecipientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                threadsRefs = false,
                messagesRefs = false,
                reactionsRefs = false,
                messageReceiptsRefs = false,
                pollsRefs = false,
                pollVotesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (threadsRefs) db.threads,
                    if (messagesRefs) db.messages,
                    if (reactionsRefs) db.reactions,
                    if (messageReceiptsRefs) db.messageReceipts,
                    if (pollsRefs) db.polls,
                    if (pollVotesRefs) db.pollVotes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (threadsRefs)
                        await $_getPrefetchedData<
                          RecipientData,
                          $RecipientsTable,
                          ThreadData
                        >(
                          currentTable: table,
                          referencedTable: $$RecipientsTableReferences
                              ._threadsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipientsTableReferences(
                                db,
                                table,
                                p0,
                              ).threadsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (messagesRefs)
                        await $_getPrefetchedData<
                          RecipientData,
                          $RecipientsTable,
                          Message
                        >(
                          currentTable: table,
                          referencedTable: $$RecipientsTableReferences
                              ._messagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipientsTableReferences(
                                db,
                                table,
                                p0,
                              ).messagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.senderRecipientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reactionsRefs)
                        await $_getPrefetchedData<
                          RecipientData,
                          $RecipientsTable,
                          Reaction
                        >(
                          currentTable: table,
                          referencedTable: $$RecipientsTableReferences
                              ._reactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipientsTableReferences(
                                db,
                                table,
                                p0,
                              ).reactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.authorId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (messageReceiptsRefs)
                        await $_getPrefetchedData<
                          RecipientData,
                          $RecipientsTable,
                          MessageReceipt
                        >(
                          currentTable: table,
                          referencedTable: $$RecipientsTableReferences
                              ._messageReceiptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipientsTableReferences(
                                db,
                                table,
                                p0,
                              ).messageReceiptsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pollsRefs)
                        await $_getPrefetchedData<
                          RecipientData,
                          $RecipientsTable,
                          PollDb
                        >(
                          currentTable: table,
                          referencedTable: $$RecipientsTableReferences
                              ._pollsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipientsTableReferences(
                                db,
                                table,
                                p0,
                              ).pollsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.authorId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pollVotesRefs)
                        await $_getPrefetchedData<
                          RecipientData,
                          $RecipientsTable,
                          PollVoteDb
                        >(
                          currentTable: table,
                          referencedTable: $$RecipientsTableReferences
                              ._pollVotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipientsTableReferences(
                                db,
                                table,
                                p0,
                              ).pollVotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.voterId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RecipientsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $RecipientsTable,
      RecipientData,
      $$RecipientsTableFilterComposer,
      $$RecipientsTableOrderingComposer,
      $$RecipientsTableAnnotationComposer,
      $$RecipientsTableCreateCompanionBuilder,
      $$RecipientsTableUpdateCompanionBuilder,
      (RecipientData, $$RecipientsTableReferences),
      RecipientData,
      PrefetchHooks Function({
        bool threadsRefs,
        bool messagesRefs,
        bool reactionsRefs,
        bool messageReceiptsRefs,
        bool pollsRefs,
        bool pollVotesRefs,
      })
    >;
typedef $$ThreadsTableCreateCompanionBuilder =
    ThreadsCompanion Function({
      Value<int> id,
      required String recipientId,
      required int date,
      Value<String?> snippet,
      Value<int> unreadCount,
      Value<bool> isArchived,
      Value<int> pinnedOrder,
      Value<int> muteUntil,
      Value<bool> isMarkedUnread,
    });
typedef $$ThreadsTableUpdateCompanionBuilder =
    ThreadsCompanion Function({
      Value<int> id,
      Value<String> recipientId,
      Value<int> date,
      Value<String?> snippet,
      Value<int> unreadCount,
      Value<bool> isArchived,
      Value<int> pinnedOrder,
      Value<int> muteUntil,
      Value<bool> isMarkedUnread,
    });

final class $$ThreadsTableReferences
    extends BaseReferences<_$SigmaDatabase, $ThreadsTable, ThreadData> {
  $$ThreadsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecipientsTable _recipientIdTable(_$SigmaDatabase db) =>
      db.recipients.createAlias(
        $_aliasNameGenerator(db.threads.recipientId, db.recipients.id),
      );

  $$RecipientsTableProcessedTableManager get recipientId {
    final $_column = $_itemColumn<String>('recipient_id')!;

    final manager = $$RecipientsTableTableManager(
      $_db,
      $_db.recipients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MessagesTable, List<Message>> _messagesRefsTable(
    _$SigmaDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.messages,
    aliasName: $_aliasNameGenerator(db.threads.id, db.messages.threadId),
  );

  $$MessagesTableProcessedTableManager get messagesRefs {
    final manager = $$MessagesTableTableManager(
      $_db,
      $_db.messages,
    ).filter((f) => f.threadId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_messagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ThreadsTableFilterComposer
    extends Composer<_$SigmaDatabase, $ThreadsTable> {
  $$ThreadsTableFilterComposer({
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

  ColumnFilters<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snippet => $composableBuilder(
    column: $table.snippet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pinnedOrder => $composableBuilder(
    column: $table.pinnedOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get muteUntil => $composableBuilder(
    column: $table.muteUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMarkedUnread => $composableBuilder(
    column: $table.isMarkedUnread,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipientsTableFilterComposer get recipientId {
    final $$RecipientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipientId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableFilterComposer(
            $db: $db,
            $table: $db.recipients,
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
      getReferencedColumn: (t) => t.threadId,
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

class $$ThreadsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $ThreadsTable> {
  $$ThreadsTableOrderingComposer({
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

  ColumnOrderings<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snippet => $composableBuilder(
    column: $table.snippet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pinnedOrder => $composableBuilder(
    column: $table.pinnedOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get muteUntil => $composableBuilder(
    column: $table.muteUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMarkedUnread => $composableBuilder(
    column: $table.isMarkedUnread,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipientsTableOrderingComposer get recipientId {
    final $$RecipientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipientId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableOrderingComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ThreadsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $ThreadsTable> {
  $$ThreadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get snippet =>
      $composableBuilder(column: $table.snippet, builder: (column) => column);

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pinnedOrder => $composableBuilder(
    column: $table.pinnedOrder,
    builder: (column) => column,
  );

  GeneratedColumn<int> get muteUntil =>
      $composableBuilder(column: $table.muteUntil, builder: (column) => column);

  GeneratedColumn<bool> get isMarkedUnread => $composableBuilder(
    column: $table.isMarkedUnread,
    builder: (column) => column,
  );

  $$RecipientsTableAnnotationComposer get recipientId {
    final $$RecipientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipientId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipients,
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
      getReferencedColumn: (t) => t.threadId,
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

class $$ThreadsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $ThreadsTable,
          ThreadData,
          $$ThreadsTableFilterComposer,
          $$ThreadsTableOrderingComposer,
          $$ThreadsTableAnnotationComposer,
          $$ThreadsTableCreateCompanionBuilder,
          $$ThreadsTableUpdateCompanionBuilder,
          (ThreadData, $$ThreadsTableReferences),
          ThreadData,
          PrefetchHooks Function({bool recipientId, bool messagesRefs})
        > {
  $$ThreadsTableTableManager(_$SigmaDatabase db, $ThreadsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThreadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThreadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThreadsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> recipientId = const Value.absent(),
                Value<int> date = const Value.absent(),
                Value<String?> snippet = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> pinnedOrder = const Value.absent(),
                Value<int> muteUntil = const Value.absent(),
                Value<bool> isMarkedUnread = const Value.absent(),
              }) => ThreadsCompanion(
                id: id,
                recipientId: recipientId,
                date: date,
                snippet: snippet,
                unreadCount: unreadCount,
                isArchived: isArchived,
                pinnedOrder: pinnedOrder,
                muteUntil: muteUntil,
                isMarkedUnread: isMarkedUnread,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String recipientId,
                required int date,
                Value<String?> snippet = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> pinnedOrder = const Value.absent(),
                Value<int> muteUntil = const Value.absent(),
                Value<bool> isMarkedUnread = const Value.absent(),
              }) => ThreadsCompanion.insert(
                id: id,
                recipientId: recipientId,
                date: date,
                snippet: snippet,
                unreadCount: unreadCount,
                isArchived: isArchived,
                pinnedOrder: pinnedOrder,
                muteUntil: muteUntil,
                isMarkedUnread: isMarkedUnread,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ThreadsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipientId = false, messagesRefs = false}) {
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
                    if (recipientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipientId,
                                referencedTable: $$ThreadsTableReferences
                                    ._recipientIdTable(db),
                                referencedColumn: $$ThreadsTableReferences
                                    ._recipientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (messagesRefs)
                    await $_getPrefetchedData<
                      ThreadData,
                      $ThreadsTable,
                      Message
                    >(
                      currentTable: table,
                      referencedTable: $$ThreadsTableReferences
                          ._messagesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ThreadsTableReferences(db, table, p0).messagesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.threadId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ThreadsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $ThreadsTable,
      ThreadData,
      $$ThreadsTableFilterComposer,
      $$ThreadsTableOrderingComposer,
      $$ThreadsTableAnnotationComposer,
      $$ThreadsTableCreateCompanionBuilder,
      $$ThreadsTableUpdateCompanionBuilder,
      (ThreadData, $$ThreadsTableReferences),
      ThreadData,
      PrefetchHooks Function({bool recipientId, bool messagesRefs})
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      required String id,
      required int threadId,
      required String chatId,
      required String senderRecipientId,
      required String textContent,
      Value<MessageTypeDb> type,
      Value<String?> attachmentUrl,
      Value<String?> attachmentAesKey,
      Value<String?> attachmentIv,
      Value<String?> attachmentMacKey,
      required int timestamp,
      Value<MessageStatusDb> status,
      required bool isFromMe,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> pollQuestion,
      Value<List<String>?> pollOptions,
      Value<bool?> allowMultipleVotes,
      Value<int> rowid,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<String> id,
      Value<int> threadId,
      Value<String> chatId,
      Value<String> senderRecipientId,
      Value<String> textContent,
      Value<MessageTypeDb> type,
      Value<String?> attachmentUrl,
      Value<String?> attachmentAesKey,
      Value<String?> attachmentIv,
      Value<String?> attachmentMacKey,
      Value<int> timestamp,
      Value<MessageStatusDb> status,
      Value<bool> isFromMe,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> pollQuestion,
      Value<List<String>?> pollOptions,
      Value<bool?> allowMultipleVotes,
      Value<int> rowid,
    });

final class $$MessagesTableReferences
    extends BaseReferences<_$SigmaDatabase, $MessagesTable, Message> {
  $$MessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ThreadsTable _threadIdTable(_$SigmaDatabase db) => db.threads
      .createAlias($_aliasNameGenerator(db.messages.threadId, db.threads.id));

  $$ThreadsTableProcessedTableManager get threadId {
    final $_column = $_itemColumn<int>('thread_id')!;

    final manager = $$ThreadsTableTableManager(
      $_db,
      $_db.threads,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_threadIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RecipientsTable _senderRecipientIdTable(_$SigmaDatabase db) =>
      db.recipients.createAlias(
        $_aliasNameGenerator(db.messages.senderRecipientId, db.recipients.id),
      );

  $$RecipientsTableProcessedTableManager get senderRecipientId {
    final $_column = $_itemColumn<String>('sender_recipient_id')!;

    final manager = $$RecipientsTableTableManager(
      $_db,
      $_db.recipients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_senderRecipientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AttachmentsTable, List<AttachmentData>>
  _attachmentsRefsTable(_$SigmaDatabase db) => MultiTypedResultKey.fromTable(
    db.attachments,
    aliasName: $_aliasNameGenerator(db.messages.id, db.attachments.messageId),
  );

  $$AttachmentsTableProcessedTableManager get attachmentsRefs {
    final manager = $$AttachmentsTableTableManager(
      $_db,
      $_db.attachments,
    ).filter((f) => f.messageId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_attachmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReactionsTable, List<Reaction>>
  _reactionsRefsTable(_$SigmaDatabase db) => MultiTypedResultKey.fromTable(
    db.reactions,
    aliasName: $_aliasNameGenerator(db.messages.id, db.reactions.messageId),
  );

  $$ReactionsTableProcessedTableManager get reactionsRefs {
    final manager = $$ReactionsTableTableManager(
      $_db,
      $_db.reactions,
    ).filter((f) => f.messageId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MessageReceiptsTable, List<MessageReceipt>>
  _messageReceiptsRefsTable(_$SigmaDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.messageReceipts,
        aliasName: $_aliasNameGenerator(
          db.messages.id,
          db.messageReceipts.messageId,
        ),
      );

  $$MessageReceiptsTableProcessedTableManager get messageReceiptsRefs {
    final manager = $$MessageReceiptsTableTableManager(
      $_db,
      $_db.messageReceipts,
    ).filter((f) => f.messageId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _messageReceiptsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PollsTable, List<PollDb>> _pollsRefsTable(
    _$SigmaDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.polls,
    aliasName: $_aliasNameGenerator(db.messages.id, db.polls.messageId),
  );

  $$PollsTableProcessedTableManager get pollsRefs {
    final manager = $$PollsTableTableManager(
      $_db,
      $_db.polls,
    ).filter((f) => f.messageId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pollsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnFilters<String> get chatId => $composableBuilder(
    column: $table.chatId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MessageTypeDb, MessageTypeDb, int> get type =>
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

  ColumnFilters<String> get attachmentIv => $composableBuilder(
    column: $table.attachmentIv,
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

  ColumnWithTypeConverterFilters<MessageStatusDb, MessageStatusDb, int>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isFromMe => $composableBuilder(
    column: $table.isFromMe,
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

  ColumnFilters<String> get pollQuestion => $composableBuilder(
    column: $table.pollQuestion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get pollOptions => $composableBuilder(
    column: $table.pollOptions,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get allowMultipleVotes => $composableBuilder(
    column: $table.allowMultipleVotes,
    builder: (column) => ColumnFilters(column),
  );

  $$ThreadsTableFilterComposer get threadId {
    final $$ThreadsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.threadId,
      referencedTable: $db.threads,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThreadsTableFilterComposer(
            $db: $db,
            $table: $db.threads,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipientsTableFilterComposer get senderRecipientId {
    final $$RecipientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senderRecipientId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableFilterComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> attachmentsRefs(
    Expression<bool> Function($$AttachmentsTableFilterComposer f) f,
  ) {
    final $$AttachmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attachments,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttachmentsTableFilterComposer(
            $db: $db,
            $table: $db.attachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reactionsRefs(
    Expression<bool> Function($$ReactionsTableFilterComposer f) f,
  ) {
    final $$ReactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reactions,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReactionsTableFilterComposer(
            $db: $db,
            $table: $db.reactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> messageReceiptsRefs(
    Expression<bool> Function($$MessageReceiptsTableFilterComposer f) f,
  ) {
    final $$MessageReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messageReceipts,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessageReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.messageReceipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pollsRefs(
    Expression<bool> Function($$PollsTableFilterComposer f) f,
  ) {
    final $$PollsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.polls,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollsTableFilterComposer(
            $db: $db,
            $table: $db.polls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  ColumnOrderings<String> get chatId => $composableBuilder(
    column: $table.chatId,
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

  ColumnOrderings<String> get attachmentIv => $composableBuilder(
    column: $table.attachmentIv,
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

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pollQuestion => $composableBuilder(
    column: $table.pollQuestion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pollOptions => $composableBuilder(
    column: $table.pollOptions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allowMultipleVotes => $composableBuilder(
    column: $table.allowMultipleVotes,
    builder: (column) => ColumnOrderings(column),
  );

  $$ThreadsTableOrderingComposer get threadId {
    final $$ThreadsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.threadId,
      referencedTable: $db.threads,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThreadsTableOrderingComposer(
            $db: $db,
            $table: $db.threads,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipientsTableOrderingComposer get senderRecipientId {
    final $$RecipientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senderRecipientId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableOrderingComposer(
            $db: $db,
            $table: $db.recipients,
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

  GeneratedColumn<String> get chatId =>
      $composableBuilder(column: $table.chatId, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<MessageTypeDb, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get attachmentUrl => $composableBuilder(
    column: $table.attachmentUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachmentAesKey => $composableBuilder(
    column: $table.attachmentAesKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachmentIv => $composableBuilder(
    column: $table.attachmentIv,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachmentMacKey => $composableBuilder(
    column: $table.attachmentMacKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MessageStatusDb, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isFromMe =>
      $composableBuilder(column: $table.isFromMe, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get pollQuestion => $composableBuilder(
    column: $table.pollQuestion,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>?, String> get pollOptions =>
      $composableBuilder(
        column: $table.pollOptions,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get allowMultipleVotes => $composableBuilder(
    column: $table.allowMultipleVotes,
    builder: (column) => column,
  );

  $$ThreadsTableAnnotationComposer get threadId {
    final $$ThreadsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.threadId,
      referencedTable: $db.threads,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThreadsTableAnnotationComposer(
            $db: $db,
            $table: $db.threads,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipientsTableAnnotationComposer get senderRecipientId {
    final $$RecipientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.senderRecipientId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> attachmentsRefs<T extends Object>(
    Expression<T> Function($$AttachmentsTableAnnotationComposer a) f,
  ) {
    final $$AttachmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attachments,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttachmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.attachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reactionsRefs<T extends Object>(
    Expression<T> Function($$ReactionsTableAnnotationComposer a) f,
  ) {
    final $$ReactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reactions,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.reactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> messageReceiptsRefs<T extends Object>(
    Expression<T> Function($$MessageReceiptsTableAnnotationComposer a) f,
  ) {
    final $$MessageReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.messageReceipts,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessageReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.messageReceipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pollsRefs<T extends Object>(
    Expression<T> Function($$PollsTableAnnotationComposer a) f,
  ) {
    final $$PollsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.polls,
      getReferencedColumn: (t) => t.messageId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollsTableAnnotationComposer(
            $db: $db,
            $table: $db.polls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (Message, $$MessagesTableReferences),
          Message,
          PrefetchHooks Function({
            bool threadId,
            bool senderRecipientId,
            bool attachmentsRefs,
            bool reactionsRefs,
            bool messageReceiptsRefs,
            bool pollsRefs,
          })
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
                Value<int> threadId = const Value.absent(),
                Value<String> chatId = const Value.absent(),
                Value<String> senderRecipientId = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<MessageTypeDb> type = const Value.absent(),
                Value<String?> attachmentUrl = const Value.absent(),
                Value<String?> attachmentAesKey = const Value.absent(),
                Value<String?> attachmentIv = const Value.absent(),
                Value<String?> attachmentMacKey = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<MessageStatusDb> status = const Value.absent(),
                Value<bool> isFromMe = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> pollQuestion = const Value.absent(),
                Value<List<String>?> pollOptions = const Value.absent(),
                Value<bool?> allowMultipleVotes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                threadId: threadId,
                chatId: chatId,
                senderRecipientId: senderRecipientId,
                textContent: textContent,
                type: type,
                attachmentUrl: attachmentUrl,
                attachmentAesKey: attachmentAesKey,
                attachmentIv: attachmentIv,
                attachmentMacKey: attachmentMacKey,
                timestamp: timestamp,
                status: status,
                isFromMe: isFromMe,
                latitude: latitude,
                longitude: longitude,
                pollQuestion: pollQuestion,
                pollOptions: pollOptions,
                allowMultipleVotes: allowMultipleVotes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int threadId,
                required String chatId,
                required String senderRecipientId,
                required String textContent,
                Value<MessageTypeDb> type = const Value.absent(),
                Value<String?> attachmentUrl = const Value.absent(),
                Value<String?> attachmentAesKey = const Value.absent(),
                Value<String?> attachmentIv = const Value.absent(),
                Value<String?> attachmentMacKey = const Value.absent(),
                required int timestamp,
                Value<MessageStatusDb> status = const Value.absent(),
                required bool isFromMe,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> pollQuestion = const Value.absent(),
                Value<List<String>?> pollOptions = const Value.absent(),
                Value<bool?> allowMultipleVotes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                threadId: threadId,
                chatId: chatId,
                senderRecipientId: senderRecipientId,
                textContent: textContent,
                type: type,
                attachmentUrl: attachmentUrl,
                attachmentAesKey: attachmentAesKey,
                attachmentIv: attachmentIv,
                attachmentMacKey: attachmentMacKey,
                timestamp: timestamp,
                status: status,
                isFromMe: isFromMe,
                latitude: latitude,
                longitude: longitude,
                pollQuestion: pollQuestion,
                pollOptions: pollOptions,
                allowMultipleVotes: allowMultipleVotes,
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
          prefetchHooksCallback:
              ({
                threadId = false,
                senderRecipientId = false,
                attachmentsRefs = false,
                reactionsRefs = false,
                messageReceiptsRefs = false,
                pollsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (attachmentsRefs) db.attachments,
                    if (reactionsRefs) db.reactions,
                    if (messageReceiptsRefs) db.messageReceipts,
                    if (pollsRefs) db.polls,
                  ],
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
                        if (threadId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.threadId,
                                    referencedTable: $$MessagesTableReferences
                                        ._threadIdTable(db),
                                    referencedColumn: $$MessagesTableReferences
                                        ._threadIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (senderRecipientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.senderRecipientId,
                                    referencedTable: $$MessagesTableReferences
                                        ._senderRecipientIdTable(db),
                                    referencedColumn: $$MessagesTableReferences
                                        ._senderRecipientIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (attachmentsRefs)
                        await $_getPrefetchedData<
                          Message,
                          $MessagesTable,
                          AttachmentData
                        >(
                          currentTable: table,
                          referencedTable: $$MessagesTableReferences
                              ._attachmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MessagesTableReferences(
                                db,
                                table,
                                p0,
                              ).attachmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.messageId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reactionsRefs)
                        await $_getPrefetchedData<
                          Message,
                          $MessagesTable,
                          Reaction
                        >(
                          currentTable: table,
                          referencedTable: $$MessagesTableReferences
                              ._reactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MessagesTableReferences(
                                db,
                                table,
                                p0,
                              ).reactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.messageId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (messageReceiptsRefs)
                        await $_getPrefetchedData<
                          Message,
                          $MessagesTable,
                          MessageReceipt
                        >(
                          currentTable: table,
                          referencedTable: $$MessagesTableReferences
                              ._messageReceiptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MessagesTableReferences(
                                db,
                                table,
                                p0,
                              ).messageReceiptsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.messageId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pollsRefs)
                        await $_getPrefetchedData<
                          Message,
                          $MessagesTable,
                          PollDb
                        >(
                          currentTable: table,
                          referencedTable: $$MessagesTableReferences
                              ._pollsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MessagesTableReferences(
                                db,
                                table,
                                p0,
                              ).pollsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.messageId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
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
      (Message, $$MessagesTableReferences),
      Message,
      PrefetchHooks Function({
        bool threadId,
        bool senderRecipientId,
        bool attachmentsRefs,
        bool reactionsRefs,
        bool messageReceiptsRefs,
        bool pollsRefs,
      })
    >;
typedef $$MessageSearchTableCreateCompanionBuilder =
    MessageSearchCompanion Function({
      required String id,
      required String textContent,
      Value<int> rowid,
    });
typedef $$MessageSearchTableUpdateCompanionBuilder =
    MessageSearchCompanion Function({
      Value<String> id,
      Value<String> textContent,
      Value<int> rowid,
    });

class $$MessageSearchTableFilterComposer
    extends Composer<_$SigmaDatabase, $MessageSearchTable> {
  $$MessageSearchTableFilterComposer({
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
}

class $$MessageSearchTableOrderingComposer
    extends Composer<_$SigmaDatabase, $MessageSearchTable> {
  $$MessageSearchTableOrderingComposer({
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
}

class $$MessageSearchTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $MessageSearchTable> {
  $$MessageSearchTableAnnotationComposer({
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
}

class $$MessageSearchTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $MessageSearchTable,
          MessageSearchData,
          $$MessageSearchTableFilterComposer,
          $$MessageSearchTableOrderingComposer,
          $$MessageSearchTableAnnotationComposer,
          $$MessageSearchTableCreateCompanionBuilder,
          $$MessageSearchTableUpdateCompanionBuilder,
          (
            MessageSearchData,
            BaseReferences<
              _$SigmaDatabase,
              $MessageSearchTable,
              MessageSearchData
            >,
          ),
          MessageSearchData,
          PrefetchHooks Function()
        > {
  $$MessageSearchTableTableManager(
    _$SigmaDatabase db,
    $MessageSearchTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessageSearchTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessageSearchTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessageSearchTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessageSearchCompanion(
                id: id,
                textContent: textContent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String textContent,
                Value<int> rowid = const Value.absent(),
              }) => MessageSearchCompanion.insert(
                id: id,
                textContent: textContent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessageSearchTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $MessageSearchTable,
      MessageSearchData,
      $$MessageSearchTableFilterComposer,
      $$MessageSearchTableOrderingComposer,
      $$MessageSearchTableAnnotationComposer,
      $$MessageSearchTableCreateCompanionBuilder,
      $$MessageSearchTableUpdateCompanionBuilder,
      (
        MessageSearchData,
        BaseReferences<_$SigmaDatabase, $MessageSearchTable, MessageSearchData>,
      ),
      MessageSearchData,
      PrefetchHooks Function()
    >;
typedef $$JobsTableCreateCompanionBuilder =
    JobsCompanion Function({
      Value<int> id,
      required String factoryKey,
      Value<String?> queueKey,
      required String data,
      Value<int> priority,
      required int createTime,
      required int nextRunAttemptTime,
      Value<int> runAttempt,
      Value<bool> isRunning,
    });
typedef $$JobsTableUpdateCompanionBuilder =
    JobsCompanion Function({
      Value<int> id,
      Value<String> factoryKey,
      Value<String?> queueKey,
      Value<String> data,
      Value<int> priority,
      Value<int> createTime,
      Value<int> nextRunAttemptTime,
      Value<int> runAttempt,
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

  ColumnFilters<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextRunAttemptTime => $composableBuilder(
    column: $table.nextRunAttemptTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get runAttempt => $composableBuilder(
    column: $table.runAttempt,
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

  ColumnOrderings<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextRunAttemptTime => $composableBuilder(
    column: $table.nextRunAttemptTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get runAttempt => $composableBuilder(
    column: $table.runAttempt,
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

  GeneratedColumn<int> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextRunAttemptTime => $composableBuilder(
    column: $table.nextRunAttemptTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get runAttempt => $composableBuilder(
    column: $table.runAttempt,
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
          JobData,
          $$JobsTableFilterComposer,
          $$JobsTableOrderingComposer,
          $$JobsTableAnnotationComposer,
          $$JobsTableCreateCompanionBuilder,
          $$JobsTableUpdateCompanionBuilder,
          (JobData, BaseReferences<_$SigmaDatabase, $JobsTable, JobData>),
          JobData,
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
                Value<int> createTime = const Value.absent(),
                Value<int> nextRunAttemptTime = const Value.absent(),
                Value<int> runAttempt = const Value.absent(),
                Value<bool> isRunning = const Value.absent(),
              }) => JobsCompanion(
                id: id,
                factoryKey: factoryKey,
                queueKey: queueKey,
                data: data,
                priority: priority,
                createTime: createTime,
                nextRunAttemptTime: nextRunAttemptTime,
                runAttempt: runAttempt,
                isRunning: isRunning,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String factoryKey,
                Value<String?> queueKey = const Value.absent(),
                required String data,
                Value<int> priority = const Value.absent(),
                required int createTime,
                required int nextRunAttemptTime,
                Value<int> runAttempt = const Value.absent(),
                Value<bool> isRunning = const Value.absent(),
              }) => JobsCompanion.insert(
                id: id,
                factoryKey: factoryKey,
                queueKey: queueKey,
                data: data,
                priority: priority,
                createTime: createTime,
                nextRunAttemptTime: nextRunAttemptTime,
                runAttempt: runAttempt,
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
      JobData,
      $$JobsTableFilterComposer,
      $$JobsTableOrderingComposer,
      $$JobsTableAnnotationComposer,
      $$JobsTableCreateCompanionBuilder,
      $$JobsTableUpdateCompanionBuilder,
      (JobData, BaseReferences<_$SigmaDatabase, $JobsTable, JobData>),
      JobData,
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
typedef $$AttachmentsTableCreateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<int> id,
      required String messageId,
      required String contentType,
      Value<String?> fileName,
      required int size,
      Value<String?> localPath,
      Value<String?> thumbnailPath,
      Value<String?> remoteId,
      Value<String?> aesKey,
      Value<String?> iv,
      Value<String?> digest,
      Value<int> transferState,
    });
typedef $$AttachmentsTableUpdateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<int> id,
      Value<String> messageId,
      Value<String> contentType,
      Value<String?> fileName,
      Value<int> size,
      Value<String?> localPath,
      Value<String?> thumbnailPath,
      Value<String?> remoteId,
      Value<String?> aesKey,
      Value<String?> iv,
      Value<String?> digest,
      Value<int> transferState,
    });

final class $$AttachmentsTableReferences
    extends BaseReferences<_$SigmaDatabase, $AttachmentsTable, AttachmentData> {
  $$AttachmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MessagesTable _messageIdTable(_$SigmaDatabase db) =>
      db.messages.createAlias(
        $_aliasNameGenerator(db.attachments.messageId, db.messages.id),
      );

  $$MessagesTableProcessedTableManager get messageId {
    final $_column = $_itemColumn<String>('message_id')!;

    final manager = $$MessagesTableTableManager(
      $_db,
      $_db.messages,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttachmentsTableFilterComposer
    extends Composer<_$SigmaDatabase, $AttachmentsTable> {
  $$AttachmentsTableFilterComposer({
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

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aesKey => $composableBuilder(
    column: $table.aesKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iv => $composableBuilder(
    column: $table.iv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get digest => $composableBuilder(
    column: $table.digest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get transferState => $composableBuilder(
    column: $table.transferState,
    builder: (column) => ColumnFilters(column),
  );

  $$MessagesTableFilterComposer get messageId {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }
}

class $$AttachmentsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $AttachmentsTable> {
  $$AttachmentsTableOrderingComposer({
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

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aesKey => $composableBuilder(
    column: $table.aesKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iv => $composableBuilder(
    column: $table.iv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get digest => $composableBuilder(
    column: $table.digest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get transferState => $composableBuilder(
    column: $table.transferState,
    builder: (column) => ColumnOrderings(column),
  );

  $$MessagesTableOrderingComposer get messageId {
    final $$MessagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableOrderingComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttachmentsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $AttachmentsTable> {
  $$AttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get aesKey =>
      $composableBuilder(column: $table.aesKey, builder: (column) => column);

  GeneratedColumn<String> get iv =>
      $composableBuilder(column: $table.iv, builder: (column) => column);

  GeneratedColumn<String> get digest =>
      $composableBuilder(column: $table.digest, builder: (column) => column);

  GeneratedColumn<int> get transferState => $composableBuilder(
    column: $table.transferState,
    builder: (column) => column,
  );

  $$MessagesTableAnnotationComposer get messageId {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }
}

class $$AttachmentsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $AttachmentsTable,
          AttachmentData,
          $$AttachmentsTableFilterComposer,
          $$AttachmentsTableOrderingComposer,
          $$AttachmentsTableAnnotationComposer,
          $$AttachmentsTableCreateCompanionBuilder,
          $$AttachmentsTableUpdateCompanionBuilder,
          (AttachmentData, $$AttachmentsTableReferences),
          AttachmentData,
          PrefetchHooks Function({bool messageId})
        > {
  $$AttachmentsTableTableManager(_$SigmaDatabase db, $AttachmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> messageId = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String?> fileName = const Value.absent(),
                Value<int> size = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> thumbnailPath = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> aesKey = const Value.absent(),
                Value<String?> iv = const Value.absent(),
                Value<String?> digest = const Value.absent(),
                Value<int> transferState = const Value.absent(),
              }) => AttachmentsCompanion(
                id: id,
                messageId: messageId,
                contentType: contentType,
                fileName: fileName,
                size: size,
                localPath: localPath,
                thumbnailPath: thumbnailPath,
                remoteId: remoteId,
                aesKey: aesKey,
                iv: iv,
                digest: digest,
                transferState: transferState,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String messageId,
                required String contentType,
                Value<String?> fileName = const Value.absent(),
                required int size,
                Value<String?> localPath = const Value.absent(),
                Value<String?> thumbnailPath = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> aesKey = const Value.absent(),
                Value<String?> iv = const Value.absent(),
                Value<String?> digest = const Value.absent(),
                Value<int> transferState = const Value.absent(),
              }) => AttachmentsCompanion.insert(
                id: id,
                messageId: messageId,
                contentType: contentType,
                fileName: fileName,
                size: size,
                localPath: localPath,
                thumbnailPath: thumbnailPath,
                remoteId: remoteId,
                aesKey: aesKey,
                iv: iv,
                digest: digest,
                transferState: transferState,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AttachmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({messageId = false}) {
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
                    if (messageId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.messageId,
                                referencedTable: $$AttachmentsTableReferences
                                    ._messageIdTable(db),
                                referencedColumn: $$AttachmentsTableReferences
                                    ._messageIdTable(db)
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

typedef $$AttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $AttachmentsTable,
      AttachmentData,
      $$AttachmentsTableFilterComposer,
      $$AttachmentsTableOrderingComposer,
      $$AttachmentsTableAnnotationComposer,
      $$AttachmentsTableCreateCompanionBuilder,
      $$AttachmentsTableUpdateCompanionBuilder,
      (AttachmentData, $$AttachmentsTableReferences),
      AttachmentData,
      PrefetchHooks Function({bool messageId})
    >;
typedef $$ReactionsTableCreateCompanionBuilder =
    ReactionsCompanion Function({
      Value<int> id,
      required String messageId,
      required String authorId,
      required String emoji,
      required int dateSent,
      required int dateReceived,
    });
typedef $$ReactionsTableUpdateCompanionBuilder =
    ReactionsCompanion Function({
      Value<int> id,
      Value<String> messageId,
      Value<String> authorId,
      Value<String> emoji,
      Value<int> dateSent,
      Value<int> dateReceived,
    });

final class $$ReactionsTableReferences
    extends BaseReferences<_$SigmaDatabase, $ReactionsTable, Reaction> {
  $$ReactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MessagesTable _messageIdTable(_$SigmaDatabase db) =>
      db.messages.createAlias(
        $_aliasNameGenerator(db.reactions.messageId, db.messages.id),
      );

  $$MessagesTableProcessedTableManager get messageId {
    final $_column = $_itemColumn<String>('message_id')!;

    final manager = $$MessagesTableTableManager(
      $_db,
      $_db.messages,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RecipientsTable _authorIdTable(_$SigmaDatabase db) =>
      db.recipients.createAlias(
        $_aliasNameGenerator(db.reactions.authorId, db.recipients.id),
      );

  $$RecipientsTableProcessedTableManager get authorId {
    final $_column = $_itemColumn<String>('author_id')!;

    final manager = $$RecipientsTableTableManager(
      $_db,
      $_db.recipients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_authorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReactionsTableFilterComposer
    extends Composer<_$SigmaDatabase, $ReactionsTable> {
  $$ReactionsTableFilterComposer({
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

  ColumnFilters<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dateSent => $composableBuilder(
    column: $table.dateSent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dateReceived => $composableBuilder(
    column: $table.dateReceived,
    builder: (column) => ColumnFilters(column),
  );

  $$MessagesTableFilterComposer get messageId {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  $$RecipientsTableFilterComposer get authorId {
    final $$RecipientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.authorId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableFilterComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dateSent => $composableBuilder(
    column: $table.dateSent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dateReceived => $composableBuilder(
    column: $table.dateReceived,
    builder: (column) => ColumnOrderings(column),
  );

  $$MessagesTableOrderingComposer get messageId {
    final $$MessagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableOrderingComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipientsTableOrderingComposer get authorId {
    final $$RecipientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.authorId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableOrderingComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<int> get dateSent =>
      $composableBuilder(column: $table.dateSent, builder: (column) => column);

  GeneratedColumn<int> get dateReceived => $composableBuilder(
    column: $table.dateReceived,
    builder: (column) => column,
  );

  $$MessagesTableAnnotationComposer get messageId {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  $$RecipientsTableAnnotationComposer get authorId {
    final $$RecipientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.authorId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
          (Reaction, $$ReactionsTableReferences),
          Reaction,
          PrefetchHooks Function({bool messageId, bool authorId})
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
                Value<int> id = const Value.absent(),
                Value<String> messageId = const Value.absent(),
                Value<String> authorId = const Value.absent(),
                Value<String> emoji = const Value.absent(),
                Value<int> dateSent = const Value.absent(),
                Value<int> dateReceived = const Value.absent(),
              }) => ReactionsCompanion(
                id: id,
                messageId: messageId,
                authorId: authorId,
                emoji: emoji,
                dateSent: dateSent,
                dateReceived: dateReceived,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String messageId,
                required String authorId,
                required String emoji,
                required int dateSent,
                required int dateReceived,
              }) => ReactionsCompanion.insert(
                id: id,
                messageId: messageId,
                authorId: authorId,
                emoji: emoji,
                dateSent: dateSent,
                dateReceived: dateReceived,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({messageId = false, authorId = false}) {
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
                    if (messageId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.messageId,
                                referencedTable: $$ReactionsTableReferences
                                    ._messageIdTable(db),
                                referencedColumn: $$ReactionsTableReferences
                                    ._messageIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (authorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.authorId,
                                referencedTable: $$ReactionsTableReferences
                                    ._authorIdTable(db),
                                referencedColumn: $$ReactionsTableReferences
                                    ._authorIdTable(db)
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
      (Reaction, $$ReactionsTableReferences),
      Reaction,
      PrefetchHooks Function({bool messageId, bool authorId})
    >;
typedef $$MessageReceiptsTableCreateCompanionBuilder =
    MessageReceiptsCompanion Function({
      Value<int> id,
      required String messageId,
      required String recipientId,
      required MessageStatusDb status,
      required int timestamp,
    });
typedef $$MessageReceiptsTableUpdateCompanionBuilder =
    MessageReceiptsCompanion Function({
      Value<int> id,
      Value<String> messageId,
      Value<String> recipientId,
      Value<MessageStatusDb> status,
      Value<int> timestamp,
    });

final class $$MessageReceiptsTableReferences
    extends
        BaseReferences<_$SigmaDatabase, $MessageReceiptsTable, MessageReceipt> {
  $$MessageReceiptsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MessagesTable _messageIdTable(_$SigmaDatabase db) =>
      db.messages.createAlias(
        $_aliasNameGenerator(db.messageReceipts.messageId, db.messages.id),
      );

  $$MessagesTableProcessedTableManager get messageId {
    final $_column = $_itemColumn<String>('message_id')!;

    final manager = $$MessagesTableTableManager(
      $_db,
      $_db.messages,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RecipientsTable _recipientIdTable(_$SigmaDatabase db) =>
      db.recipients.createAlias(
        $_aliasNameGenerator(db.messageReceipts.recipientId, db.recipients.id),
      );

  $$RecipientsTableProcessedTableManager get recipientId {
    final $_column = $_itemColumn<String>('recipient_id')!;

    final manager = $$RecipientsTableTableManager(
      $_db,
      $_db.recipients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MessageReceiptsTableFilterComposer
    extends Composer<_$SigmaDatabase, $MessageReceiptsTable> {
  $$MessageReceiptsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<MessageStatusDb, MessageStatusDb, int>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  $$MessagesTableFilterComposer get messageId {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  $$RecipientsTableFilterComposer get recipientId {
    final $$RecipientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipientId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableFilterComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MessageReceiptsTableOrderingComposer
    extends Composer<_$SigmaDatabase, $MessageReceiptsTable> {
  $$MessageReceiptsTableOrderingComposer({
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

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  $$MessagesTableOrderingComposer get messageId {
    final $$MessagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableOrderingComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipientsTableOrderingComposer get recipientId {
    final $$RecipientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipientId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableOrderingComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MessageReceiptsTableAnnotationComposer
    extends Composer<_$SigmaDatabase, $MessageReceiptsTable> {
  $$MessageReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MessageStatusDb, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$MessagesTableAnnotationComposer get messageId {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  $$RecipientsTableAnnotationComposer get recipientId {
    final $$RecipientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipientId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MessageReceiptsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $MessageReceiptsTable,
          MessageReceipt,
          $$MessageReceiptsTableFilterComposer,
          $$MessageReceiptsTableOrderingComposer,
          $$MessageReceiptsTableAnnotationComposer,
          $$MessageReceiptsTableCreateCompanionBuilder,
          $$MessageReceiptsTableUpdateCompanionBuilder,
          (MessageReceipt, $$MessageReceiptsTableReferences),
          MessageReceipt,
          PrefetchHooks Function({bool messageId, bool recipientId})
        > {
  $$MessageReceiptsTableTableManager(
    _$SigmaDatabase db,
    $MessageReceiptsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessageReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessageReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessageReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> messageId = const Value.absent(),
                Value<String> recipientId = const Value.absent(),
                Value<MessageStatusDb> status = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
              }) => MessageReceiptsCompanion(
                id: id,
                messageId: messageId,
                recipientId: recipientId,
                status: status,
                timestamp: timestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String messageId,
                required String recipientId,
                required MessageStatusDb status,
                required int timestamp,
              }) => MessageReceiptsCompanion.insert(
                id: id,
                messageId: messageId,
                recipientId: recipientId,
                status: status,
                timestamp: timestamp,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MessageReceiptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({messageId = false, recipientId = false}) {
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
                    if (messageId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.messageId,
                                referencedTable:
                                    $$MessageReceiptsTableReferences
                                        ._messageIdTable(db),
                                referencedColumn:
                                    $$MessageReceiptsTableReferences
                                        ._messageIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (recipientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipientId,
                                referencedTable:
                                    $$MessageReceiptsTableReferences
                                        ._recipientIdTable(db),
                                referencedColumn:
                                    $$MessageReceiptsTableReferences
                                        ._recipientIdTable(db)
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

typedef $$MessageReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $MessageReceiptsTable,
      MessageReceipt,
      $$MessageReceiptsTableFilterComposer,
      $$MessageReceiptsTableOrderingComposer,
      $$MessageReceiptsTableAnnotationComposer,
      $$MessageReceiptsTableCreateCompanionBuilder,
      $$MessageReceiptsTableUpdateCompanionBuilder,
      (MessageReceipt, $$MessageReceiptsTableReferences),
      MessageReceipt,
      PrefetchHooks Function({bool messageId, bool recipientId})
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
    extends Composer<_$SigmaDatabase, $SignalSessionsTable> {
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
    extends Composer<_$SigmaDatabase, $SignalSessionsTable> {
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
    extends Composer<_$SigmaDatabase, $SignalSessionsTable> {
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
          _$SigmaDatabase,
          $SignalSessionsTable,
          SignalSession,
          $$SignalSessionsTableFilterComposer,
          $$SignalSessionsTableOrderingComposer,
          $$SignalSessionsTableAnnotationComposer,
          $$SignalSessionsTableCreateCompanionBuilder,
          $$SignalSessionsTableUpdateCompanionBuilder,
          (
            SignalSession,
            BaseReferences<
              _$SigmaDatabase,
              $SignalSessionsTable,
              SignalSession
            >,
          ),
          SignalSession,
          PrefetchHooks Function()
        > {
  $$SignalSessionsTableTableManager(
    _$SigmaDatabase db,
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
      _$SigmaDatabase,
      $SignalSessionsTable,
      SignalSession,
      $$SignalSessionsTableFilterComposer,
      $$SignalSessionsTableOrderingComposer,
      $$SignalSessionsTableAnnotationComposer,
      $$SignalSessionsTableCreateCompanionBuilder,
      $$SignalSessionsTableUpdateCompanionBuilder,
      (
        SignalSession,
        BaseReferences<_$SigmaDatabase, $SignalSessionsTable, SignalSession>,
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
    extends Composer<_$SigmaDatabase, $SignalPreKeysTable> {
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
    extends Composer<_$SigmaDatabase, $SignalPreKeysTable> {
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
    extends Composer<_$SigmaDatabase, $SignalPreKeysTable> {
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
          _$SigmaDatabase,
          $SignalPreKeysTable,
          SignalPreKey,
          $$SignalPreKeysTableFilterComposer,
          $$SignalPreKeysTableOrderingComposer,
          $$SignalPreKeysTableAnnotationComposer,
          $$SignalPreKeysTableCreateCompanionBuilder,
          $$SignalPreKeysTableUpdateCompanionBuilder,
          (
            SignalPreKey,
            BaseReferences<_$SigmaDatabase, $SignalPreKeysTable, SignalPreKey>,
          ),
          SignalPreKey,
          PrefetchHooks Function()
        > {
  $$SignalPreKeysTableTableManager(
    _$SigmaDatabase db,
    $SignalPreKeysTable table,
  ) : super(
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
      _$SigmaDatabase,
      $SignalPreKeysTable,
      SignalPreKey,
      $$SignalPreKeysTableFilterComposer,
      $$SignalPreKeysTableOrderingComposer,
      $$SignalPreKeysTableAnnotationComposer,
      $$SignalPreKeysTableCreateCompanionBuilder,
      $$SignalPreKeysTableUpdateCompanionBuilder,
      (
        SignalPreKey,
        BaseReferences<_$SigmaDatabase, $SignalPreKeysTable, SignalPreKey>,
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
    extends Composer<_$SigmaDatabase, $SignalSignedPreKeysTable> {
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
    extends Composer<_$SigmaDatabase, $SignalSignedPreKeysTable> {
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
    extends Composer<_$SigmaDatabase, $SignalSignedPreKeysTable> {
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
          _$SigmaDatabase,
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
              _$SigmaDatabase,
              $SignalSignedPreKeysTable,
              SignalSignedPreKey
            >,
          ),
          SignalSignedPreKey,
          PrefetchHooks Function()
        > {
  $$SignalSignedPreKeysTableTableManager(
    _$SigmaDatabase db,
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
      _$SigmaDatabase,
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
          _$SigmaDatabase,
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
    extends Composer<_$SigmaDatabase, $SignalIdentitiesTable> {
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
    extends Composer<_$SigmaDatabase, $SignalIdentitiesTable> {
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
    extends Composer<_$SigmaDatabase, $SignalIdentitiesTable> {
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
          _$SigmaDatabase,
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
              _$SigmaDatabase,
              $SignalIdentitiesTable,
              SignalIdentity
            >,
          ),
          SignalIdentity,
          PrefetchHooks Function()
        > {
  $$SignalIdentitiesTableTableManager(
    _$SigmaDatabase db,
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
      _$SigmaDatabase,
      $SignalIdentitiesTable,
      SignalIdentity,
      $$SignalIdentitiesTableFilterComposer,
      $$SignalIdentitiesTableOrderingComposer,
      $$SignalIdentitiesTableAnnotationComposer,
      $$SignalIdentitiesTableCreateCompanionBuilder,
      $$SignalIdentitiesTableUpdateCompanionBuilder,
      (
        SignalIdentity,
        BaseReferences<_$SigmaDatabase, $SignalIdentitiesTable, SignalIdentity>,
      ),
      SignalIdentity,
      PrefetchHooks Function()
    >;
typedef $$PollsTableCreateCompanionBuilder =
    PollsCompanion Function({
      required String id,
      required String question,
      Value<bool> allowMultipleVotes,
      Value<bool> hasEnded,
      required String authorId,
      required String messageId,
      Value<int> rowid,
    });
typedef $$PollsTableUpdateCompanionBuilder =
    PollsCompanion Function({
      Value<String> id,
      Value<String> question,
      Value<bool> allowMultipleVotes,
      Value<bool> hasEnded,
      Value<String> authorId,
      Value<String> messageId,
      Value<int> rowid,
    });

final class $$PollsTableReferences
    extends BaseReferences<_$SigmaDatabase, $PollsTable, PollDb> {
  $$PollsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecipientsTable _authorIdTable(_$SigmaDatabase db) => db.recipients
      .createAlias($_aliasNameGenerator(db.polls.authorId, db.recipients.id));

  $$RecipientsTableProcessedTableManager get authorId {
    final $_column = $_itemColumn<String>('author_id')!;

    final manager = $$RecipientsTableTableManager(
      $_db,
      $_db.recipients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_authorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MessagesTable _messageIdTable(_$SigmaDatabase db) => db.messages
      .createAlias($_aliasNameGenerator(db.polls.messageId, db.messages.id));

  $$MessagesTableProcessedTableManager get messageId {
    final $_column = $_itemColumn<String>('message_id')!;

    final manager = $$MessagesTableTableManager(
      $_db,
      $_db.messages,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PollOptionsTable, List<PollOptionDb>>
  _pollOptionsRefsTable(_$SigmaDatabase db) => MultiTypedResultKey.fromTable(
    db.pollOptions,
    aliasName: $_aliasNameGenerator(db.polls.id, db.pollOptions.pollId),
  );

  $$PollOptionsTableProcessedTableManager get pollOptionsRefs {
    final manager = $$PollOptionsTableTableManager(
      $_db,
      $_db.pollOptions,
    ).filter((f) => f.pollId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pollOptionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PollVotesTable, List<PollVoteDb>>
  _pollVotesRefsTable(_$SigmaDatabase db) => MultiTypedResultKey.fromTable(
    db.pollVotes,
    aliasName: $_aliasNameGenerator(db.polls.id, db.pollVotes.pollId),
  );

  $$PollVotesTableProcessedTableManager get pollVotesRefs {
    final manager = $$PollVotesTableTableManager(
      $_db,
      $_db.pollVotes,
    ).filter((f) => f.pollId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pollVotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allowMultipleVotes => $composableBuilder(
    column: $table.allowMultipleVotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasEnded => $composableBuilder(
    column: $table.hasEnded,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipientsTableFilterComposer get authorId {
    final $$RecipientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.authorId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableFilterComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MessagesTableFilterComposer get messageId {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  Expression<bool> pollOptionsRefs(
    Expression<bool> Function($$PollOptionsTableFilterComposer f) f,
  ) {
    final $$PollOptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pollOptions,
      getReferencedColumn: (t) => t.pollId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollOptionsTableFilterComposer(
            $db: $db,
            $table: $db.pollOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pollVotesRefs(
    Expression<bool> Function($$PollVotesTableFilterComposer f) f,
  ) {
    final $$PollVotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pollVotes,
      getReferencedColumn: (t) => t.pollId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollVotesTableFilterComposer(
            $db: $db,
            $table: $db.pollVotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allowMultipleVotes => $composableBuilder(
    column: $table.allowMultipleVotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasEnded => $composableBuilder(
    column: $table.hasEnded,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipientsTableOrderingComposer get authorId {
    final $$RecipientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.authorId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableOrderingComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MessagesTableOrderingComposer get messageId {
    final $$MessagesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MessagesTableOrderingComposer(
            $db: $db,
            $table: $db.messages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<bool> get allowMultipleVotes => $composableBuilder(
    column: $table.allowMultipleVotes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasEnded =>
      $composableBuilder(column: $table.hasEnded, builder: (column) => column);

  $$RecipientsTableAnnotationComposer get authorId {
    final $$RecipientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.authorId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MessagesTableAnnotationComposer get messageId {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.messageId,
      referencedTable: $db.messages,
      getReferencedColumn: (t) => t.id,
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
    return composer;
  }

  Expression<T> pollOptionsRefs<T extends Object>(
    Expression<T> Function($$PollOptionsTableAnnotationComposer a) f,
  ) {
    final $$PollOptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pollOptions,
      getReferencedColumn: (t) => t.pollId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollOptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.pollOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pollVotesRefs<T extends Object>(
    Expression<T> Function($$PollVotesTableAnnotationComposer a) f,
  ) {
    final $$PollVotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pollVotes,
      getReferencedColumn: (t) => t.pollId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollVotesTableAnnotationComposer(
            $db: $db,
            $table: $db.pollVotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PollsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $PollsTable,
          PollDb,
          $$PollsTableFilterComposer,
          $$PollsTableOrderingComposer,
          $$PollsTableAnnotationComposer,
          $$PollsTableCreateCompanionBuilder,
          $$PollsTableUpdateCompanionBuilder,
          (PollDb, $$PollsTableReferences),
          PollDb,
          PrefetchHooks Function({
            bool authorId,
            bool messageId,
            bool pollOptionsRefs,
            bool pollVotesRefs,
          })
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
                Value<String> question = const Value.absent(),
                Value<bool> allowMultipleVotes = const Value.absent(),
                Value<bool> hasEnded = const Value.absent(),
                Value<String> authorId = const Value.absent(),
                Value<String> messageId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PollsCompanion(
                id: id,
                question: question,
                allowMultipleVotes: allowMultipleVotes,
                hasEnded: hasEnded,
                authorId: authorId,
                messageId: messageId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String question,
                Value<bool> allowMultipleVotes = const Value.absent(),
                Value<bool> hasEnded = const Value.absent(),
                required String authorId,
                required String messageId,
                Value<int> rowid = const Value.absent(),
              }) => PollsCompanion.insert(
                id: id,
                question: question,
                allowMultipleVotes: allowMultipleVotes,
                hasEnded: hasEnded,
                authorId: authorId,
                messageId: messageId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PollsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                authorId = false,
                messageId = false,
                pollOptionsRefs = false,
                pollVotesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pollOptionsRefs) db.pollOptions,
                    if (pollVotesRefs) db.pollVotes,
                  ],
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
                        if (authorId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.authorId,
                                    referencedTable: $$PollsTableReferences
                                        ._authorIdTable(db),
                                    referencedColumn: $$PollsTableReferences
                                        ._authorIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (messageId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.messageId,
                                    referencedTable: $$PollsTableReferences
                                        ._messageIdTable(db),
                                    referencedColumn: $$PollsTableReferences
                                        ._messageIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pollOptionsRefs)
                        await $_getPrefetchedData<
                          PollDb,
                          $PollsTable,
                          PollOptionDb
                        >(
                          currentTable: table,
                          referencedTable: $$PollsTableReferences
                              ._pollOptionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PollsTableReferences(
                                db,
                                table,
                                p0,
                              ).pollOptionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pollId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pollVotesRefs)
                        await $_getPrefetchedData<
                          PollDb,
                          $PollsTable,
                          PollVoteDb
                        >(
                          currentTable: table,
                          referencedTable: $$PollsTableReferences
                              ._pollVotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PollsTableReferences(
                                db,
                                table,
                                p0,
                              ).pollVotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pollId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PollsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $PollsTable,
      PollDb,
      $$PollsTableFilterComposer,
      $$PollsTableOrderingComposer,
      $$PollsTableAnnotationComposer,
      $$PollsTableCreateCompanionBuilder,
      $$PollsTableUpdateCompanionBuilder,
      (PollDb, $$PollsTableReferences),
      PollDb,
      PrefetchHooks Function({
        bool authorId,
        bool messageId,
        bool pollOptionsRefs,
        bool pollVotesRefs,
      })
    >;
typedef $$PollOptionsTableCreateCompanionBuilder =
    PollOptionsCompanion Function({
      Value<int> id,
      required String pollId,
      required String optionText,
    });
typedef $$PollOptionsTableUpdateCompanionBuilder =
    PollOptionsCompanion Function({
      Value<int> id,
      Value<String> pollId,
      Value<String> optionText,
    });

final class $$PollOptionsTableReferences
    extends BaseReferences<_$SigmaDatabase, $PollOptionsTable, PollOptionDb> {
  $$PollOptionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PollsTable _pollIdTable(_$SigmaDatabase db) => db.polls.createAlias(
    $_aliasNameGenerator(db.pollOptions.pollId, db.polls.id),
  );

  $$PollsTableProcessedTableManager get pollId {
    final $_column = $_itemColumn<String>('poll_id')!;

    final manager = $$PollsTableTableManager(
      $_db,
      $_db.polls,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pollIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PollVotesTable, List<PollVoteDb>>
  _pollVotesRefsTable(_$SigmaDatabase db) => MultiTypedResultKey.fromTable(
    db.pollVotes,
    aliasName: $_aliasNameGenerator(db.pollOptions.id, db.pollVotes.optionId),
  );

  $$PollVotesTableProcessedTableManager get pollVotesRefs {
    final manager = $$PollVotesTableTableManager(
      $_db,
      $_db.pollVotes,
    ).filter((f) => f.optionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pollVotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PollOptionsTableFilterComposer
    extends Composer<_$SigmaDatabase, $PollOptionsTable> {
  $$PollOptionsTableFilterComposer({
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

  ColumnFilters<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => ColumnFilters(column),
  );

  $$PollsTableFilterComposer get pollId {
    final $$PollsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pollId,
      referencedTable: $db.polls,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollsTableFilterComposer(
            $db: $db,
            $table: $db.polls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pollVotesRefs(
    Expression<bool> Function($$PollVotesTableFilterComposer f) f,
  ) {
    final $$PollVotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pollVotes,
      getReferencedColumn: (t) => t.optionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollVotesTableFilterComposer(
            $db: $db,
            $table: $db.pollVotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => ColumnOrderings(column),
  );

  $$PollsTableOrderingComposer get pollId {
    final $$PollsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pollId,
      referencedTable: $db.polls,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollsTableOrderingComposer(
            $db: $db,
            $table: $db.polls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => column,
  );

  $$PollsTableAnnotationComposer get pollId {
    final $$PollsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pollId,
      referencedTable: $db.polls,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollsTableAnnotationComposer(
            $db: $db,
            $table: $db.polls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pollVotesRefs<T extends Object>(
    Expression<T> Function($$PollVotesTableAnnotationComposer a) f,
  ) {
    final $$PollVotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pollVotes,
      getReferencedColumn: (t) => t.optionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollVotesTableAnnotationComposer(
            $db: $db,
            $table: $db.pollVotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PollOptionsTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $PollOptionsTable,
          PollOptionDb,
          $$PollOptionsTableFilterComposer,
          $$PollOptionsTableOrderingComposer,
          $$PollOptionsTableAnnotationComposer,
          $$PollOptionsTableCreateCompanionBuilder,
          $$PollOptionsTableUpdateCompanionBuilder,
          (PollOptionDb, $$PollOptionsTableReferences),
          PollOptionDb,
          PrefetchHooks Function({bool pollId, bool pollVotesRefs})
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
                Value<int> id = const Value.absent(),
                Value<String> pollId = const Value.absent(),
                Value<String> optionText = const Value.absent(),
              }) => PollOptionsCompanion(
                id: id,
                pollId: pollId,
                optionText: optionText,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String pollId,
                required String optionText,
              }) => PollOptionsCompanion.insert(
                id: id,
                pollId: pollId,
                optionText: optionText,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PollOptionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pollId = false, pollVotesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pollVotesRefs) db.pollVotes],
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
                    if (pollId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pollId,
                                referencedTable: $$PollOptionsTableReferences
                                    ._pollIdTable(db),
                                referencedColumn: $$PollOptionsTableReferences
                                    ._pollIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pollVotesRefs)
                    await $_getPrefetchedData<
                      PollOptionDb,
                      $PollOptionsTable,
                      PollVoteDb
                    >(
                      currentTable: table,
                      referencedTable: $$PollOptionsTableReferences
                          ._pollVotesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PollOptionsTableReferences(
                            db,
                            table,
                            p0,
                          ).pollVotesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.optionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PollOptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $PollOptionsTable,
      PollOptionDb,
      $$PollOptionsTableFilterComposer,
      $$PollOptionsTableOrderingComposer,
      $$PollOptionsTableAnnotationComposer,
      $$PollOptionsTableCreateCompanionBuilder,
      $$PollOptionsTableUpdateCompanionBuilder,
      (PollOptionDb, $$PollOptionsTableReferences),
      PollOptionDb,
      PrefetchHooks Function({bool pollId, bool pollVotesRefs})
    >;
typedef $$PollVotesTableCreateCompanionBuilder =
    PollVotesCompanion Function({
      Value<int> id,
      required String pollId,
      required int optionId,
      required String voterId,
      required int timestamp,
    });
typedef $$PollVotesTableUpdateCompanionBuilder =
    PollVotesCompanion Function({
      Value<int> id,
      Value<String> pollId,
      Value<int> optionId,
      Value<String> voterId,
      Value<int> timestamp,
    });

final class $$PollVotesTableReferences
    extends BaseReferences<_$SigmaDatabase, $PollVotesTable, PollVoteDb> {
  $$PollVotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PollsTable _pollIdTable(_$SigmaDatabase db) => db.polls.createAlias(
    $_aliasNameGenerator(db.pollVotes.pollId, db.polls.id),
  );

  $$PollsTableProcessedTableManager get pollId {
    final $_column = $_itemColumn<String>('poll_id')!;

    final manager = $$PollsTableTableManager(
      $_db,
      $_db.polls,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pollIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PollOptionsTable _optionIdTable(_$SigmaDatabase db) =>
      db.pollOptions.createAlias(
        $_aliasNameGenerator(db.pollVotes.optionId, db.pollOptions.id),
      );

  $$PollOptionsTableProcessedTableManager get optionId {
    final $_column = $_itemColumn<int>('option_id')!;

    final manager = $$PollOptionsTableTableManager(
      $_db,
      $_db.pollOptions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_optionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RecipientsTable _voterIdTable(_$SigmaDatabase db) =>
      db.recipients.createAlias(
        $_aliasNameGenerator(db.pollVotes.voterId, db.recipients.id),
      );

  $$RecipientsTableProcessedTableManager get voterId {
    final $_column = $_itemColumn<String>('voter_id')!;

    final manager = $$RecipientsTableTableManager(
      $_db,
      $_db.recipients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_voterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PollVotesTableFilterComposer
    extends Composer<_$SigmaDatabase, $PollVotesTable> {
  $$PollVotesTableFilterComposer({
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

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  $$PollsTableFilterComposer get pollId {
    final $$PollsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pollId,
      referencedTable: $db.polls,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollsTableFilterComposer(
            $db: $db,
            $table: $db.polls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PollOptionsTableFilterComposer get optionId {
    final $$PollOptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.optionId,
      referencedTable: $db.pollOptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollOptionsTableFilterComposer(
            $db: $db,
            $table: $db.pollOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipientsTableFilterComposer get voterId {
    final $$RecipientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.voterId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableFilterComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  $$PollsTableOrderingComposer get pollId {
    final $$PollsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pollId,
      referencedTable: $db.polls,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollsTableOrderingComposer(
            $db: $db,
            $table: $db.polls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PollOptionsTableOrderingComposer get optionId {
    final $$PollOptionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.optionId,
      referencedTable: $db.pollOptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollOptionsTableOrderingComposer(
            $db: $db,
            $table: $db.pollOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipientsTableOrderingComposer get voterId {
    final $$RecipientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.voterId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableOrderingComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$PollsTableAnnotationComposer get pollId {
    final $$PollsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pollId,
      referencedTable: $db.polls,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollsTableAnnotationComposer(
            $db: $db,
            $table: $db.polls,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PollOptionsTableAnnotationComposer get optionId {
    final $$PollOptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.optionId,
      referencedTable: $db.pollOptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PollOptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.pollOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipientsTableAnnotationComposer get voterId {
    final $$RecipientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.voterId,
      referencedTable: $db.recipients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipientsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PollVotesTableTableManager
    extends
        RootTableManager<
          _$SigmaDatabase,
          $PollVotesTable,
          PollVoteDb,
          $$PollVotesTableFilterComposer,
          $$PollVotesTableOrderingComposer,
          $$PollVotesTableAnnotationComposer,
          $$PollVotesTableCreateCompanionBuilder,
          $$PollVotesTableUpdateCompanionBuilder,
          (PollVoteDb, $$PollVotesTableReferences),
          PollVoteDb,
          PrefetchHooks Function({bool pollId, bool optionId, bool voterId})
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
                Value<int> id = const Value.absent(),
                Value<String> pollId = const Value.absent(),
                Value<int> optionId = const Value.absent(),
                Value<String> voterId = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
              }) => PollVotesCompanion(
                id: id,
                pollId: pollId,
                optionId: optionId,
                voterId: voterId,
                timestamp: timestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String pollId,
                required int optionId,
                required String voterId,
                required int timestamp,
              }) => PollVotesCompanion.insert(
                id: id,
                pollId: pollId,
                optionId: optionId,
                voterId: voterId,
                timestamp: timestamp,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PollVotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({pollId = false, optionId = false, voterId = false}) {
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
                        if (pollId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.pollId,
                                    referencedTable: $$PollVotesTableReferences
                                        ._pollIdTable(db),
                                    referencedColumn: $$PollVotesTableReferences
                                        ._pollIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (optionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.optionId,
                                    referencedTable: $$PollVotesTableReferences
                                        ._optionIdTable(db),
                                    referencedColumn: $$PollVotesTableReferences
                                        ._optionIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (voterId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.voterId,
                                    referencedTable: $$PollVotesTableReferences
                                        ._voterIdTable(db),
                                    referencedColumn: $$PollVotesTableReferences
                                        ._voterIdTable(db)
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

typedef $$PollVotesTableProcessedTableManager =
    ProcessedTableManager<
      _$SigmaDatabase,
      $PollVotesTable,
      PollVoteDb,
      $$PollVotesTableFilterComposer,
      $$PollVotesTableOrderingComposer,
      $$PollVotesTableAnnotationComposer,
      $$PollVotesTableCreateCompanionBuilder,
      $$PollVotesTableUpdateCompanionBuilder,
      (PollVoteDb, $$PollVotesTableReferences),
      PollVoteDb,
      PrefetchHooks Function({bool pollId, bool optionId, bool voterId})
    >;

class $SigmaDatabaseManager {
  final _$SigmaDatabase _db;
  $SigmaDatabaseManager(this._db);
  $$RecipientsTableTableManager get recipients =>
      $$RecipientsTableTableManager(_db, _db.recipients);
  $$ThreadsTableTableManager get threads =>
      $$ThreadsTableTableManager(_db, _db.threads);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$MessageSearchTableTableManager get messageSearch =>
      $$MessageSearchTableTableManager(_db, _db.messageSearch);
  $$JobsTableTableManager get jobs => $$JobsTableTableManager(_db, _db.jobs);
  $$KeyValuesTableTableManager get keyValues =>
      $$KeyValuesTableTableManager(_db, _db.keyValues);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db, _db.attachments);
  $$ReactionsTableTableManager get reactions =>
      $$ReactionsTableTableManager(_db, _db.reactions);
  $$MessageReceiptsTableTableManager get messageReceipts =>
      $$MessageReceiptsTableTableManager(_db, _db.messageReceipts);
  $$SignalSessionsTableTableManager get signalSessions =>
      $$SignalSessionsTableTableManager(_db, _db.signalSessions);
  $$SignalPreKeysTableTableManager get signalPreKeys =>
      $$SignalPreKeysTableTableManager(_db, _db.signalPreKeys);
  $$SignalSignedPreKeysTableTableManager get signalSignedPreKeys =>
      $$SignalSignedPreKeysTableTableManager(_db, _db.signalSignedPreKeys);
  $$SignalIdentitiesTableTableManager get signalIdentities =>
      $$SignalIdentitiesTableTableManager(_db, _db.signalIdentities);
  $$PollsTableTableManager get polls =>
      $$PollsTableTableManager(_db, _db.polls);
  $$PollOptionsTableTableManager get pollOptions =>
      $$PollOptionsTableTableManager(_db, _db.pollOptions);
  $$PollVotesTableTableManager get pollVotes =>
      $$PollVotesTableTableManager(_db, _db.pollVotes);
}
