import 'dart:io' show Directory;

import 'package:drift/drift.dart';
import 'package:masterkey_core/src/src.dart';

import 'package:path/path.dart' show join;

class CollectionModel extends Collection {
  const CollectionModel({
    super.id,
    required super.name,
    required super.iconPath,
    required super.passwords,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CollectionModel.fromTableData(
    CollectionTableData data, {
    List<PasswordModel> passwords = const [],
    required Directory resourcesDir,
  }) {
    String iconPath = data.iconPath;
    if (iconPath.isImage) iconPath = join(resourcesDir.path, iconPath);
    return CollectionModel(
      id: data.id,
      name: data.name!,
      iconPath: getIconEntityFromString(iconPath),
      passwords: passwords.map((e) => e.toEntity()).toList(),
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  CollectionTableCompanion toTableCompanion() {
    return CollectionTableCompanion(
      name: Value(name),
      iconPath: Value(iconPath.value),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  Collection toEntity() {
    return Collection(
      id: id,
      name: name,
      iconPath: iconPath,
      passwords: passwords,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory CollectionModel.fromEntity(Collection entity) {
    return CollectionModel(
      id: entity.id,
      name: entity.name,
      iconPath: entity.iconPath,
      passwords: entity.passwords,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  @override
  CollectionModel copyWith({
    int? id,
    String? name,
    IconEntity? iconPath,
    List<Password>? passwords,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CollectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
      passwords: passwords ?? this.passwords,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
