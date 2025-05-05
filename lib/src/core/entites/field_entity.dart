import 'package:equatable/equatable.dart';

class FieldEntity extends Equatable {
  final int? id;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FieldEntity({
    this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, createdAt, updatedAt];

  factory FieldEntity.fake() {
    return FieldEntity(
      id: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
