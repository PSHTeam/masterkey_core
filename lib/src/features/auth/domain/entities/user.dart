import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String masterPassword;
  final String? masterHint;
  final DateTime createdAt;

  const User({
    this.id,
    required this.masterPassword,
    required this.masterHint,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, masterPassword, masterHint, createdAt];
}
