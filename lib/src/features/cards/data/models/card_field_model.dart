import 'package:drift/drift.dart';
import 'package:masterkey_core/src/src.dart';

class CardFieldModel extends CardField {
  const CardFieldModel({
    super.id,
    required super.cardId,
    required super.type,
    required super.value,
    required super.createdAt,
  });

  factory CardFieldModel.fromTableData(CardFieldTableData data) {
    return CardFieldModel(
      id: data.id,
      cardId: data.cardId,
      type: data.type,
      value: data.value,
      createdAt: data.createdAt,
    );
  }

  CardFieldTableCompanion toTableCompanion() {
    return CardFieldTableCompanion(
      cardId: Value(cardId),
      type: Value(type),
      value: Value(value),
      createdAt: Value(createdAt),
    );
  }

  CardField toEntity() {
    return CardField(
      id: id,
      cardId: cardId,
      type: type,
      value: value,
      createdAt: createdAt,
    );
  }

  factory CardFieldModel.fromEntity(CardField entity) {
    return CardFieldModel(
      id: entity.id,
      cardId: entity.cardId,
      type: entity.type,
      value: entity.value,
      createdAt: entity.createdAt,
    );
  }

  CardFieldModel copyWith({
    int? id,
    int? cardId,
    int? type,
    String? value,
    DateTime? createdAt,
  }) {
    return CardFieldModel(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      type: type ?? this.type,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
