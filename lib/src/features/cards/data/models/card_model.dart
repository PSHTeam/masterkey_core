import 'package:drift/drift.dart';
import 'package:masterkey_core/src/src.dart';

class CardModel extends CardEntity {
  const CardModel({
    super.id,
    required super.title,
    required super.holderName,
    required super.number,
    required super.expireDate,
    required super.cvv,
    required super.hasPin,
    required super.pin,
    required super.fields,
    required super.hasArchived,
    required super.styleIndex,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CardModel.fromTableData(
    CardTableData tableData, {
    List<CardFieldTableData> fields = const [],
  }) {
    return CardModel(
      id: tableData.id,
      title: tableData.title,
      holderName: tableData.holderName,
      number: int.parse(tableData.number),
      expireDate: tableData.expireDate,
      cvv: int.parse(tableData.cvv),
      hasPin: tableData.hasPin,
      pin: int.parse(tableData.pin ?? 0.toString()),
      styleIndex: tableData.styleIndex,
      fields: fields
          .map((e) => CardFieldModel.fromTableData(e).toEntity())
          .toList(),
      hasArchived: tableData.hasArchived,
      createdAt: tableData.createdAt,
      updatedAt: tableData.updatedAt,
    );
  }

  CardTableCompanion toTableCompanion() {
    return CardTableCompanion(
      title: Value(title),
      holderName: Value(holderName),
      number: Value(number.toString()),
      expireDate: Value(expireDate),
      cvv: Value(cvv.toString()),
      hasPin: Value(hasPin),
      pin: Value(pin.toString()),
      styleIndex: Value(styleIndex),
      hasArchived: Value(hasArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  CardEntity toEntity() {
    return CardEntity(
      id: id,
      title: title,
      holderName: holderName,
      number: number,
      expireDate: expireDate,
      cvv: cvv,
      hasPin: hasPin,
      pin: pin,
      fields: fields,
      hasArchived: hasArchived,
      styleIndex: styleIndex,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory CardModel.fromEntity(CardEntity entity) {
    return CardModel(
      id: entity.id,
      title: entity.title,
      holderName: entity.holderName,
      number: entity.number,
      expireDate: entity.expireDate,
      cvv: entity.cvv,
      hasPin: entity.hasPin,
      pin: entity.pin,
      hasArchived: entity.hasArchived,
      fields: entity.fields,
      styleIndex: entity.styleIndex,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  CardModel copyWith({
    int? id,
    String? title,
    String? holderName,
    int? number,
    DateTime? expireDate,
    int? cvv,
    bool? hasPin,
    int? pin,
    int? styleIndex,
    bool? hasArchived,
    List<CardField>? fields,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      holderName: holderName ?? this.holderName,
      number: number ?? this.number,
      expireDate: expireDate ?? this.expireDate,
      cvv: cvv ?? this.cvv,
      hasPin: hasPin ?? this.hasPin,
      pin: pin ?? this.pin,
      styleIndex: styleIndex ?? this.styleIndex,
      hasArchived: hasArchived ?? this.hasArchived,
      fields: fields ?? this.fields,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
