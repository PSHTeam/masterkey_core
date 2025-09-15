import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:masterkey_core/src/src.dart';
import 'package:masterkey_core/dependency_injection.dart';

abstract class ManageLocalDatasource {
  Future<bool> backupDatabase(BackupDatabaseParams params);
  Future<bool> restoreBackup(RestoreBackupParams params);
  Future<bool> deleteDatabase();
  Future<bool> resetTheApp();
}

@LazySingleton(as: ManageLocalDatasource)
class ManageLocalDatasourceImpl implements ManageLocalDatasource {
  final AppDatabaseWrapper appDatabase;
  final SharedPreferences sharedPreferences;
  final Directory resourcesDir;

  const ManageLocalDatasourceImpl(
    this.appDatabase,
    this.sharedPreferences,
    this.resourcesDir,
  );

  @override
  Future<bool> backupDatabase(BackupDatabaseParams params) async {
    final backupPath = await BackupRestoreService.backup(
      zipName: AppDatabaseWrapper.backupNameZip,
      resourcesDir: resourcesDir,
      sharedPreferences: sharedPreferences,
    );
    return backupPath;
  }

  @override
  Future<bool> restoreBackup(RestoreBackupParams params) async {
    final backupPath = await BackupRestoreService.restore(
      params.path,
      params.password,
      appDatabase: appDatabase,
      resourcesDir: resourcesDir,
      sharedPreferences: sharedPreferences,
    );
    return backupPath;
  }

  @override
  Future<bool> deleteDatabase({bool reset = false}) async {
    await appDatabase.db.batch((batch) {
      batch.deleteAll(appDatabase.db.collectionItemTable);
      batch.deleteAll(appDatabase.db.passwordFieldTable);
      batch.deleteAll(appDatabase.db.passwordTable);
      batch.deleteAll(appDatabase.db.cardTable);
      batch.deleteAll(appDatabase.db.cardFieldTable);
      batch.deleteAll(appDatabase.db.walletTable);
      if (reset) {
        batch.deleteAll(appDatabase.db.userTable);
        batch.deleteAll(appDatabase.db.collectionTable);
      }
    });
    List<String> expectedImages = [];
    if (!reset) {
      expectedImages.addAll(
        await appDatabase.db.collectionDao.getAllCollectionsImages(),
      );
    }
    await deleteImages(expectedImages);
    return true;
  }

  @override
  Future<bool> resetTheApp() async {
    try {
      await sharedPreferences.clear();
      await deleteDatabase(reset: true);
      await appDatabase.db.close();
      await Future.delayed(const Duration(milliseconds: 500));
      await sl.unregister<DatabaseEncryptorService>();
      appDatabase.db = AppDatabase();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteImages(List<String> exceptions) async {
    final allFiles = resourcesDir.list(recursive: false, followLinks: false);
    await for (var file in allFiles) {
      final name = file.uri.pathSegments.last;
      if (file is File && name.isImage && !exceptions.contains(name)) {
        await file.delete();
      }
    }
  }
}
