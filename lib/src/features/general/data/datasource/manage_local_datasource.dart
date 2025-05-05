import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:masterkey_core/dependency_injection.dart';
import 'package:masterkey_core/src/src.dart';

abstract class ManageLocalDatasource {
  Future<bool> backupDatabase(BackupDatabaseParams params);
  Future<bool> restoreBackup(RestoreBackupParams params);
  Future<bool> deleteDatabase();
  Future<bool> resetTheApp();
}

@LazySingleton(as: ManageLocalDatasource)
class ManageLocalDatasourceImpl implements ManageLocalDatasource {
  final AppDatabase appDatabase;
  final SharedPreferences prefs;
  final Directory cacheDir;

  const ManageLocalDatasourceImpl(this.appDatabase, this.prefs, this.cacheDir);

  @override
  Future<bool> backupDatabase(BackupDatabaseParams params) async {
    final backupPath = await BackupRestoreServices.backup(
      zipName: AppDatabase.backupNameZip,
      cacheDir: cacheDir,
      prefs: prefs,
    );
    return backupPath;
    // return BackupModel(
    //   backupPath: backupPath.$1,
    //   backupSize: backupPath.$2,
    //   lastBackupUpdate: backupPath.$3,
    // );
  }

  @override
  Future<bool> restoreBackup(RestoreBackupParams params) async {
    final backupPath = await BackupRestoreServices.restore(
      params.path,
      params.password,
      cacheDir: cacheDir,
      prefs: prefs,
    );
    // log('restore backup path: $backupPath');
    return backupPath;
  }

  @override
  Future<bool> deleteDatabase({bool reset = false}) async {
    await appDatabase.batch((batch) {
      batch.deleteAll(appDatabase.categoryItemTable);
      batch.deleteAll(appDatabase.passwordFieldTable);
      batch.deleteAll(appDatabase.passwordTable);
      batch.deleteAll(appDatabase.cardTable);
      batch.deleteAll(appDatabase.cardFieldTable);
      batch.deleteAll(appDatabase.walletTable);
      if (reset) {
        batch.deleteAll(appDatabase.userTable);
        batch.deleteAll(appDatabase.categoryTable);
      }
    });
    List<String> expectedImages = [];
    if (!reset) {
      expectedImages.addAll(
        await appDatabase.categoryDao.getAllCategoriesImages(),
      );
    }
    final allFiles = cacheDir.list(recursive: false, followLinks: false);
    await for (var file in allFiles) {
      final name = file.uri.pathSegments.last;
      if (file is File &&
          name.endsWith('.png') &&
          !expectedImages.contains(name)) {
        await file.delete();
      }
    }
    return true;
  }

  @override
  Future<bool> resetTheApp() async {
    try {
      await prefs.clear();
      await deleteDatabase(reset: true);
      await appDatabase.close();
      final allFiles = cacheDir.list(recursive: false, followLinks: false);
      await for (var file in allFiles) {
        if (file is File && file.uri.pathSegments.last.endsWith('.png')) {
          await file.delete();
        }
      }
      await Future.delayed(const Duration(milliseconds: 500));
      await sl.unregister<DatabaseEncryptorService>();
      return false;
    } catch (e) {
      return false;
    }
  }
}
