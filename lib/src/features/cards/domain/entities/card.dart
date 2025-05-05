import 'package:masterkey_core/src/src.dart' show BaseEntity, CardField;

class CardEntity extends BaseEntity {
  final int? id;
  final String title;
  final String holderName;
  final int number;
  final DateTime expireDate;
  final int cvv;
  final bool hasPin;
  final int pin;
  final int styleIndex;
  final List<CardField> fields;
  final bool hasArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CardEntity({
    this.id,
    required this.title,
    required this.holderName,
    required this.number,
    required this.expireDate,
    required this.cvv,
    required this.hasPin,
    required this.pin,
    required this.styleIndex,
    required this.fields,
    required this.hasArchived,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    holderName,
    number,
    expireDate,
    cvv,
    hasPin,
    pin,
    styleIndex,
    hasArchived,
    fields,
    createdAt,
    updatedAt,
  ];

  factory CardEntity.fake({bool isRTL = false}) {
    return CardEntity(
      id: -1,
      title: 'Card Title',
      holderName: isRTL ? "Ahmed Ali" : 'John Wick',
      number: 4242424242424242,
      expireDate: DateTime.now()..add(const Duration(days: 365)),
      cvv: 123,
      hasPin: true,
      pin: 1234,
      hasArchived: false,
      styleIndex: 0,
      fields: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
