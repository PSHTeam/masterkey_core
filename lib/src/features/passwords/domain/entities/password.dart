import 'package:masterkey_core/src/src.dart'
    show BaseEntity, PasswordField, IconEntity, TextIcon;

class Password extends BaseEntity {
  final int? id;
  final String title;
  final IconEntity iconPath;
  final bool has2fa;
  final String? authKey;
  final bool hasArchived;
  final List<PasswordField> passwordFields;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Password({
    this.id,
    required this.title,
    required this.iconPath,
    required this.has2fa,
    this.authKey,
    required this.hasArchived,
    required this.passwordFields,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    iconPath,
    has2fa,
    authKey,
    hasArchived,
    passwordFields,
    createdAt,
    updatedAt,
  ];

  factory Password.fake() {
    return Password(
      id: -1,
      title: "PSHTeam Udemy",
      iconPath: TextIcon("PSH.ti"),
      has2fa: true,
      authKey: "jnms kisyb nmgb lmkou vbnhx",
      hasArchived: false,
      passwordFields: [
        PasswordField.fake(),
        PasswordField.fake(),
        PasswordField.fake(),
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
