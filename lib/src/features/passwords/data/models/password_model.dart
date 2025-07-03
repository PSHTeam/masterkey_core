import 'dart:io' show Directory;

import 'package:drift/drift.dart';
import 'package:masterkey_core/src/src.dart';
import 'package:path/path.dart';

class PasswordModel extends Password {
  const PasswordModel({
    super.id,
    required super.title,
    required super.iconPath,
    required super.has2fa,
    super.authKey,
    required super.hasArchived,
    required super.passwordFields,
    required super.createdAt,
    required super.updatedAt,
  });

  factory PasswordModel.fromTableData(
    PasswordTableData data, {
    List<PasswordFieldModel> passwordFields = const [],
    required Directory resourcesDir,
  }) {
    String iconPath = data.iconPath;
    if (iconPath.isImage) iconPath = join(resourcesDir.path, iconPath);

    return PasswordModel(
      id: data.id,
      title: data.title,
      iconPath: getIconEntityFromString(iconPath),
      has2fa: data.has2fa,
      authKey: data.authKey,
      hasArchived: data.hasArchived,
      passwordFields: passwordFields.map((e) => e.toEntity()).toList(),
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  PasswordTableCompanion toTableCompanion() {
    return PasswordTableCompanion(
      title: Value(title),
      iconPath: Value(iconPath.value),
      has2fa: Value(has2fa),
      authKey: authKey != null ? Value(authKey) : Value.absent(),
      hasArchived: Value(hasArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  Password toEntity() {
    return Password(
      id: id,
      title: title,
      iconPath: iconPath,
      has2fa: has2fa,
      authKey: authKey,
      hasArchived: hasArchived,
      passwordFields: passwordFields,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory PasswordModel.fromEntity(Password entity) {
    return PasswordModel(
      id: entity.id,
      title: entity.title,
      iconPath: entity.iconPath,
      has2fa: entity.has2fa,
      authKey: entity.authKey,
      hasArchived: entity.hasArchived,
      passwordFields: entity.passwordFields,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
