import 'package:masterkey_core/src/src.dart' show FieldEntity, FieldType;

class PasswordField extends FieldEntity {
  final int? passwordId;
  final FieldType type;
  final int order;
  final String value;

  const PasswordField({
    super.id,
    this.passwordId,
    required this.type,
    required this.order,
    required this.value,
    required super.createdAt,
    required super.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    passwordId,
    type,
    order,
    value,
    createdAt,
    updatedAt,
  ];

  factory PasswordField.fromCubit(FieldType type, int order) {
    return PasswordField(
      type: type,
      order: order,
      value: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory PasswordField.fake({FieldType type = FieldType.email}) {
    return PasswordField(
      id: -1,
      passwordId: 1,
      type: type,
      order: 0,
      value: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  PasswordField copyWith({
    int? id,
    int? passwordId,
    FieldType? type,
    int? order,
    String? value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PasswordField(
      id: id ?? this.id,
      passwordId: passwordId ?? this.passwordId,
      type: type ?? this.type,
      order: order ?? this.order,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PasswordField.authCode({
    required int passwordId,
    required String value,
  }) {
    return PasswordField(
      id: -1,
      passwordId: passwordId,
      type: FieldType.authCode,
      order: 0,
      value: value,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
  }
}
