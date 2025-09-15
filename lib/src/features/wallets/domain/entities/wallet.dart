import 'package:masterkey_core/src/src.dart';

class Wallet extends BaseEntity {
  final int id;
  final String title;
  final String seedPhrase;
  final bool hasArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Wallet({
    required this.id,
    required this.title,
    required this.seedPhrase,
    required this.hasArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  List<Object?> get props => [id, title, hasArchived, createdAt, updatedAt];
}
