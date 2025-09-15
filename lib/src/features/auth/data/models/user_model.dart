import 'package:drift/drift.dart';
import 'package:masterkey_core/src/src.dart';

class UserModel extends User {
  const UserModel({
    super.id,
    required super.masterPassword,
    super.masterHint,
    required super.createdAt,
  });

  factory UserModel.fromTableData(UserTableData tableData) {
    return UserModel(
      id: tableData.id,
      masterPassword: tableData.password,
      masterHint: tableData.passwordHint,
      createdAt: tableData.createdAt,
    );
  }

  UserTableCompanion toTableCompanion() {
    return UserTableCompanion(
      password: Value((masterPassword)),
      passwordHint: masterHint != null
          ? Value(masterHint)
          : const Value.absent(),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
  }

  User toEntity() {
    return User(
      id: id,
      masterPassword: masterPassword,
      masterHint: masterHint,
      createdAt: createdAt,
    );
  }

  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      masterPassword: entity.masterPassword,
      masterHint: entity.masterHint,
      createdAt: entity.createdAt,
    );
  }
}
