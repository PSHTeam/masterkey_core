import 'package:drift/drift.dart';
import 'package:masterkey_core/src/src.dart';

class PasswordFieldModel extends PasswordField {
  const PasswordFieldModel({
    super.id,
    required super.passwordId,
    required super.type,
    required super.order,
    required super.value,
    required super.createdAt,
    required super.updatedAt,
  });

  factory PasswordFieldModel.fromTableData(PasswordFieldTableData field) {
    return PasswordFieldModel(
      id: field.id,
      passwordId: field.passwordId,
      order: field.order,
      type: FieldType.values[field.type],
      value: field.value,
      createdAt: field.createdAt,
      updatedAt: field.updatedAt,
    );
  }

  PasswordFieldTableCompanion toTableCompanion() {
    return PasswordFieldTableCompanion(
      id: id != null ? Value(id!) : Value.absent(),
      passwordId: Value(passwordId!),
      value: Value(value),
      order: Value(order),
      type: Value(type.index),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  PasswordField toEntity() {
    return PasswordField(
      id: id,
      passwordId: passwordId,
      type: type,
      order: order,
      value: value,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory PasswordFieldModel.fromEntity(PasswordField entity) {
    return PasswordFieldModel(
      id: entity.id,
      passwordId: entity.passwordId,
      type: entity.type,
      order: entity.order,
      value: entity.value,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
