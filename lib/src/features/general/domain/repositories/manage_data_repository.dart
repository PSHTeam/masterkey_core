import 'package:masterkey_core/src/src.dart';

abstract class ManageDataRepository {
  FailureOr<bool> backupDatabase(BackupDatabaseParams params);
  FailureOr<bool> restoreBackup(RestoreBackupParams params);
  FailureOr<bool> deleteDatabase();
  FailureOr<bool> resetTheApp();
}
