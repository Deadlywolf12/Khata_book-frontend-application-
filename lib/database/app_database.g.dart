// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarIndexMeta = const VerificationMeta(
    'avatarIndex',
  );
  @override
  late final GeneratedColumn<int> avatarIndex = GeneratedColumn<int>(
    'avatar_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyNameMeta = const VerificationMeta(
    'currencyName',
  );
  @override
  late final GeneratedColumn<String> currencyName = GeneratedColumn<String>(
    'currency_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accTypeMeta = const VerificationMeta(
    'accType',
  );
  @override
  late final GeneratedColumn<String> accType = GeneratedColumn<String>(
    'acc_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinEnabledMeta = const VerificationMeta(
    'pinEnabled',
  );
  @override
  late final GeneratedColumn<bool> pinEnabled = GeneratedColumn<bool>(
    'pin_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pin_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uid,
    username,
    avatarIndex,
    currencyCode,
    currencyName,
    accType,
    pinEnabled,
    isSynced,
    isDeleted,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('avatar_index')) {
      context.handle(
        _avatarIndexMeta,
        avatarIndex.isAcceptableOrUnknown(
          data['avatar_index']!,
          _avatarIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_avatarIndexMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('currency_name')) {
      context.handle(
        _currencyNameMeta,
        currencyName.isAcceptableOrUnknown(
          data['currency_name']!,
          _currencyNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyNameMeta);
    }
    if (data.containsKey('acc_type')) {
      context.handle(
        _accTypeMeta,
        accType.isAcceptableOrUnknown(data['acc_type']!, _accTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_accTypeMeta);
    }
    if (data.containsKey('pin_enabled')) {
      context.handle(
        _pinEnabledMeta,
        pinEnabled.isAcceptableOrUnknown(data['pin_enabled']!, _pinEnabledMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
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
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      avatarIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}avatar_index'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      currencyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_name'],
      )!,
      accType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}acc_type'],
      )!,
      pinEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pin_enabled'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final String uid;
  final String username;
  final int avatarIndex;
  final String currencyCode;
  final String currencyName;
  final String accType;
  final bool pinEnabled;
  final bool isSynced;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserProfile({
    required this.id,
    required this.uid,
    required this.username,
    required this.avatarIndex,
    required this.currencyCode,
    required this.currencyName,
    required this.accType,
    required this.pinEnabled,
    required this.isSynced,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uid'] = Variable<String>(uid);
    map['username'] = Variable<String>(username);
    map['avatar_index'] = Variable<int>(avatarIndex);
    map['currency_code'] = Variable<String>(currencyCode);
    map['currency_name'] = Variable<String>(currencyName);
    map['acc_type'] = Variable<String>(accType);
    map['pin_enabled'] = Variable<bool>(pinEnabled);
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      uid: Value(uid),
      username: Value(username),
      avatarIndex: Value(avatarIndex),
      currencyCode: Value(currencyCode),
      currencyName: Value(currencyName),
      accType: Value(accType),
      pinEnabled: Value(pinEnabled),
      isSynced: Value(isSynced),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      username: serializer.fromJson<String>(json['username']),
      avatarIndex: serializer.fromJson<int>(json['avatarIndex']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      currencyName: serializer.fromJson<String>(json['currencyName']),
      accType: serializer.fromJson<String>(json['accType']),
      pinEnabled: serializer.fromJson<bool>(json['pinEnabled']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uid': serializer.toJson<String>(uid),
      'username': serializer.toJson<String>(username),
      'avatarIndex': serializer.toJson<int>(avatarIndex),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'currencyName': serializer.toJson<String>(currencyName),
      'accType': serializer.toJson<String>(accType),
      'pinEnabled': serializer.toJson<bool>(pinEnabled),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfile copyWith({
    int? id,
    String? uid,
    String? username,
    int? avatarIndex,
    String? currencyCode,
    String? currencyName,
    String? accType,
    bool? pinEnabled,
    bool? isSynced,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserProfile(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    username: username ?? this.username,
    avatarIndex: avatarIndex ?? this.avatarIndex,
    currencyCode: currencyCode ?? this.currencyCode,
    currencyName: currencyName ?? this.currencyName,
    accType: accType ?? this.accType,
    pinEnabled: pinEnabled ?? this.pinEnabled,
    isSynced: isSynced ?? this.isSynced,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      username: data.username.present ? data.username.value : this.username,
      avatarIndex: data.avatarIndex.present
          ? data.avatarIndex.value
          : this.avatarIndex,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      currencyName: data.currencyName.present
          ? data.currencyName.value
          : this.currencyName,
      accType: data.accType.present ? data.accType.value : this.accType,
      pinEnabled: data.pinEnabled.present
          ? data.pinEnabled.value
          : this.pinEnabled,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('username: $username, ')
          ..write('avatarIndex: $avatarIndex, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencyName: $currencyName, ')
          ..write('accType: $accType, ')
          ..write('pinEnabled: $pinEnabled, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uid,
    username,
    avatarIndex,
    currencyCode,
    currencyName,
    accType,
    pinEnabled,
    isSynced,
    isDeleted,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.username == this.username &&
          other.avatarIndex == this.avatarIndex &&
          other.currencyCode == this.currencyCode &&
          other.currencyName == this.currencyName &&
          other.accType == this.accType &&
          other.pinEnabled == this.pinEnabled &&
          other.isSynced == this.isSynced &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<String> uid;
  final Value<String> username;
  final Value<int> avatarIndex;
  final Value<String> currencyCode;
  final Value<String> currencyName;
  final Value<String> accType;
  final Value<bool> pinEnabled;
  final Value<bool> isSynced;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.username = const Value.absent(),
    this.avatarIndex = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.currencyName = const Value.absent(),
    this.accType = const Value.absent(),
    this.pinEnabled = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String uid,
    required String username,
    required int avatarIndex,
    required String currencyCode,
    required String currencyName,
    required String accType,
    this.pinEnabled = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : uid = Value(uid),
       username = Value(username),
       avatarIndex = Value(avatarIndex),
       currencyCode = Value(currencyCode),
       currencyName = Value(currencyName),
       accType = Value(accType);
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<String>? uid,
    Expression<String>? username,
    Expression<int>? avatarIndex,
    Expression<String>? currencyCode,
    Expression<String>? currencyName,
    Expression<String>? accType,
    Expression<bool>? pinEnabled,
    Expression<bool>? isSynced,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (username != null) 'username': username,
      if (avatarIndex != null) 'avatar_index': avatarIndex,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (currencyName != null) 'currency_name': currencyName,
      if (accType != null) 'acc_type': accType,
      if (pinEnabled != null) 'pin_enabled': pinEnabled,
      if (isSynced != null) 'is_synced': isSynced,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? uid,
    Value<String>? username,
    Value<int>? avatarIndex,
    Value<String>? currencyCode,
    Value<String>? currencyName,
    Value<String>? accType,
    Value<bool>? pinEnabled,
    Value<bool>? isSynced,
    Value<bool>? isDeleted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      avatarIndex: avatarIndex ?? this.avatarIndex,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyName: currencyName ?? this.currencyName,
      accType: accType ?? this.accType,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (avatarIndex.present) {
      map['avatar_index'] = Variable<int>(avatarIndex.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (currencyName.present) {
      map['currency_name'] = Variable<String>(currencyName.value);
    }
    if (accType.present) {
      map['acc_type'] = Variable<String>(accType.value);
    }
    if (pinEnabled.present) {
      map['pin_enabled'] = Variable<bool>(pinEnabled.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('username: $username, ')
          ..write('avatarIndex: $avatarIndex, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencyName: $currencyName, ')
          ..write('accType: $accType, ')
          ..write('pinEnabled: $pinEnabled, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userProfiles];
}

typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      required String uid,
      required String username,
      required int avatarIndex,
      required String currencyCode,
      required String currencyName,
      required String accType,
      Value<bool> pinEnabled,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String> uid,
      Value<String> username,
      Value<int> avatarIndex,
      Value<String> currencyCode,
      Value<String> currencyName,
      Value<String> accType,
      Value<bool> pinEnabled,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
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

  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get avatarIndex => $composableBuilder(
    column: $table.avatarIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyName => $composableBuilder(
    column: $table.currencyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accType => $composableBuilder(
    column: $table.accType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pinEnabled => $composableBuilder(
    column: $table.pinEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
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

  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get avatarIndex => $composableBuilder(
    column: $table.avatarIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyName => $composableBuilder(
    column: $table.currencyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accType => $composableBuilder(
    column: $table.accType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pinEnabled => $composableBuilder(
    column: $table.pinEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<int> get avatarIndex => $composableBuilder(
    column: $table.avatarIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyName => $composableBuilder(
    column: $table.currencyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accType =>
      $composableBuilder(column: $table.accType, builder: (column) => column);

  GeneratedColumn<bool> get pinEnabled => $composableBuilder(
    column: $table.pinEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uid = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<int> avatarIndex = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> currencyName = const Value.absent(),
                Value<String> accType = const Value.absent(),
                Value<bool> pinEnabled = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                uid: uid,
                username: username,
                avatarIndex: avatarIndex,
                currencyCode: currencyCode,
                currencyName: currencyName,
                accType: accType,
                pinEnabled: pinEnabled,
                isSynced: isSynced,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uid,
                required String username,
                required int avatarIndex,
                required String currencyCode,
                required String currencyName,
                required String accType,
                Value<bool> pinEnabled = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                uid: uid,
                username: username,
                avatarIndex: avatarIndex,
                currencyCode: currencyCode,
                currencyName: currencyName,
                accType: accType,
                pinEnabled: pinEnabled,
                isSynced: isSynced,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
}
