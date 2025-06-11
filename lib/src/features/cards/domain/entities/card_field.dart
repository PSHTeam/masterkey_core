import 'package:equatable/equatable.dart';

class CardField extends Equatable {
  final int? id;
  final int cardId;
  final int type;
  final String value;
  final DateTime createdAt;

  const CardField({
    this.id,
    required this.cardId,
    required this.type,
    required this.value,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, cardId, type, value, createdAt];
}
