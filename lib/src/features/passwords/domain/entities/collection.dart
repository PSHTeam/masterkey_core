import 'package:masterkey_core/src/src.dart' show BaseEntity, Password;

class Collection extends BaseEntity {
  final int? id;
  final String name;
  final String iconPath;
  final List<Password> passwords;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Collection({
    this.id,
    required this.name,
    required this.iconPath,
    required this.passwords,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    iconPath,
    passwords,
    createdAt,
    updatedAt,
  ];

  factory Collection.fake() {
    return Collection(
      id: -1,
      name: "Google",
      iconPath: "",
      passwords: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
