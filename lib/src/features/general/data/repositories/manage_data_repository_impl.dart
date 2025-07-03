import 'package:dartz/dartz.dart' show Left, Right;
import 'package:injectable/injectable.dart';

import 'package:masterkey_core/src/src.dart';

@LazySingleton(as: ManageDataRepository)
class ManageDataRepositoryImpl implements ManageDataRepository {
  final ManageLocalDatasource datasource;

  ManageDataRepositoryImpl(this.datasource);

  @override
  FailureOr<bool> backupDatabase(BackupDatabaseParams params) async {
    try {
      final backupPath = await datasource.backupDatabase(params);
      return Right(backupPath);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }

  @override
  FailureOr<bool> restoreBackup(RestoreBackupParams params) async {
    try {
      final result = await datasource.restoreBackup(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }

  @override
  FailureOr<bool> deleteDatabase() async {
    try {
      final result = await datasource.deleteDatabase();
      return Right(result);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<bool> resetTheApp() async {
    try {
      final result = await datasource.resetTheApp();
      return Right(result);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
