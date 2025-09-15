// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordHintMeta = const VerificationMeta(
    'passwordHint',
  );
  @override
  late final GeneratedColumn<String> passwordHint = GeneratedColumn<String>(
    'password_hint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    clientDefault: () => DateTime.now(),
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
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    password,
    passwordHint,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('password_hint')) {
      context.handle(
        _passwordHintMeta,
        passwordHint.isAcceptableOrUnknown(
          data['password_hint']!,
          _passwordHintMeta,
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
  UserTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      passwordHint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hint'],
      ),
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
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

class UserTableData extends DataClass implements Insertable<UserTableData> {
  final int id;
  final String password;
  final String? passwordHint;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserTableData({
    required this.id,
    required this.password,
    this.passwordHint,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || passwordHint != null) {
      map['password_hint'] = Variable<String>(passwordHint);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      password: Value(password),
      passwordHint: passwordHint == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordHint),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTableData(
      id: serializer.fromJson<int>(json['id']),
      password: serializer.fromJson<String>(json['password']),
      passwordHint: serializer.fromJson<String?>(json['passwordHint']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'password': serializer.toJson<String>(password),
      'passwordHint': serializer.toJson<String?>(passwordHint),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserTableData copyWith({
    int? id,
    String? password,
    Value<String?> passwordHint = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserTableData(
    id: id ?? this.id,
    password: password ?? this.password,
    passwordHint: passwordHint.present ? passwordHint.value : this.passwordHint,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserTableData copyWithCompanion(UserTableCompanion data) {
    return UserTableData(
      id: data.id.present ? data.id.value : this.id,
      password: data.password.present ? data.password.value : this.password,
      passwordHint: data.passwordHint.present
          ? data.passwordHint.value
          : this.passwordHint,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('id: $id, ')
          ..write('password: $password, ')
          ..write('passwordHint: $passwordHint, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, password, passwordHint, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.id == this.id &&
          other.password == this.password &&
          other.passwordHint == this.passwordHint &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<int> id;
  final Value<String> password;
  final Value<String?> passwordHint;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.password = const Value.absent(),
    this.passwordHint = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    required String password,
    this.passwordHint = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : password = Value(password);
  static Insertable<UserTableData> custom({
    Expression<int>? id,
    Expression<String>? password,
    Expression<String>? passwordHint,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (password != null) 'password': password,
      if (passwordHint != null) 'password_hint': passwordHint,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserTableCompanion copyWith({
    Value<int>? id,
    Value<String>? password,
    Value<String?>? passwordHint,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserTableCompanion(
      id: id ?? this.id,
      password: password ?? this.password,
      passwordHint: passwordHint ?? this.passwordHint,
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
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (passwordHint.present) {
      map['password_hint'] = Variable<String>(passwordHint.value);
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
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('password: $password, ')
          ..write('passwordHint: $passwordHint, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CollectionTableTable extends CollectionTable
    with TableInfo<$CollectionTableTable, CollectionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconPathMeta = const VerificationMeta(
    'iconPath',
  );
  @override
  late final GeneratedColumn<String> iconPath = GeneratedColumn<String>(
    'icon_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    clientDefault: () => DateTime.now(),
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
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    iconPath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collection_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('icon_path')) {
      context.handle(
        _iconPathMeta,
        iconPath.isAcceptableOrUnknown(data['icon_path']!, _iconPathMeta),
      );
    } else if (isInserting) {
      context.missing(_iconPathMeta);
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
  CollectionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      iconPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_path'],
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
  $CollectionTableTable createAlias(String alias) {
    return $CollectionTableTable(attachedDatabase, alias);
  }
}

class CollectionTableData extends DataClass
    implements Insertable<CollectionTableData> {
  final int id;
  final String? name;
  final String iconPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CollectionTableData({
    required this.id,
    this.name,
    required this.iconPath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['icon_path'] = Variable<String>(iconPath);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CollectionTableCompanion toCompanion(bool nullToAbsent) {
    return CollectionTableCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      iconPath: Value(iconPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CollectionTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      iconPath: serializer.fromJson<String>(json['iconPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'iconPath': serializer.toJson<String>(iconPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CollectionTableData copyWith({
    int? id,
    Value<String?> name = const Value.absent(),
    String? iconPath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CollectionTableData(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    iconPath: iconPath ?? this.iconPath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CollectionTableData copyWithCompanion(CollectionTableCompanion data) {
    return CollectionTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconPath: data.iconPath.present ? data.iconPath.value : this.iconPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconPath: $iconPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, iconPath, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconPath == this.iconPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CollectionTableCompanion extends UpdateCompanion<CollectionTableData> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String> iconPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CollectionTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CollectionTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required String iconPath,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : iconPath = Value(iconPath);
  static Insertable<CollectionTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? iconPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconPath != null) 'icon_path': iconPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CollectionTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? name,
    Value<String>? iconPath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CollectionTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconPath.present) {
      map['icon_path'] = Variable<String>(iconPath.value);
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
    return (StringBuffer('CollectionTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconPath: $iconPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PasswordTableTable extends PasswordTable
    with TableInfo<$PasswordTableTable, PasswordTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PasswordTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconPathMeta = const VerificationMeta(
    'iconPath',
  );
  @override
  late final GeneratedColumn<String> iconPath = GeneratedColumn<String>(
    'icon_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _has2faMeta = const VerificationMeta('has2fa');
  @override
  late final GeneratedColumn<bool> has2fa = GeneratedColumn<bool>(
    'has2fa',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has2fa" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  static const VerificationMeta _authKeyMeta = const VerificationMeta(
    'authKey',
  );
  @override
  late final GeneratedColumn<String> authKey = GeneratedColumn<String>(
    'auth_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasArchivedMeta = const VerificationMeta(
    'hasArchived',
  );
  @override
  late final GeneratedColumn<bool> hasArchived = GeneratedColumn<bool>(
    'has_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_archived" IN (0, 1))',
    ),
    clientDefault: () => false,
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
    clientDefault: () => DateTime.now(),
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
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    iconPath,
    has2fa,
    authKey,
    hasArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'password_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PasswordTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('icon_path')) {
      context.handle(
        _iconPathMeta,
        iconPath.isAcceptableOrUnknown(data['icon_path']!, _iconPathMeta),
      );
    } else if (isInserting) {
      context.missing(_iconPathMeta);
    }
    if (data.containsKey('has2fa')) {
      context.handle(
        _has2faMeta,
        has2fa.isAcceptableOrUnknown(data['has2fa']!, _has2faMeta),
      );
    }
    if (data.containsKey('auth_key')) {
      context.handle(
        _authKeyMeta,
        authKey.isAcceptableOrUnknown(data['auth_key']!, _authKeyMeta),
      );
    }
    if (data.containsKey('has_archived')) {
      context.handle(
        _hasArchivedMeta,
        hasArchived.isAcceptableOrUnknown(
          data['has_archived']!,
          _hasArchivedMeta,
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
  PasswordTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PasswordTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      iconPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_path'],
      )!,
      has2fa: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has2fa'],
      )!,
      authKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auth_key'],
      ),
      hasArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_archived'],
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
  $PasswordTableTable createAlias(String alias) {
    return $PasswordTableTable(attachedDatabase, alias);
  }
}

class PasswordTableData extends DataClass
    implements Insertable<PasswordTableData> {
  final int id;
  final String title;
  final String iconPath;
  final bool has2fa;
  final String? authKey;
  final bool hasArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PasswordTableData({
    required this.id,
    required this.title,
    required this.iconPath,
    required this.has2fa,
    this.authKey,
    required this.hasArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['icon_path'] = Variable<String>(iconPath);
    map['has2fa'] = Variable<bool>(has2fa);
    if (!nullToAbsent || authKey != null) {
      map['auth_key'] = Variable<String>(authKey);
    }
    map['has_archived'] = Variable<bool>(hasArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PasswordTableCompanion toCompanion(bool nullToAbsent) {
    return PasswordTableCompanion(
      id: Value(id),
      title: Value(title),
      iconPath: Value(iconPath),
      has2fa: Value(has2fa),
      authKey: authKey == null && nullToAbsent
          ? const Value.absent()
          : Value(authKey),
      hasArchived: Value(hasArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PasswordTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PasswordTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      iconPath: serializer.fromJson<String>(json['iconPath']),
      has2fa: serializer.fromJson<bool>(json['has2fa']),
      authKey: serializer.fromJson<String?>(json['authKey']),
      hasArchived: serializer.fromJson<bool>(json['hasArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'iconPath': serializer.toJson<String>(iconPath),
      'has2fa': serializer.toJson<bool>(has2fa),
      'authKey': serializer.toJson<String?>(authKey),
      'hasArchived': serializer.toJson<bool>(hasArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PasswordTableData copyWith({
    int? id,
    String? title,
    String? iconPath,
    bool? has2fa,
    Value<String?> authKey = const Value.absent(),
    bool? hasArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PasswordTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    iconPath: iconPath ?? this.iconPath,
    has2fa: has2fa ?? this.has2fa,
    authKey: authKey.present ? authKey.value : this.authKey,
    hasArchived: hasArchived ?? this.hasArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PasswordTableData copyWithCompanion(PasswordTableCompanion data) {
    return PasswordTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      iconPath: data.iconPath.present ? data.iconPath.value : this.iconPath,
      has2fa: data.has2fa.present ? data.has2fa.value : this.has2fa,
      authKey: data.authKey.present ? data.authKey.value : this.authKey,
      hasArchived: data.hasArchived.present
          ? data.hasArchived.value
          : this.hasArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PasswordTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('iconPath: $iconPath, ')
          ..write('has2fa: $has2fa, ')
          ..write('authKey: $authKey, ')
          ..write('hasArchived: $hasArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    iconPath,
    has2fa,
    authKey,
    hasArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PasswordTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.iconPath == this.iconPath &&
          other.has2fa == this.has2fa &&
          other.authKey == this.authKey &&
          other.hasArchived == this.hasArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PasswordTableCompanion extends UpdateCompanion<PasswordTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> iconPath;
  final Value<bool> has2fa;
  final Value<String?> authKey;
  final Value<bool> hasArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PasswordTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.iconPath = const Value.absent(),
    this.has2fa = const Value.absent(),
    this.authKey = const Value.absent(),
    this.hasArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PasswordTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String iconPath,
    this.has2fa = const Value.absent(),
    this.authKey = const Value.absent(),
    this.hasArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title),
       iconPath = Value(iconPath);
  static Insertable<PasswordTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? iconPath,
    Expression<bool>? has2fa,
    Expression<String>? authKey,
    Expression<bool>? hasArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (iconPath != null) 'icon_path': iconPath,
      if (has2fa != null) 'has2fa': has2fa,
      if (authKey != null) 'auth_key': authKey,
      if (hasArchived != null) 'has_archived': hasArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PasswordTableCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? iconPath,
    Value<bool>? has2fa,
    Value<String?>? authKey,
    Value<bool>? hasArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PasswordTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      iconPath: iconPath ?? this.iconPath,
      has2fa: has2fa ?? this.has2fa,
      authKey: authKey ?? this.authKey,
      hasArchived: hasArchived ?? this.hasArchived,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (iconPath.present) {
      map['icon_path'] = Variable<String>(iconPath.value);
    }
    if (has2fa.present) {
      map['has2fa'] = Variable<bool>(has2fa.value);
    }
    if (authKey.present) {
      map['auth_key'] = Variable<String>(authKey.value);
    }
    if (hasArchived.present) {
      map['has_archived'] = Variable<bool>(hasArchived.value);
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
    return (StringBuffer('PasswordTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('iconPath: $iconPath, ')
          ..write('has2fa: $has2fa, ')
          ..write('authKey: $authKey, ')
          ..write('hasArchived: $hasArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CollectionItemTableTable extends CollectionItemTable
    with TableInfo<$CollectionItemTableTable, CollectionItemTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionItemTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES collection_table (id)',
    ),
  );
  static const VerificationMeta _passwordIdMeta = const VerificationMeta(
    'passwordId',
  );
  @override
  late final GeneratedColumn<int> passwordId = GeneratedColumn<int>(
    'password_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES password_table (id)',
    ),
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
    clientDefault: () => DateTime.now(),
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
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    passwordId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collection_item_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionItemTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('password_id')) {
      context.handle(
        _passwordIdMeta,
        passwordId.isAcceptableOrUnknown(data['password_id']!, _passwordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordIdMeta);
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
  CollectionItemTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionItemTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}collection_id'],
      )!,
      passwordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}password_id'],
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
  $CollectionItemTableTable createAlias(String alias) {
    return $CollectionItemTableTable(attachedDatabase, alias);
  }
}

class CollectionItemTableData extends DataClass
    implements Insertable<CollectionItemTableData> {
  final int id;
  final int collectionId;
  final int passwordId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CollectionItemTableData({
    required this.id,
    required this.collectionId,
    required this.passwordId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_id'] = Variable<int>(collectionId);
    map['password_id'] = Variable<int>(passwordId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CollectionItemTableCompanion toCompanion(bool nullToAbsent) {
    return CollectionItemTableCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      passwordId: Value(passwordId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CollectionItemTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionItemTableData(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<int>(json['collectionId']),
      passwordId: serializer.fromJson<int>(json['passwordId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int>(collectionId),
      'passwordId': serializer.toJson<int>(passwordId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CollectionItemTableData copyWith({
    int? id,
    int? collectionId,
    int? passwordId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CollectionItemTableData(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    passwordId: passwordId ?? this.passwordId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CollectionItemTableData copyWithCompanion(CollectionItemTableCompanion data) {
    return CollectionItemTableData(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      passwordId: data.passwordId.present
          ? data.passwordId.value
          : this.passwordId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionItemTableData(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('passwordId: $passwordId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, collectionId, passwordId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionItemTableData &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.passwordId == this.passwordId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CollectionItemTableCompanion
    extends UpdateCompanion<CollectionItemTableData> {
  final Value<int> id;
  final Value<int> collectionId;
  final Value<int> passwordId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CollectionItemTableCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.passwordId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CollectionItemTableCompanion.insert({
    this.id = const Value.absent(),
    required int collectionId,
    required int passwordId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : collectionId = Value(collectionId),
       passwordId = Value(passwordId);
  static Insertable<CollectionItemTableData> custom({
    Expression<int>? id,
    Expression<int>? collectionId,
    Expression<int>? passwordId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (passwordId != null) 'password_id': passwordId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CollectionItemTableCompanion copyWith({
    Value<int>? id,
    Value<int>? collectionId,
    Value<int>? passwordId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CollectionItemTableCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      passwordId: passwordId ?? this.passwordId,
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
    if (collectionId.present) {
      map['collection_id'] = Variable<int>(collectionId.value);
    }
    if (passwordId.present) {
      map['password_id'] = Variable<int>(passwordId.value);
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
    return (StringBuffer('CollectionItemTableCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('passwordId: $passwordId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PasswordFieldTableTable extends PasswordFieldTable
    with TableInfo<$PasswordFieldTableTable, PasswordFieldTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PasswordFieldTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _passwordIdMeta = const VerificationMeta(
    'passwordId',
  );
  @override
  late final GeneratedColumn<int> passwordId = GeneratedColumn<int>(
    'password_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES password_table (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    clientDefault: () => DateTime.now(),
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
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    passwordId,
    type,
    order,
    value,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'password_field_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PasswordFieldTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('password_id')) {
      context.handle(
        _passwordIdMeta,
        passwordId.isAcceptableOrUnknown(data['password_id']!, _passwordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
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
  PasswordFieldTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PasswordFieldTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      passwordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}password_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
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
  $PasswordFieldTableTable createAlias(String alias) {
    return $PasswordFieldTableTable(attachedDatabase, alias);
  }
}

class PasswordFieldTableData extends DataClass
    implements Insertable<PasswordFieldTableData> {
  final int id;
  final int passwordId;
  final int type;
  final int order;
  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PasswordFieldTableData({
    required this.id,
    required this.passwordId,
    required this.type,
    required this.order,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['password_id'] = Variable<int>(passwordId);
    map['type'] = Variable<int>(type);
    map['order'] = Variable<int>(order);
    map['value'] = Variable<String>(value);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PasswordFieldTableCompanion toCompanion(bool nullToAbsent) {
    return PasswordFieldTableCompanion(
      id: Value(id),
      passwordId: Value(passwordId),
      type: Value(type),
      order: Value(order),
      value: Value(value),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PasswordFieldTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PasswordFieldTableData(
      id: serializer.fromJson<int>(json['id']),
      passwordId: serializer.fromJson<int>(json['passwordId']),
      type: serializer.fromJson<int>(json['type']),
      order: serializer.fromJson<int>(json['order']),
      value: serializer.fromJson<String>(json['value']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'passwordId': serializer.toJson<int>(passwordId),
      'type': serializer.toJson<int>(type),
      'order': serializer.toJson<int>(order),
      'value': serializer.toJson<String>(value),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PasswordFieldTableData copyWith({
    int? id,
    int? passwordId,
    int? type,
    int? order,
    String? value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PasswordFieldTableData(
    id: id ?? this.id,
    passwordId: passwordId ?? this.passwordId,
    type: type ?? this.type,
    order: order ?? this.order,
    value: value ?? this.value,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PasswordFieldTableData copyWithCompanion(PasswordFieldTableCompanion data) {
    return PasswordFieldTableData(
      id: data.id.present ? data.id.value : this.id,
      passwordId: data.passwordId.present
          ? data.passwordId.value
          : this.passwordId,
      type: data.type.present ? data.type.value : this.type,
      order: data.order.present ? data.order.value : this.order,
      value: data.value.present ? data.value.value : this.value,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PasswordFieldTableData(')
          ..write('id: $id, ')
          ..write('passwordId: $passwordId, ')
          ..write('type: $type, ')
          ..write('order: $order, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, passwordId, type, order, value, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PasswordFieldTableData &&
          other.id == this.id &&
          other.passwordId == this.passwordId &&
          other.type == this.type &&
          other.order == this.order &&
          other.value == this.value &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PasswordFieldTableCompanion
    extends UpdateCompanion<PasswordFieldTableData> {
  final Value<int> id;
  final Value<int> passwordId;
  final Value<int> type;
  final Value<int> order;
  final Value<String> value;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PasswordFieldTableCompanion({
    this.id = const Value.absent(),
    this.passwordId = const Value.absent(),
    this.type = const Value.absent(),
    this.order = const Value.absent(),
    this.value = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PasswordFieldTableCompanion.insert({
    this.id = const Value.absent(),
    required int passwordId,
    required int type,
    this.order = const Value.absent(),
    required String value,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : passwordId = Value(passwordId),
       type = Value(type),
       value = Value(value);
  static Insertable<PasswordFieldTableData> custom({
    Expression<int>? id,
    Expression<int>? passwordId,
    Expression<int>? type,
    Expression<int>? order,
    Expression<String>? value,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (passwordId != null) 'password_id': passwordId,
      if (type != null) 'type': type,
      if (order != null) 'order': order,
      if (value != null) 'value': value,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PasswordFieldTableCompanion copyWith({
    Value<int>? id,
    Value<int>? passwordId,
    Value<int>? type,
    Value<int>? order,
    Value<String>? value,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PasswordFieldTableCompanion(
      id: id ?? this.id,
      passwordId: passwordId ?? this.passwordId,
      type: type ?? this.type,
      order: order ?? this.order,
      value: value ?? this.value,
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
    if (passwordId.present) {
      map['password_id'] = Variable<int>(passwordId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
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
    return (StringBuffer('PasswordFieldTableCompanion(')
          ..write('id: $id, ')
          ..write('passwordId: $passwordId, ')
          ..write('type: $type, ')
          ..write('order: $order, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CardTableTable extends CardTable
    with TableInfo<$CardTableTable, CardTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _holderNameMeta = const VerificationMeta(
    'holderName',
  );
  @override
  late final GeneratedColumn<String> holderName = GeneratedColumn<String>(
    'holder_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expireDateMeta = const VerificationMeta(
    'expireDate',
  );
  @override
  late final GeneratedColumn<DateTime> expireDate = GeneratedColumn<DateTime>(
    'expire_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cvvMeta = const VerificationMeta('cvv');
  @override
  late final GeneratedColumn<String> cvv = GeneratedColumn<String>(
    'cvv',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasPinMeta = const VerificationMeta('hasPin');
  @override
  late final GeneratedColumn<bool> hasPin = GeneratedColumn<bool>(
    'has_pin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_pin" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  static const VerificationMeta _pinMeta = const VerificationMeta('pin');
  @override
  late final GeneratedColumn<String> pin = GeneratedColumn<String>(
    'pin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasArchivedMeta = const VerificationMeta(
    'hasArchived',
  );
  @override
  late final GeneratedColumn<bool> hasArchived = GeneratedColumn<bool>(
    'has_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_archived" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  static const VerificationMeta _styleIndexMeta = const VerificationMeta(
    'styleIndex',
  );
  @override
  late final GeneratedColumn<int> styleIndex = GeneratedColumn<int>(
    'style_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
    clientDefault: () => DateTime.now(),
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
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    holderName,
    number,
    expireDate,
    cvv,
    hasPin,
    pin,
    hasArchived,
    styleIndex,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('holder_name')) {
      context.handle(
        _holderNameMeta,
        holderName.isAcceptableOrUnknown(data['holder_name']!, _holderNameMeta),
      );
    } else if (isInserting) {
      context.missing(_holderNameMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('expire_date')) {
      context.handle(
        _expireDateMeta,
        expireDate.isAcceptableOrUnknown(data['expire_date']!, _expireDateMeta),
      );
    } else if (isInserting) {
      context.missing(_expireDateMeta);
    }
    if (data.containsKey('cvv')) {
      context.handle(
        _cvvMeta,
        cvv.isAcceptableOrUnknown(data['cvv']!, _cvvMeta),
      );
    } else if (isInserting) {
      context.missing(_cvvMeta);
    }
    if (data.containsKey('has_pin')) {
      context.handle(
        _hasPinMeta,
        hasPin.isAcceptableOrUnknown(data['has_pin']!, _hasPinMeta),
      );
    }
    if (data.containsKey('pin')) {
      context.handle(
        _pinMeta,
        pin.isAcceptableOrUnknown(data['pin']!, _pinMeta),
      );
    }
    if (data.containsKey('has_archived')) {
      context.handle(
        _hasArchivedMeta,
        hasArchived.isAcceptableOrUnknown(
          data['has_archived']!,
          _hasArchivedMeta,
        ),
      );
    }
    if (data.containsKey('style_index')) {
      context.handle(
        _styleIndexMeta,
        styleIndex.isAcceptableOrUnknown(data['style_index']!, _styleIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_styleIndexMeta);
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
  CardTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      holderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}holder_name'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      )!,
      expireDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expire_date'],
      )!,
      cvv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cvv'],
      )!,
      hasPin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_pin'],
      )!,
      pin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin'],
      ),
      hasArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_archived'],
      )!,
      styleIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}style_index'],
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
  $CardTableTable createAlias(String alias) {
    return $CardTableTable(attachedDatabase, alias);
  }
}

class CardTableData extends DataClass implements Insertable<CardTableData> {
  final int id;
  final String title;
  final String holderName;
  final String number;
  final DateTime expireDate;
  final String cvv;
  final bool hasPin;
  final String? pin;
  final bool hasArchived;
  final int styleIndex;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CardTableData({
    required this.id,
    required this.title,
    required this.holderName,
    required this.number,
    required this.expireDate,
    required this.cvv,
    required this.hasPin,
    this.pin,
    required this.hasArchived,
    required this.styleIndex,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['holder_name'] = Variable<String>(holderName);
    map['number'] = Variable<String>(number);
    map['expire_date'] = Variable<DateTime>(expireDate);
    map['cvv'] = Variable<String>(cvv);
    map['has_pin'] = Variable<bool>(hasPin);
    if (!nullToAbsent || pin != null) {
      map['pin'] = Variable<String>(pin);
    }
    map['has_archived'] = Variable<bool>(hasArchived);
    map['style_index'] = Variable<int>(styleIndex);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CardTableCompanion toCompanion(bool nullToAbsent) {
    return CardTableCompanion(
      id: Value(id),
      title: Value(title),
      holderName: Value(holderName),
      number: Value(number),
      expireDate: Value(expireDate),
      cvv: Value(cvv),
      hasPin: Value(hasPin),
      pin: pin == null && nullToAbsent ? const Value.absent() : Value(pin),
      hasArchived: Value(hasArchived),
      styleIndex: Value(styleIndex),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CardTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      holderName: serializer.fromJson<String>(json['holderName']),
      number: serializer.fromJson<String>(json['number']),
      expireDate: serializer.fromJson<DateTime>(json['expireDate']),
      cvv: serializer.fromJson<String>(json['cvv']),
      hasPin: serializer.fromJson<bool>(json['hasPin']),
      pin: serializer.fromJson<String?>(json['pin']),
      hasArchived: serializer.fromJson<bool>(json['hasArchived']),
      styleIndex: serializer.fromJson<int>(json['styleIndex']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'holderName': serializer.toJson<String>(holderName),
      'number': serializer.toJson<String>(number),
      'expireDate': serializer.toJson<DateTime>(expireDate),
      'cvv': serializer.toJson<String>(cvv),
      'hasPin': serializer.toJson<bool>(hasPin),
      'pin': serializer.toJson<String?>(pin),
      'hasArchived': serializer.toJson<bool>(hasArchived),
      'styleIndex': serializer.toJson<int>(styleIndex),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CardTableData copyWith({
    int? id,
    String? title,
    String? holderName,
    String? number,
    DateTime? expireDate,
    String? cvv,
    bool? hasPin,
    Value<String?> pin = const Value.absent(),
    bool? hasArchived,
    int? styleIndex,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CardTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    holderName: holderName ?? this.holderName,
    number: number ?? this.number,
    expireDate: expireDate ?? this.expireDate,
    cvv: cvv ?? this.cvv,
    hasPin: hasPin ?? this.hasPin,
    pin: pin.present ? pin.value : this.pin,
    hasArchived: hasArchived ?? this.hasArchived,
    styleIndex: styleIndex ?? this.styleIndex,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CardTableData copyWithCompanion(CardTableCompanion data) {
    return CardTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      holderName: data.holderName.present
          ? data.holderName.value
          : this.holderName,
      number: data.number.present ? data.number.value : this.number,
      expireDate: data.expireDate.present
          ? data.expireDate.value
          : this.expireDate,
      cvv: data.cvv.present ? data.cvv.value : this.cvv,
      hasPin: data.hasPin.present ? data.hasPin.value : this.hasPin,
      pin: data.pin.present ? data.pin.value : this.pin,
      hasArchived: data.hasArchived.present
          ? data.hasArchived.value
          : this.hasArchived,
      styleIndex: data.styleIndex.present
          ? data.styleIndex.value
          : this.styleIndex,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('holderName: $holderName, ')
          ..write('number: $number, ')
          ..write('expireDate: $expireDate, ')
          ..write('cvv: $cvv, ')
          ..write('hasPin: $hasPin, ')
          ..write('pin: $pin, ')
          ..write('hasArchived: $hasArchived, ')
          ..write('styleIndex: $styleIndex, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    holderName,
    number,
    expireDate,
    cvv,
    hasPin,
    pin,
    hasArchived,
    styleIndex,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.holderName == this.holderName &&
          other.number == this.number &&
          other.expireDate == this.expireDate &&
          other.cvv == this.cvv &&
          other.hasPin == this.hasPin &&
          other.pin == this.pin &&
          other.hasArchived == this.hasArchived &&
          other.styleIndex == this.styleIndex &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CardTableCompanion extends UpdateCompanion<CardTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> holderName;
  final Value<String> number;
  final Value<DateTime> expireDate;
  final Value<String> cvv;
  final Value<bool> hasPin;
  final Value<String?> pin;
  final Value<bool> hasArchived;
  final Value<int> styleIndex;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CardTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.holderName = const Value.absent(),
    this.number = const Value.absent(),
    this.expireDate = const Value.absent(),
    this.cvv = const Value.absent(),
    this.hasPin = const Value.absent(),
    this.pin = const Value.absent(),
    this.hasArchived = const Value.absent(),
    this.styleIndex = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CardTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String holderName,
    required String number,
    required DateTime expireDate,
    required String cvv,
    this.hasPin = const Value.absent(),
    this.pin = const Value.absent(),
    this.hasArchived = const Value.absent(),
    required int styleIndex,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title),
       holderName = Value(holderName),
       number = Value(number),
       expireDate = Value(expireDate),
       cvv = Value(cvv),
       styleIndex = Value(styleIndex);
  static Insertable<CardTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? holderName,
    Expression<String>? number,
    Expression<DateTime>? expireDate,
    Expression<String>? cvv,
    Expression<bool>? hasPin,
    Expression<String>? pin,
    Expression<bool>? hasArchived,
    Expression<int>? styleIndex,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (holderName != null) 'holder_name': holderName,
      if (number != null) 'number': number,
      if (expireDate != null) 'expire_date': expireDate,
      if (cvv != null) 'cvv': cvv,
      if (hasPin != null) 'has_pin': hasPin,
      if (pin != null) 'pin': pin,
      if (hasArchived != null) 'has_archived': hasArchived,
      if (styleIndex != null) 'style_index': styleIndex,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CardTableCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? holderName,
    Value<String>? number,
    Value<DateTime>? expireDate,
    Value<String>? cvv,
    Value<bool>? hasPin,
    Value<String?>? pin,
    Value<bool>? hasArchived,
    Value<int>? styleIndex,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CardTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      holderName: holderName ?? this.holderName,
      number: number ?? this.number,
      expireDate: expireDate ?? this.expireDate,
      cvv: cvv ?? this.cvv,
      hasPin: hasPin ?? this.hasPin,
      pin: pin ?? this.pin,
      hasArchived: hasArchived ?? this.hasArchived,
      styleIndex: styleIndex ?? this.styleIndex,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (holderName.present) {
      map['holder_name'] = Variable<String>(holderName.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (expireDate.present) {
      map['expire_date'] = Variable<DateTime>(expireDate.value);
    }
    if (cvv.present) {
      map['cvv'] = Variable<String>(cvv.value);
    }
    if (hasPin.present) {
      map['has_pin'] = Variable<bool>(hasPin.value);
    }
    if (pin.present) {
      map['pin'] = Variable<String>(pin.value);
    }
    if (hasArchived.present) {
      map['has_archived'] = Variable<bool>(hasArchived.value);
    }
    if (styleIndex.present) {
      map['style_index'] = Variable<int>(styleIndex.value);
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
    return (StringBuffer('CardTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('holderName: $holderName, ')
          ..write('number: $number, ')
          ..write('expireDate: $expireDate, ')
          ..write('cvv: $cvv, ')
          ..write('hasPin: $hasPin, ')
          ..write('pin: $pin, ')
          ..write('hasArchived: $hasArchived, ')
          ..write('styleIndex: $styleIndex, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CardFieldTableTable extends CardFieldTable
    with TableInfo<$CardFieldTableTable, CardFieldTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardFieldTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES card_table (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hintTextMeta = const VerificationMeta(
    'hintText',
  );
  @override
  late final GeneratedColumn<String> hintText = GeneratedColumn<String>(
    'hint_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    clientDefault: () => DateTime.now(),
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
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cardId,
    type,
    value,
    hintText,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_field_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardFieldTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('hint_text')) {
      context.handle(
        _hintTextMeta,
        hintText.isAcceptableOrUnknown(data['hint_text']!, _hintTextMeta),
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
  CardFieldTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardFieldTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}card_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      hintText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hint_text'],
      ),
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
  $CardFieldTableTable createAlias(String alias) {
    return $CardFieldTableTable(attachedDatabase, alias);
  }
}

class CardFieldTableData extends DataClass
    implements Insertable<CardFieldTableData> {
  final int id;
  final int cardId;
  final int type;
  final String value;
  final String? hintText;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CardFieldTableData({
    required this.id,
    required this.cardId,
    required this.type,
    required this.value,
    this.hintText,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    map['type'] = Variable<int>(type);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || hintText != null) {
      map['hint_text'] = Variable<String>(hintText);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CardFieldTableCompanion toCompanion(bool nullToAbsent) {
    return CardFieldTableCompanion(
      id: Value(id),
      cardId: Value(cardId),
      type: Value(type),
      value: Value(value),
      hintText: hintText == null && nullToAbsent
          ? const Value.absent()
          : Value(hintText),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CardFieldTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardFieldTableData(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      type: serializer.fromJson<int>(json['type']),
      value: serializer.fromJson<String>(json['value']),
      hintText: serializer.fromJson<String?>(json['hintText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'type': serializer.toJson<int>(type),
      'value': serializer.toJson<String>(value),
      'hintText': serializer.toJson<String?>(hintText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CardFieldTableData copyWith({
    int? id,
    int? cardId,
    int? type,
    String? value,
    Value<String?> hintText = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CardFieldTableData(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    type: type ?? this.type,
    value: value ?? this.value,
    hintText: hintText.present ? hintText.value : this.hintText,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CardFieldTableData copyWithCompanion(CardFieldTableCompanion data) {
    return CardFieldTableData(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      type: data.type.present ? data.type.value : this.type,
      value: data.value.present ? data.value.value : this.value,
      hintText: data.hintText.present ? data.hintText.value : this.hintText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardFieldTableData(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('hintText: $hintText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, cardId, type, value, hintText, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardFieldTableData &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.type == this.type &&
          other.value == this.value &&
          other.hintText == this.hintText &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CardFieldTableCompanion extends UpdateCompanion<CardFieldTableData> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<int> type;
  final Value<String> value;
  final Value<String?> hintText;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CardFieldTableCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.hintText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CardFieldTableCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    required int type,
    required String value,
    this.hintText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : cardId = Value(cardId),
       type = Value(type),
       value = Value(value);
  static Insertable<CardFieldTableData> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<int>? type,
    Expression<String>? value,
    Expression<String>? hintText,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (hintText != null) 'hint_text': hintText,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CardFieldTableCompanion copyWith({
    Value<int>? id,
    Value<int>? cardId,
    Value<int>? type,
    Value<String>? value,
    Value<String?>? hintText,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CardFieldTableCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      type: type ?? this.type,
      value: value ?? this.value,
      hintText: hintText ?? this.hintText,
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
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (hintText.present) {
      map['hint_text'] = Variable<String>(hintText.value);
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
    return (StringBuffer('CardFieldTableCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('hintText: $hintText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WalletTableTable extends WalletTable
    with TableInfo<$WalletTableTable, WalletTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seedPhraseMeta = const VerificationMeta(
    'seedPhrase',
  );
  @override
  late final GeneratedColumn<String> seedPhrase = GeneratedColumn<String>(
    'seed_phrase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasArchivedMeta = const VerificationMeta(
    'hasArchived',
  );
  @override
  late final GeneratedColumn<bool> hasArchived = GeneratedColumn<bool>(
    'has_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_archived" IN (0, 1))',
    ),
    clientDefault: () => false,
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
    clientDefault: () => DateTime.now(),
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
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    icon,
    title,
    seedPhrase,
    hasArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallet_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalletTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('seed_phrase')) {
      context.handle(
        _seedPhraseMeta,
        seedPhrase.isAcceptableOrUnknown(data['seed_phrase']!, _seedPhraseMeta),
      );
    } else if (isInserting) {
      context.missing(_seedPhraseMeta);
    }
    if (data.containsKey('has_archived')) {
      context.handle(
        _hasArchivedMeta,
        hasArchived.isAcceptableOrUnknown(
          data['has_archived']!,
          _hasArchivedMeta,
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
  WalletTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalletTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      seedPhrase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seed_phrase'],
      )!,
      hasArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_archived'],
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
  $WalletTableTable createAlias(String alias) {
    return $WalletTableTable(attachedDatabase, alias);
  }
}

class WalletTableData extends DataClass implements Insertable<WalletTableData> {
  final int id;
  final String? icon;
  final String title;
  final String seedPhrase;
  final bool hasArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WalletTableData({
    required this.id,
    this.icon,
    required this.title,
    required this.seedPhrase,
    required this.hasArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['title'] = Variable<String>(title);
    map['seed_phrase'] = Variable<String>(seedPhrase);
    map['has_archived'] = Variable<bool>(hasArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WalletTableCompanion toCompanion(bool nullToAbsent) {
    return WalletTableCompanion(
      id: Value(id),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      title: Value(title),
      seedPhrase: Value(seedPhrase),
      hasArchived: Value(hasArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WalletTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalletTableData(
      id: serializer.fromJson<int>(json['id']),
      icon: serializer.fromJson<String?>(json['icon']),
      title: serializer.fromJson<String>(json['title']),
      seedPhrase: serializer.fromJson<String>(json['seedPhrase']),
      hasArchived: serializer.fromJson<bool>(json['hasArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'icon': serializer.toJson<String?>(icon),
      'title': serializer.toJson<String>(title),
      'seedPhrase': serializer.toJson<String>(seedPhrase),
      'hasArchived': serializer.toJson<bool>(hasArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WalletTableData copyWith({
    int? id,
    Value<String?> icon = const Value.absent(),
    String? title,
    String? seedPhrase,
    bool? hasArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WalletTableData(
    id: id ?? this.id,
    icon: icon.present ? icon.value : this.icon,
    title: title ?? this.title,
    seedPhrase: seedPhrase ?? this.seedPhrase,
    hasArchived: hasArchived ?? this.hasArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WalletTableData copyWithCompanion(WalletTableCompanion data) {
    return WalletTableData(
      id: data.id.present ? data.id.value : this.id,
      icon: data.icon.present ? data.icon.value : this.icon,
      title: data.title.present ? data.title.value : this.title,
      seedPhrase: data.seedPhrase.present
          ? data.seedPhrase.value
          : this.seedPhrase,
      hasArchived: data.hasArchived.present
          ? data.hasArchived.value
          : this.hasArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalletTableData(')
          ..write('id: $id, ')
          ..write('icon: $icon, ')
          ..write('title: $title, ')
          ..write('seedPhrase: $seedPhrase, ')
          ..write('hasArchived: $hasArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    icon,
    title,
    seedPhrase,
    hasArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalletTableData &&
          other.id == this.id &&
          other.icon == this.icon &&
          other.title == this.title &&
          other.seedPhrase == this.seedPhrase &&
          other.hasArchived == this.hasArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WalletTableCompanion extends UpdateCompanion<WalletTableData> {
  final Value<int> id;
  final Value<String?> icon;
  final Value<String> title;
  final Value<String> seedPhrase;
  final Value<bool> hasArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WalletTableCompanion({
    this.id = const Value.absent(),
    this.icon = const Value.absent(),
    this.title = const Value.absent(),
    this.seedPhrase = const Value.absent(),
    this.hasArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WalletTableCompanion.insert({
    this.id = const Value.absent(),
    this.icon = const Value.absent(),
    required String title,
    required String seedPhrase,
    this.hasArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title),
       seedPhrase = Value(seedPhrase);
  static Insertable<WalletTableData> custom({
    Expression<int>? id,
    Expression<String>? icon,
    Expression<String>? title,
    Expression<String>? seedPhrase,
    Expression<bool>? hasArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (icon != null) 'icon': icon,
      if (title != null) 'title': title,
      if (seedPhrase != null) 'seed_phrase': seedPhrase,
      if (hasArchived != null) 'has_archived': hasArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WalletTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? icon,
    Value<String>? title,
    Value<String>? seedPhrase,
    Value<bool>? hasArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return WalletTableCompanion(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      seedPhrase: seedPhrase ?? this.seedPhrase,
      hasArchived: hasArchived ?? this.hasArchived,
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
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (seedPhrase.present) {
      map['seed_phrase'] = Variable<String>(seedPhrase.value);
    }
    if (hasArchived.present) {
      map['has_archived'] = Variable<bool>(hasArchived.value);
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
    return (StringBuffer('WalletTableCompanion(')
          ..write('id: $id, ')
          ..write('icon: $icon, ')
          ..write('title: $title, ')
          ..write('seedPhrase: $seedPhrase, ')
          ..write('hasArchived: $hasArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WalletFieldTableTable extends WalletFieldTable
    with TableInfo<$WalletFieldTableTable, WalletFieldTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletFieldTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _walletIdMeta = const VerificationMeta(
    'walletId',
  );
  @override
  late final GeneratedColumn<int> walletId = GeneratedColumn<int>(
    'wallet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wallet_table (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hintTextMeta = const VerificationMeta(
    'hintText',
  );
  @override
  late final GeneratedColumn<String> hintText = GeneratedColumn<String>(
    'hint_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    clientDefault: () => DateTime.now(),
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
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    walletId,
    type,
    value,
    hintText,
    order,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallet_field_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalletFieldTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wallet_id')) {
      context.handle(
        _walletIdMeta,
        walletId.isAcceptableOrUnknown(data['wallet_id']!, _walletIdMeta),
      );
    } else if (isInserting) {
      context.missing(_walletIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('hint_text')) {
      context.handle(
        _hintTextMeta,
        hintText.isAcceptableOrUnknown(data['hint_text']!, _hintTextMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
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
  WalletFieldTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalletFieldTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      walletId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wallet_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      hintText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hint_text'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
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
  $WalletFieldTableTable createAlias(String alias) {
    return $WalletFieldTableTable(attachedDatabase, alias);
  }
}

class WalletFieldTableData extends DataClass
    implements Insertable<WalletFieldTableData> {
  final int id;
  final int walletId;
  final int type;
  final String value;
  final String? hintText;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WalletFieldTableData({
    required this.id,
    required this.walletId,
    required this.type,
    required this.value,
    this.hintText,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wallet_id'] = Variable<int>(walletId);
    map['type'] = Variable<int>(type);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || hintText != null) {
      map['hint_text'] = Variable<String>(hintText);
    }
    map['order'] = Variable<int>(order);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WalletFieldTableCompanion toCompanion(bool nullToAbsent) {
    return WalletFieldTableCompanion(
      id: Value(id),
      walletId: Value(walletId),
      type: Value(type),
      value: Value(value),
      hintText: hintText == null && nullToAbsent
          ? const Value.absent()
          : Value(hintText),
      order: Value(order),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WalletFieldTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalletFieldTableData(
      id: serializer.fromJson<int>(json['id']),
      walletId: serializer.fromJson<int>(json['walletId']),
      type: serializer.fromJson<int>(json['type']),
      value: serializer.fromJson<String>(json['value']),
      hintText: serializer.fromJson<String?>(json['hintText']),
      order: serializer.fromJson<int>(json['order']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'walletId': serializer.toJson<int>(walletId),
      'type': serializer.toJson<int>(type),
      'value': serializer.toJson<String>(value),
      'hintText': serializer.toJson<String?>(hintText),
      'order': serializer.toJson<int>(order),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WalletFieldTableData copyWith({
    int? id,
    int? walletId,
    int? type,
    String? value,
    Value<String?> hintText = const Value.absent(),
    int? order,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WalletFieldTableData(
    id: id ?? this.id,
    walletId: walletId ?? this.walletId,
    type: type ?? this.type,
    value: value ?? this.value,
    hintText: hintText.present ? hintText.value : this.hintText,
    order: order ?? this.order,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WalletFieldTableData copyWithCompanion(WalletFieldTableCompanion data) {
    return WalletFieldTableData(
      id: data.id.present ? data.id.value : this.id,
      walletId: data.walletId.present ? data.walletId.value : this.walletId,
      type: data.type.present ? data.type.value : this.type,
      value: data.value.present ? data.value.value : this.value,
      hintText: data.hintText.present ? data.hintText.value : this.hintText,
      order: data.order.present ? data.order.value : this.order,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalletFieldTableData(')
          ..write('id: $id, ')
          ..write('walletId: $walletId, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('hintText: $hintText, ')
          ..write('order: $order, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    walletId,
    type,
    value,
    hintText,
    order,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalletFieldTableData &&
          other.id == this.id &&
          other.walletId == this.walletId &&
          other.type == this.type &&
          other.value == this.value &&
          other.hintText == this.hintText &&
          other.order == this.order &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WalletFieldTableCompanion extends UpdateCompanion<WalletFieldTableData> {
  final Value<int> id;
  final Value<int> walletId;
  final Value<int> type;
  final Value<String> value;
  final Value<String?> hintText;
  final Value<int> order;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WalletFieldTableCompanion({
    this.id = const Value.absent(),
    this.walletId = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.hintText = const Value.absent(),
    this.order = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WalletFieldTableCompanion.insert({
    this.id = const Value.absent(),
    required int walletId,
    required int type,
    required String value,
    this.hintText = const Value.absent(),
    this.order = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : walletId = Value(walletId),
       type = Value(type),
       value = Value(value);
  static Insertable<WalletFieldTableData> custom({
    Expression<int>? id,
    Expression<int>? walletId,
    Expression<int>? type,
    Expression<String>? value,
    Expression<String>? hintText,
    Expression<int>? order,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (walletId != null) 'wallet_id': walletId,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (hintText != null) 'hint_text': hintText,
      if (order != null) 'order': order,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WalletFieldTableCompanion copyWith({
    Value<int>? id,
    Value<int>? walletId,
    Value<int>? type,
    Value<String>? value,
    Value<String?>? hintText,
    Value<int>? order,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return WalletFieldTableCompanion(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      type: type ?? this.type,
      value: value ?? this.value,
      hintText: hintText ?? this.hintText,
      order: order ?? this.order,
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
    if (walletId.present) {
      map['wallet_id'] = Variable<int>(walletId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (hintText.present) {
      map['hint_text'] = Variable<String>(hintText.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
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
    return (StringBuffer('WalletFieldTableCompanion(')
          ..write('id: $id, ')
          ..write('walletId: $walletId, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('hintText: $hintText, ')
          ..write('order: $order, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $CollectionTableTable collectionTable = $CollectionTableTable(
    this,
  );
  late final $PasswordTableTable passwordTable = $PasswordTableTable(this);
  late final $CollectionItemTableTable collectionItemTable =
      $CollectionItemTableTable(this);
  late final $PasswordFieldTableTable passwordFieldTable =
      $PasswordFieldTableTable(this);
  late final $CardTableTable cardTable = $CardTableTable(this);
  late final $CardFieldTableTable cardFieldTable = $CardFieldTableTable(this);
  late final $WalletTableTable walletTable = $WalletTableTable(this);
  late final $WalletFieldTableTable walletFieldTable = $WalletFieldTableTable(
    this,
  );
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final CollectionDao collectionDao = CollectionDao(this as AppDatabase);
  late final PasswordDao passwordDao = PasswordDao(this as AppDatabase);
  late final CardDao cardDao = CardDao(this as AppDatabase);
  late final WalletDao walletDao = WalletDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userTable,
    collectionTable,
    passwordTable,
    collectionItemTable,
    passwordFieldTable,
    cardTable,
    cardFieldTable,
    walletTable,
    walletFieldTable,
  ];
}

typedef $$UserTableTableCreateCompanionBuilder =
    UserTableCompanion Function({
      Value<int> id,
      required String password,
      Value<String?> passwordHint,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UserTableTableUpdateCompanionBuilder =
    UserTableCompanion Function({
      Value<int> id,
      Value<String> password,
      Value<String?> passwordHint,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$UserTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableFilterComposer({
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

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHint => $composableBuilder(
    column: $table.passwordHint,
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

class $$UserTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableOrderingComposer({
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

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHint => $composableBuilder(
    column: $table.passwordHint,
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

class $$UserTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get passwordHint => $composableBuilder(
    column: $table.passwordHint,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserTableTable,
          UserTableData,
          $$UserTableTableFilterComposer,
          $$UserTableTableOrderingComposer,
          $$UserTableTableAnnotationComposer,
          $$UserTableTableCreateCompanionBuilder,
          $$UserTableTableUpdateCompanionBuilder,
          (
            UserTableData,
            BaseReferences<_$AppDatabase, $UserTableTable, UserTableData>,
          ),
          UserTableData,
          PrefetchHooks Function()
        > {
  $$UserTableTableTableManager(_$AppDatabase db, $UserTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String?> passwordHint = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserTableCompanion(
                id: id,
                password: password,
                passwordHint: passwordHint,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String password,
                Value<String?> passwordHint = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserTableCompanion.insert(
                id: id,
                password: password,
                passwordHint: passwordHint,
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

typedef $$UserTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserTableTable,
      UserTableData,
      $$UserTableTableFilterComposer,
      $$UserTableTableOrderingComposer,
      $$UserTableTableAnnotationComposer,
      $$UserTableTableCreateCompanionBuilder,
      $$UserTableTableUpdateCompanionBuilder,
      (
        UserTableData,
        BaseReferences<_$AppDatabase, $UserTableTable, UserTableData>,
      ),
      UserTableData,
      PrefetchHooks Function()
    >;
typedef $$CollectionTableTableCreateCompanionBuilder =
    CollectionTableCompanion Function({
      Value<int> id,
      Value<String?> name,
      required String iconPath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CollectionTableTableUpdateCompanionBuilder =
    CollectionTableCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<String> iconPath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CollectionTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CollectionTableTable,
          CollectionTableData
        > {
  $$CollectionTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $CollectionItemTableTable,
    List<CollectionItemTableData>
  >
  _collectionItemTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectionItemTable,
        aliasName: $_aliasNameGenerator(
          db.collectionTable.id,
          db.collectionItemTable.collectionId,
        ),
      );

  $$CollectionItemTableTableProcessedTableManager get collectionItemTableRefs {
    final manager = $$CollectionItemTableTableTableManager(
      $_db,
      $_db.collectionItemTable,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionItemTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CollectionTableTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionTableTable> {
  $$CollectionTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconPath => $composableBuilder(
    column: $table.iconPath,
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

  Expression<bool> collectionItemTableRefs(
    Expression<bool> Function($$CollectionItemTableTableFilterComposer f) f,
  ) {
    final $$CollectionItemTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectionItemTable,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionItemTableTableFilterComposer(
            $db: $db,
            $table: $db.collectionItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CollectionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionTableTable> {
  $$CollectionTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconPath => $composableBuilder(
    column: $table.iconPath,
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

class $$CollectionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionTableTable> {
  $$CollectionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconPath =>
      $composableBuilder(column: $table.iconPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> collectionItemTableRefs<T extends Object>(
    Expression<T> Function($$CollectionItemTableTableAnnotationComposer a) f,
  ) {
    final $$CollectionItemTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionItemTable,
          getReferencedColumn: (t) => t.collectionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionItemTableTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionItemTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CollectionTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionTableTable,
          CollectionTableData,
          $$CollectionTableTableFilterComposer,
          $$CollectionTableTableOrderingComposer,
          $$CollectionTableTableAnnotationComposer,
          $$CollectionTableTableCreateCompanionBuilder,
          $$CollectionTableTableUpdateCompanionBuilder,
          (CollectionTableData, $$CollectionTableTableReferences),
          CollectionTableData,
          PrefetchHooks Function({bool collectionItemTableRefs})
        > {
  $$CollectionTableTableTableManager(
    _$AppDatabase db,
    $CollectionTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String> iconPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CollectionTableCompanion(
                id: id,
                name: name,
                iconPath: iconPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                required String iconPath,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CollectionTableCompanion.insert(
                id: id,
                name: name,
                iconPath: iconPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectionTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({collectionItemTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (collectionItemTableRefs) db.collectionItemTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (collectionItemTableRefs)
                    await $_getPrefetchedData<
                      CollectionTableData,
                      $CollectionTableTable,
                      CollectionItemTableData
                    >(
                      currentTable: table,
                      referencedTable: $$CollectionTableTableReferences
                          ._collectionItemTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CollectionTableTableReferences(
                            db,
                            table,
                            p0,
                          ).collectionItemTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.collectionId == item.id,
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

typedef $$CollectionTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionTableTable,
      CollectionTableData,
      $$CollectionTableTableFilterComposer,
      $$CollectionTableTableOrderingComposer,
      $$CollectionTableTableAnnotationComposer,
      $$CollectionTableTableCreateCompanionBuilder,
      $$CollectionTableTableUpdateCompanionBuilder,
      (CollectionTableData, $$CollectionTableTableReferences),
      CollectionTableData,
      PrefetchHooks Function({bool collectionItemTableRefs})
    >;
typedef $$PasswordTableTableCreateCompanionBuilder =
    PasswordTableCompanion Function({
      Value<int> id,
      required String title,
      required String iconPath,
      Value<bool> has2fa,
      Value<String?> authKey,
      Value<bool> hasArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$PasswordTableTableUpdateCompanionBuilder =
    PasswordTableCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> iconPath,
      Value<bool> has2fa,
      Value<String?> authKey,
      Value<bool> hasArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$PasswordTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $PasswordTableTable, PasswordTableData> {
  $$PasswordTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $CollectionItemTableTable,
    List<CollectionItemTableData>
  >
  _collectionItemTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectionItemTable,
        aliasName: $_aliasNameGenerator(
          db.passwordTable.id,
          db.collectionItemTable.passwordId,
        ),
      );

  $$CollectionItemTableTableProcessedTableManager get collectionItemTableRefs {
    final manager = $$CollectionItemTableTableTableManager(
      $_db,
      $_db.collectionItemTable,
    ).filter((f) => f.passwordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionItemTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PasswordFieldTableTable,
    List<PasswordFieldTableData>
  >
  _passwordFieldTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.passwordFieldTable,
        aliasName: $_aliasNameGenerator(
          db.passwordTable.id,
          db.passwordFieldTable.passwordId,
        ),
      );

  $$PasswordFieldTableTableProcessedTableManager get passwordFieldTableRefs {
    final manager = $$PasswordFieldTableTableTableManager(
      $_db,
      $_db.passwordFieldTable,
    ).filter((f) => f.passwordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _passwordFieldTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PasswordTableTableFilterComposer
    extends Composer<_$AppDatabase, $PasswordTableTable> {
  $$PasswordTableTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconPath => $composableBuilder(
    column: $table.iconPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get has2fa => $composableBuilder(
    column: $table.has2fa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authKey => $composableBuilder(
    column: $table.authKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasArchived => $composableBuilder(
    column: $table.hasArchived,
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

  Expression<bool> collectionItemTableRefs(
    Expression<bool> Function($$CollectionItemTableTableFilterComposer f) f,
  ) {
    final $$CollectionItemTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectionItemTable,
      getReferencedColumn: (t) => t.passwordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionItemTableTableFilterComposer(
            $db: $db,
            $table: $db.collectionItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> passwordFieldTableRefs(
    Expression<bool> Function($$PasswordFieldTableTableFilterComposer f) f,
  ) {
    final $$PasswordFieldTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.passwordFieldTable,
      getReferencedColumn: (t) => t.passwordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PasswordFieldTableTableFilterComposer(
            $db: $db,
            $table: $db.passwordFieldTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PasswordTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PasswordTableTable> {
  $$PasswordTableTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconPath => $composableBuilder(
    column: $table.iconPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get has2fa => $composableBuilder(
    column: $table.has2fa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authKey => $composableBuilder(
    column: $table.authKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasArchived => $composableBuilder(
    column: $table.hasArchived,
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

class $$PasswordTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PasswordTableTable> {
  $$PasswordTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get iconPath =>
      $composableBuilder(column: $table.iconPath, builder: (column) => column);

  GeneratedColumn<bool> get has2fa =>
      $composableBuilder(column: $table.has2fa, builder: (column) => column);

  GeneratedColumn<String> get authKey =>
      $composableBuilder(column: $table.authKey, builder: (column) => column);

  GeneratedColumn<bool> get hasArchived => $composableBuilder(
    column: $table.hasArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> collectionItemTableRefs<T extends Object>(
    Expression<T> Function($$CollectionItemTableTableAnnotationComposer a) f,
  ) {
    final $$CollectionItemTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionItemTable,
          getReferencedColumn: (t) => t.passwordId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionItemTableTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionItemTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> passwordFieldTableRefs<T extends Object>(
    Expression<T> Function($$PasswordFieldTableTableAnnotationComposer a) f,
  ) {
    final $$PasswordFieldTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.passwordFieldTable,
          getReferencedColumn: (t) => t.passwordId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PasswordFieldTableTableAnnotationComposer(
                $db: $db,
                $table: $db.passwordFieldTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PasswordTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PasswordTableTable,
          PasswordTableData,
          $$PasswordTableTableFilterComposer,
          $$PasswordTableTableOrderingComposer,
          $$PasswordTableTableAnnotationComposer,
          $$PasswordTableTableCreateCompanionBuilder,
          $$PasswordTableTableUpdateCompanionBuilder,
          (PasswordTableData, $$PasswordTableTableReferences),
          PasswordTableData,
          PrefetchHooks Function({
            bool collectionItemTableRefs,
            bool passwordFieldTableRefs,
          })
        > {
  $$PasswordTableTableTableManager(_$AppDatabase db, $PasswordTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PasswordTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PasswordTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PasswordTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> iconPath = const Value.absent(),
                Value<bool> has2fa = const Value.absent(),
                Value<String?> authKey = const Value.absent(),
                Value<bool> hasArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PasswordTableCompanion(
                id: id,
                title: title,
                iconPath: iconPath,
                has2fa: has2fa,
                authKey: authKey,
                hasArchived: hasArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String iconPath,
                Value<bool> has2fa = const Value.absent(),
                Value<String?> authKey = const Value.absent(),
                Value<bool> hasArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PasswordTableCompanion.insert(
                id: id,
                title: title,
                iconPath: iconPath,
                has2fa: has2fa,
                authKey: authKey,
                hasArchived: hasArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PasswordTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                collectionItemTableRefs = false,
                passwordFieldTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (collectionItemTableRefs) db.collectionItemTable,
                    if (passwordFieldTableRefs) db.passwordFieldTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (collectionItemTableRefs)
                        await $_getPrefetchedData<
                          PasswordTableData,
                          $PasswordTableTable,
                          CollectionItemTableData
                        >(
                          currentTable: table,
                          referencedTable: $$PasswordTableTableReferences
                              ._collectionItemTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PasswordTableTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionItemTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.passwordId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (passwordFieldTableRefs)
                        await $_getPrefetchedData<
                          PasswordTableData,
                          $PasswordTableTable,
                          PasswordFieldTableData
                        >(
                          currentTable: table,
                          referencedTable: $$PasswordTableTableReferences
                              ._passwordFieldTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PasswordTableTableReferences(
                                db,
                                table,
                                p0,
                              ).passwordFieldTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.passwordId == item.id,
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

typedef $$PasswordTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PasswordTableTable,
      PasswordTableData,
      $$PasswordTableTableFilterComposer,
      $$PasswordTableTableOrderingComposer,
      $$PasswordTableTableAnnotationComposer,
      $$PasswordTableTableCreateCompanionBuilder,
      $$PasswordTableTableUpdateCompanionBuilder,
      (PasswordTableData, $$PasswordTableTableReferences),
      PasswordTableData,
      PrefetchHooks Function({
        bool collectionItemTableRefs,
        bool passwordFieldTableRefs,
      })
    >;
typedef $$CollectionItemTableTableCreateCompanionBuilder =
    CollectionItemTableCompanion Function({
      Value<int> id,
      required int collectionId,
      required int passwordId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CollectionItemTableTableUpdateCompanionBuilder =
    CollectionItemTableCompanion Function({
      Value<int> id,
      Value<int> collectionId,
      Value<int> passwordId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CollectionItemTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CollectionItemTableTable,
          CollectionItemTableData
        > {
  $$CollectionItemTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CollectionTableTable _collectionIdTable(_$AppDatabase db) =>
      db.collectionTable.createAlias(
        $_aliasNameGenerator(
          db.collectionItemTable.collectionId,
          db.collectionTable.id,
        ),
      );

  $$CollectionTableTableProcessedTableManager get collectionId {
    final $_column = $_itemColumn<int>('collection_id')!;

    final manager = $$CollectionTableTableTableManager(
      $_db,
      $_db.collectionTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PasswordTableTable _passwordIdTable(_$AppDatabase db) =>
      db.passwordTable.createAlias(
        $_aliasNameGenerator(
          db.collectionItemTable.passwordId,
          db.passwordTable.id,
        ),
      );

  $$PasswordTableTableProcessedTableManager get passwordId {
    final $_column = $_itemColumn<int>('password_id')!;

    final manager = $$PasswordTableTableTableManager(
      $_db,
      $_db.passwordTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_passwordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CollectionItemTableTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionItemTableTable> {
  $$CollectionItemTableTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CollectionTableTableFilterComposer get collectionId {
    final $$CollectionTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collectionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionTableTableFilterComposer(
            $db: $db,
            $table: $db.collectionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PasswordTableTableFilterComposer get passwordId {
    final $$PasswordTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passwordId,
      referencedTable: $db.passwordTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PasswordTableTableFilterComposer(
            $db: $db,
            $table: $db.passwordTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionItemTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionItemTableTable> {
  $$CollectionItemTableTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CollectionTableTableOrderingComposer get collectionId {
    final $$CollectionTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collectionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionTableTableOrderingComposer(
            $db: $db,
            $table: $db.collectionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PasswordTableTableOrderingComposer get passwordId {
    final $$PasswordTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passwordId,
      referencedTable: $db.passwordTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PasswordTableTableOrderingComposer(
            $db: $db,
            $table: $db.passwordTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionItemTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionItemTableTable> {
  $$CollectionItemTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CollectionTableTableAnnotationComposer get collectionId {
    final $$CollectionTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collectionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionTableTableAnnotationComposer(
            $db: $db,
            $table: $db.collectionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PasswordTableTableAnnotationComposer get passwordId {
    final $$PasswordTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passwordId,
      referencedTable: $db.passwordTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PasswordTableTableAnnotationComposer(
            $db: $db,
            $table: $db.passwordTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionItemTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionItemTableTable,
          CollectionItemTableData,
          $$CollectionItemTableTableFilterComposer,
          $$CollectionItemTableTableOrderingComposer,
          $$CollectionItemTableTableAnnotationComposer,
          $$CollectionItemTableTableCreateCompanionBuilder,
          $$CollectionItemTableTableUpdateCompanionBuilder,
          (CollectionItemTableData, $$CollectionItemTableTableReferences),
          CollectionItemTableData,
          PrefetchHooks Function({bool collectionId, bool passwordId})
        > {
  $$CollectionItemTableTableTableManager(
    _$AppDatabase db,
    $CollectionItemTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionItemTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionItemTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CollectionItemTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> collectionId = const Value.absent(),
                Value<int> passwordId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CollectionItemTableCompanion(
                id: id,
                collectionId: collectionId,
                passwordId: passwordId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int collectionId,
                required int passwordId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CollectionItemTableCompanion.insert(
                id: id,
                collectionId: collectionId,
                passwordId: passwordId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectionItemTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({collectionId = false, passwordId = false}) {
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
                    if (collectionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.collectionId,
                                referencedTable:
                                    $$CollectionItemTableTableReferences
                                        ._collectionIdTable(db),
                                referencedColumn:
                                    $$CollectionItemTableTableReferences
                                        ._collectionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (passwordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.passwordId,
                                referencedTable:
                                    $$CollectionItemTableTableReferences
                                        ._passwordIdTable(db),
                                referencedColumn:
                                    $$CollectionItemTableTableReferences
                                        ._passwordIdTable(db)
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

typedef $$CollectionItemTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionItemTableTable,
      CollectionItemTableData,
      $$CollectionItemTableTableFilterComposer,
      $$CollectionItemTableTableOrderingComposer,
      $$CollectionItemTableTableAnnotationComposer,
      $$CollectionItemTableTableCreateCompanionBuilder,
      $$CollectionItemTableTableUpdateCompanionBuilder,
      (CollectionItemTableData, $$CollectionItemTableTableReferences),
      CollectionItemTableData,
      PrefetchHooks Function({bool collectionId, bool passwordId})
    >;
typedef $$PasswordFieldTableTableCreateCompanionBuilder =
    PasswordFieldTableCompanion Function({
      Value<int> id,
      required int passwordId,
      required int type,
      Value<int> order,
      required String value,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$PasswordFieldTableTableUpdateCompanionBuilder =
    PasswordFieldTableCompanion Function({
      Value<int> id,
      Value<int> passwordId,
      Value<int> type,
      Value<int> order,
      Value<String> value,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$PasswordFieldTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PasswordFieldTableTable,
          PasswordFieldTableData
        > {
  $$PasswordFieldTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PasswordTableTable _passwordIdTable(_$AppDatabase db) =>
      db.passwordTable.createAlias(
        $_aliasNameGenerator(
          db.passwordFieldTable.passwordId,
          db.passwordTable.id,
        ),
      );

  $$PasswordTableTableProcessedTableManager get passwordId {
    final $_column = $_itemColumn<int>('password_id')!;

    final manager = $$PasswordTableTableTableManager(
      $_db,
      $_db.passwordTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_passwordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PasswordFieldTableTableFilterComposer
    extends Composer<_$AppDatabase, $PasswordFieldTableTable> {
  $$PasswordFieldTableTableFilterComposer({
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

  ColumnFilters<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
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

  $$PasswordTableTableFilterComposer get passwordId {
    final $$PasswordTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passwordId,
      referencedTable: $db.passwordTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PasswordTableTableFilterComposer(
            $db: $db,
            $table: $db.passwordTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PasswordFieldTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PasswordFieldTableTable> {
  $$PasswordFieldTableTableOrderingComposer({
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

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
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

  $$PasswordTableTableOrderingComposer get passwordId {
    final $$PasswordTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passwordId,
      referencedTable: $db.passwordTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PasswordTableTableOrderingComposer(
            $db: $db,
            $table: $db.passwordTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PasswordFieldTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PasswordFieldTableTable> {
  $$PasswordFieldTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PasswordTableTableAnnotationComposer get passwordId {
    final $$PasswordTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.passwordId,
      referencedTable: $db.passwordTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PasswordTableTableAnnotationComposer(
            $db: $db,
            $table: $db.passwordTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PasswordFieldTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PasswordFieldTableTable,
          PasswordFieldTableData,
          $$PasswordFieldTableTableFilterComposer,
          $$PasswordFieldTableTableOrderingComposer,
          $$PasswordFieldTableTableAnnotationComposer,
          $$PasswordFieldTableTableCreateCompanionBuilder,
          $$PasswordFieldTableTableUpdateCompanionBuilder,
          (PasswordFieldTableData, $$PasswordFieldTableTableReferences),
          PasswordFieldTableData,
          PrefetchHooks Function({bool passwordId})
        > {
  $$PasswordFieldTableTableTableManager(
    _$AppDatabase db,
    $PasswordFieldTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PasswordFieldTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PasswordFieldTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PasswordFieldTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> passwordId = const Value.absent(),
                Value<int> type = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PasswordFieldTableCompanion(
                id: id,
                passwordId: passwordId,
                type: type,
                order: order,
                value: value,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int passwordId,
                required int type,
                Value<int> order = const Value.absent(),
                required String value,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PasswordFieldTableCompanion.insert(
                id: id,
                passwordId: passwordId,
                type: type,
                order: order,
                value: value,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PasswordFieldTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({passwordId = false}) {
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
                    if (passwordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.passwordId,
                                referencedTable:
                                    $$PasswordFieldTableTableReferences
                                        ._passwordIdTable(db),
                                referencedColumn:
                                    $$PasswordFieldTableTableReferences
                                        ._passwordIdTable(db)
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

typedef $$PasswordFieldTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PasswordFieldTableTable,
      PasswordFieldTableData,
      $$PasswordFieldTableTableFilterComposer,
      $$PasswordFieldTableTableOrderingComposer,
      $$PasswordFieldTableTableAnnotationComposer,
      $$PasswordFieldTableTableCreateCompanionBuilder,
      $$PasswordFieldTableTableUpdateCompanionBuilder,
      (PasswordFieldTableData, $$PasswordFieldTableTableReferences),
      PasswordFieldTableData,
      PrefetchHooks Function({bool passwordId})
    >;
typedef $$CardTableTableCreateCompanionBuilder =
    CardTableCompanion Function({
      Value<int> id,
      required String title,
      required String holderName,
      required String number,
      required DateTime expireDate,
      required String cvv,
      Value<bool> hasPin,
      Value<String?> pin,
      Value<bool> hasArchived,
      required int styleIndex,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CardTableTableUpdateCompanionBuilder =
    CardTableCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> holderName,
      Value<String> number,
      Value<DateTime> expireDate,
      Value<String> cvv,
      Value<bool> hasPin,
      Value<String?> pin,
      Value<bool> hasArchived,
      Value<int> styleIndex,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CardTableTableReferences
    extends BaseReferences<_$AppDatabase, $CardTableTable, CardTableData> {
  $$CardTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CardFieldTableTable, List<CardFieldTableData>>
  _cardFieldTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cardFieldTable,
    aliasName: $_aliasNameGenerator(db.cardTable.id, db.cardFieldTable.cardId),
  );

  $$CardFieldTableTableProcessedTableManager get cardFieldTableRefs {
    final manager = $$CardFieldTableTableTableManager(
      $_db,
      $_db.cardFieldTable,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardFieldTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CardTableTableFilterComposer
    extends Composer<_$AppDatabase, $CardTableTable> {
  $$CardTableTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expireDate => $composableBuilder(
    column: $table.expireDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cvv => $composableBuilder(
    column: $table.cvv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasPin => $composableBuilder(
    column: $table.hasPin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pin => $composableBuilder(
    column: $table.pin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasArchived => $composableBuilder(
    column: $table.hasArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get styleIndex => $composableBuilder(
    column: $table.styleIndex,
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

  Expression<bool> cardFieldTableRefs(
    Expression<bool> Function($$CardFieldTableTableFilterComposer f) f,
  ) {
    final $$CardFieldTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardFieldTable,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardFieldTableTableFilterComposer(
            $db: $db,
            $table: $db.cardFieldTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CardTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CardTableTable> {
  $$CardTableTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expireDate => $composableBuilder(
    column: $table.expireDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cvv => $composableBuilder(
    column: $table.cvv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasPin => $composableBuilder(
    column: $table.hasPin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pin => $composableBuilder(
    column: $table.pin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasArchived => $composableBuilder(
    column: $table.hasArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get styleIndex => $composableBuilder(
    column: $table.styleIndex,
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

class $$CardTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardTableTable> {
  $$CardTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<DateTime> get expireDate => $composableBuilder(
    column: $table.expireDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cvv =>
      $composableBuilder(column: $table.cvv, builder: (column) => column);

  GeneratedColumn<bool> get hasPin =>
      $composableBuilder(column: $table.hasPin, builder: (column) => column);

  GeneratedColumn<String> get pin =>
      $composableBuilder(column: $table.pin, builder: (column) => column);

  GeneratedColumn<bool> get hasArchived => $composableBuilder(
    column: $table.hasArchived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get styleIndex => $composableBuilder(
    column: $table.styleIndex,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> cardFieldTableRefs<T extends Object>(
    Expression<T> Function($$CardFieldTableTableAnnotationComposer a) f,
  ) {
    final $$CardFieldTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardFieldTable,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardFieldTableTableAnnotationComposer(
            $db: $db,
            $table: $db.cardFieldTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CardTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CardTableTable,
          CardTableData,
          $$CardTableTableFilterComposer,
          $$CardTableTableOrderingComposer,
          $$CardTableTableAnnotationComposer,
          $$CardTableTableCreateCompanionBuilder,
          $$CardTableTableUpdateCompanionBuilder,
          (CardTableData, $$CardTableTableReferences),
          CardTableData,
          PrefetchHooks Function({bool cardFieldTableRefs})
        > {
  $$CardTableTableTableManager(_$AppDatabase db, $CardTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> holderName = const Value.absent(),
                Value<String> number = const Value.absent(),
                Value<DateTime> expireDate = const Value.absent(),
                Value<String> cvv = const Value.absent(),
                Value<bool> hasPin = const Value.absent(),
                Value<String?> pin = const Value.absent(),
                Value<bool> hasArchived = const Value.absent(),
                Value<int> styleIndex = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CardTableCompanion(
                id: id,
                title: title,
                holderName: holderName,
                number: number,
                expireDate: expireDate,
                cvv: cvv,
                hasPin: hasPin,
                pin: pin,
                hasArchived: hasArchived,
                styleIndex: styleIndex,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String holderName,
                required String number,
                required DateTime expireDate,
                required String cvv,
                Value<bool> hasPin = const Value.absent(),
                Value<String?> pin = const Value.absent(),
                Value<bool> hasArchived = const Value.absent(),
                required int styleIndex,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CardTableCompanion.insert(
                id: id,
                title: title,
                holderName: holderName,
                number: number,
                expireDate: expireDate,
                cvv: cvv,
                hasPin: hasPin,
                pin: pin,
                hasArchived: hasArchived,
                styleIndex: styleIndex,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CardTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardFieldTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cardFieldTableRefs) db.cardFieldTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cardFieldTableRefs)
                    await $_getPrefetchedData<
                      CardTableData,
                      $CardTableTable,
                      CardFieldTableData
                    >(
                      currentTable: table,
                      referencedTable: $$CardTableTableReferences
                          ._cardFieldTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CardTableTableReferences(
                            db,
                            table,
                            p0,
                          ).cardFieldTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.cardId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CardTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CardTableTable,
      CardTableData,
      $$CardTableTableFilterComposer,
      $$CardTableTableOrderingComposer,
      $$CardTableTableAnnotationComposer,
      $$CardTableTableCreateCompanionBuilder,
      $$CardTableTableUpdateCompanionBuilder,
      (CardTableData, $$CardTableTableReferences),
      CardTableData,
      PrefetchHooks Function({bool cardFieldTableRefs})
    >;
typedef $$CardFieldTableTableCreateCompanionBuilder =
    CardFieldTableCompanion Function({
      Value<int> id,
      required int cardId,
      required int type,
      required String value,
      Value<String?> hintText,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CardFieldTableTableUpdateCompanionBuilder =
    CardFieldTableCompanion Function({
      Value<int> id,
      Value<int> cardId,
      Value<int> type,
      Value<String> value,
      Value<String?> hintText,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CardFieldTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CardFieldTableTable,
          CardFieldTableData
        > {
  $$CardFieldTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CardTableTable _cardIdTable(_$AppDatabase db) =>
      db.cardTable.createAlias(
        $_aliasNameGenerator(db.cardFieldTable.cardId, db.cardTable.id),
      );

  $$CardTableTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<int>('card_id')!;

    final manager = $$CardTableTableTableManager(
      $_db,
      $_db.cardTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CardFieldTableTableFilterComposer
    extends Composer<_$AppDatabase, $CardFieldTableTable> {
  $$CardFieldTableTableFilterComposer({
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

  ColumnFilters<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hintText => $composableBuilder(
    column: $table.hintText,
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

  $$CardTableTableFilterComposer get cardId {
    final $$CardTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardTableTableFilterComposer(
            $db: $db,
            $table: $db.cardTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardFieldTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CardFieldTableTable> {
  $$CardFieldTableTableOrderingComposer({
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

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hintText => $composableBuilder(
    column: $table.hintText,
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

  $$CardTableTableOrderingComposer get cardId {
    final $$CardTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardTableTableOrderingComposer(
            $db: $db,
            $table: $db.cardTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardFieldTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardFieldTableTable> {
  $$CardFieldTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get hintText =>
      $composableBuilder(column: $table.hintText, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CardTableTableAnnotationComposer get cardId {
    final $$CardTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardTableTableAnnotationComposer(
            $db: $db,
            $table: $db.cardTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardFieldTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CardFieldTableTable,
          CardFieldTableData,
          $$CardFieldTableTableFilterComposer,
          $$CardFieldTableTableOrderingComposer,
          $$CardFieldTableTableAnnotationComposer,
          $$CardFieldTableTableCreateCompanionBuilder,
          $$CardFieldTableTableUpdateCompanionBuilder,
          (CardFieldTableData, $$CardFieldTableTableReferences),
          CardFieldTableData,
          PrefetchHooks Function({bool cardId})
        > {
  $$CardFieldTableTableTableManager(
    _$AppDatabase db,
    $CardFieldTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardFieldTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardFieldTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardFieldTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> cardId = const Value.absent(),
                Value<int> type = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String?> hintText = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CardFieldTableCompanion(
                id: id,
                cardId: cardId,
                type: type,
                value: value,
                hintText: hintText,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int cardId,
                required int type,
                required String value,
                Value<String?> hintText = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CardFieldTableCompanion.insert(
                id: id,
                cardId: cardId,
                type: type,
                value: value,
                hintText: hintText,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CardFieldTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
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
                    if (cardId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cardId,
                                referencedTable: $$CardFieldTableTableReferences
                                    ._cardIdTable(db),
                                referencedColumn:
                                    $$CardFieldTableTableReferences
                                        ._cardIdTable(db)
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

typedef $$CardFieldTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CardFieldTableTable,
      CardFieldTableData,
      $$CardFieldTableTableFilterComposer,
      $$CardFieldTableTableOrderingComposer,
      $$CardFieldTableTableAnnotationComposer,
      $$CardFieldTableTableCreateCompanionBuilder,
      $$CardFieldTableTableUpdateCompanionBuilder,
      (CardFieldTableData, $$CardFieldTableTableReferences),
      CardFieldTableData,
      PrefetchHooks Function({bool cardId})
    >;
typedef $$WalletTableTableCreateCompanionBuilder =
    WalletTableCompanion Function({
      Value<int> id,
      Value<String?> icon,
      required String title,
      required String seedPhrase,
      Value<bool> hasArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$WalletTableTableUpdateCompanionBuilder =
    WalletTableCompanion Function({
      Value<int> id,
      Value<String?> icon,
      Value<String> title,
      Value<String> seedPhrase,
      Value<bool> hasArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$WalletTableTableReferences
    extends BaseReferences<_$AppDatabase, $WalletTableTable, WalletTableData> {
  $$WalletTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WalletFieldTableTable, List<WalletFieldTableData>>
  _walletFieldTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.walletFieldTable,
    aliasName: $_aliasNameGenerator(
      db.walletTable.id,
      db.walletFieldTable.walletId,
    ),
  );

  $$WalletFieldTableTableProcessedTableManager get walletFieldTableRefs {
    final manager = $$WalletFieldTableTableTableManager(
      $_db,
      $_db.walletFieldTable,
    ).filter((f) => f.walletId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _walletFieldTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WalletTableTableFilterComposer
    extends Composer<_$AppDatabase, $WalletTableTable> {
  $$WalletTableTableFilterComposer({
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

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seedPhrase => $composableBuilder(
    column: $table.seedPhrase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasArchived => $composableBuilder(
    column: $table.hasArchived,
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

  Expression<bool> walletFieldTableRefs(
    Expression<bool> Function($$WalletFieldTableTableFilterComposer f) f,
  ) {
    final $$WalletFieldTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.walletFieldTable,
      getReferencedColumn: (t) => t.walletId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletFieldTableTableFilterComposer(
            $db: $db,
            $table: $db.walletFieldTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WalletTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletTableTable> {
  $$WalletTableTableOrderingComposer({
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

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seedPhrase => $composableBuilder(
    column: $table.seedPhrase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasArchived => $composableBuilder(
    column: $table.hasArchived,
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

class $$WalletTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletTableTable> {
  $$WalletTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get seedPhrase => $composableBuilder(
    column: $table.seedPhrase,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasArchived => $composableBuilder(
    column: $table.hasArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> walletFieldTableRefs<T extends Object>(
    Expression<T> Function($$WalletFieldTableTableAnnotationComposer a) f,
  ) {
    final $$WalletFieldTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.walletFieldTable,
      getReferencedColumn: (t) => t.walletId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletFieldTableTableAnnotationComposer(
            $db: $db,
            $table: $db.walletFieldTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WalletTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalletTableTable,
          WalletTableData,
          $$WalletTableTableFilterComposer,
          $$WalletTableTableOrderingComposer,
          $$WalletTableTableAnnotationComposer,
          $$WalletTableTableCreateCompanionBuilder,
          $$WalletTableTableUpdateCompanionBuilder,
          (WalletTableData, $$WalletTableTableReferences),
          WalletTableData,
          PrefetchHooks Function({bool walletFieldTableRefs})
        > {
  $$WalletTableTableTableManager(_$AppDatabase db, $WalletTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> seedPhrase = const Value.absent(),
                Value<bool> hasArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WalletTableCompanion(
                id: id,
                icon: icon,
                title: title,
                seedPhrase: seedPhrase,
                hasArchived: hasArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                required String title,
                required String seedPhrase,
                Value<bool> hasArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WalletTableCompanion.insert(
                id: id,
                icon: icon,
                title: title,
                seedPhrase: seedPhrase,
                hasArchived: hasArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WalletTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({walletFieldTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (walletFieldTableRefs) db.walletFieldTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (walletFieldTableRefs)
                    await $_getPrefetchedData<
                      WalletTableData,
                      $WalletTableTable,
                      WalletFieldTableData
                    >(
                      currentTable: table,
                      referencedTable: $$WalletTableTableReferences
                          ._walletFieldTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$WalletTableTableReferences(
                            db,
                            table,
                            p0,
                          ).walletFieldTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.walletId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WalletTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalletTableTable,
      WalletTableData,
      $$WalletTableTableFilterComposer,
      $$WalletTableTableOrderingComposer,
      $$WalletTableTableAnnotationComposer,
      $$WalletTableTableCreateCompanionBuilder,
      $$WalletTableTableUpdateCompanionBuilder,
      (WalletTableData, $$WalletTableTableReferences),
      WalletTableData,
      PrefetchHooks Function({bool walletFieldTableRefs})
    >;
typedef $$WalletFieldTableTableCreateCompanionBuilder =
    WalletFieldTableCompanion Function({
      Value<int> id,
      required int walletId,
      required int type,
      required String value,
      Value<String?> hintText,
      Value<int> order,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$WalletFieldTableTableUpdateCompanionBuilder =
    WalletFieldTableCompanion Function({
      Value<int> id,
      Value<int> walletId,
      Value<int> type,
      Value<String> value,
      Value<String?> hintText,
      Value<int> order,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$WalletFieldTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WalletFieldTableTable,
          WalletFieldTableData
        > {
  $$WalletFieldTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WalletTableTable _walletIdTable(_$AppDatabase db) =>
      db.walletTable.createAlias(
        $_aliasNameGenerator(db.walletFieldTable.walletId, db.walletTable.id),
      );

  $$WalletTableTableProcessedTableManager get walletId {
    final $_column = $_itemColumn<int>('wallet_id')!;

    final manager = $$WalletTableTableTableManager(
      $_db,
      $_db.walletTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_walletIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WalletFieldTableTableFilterComposer
    extends Composer<_$AppDatabase, $WalletFieldTableTable> {
  $$WalletFieldTableTableFilterComposer({
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

  ColumnFilters<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hintText => $composableBuilder(
    column: $table.hintText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
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

  $$WalletTableTableFilterComposer get walletId {
    final $$WalletTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletTableTableFilterComposer(
            $db: $db,
            $table: $db.walletTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalletFieldTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletFieldTableTable> {
  $$WalletFieldTableTableOrderingComposer({
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

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hintText => $composableBuilder(
    column: $table.hintText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
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

  $$WalletTableTableOrderingComposer get walletId {
    final $$WalletTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletTableTableOrderingComposer(
            $db: $db,
            $table: $db.walletTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalletFieldTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletFieldTableTable> {
  $$WalletFieldTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get hintText =>
      $composableBuilder(column: $table.hintText, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WalletTableTableAnnotationComposer get walletId {
    final $$WalletTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletTableTableAnnotationComposer(
            $db: $db,
            $table: $db.walletTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalletFieldTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalletFieldTableTable,
          WalletFieldTableData,
          $$WalletFieldTableTableFilterComposer,
          $$WalletFieldTableTableOrderingComposer,
          $$WalletFieldTableTableAnnotationComposer,
          $$WalletFieldTableTableCreateCompanionBuilder,
          $$WalletFieldTableTableUpdateCompanionBuilder,
          (WalletFieldTableData, $$WalletFieldTableTableReferences),
          WalletFieldTableData,
          PrefetchHooks Function({bool walletId})
        > {
  $$WalletFieldTableTableTableManager(
    _$AppDatabase db,
    $WalletFieldTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletFieldTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletFieldTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletFieldTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> walletId = const Value.absent(),
                Value<int> type = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String?> hintText = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WalletFieldTableCompanion(
                id: id,
                walletId: walletId,
                type: type,
                value: value,
                hintText: hintText,
                order: order,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int walletId,
                required int type,
                required String value,
                Value<String?> hintText = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WalletFieldTableCompanion.insert(
                id: id,
                walletId: walletId,
                type: type,
                value: value,
                hintText: hintText,
                order: order,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WalletFieldTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({walletId = false}) {
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
                    if (walletId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.walletId,
                                referencedTable:
                                    $$WalletFieldTableTableReferences
                                        ._walletIdTable(db),
                                referencedColumn:
                                    $$WalletFieldTableTableReferences
                                        ._walletIdTable(db)
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

typedef $$WalletFieldTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalletFieldTableTable,
      WalletFieldTableData,
      $$WalletFieldTableTableFilterComposer,
      $$WalletFieldTableTableOrderingComposer,
      $$WalletFieldTableTableAnnotationComposer,
      $$WalletFieldTableTableCreateCompanionBuilder,
      $$WalletFieldTableTableUpdateCompanionBuilder,
      (WalletFieldTableData, $$WalletFieldTableTableReferences),
      WalletFieldTableData,
      PrefetchHooks Function({bool walletId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserTableTableTableManager get userTable =>
      $$UserTableTableTableManager(_db, _db.userTable);
  $$CollectionTableTableTableManager get collectionTable =>
      $$CollectionTableTableTableManager(_db, _db.collectionTable);
  $$PasswordTableTableTableManager get passwordTable =>
      $$PasswordTableTableTableManager(_db, _db.passwordTable);
  $$CollectionItemTableTableTableManager get collectionItemTable =>
      $$CollectionItemTableTableTableManager(_db, _db.collectionItemTable);
  $$PasswordFieldTableTableTableManager get passwordFieldTable =>
      $$PasswordFieldTableTableTableManager(_db, _db.passwordFieldTable);
  $$CardTableTableTableManager get cardTable =>
      $$CardTableTableTableManager(_db, _db.cardTable);
  $$CardFieldTableTableTableManager get cardFieldTable =>
      $$CardFieldTableTableTableManager(_db, _db.cardFieldTable);
  $$WalletTableTableTableManager get walletTable =>
      $$WalletTableTableTableManager(_db, _db.walletTable);
  $$WalletFieldTableTableTableManager get walletFieldTable =>
      $$WalletFieldTableTableTableManager(_db, _db.walletFieldTable);
}
