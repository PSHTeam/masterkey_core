import 'package:masterkey_core/src/core/core.dart'
    show IconEntity, getIconEntityFromString;
import 'package:masterkey_core/src/src.dart' show BaseEntity, Password;

class Collection extends BaseEntity {
  final int? id;
  final String name;
  final IconEntity iconPath;
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
      iconPath: getIconEntityFromString("G.it"),
      passwords: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Collection copyWith({
    int? id,
    String? name,
    IconEntity? iconPath,
    List<Password>? passwords,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
      passwords: passwords ?? this.passwords,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
