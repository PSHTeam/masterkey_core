import 'package:dartz/dartz.dart' show Left, Right;
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@LazySingleton(as: PasswordRepository)
class PasswordRepositoryImpl implements PasswordRepository {
  final PasswordLocalDatasource datasource;

  PasswordRepositoryImpl(this.datasource);

  @override
  FailureOr<Password> addPassword(PasswordModel password) async {
    try {
      final responce = await datasource.addPassword(password);
      return Right(responce.toEntity());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<bool> deletePassword(int passwordId) async {
    try {
      final responce = await datasource.deletePassword(passwordId);
      return Right(responce);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<List<Password>> getAllPasswords(
    GetAllPasswordsParams params,
  ) async {
    try {
      final List<PasswordModel> responce = await datasource.getAllPasswords(
        params,
      );
      return Right(responce.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<Password> updatePassword(UpdatePasswordParams params) async {
    try {
      final responce = await datasource.updatePassword(params);
      return Right(responce);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<Password> toggle2FA(Toggle2FAParams params) async {
    try {
      final responce = await datasource.toggle2FA(params);
      return Right(responce.toEntity());
    } catch (e) {
      // log(e.toString());
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<Password> toggleArchiveStatus(
    TogglePasswordArchiveParams params,
  ) async {
    try {
      final responce = await datasource.toggleArchiveStatus(params);
      return Right(responce.toEntity());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<bool> deletePasswords(NoParams params) async {
    try {
      final responce = await datasource.deletePasswords(params);
      return Right(responce);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
