import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

abstract class PasswordLocalDatasource {
  Future<PasswordModel> addPassword(PasswordModel password);
  Future<PasswordModel> updatePassword(UpdatePasswordParams params);
  Future<bool> deletePassword(int passwordId);
  Future<List<PasswordModel>> getAllPasswords(GetAllPasswordsParams params);
  Future<bool> deletePasswords(NoParams params);

  // enable 2FA
  Future<PasswordModel> toggle2FA(Toggle2FAParams params);
  // Toggle Archive Status
  Future<PasswordModel> toggleArchiveStatus(TogglePasswordArchiveParams params);
}

@LazySingleton(as: PasswordLocalDatasource)
class PasswordLocalDatasourceImpl implements PasswordLocalDatasource {
  final AppDatabaseWrapper appDatabase;
  final Directory resourcesDir;
  const PasswordLocalDatasourceImpl(this.appDatabase, this.resourcesDir);

  @override
  Future<PasswordModel> addPassword(PasswordModel password) async {
    try {
      final newId = await appDatabase.db.passwordDao.insertPassword(
        password.toTableCompanion(),
      );

      await appDatabase.db.passwordDao.insertPasswordFields(
        passwordId: newId,
        passwordFields: password.passwordFields
            .map(
              (e) => PasswordFieldModel.fromEntity(
                e.copyWith(
                  passwordId: newId,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              ).toTableCompanion(),
            )
            .toList(),
      );

      return await getPasswordInfo(newId);
    } catch (e) {
      throw CustomFailure("$e");
    }
  }

  @override
  Future<PasswordModel> updatePassword(UpdatePasswordParams params) async {
    final updatedRows = await appDatabase.db.passwordDao.updatePassword(params);
    if (updatedRows == 0) throw UnknownFailure();

    return await getPasswordInfo(params.id);
  }

  @override
  Future<bool> deletePassword(int passwordId) async {
    final response = await appDatabase.db.passwordDao.deletePassword(
      passwordId,
      resourcesDir,
    );
    if (response == 0) throw UnknownFailure();
    return response != 0;
  }

  @override
  Future<List<PasswordModel>> getAllPasswords(
    GetAllPasswordsParams params,
  ) async {
    try {
      final passwordlist = await appDatabase.db.passwordDao.getPasswords(
        params,
      );
      if (passwordlist.isEmpty) return [];
      List<PasswordModel> passwords = [
        for (PasswordTableData password in passwordlist)
          await getPasswordInfo(password.id),
      ];

      return passwords;
    } catch (e) {
      throw CustomFailure(e.toString());
    }
  }

  @override
  Future<bool> deletePasswords(NoParams params) async {
    final response = await appDatabase.db.passwordDao.deletePasswords();
    if (response == 0) throw UnknownFailure();

    return response != 0;
  }

  @override
  Future<PasswordModel> toggle2FA(Toggle2FAParams params) async {
    final updateId = await appDatabase.db.passwordDao.toggle2FA(params);
    if (updateId == 0) throw UnknownFailure();

    return await getPasswordInfo(params.id);
  }

  @override
  Future<PasswordModel> toggleArchiveStatus(
    TogglePasswordArchiveParams params,
  ) async {
    final updateId = await appDatabase.db.passwordDao.toggleArchiveStatus(
      params,
    );
    if (updateId == 0) throw UnknownFailure();

    try {
      return await getPasswordInfo(params.id);
    } catch (e) {
      throw CustomFailure(e.toString());
    }
  }

  Future<PasswordModel> getPasswordInfo(int paramsId) async {
    final newPassword = await appDatabase.db.passwordDao.getPasswordById(
      paramsId,
    );
    List<PasswordFieldTableData> getFields = await appDatabase.db.passwordDao
        .getPasswordFields(paramsId);
    if (newPassword == null) throw UnknownFailure();
    final List<PasswordFieldModel> passwordFields = [];
    try {
      for (PasswordFieldTableData field in getFields) {
        passwordFields.add(PasswordFieldModel.fromTableData(field));
      }

      final response = PasswordModel.fromTableData(
        newPassword,
        passwordFields: passwordFields,
        resourcesDir: resourcesDir,
      );
      return response;
    } catch (e) {
      throw CustomFailure(e.toString());
    }
  }
}
