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
    return await BackupRestoreService.backup(
      zipName: AppDatabaseWrapper.backupNameZip,
      cacheDir: cacheDir,
      prefs: prefs,
    );
  }

  @override
  Future<bool> restoreBackup(RestoreBackupParams params) async {
    return await BackupRestoreService.restore(
      params.path,
      params.password,
      cacheDir: cacheDir,
      prefs: prefs,
    );
  }

  @override
  Future<bool> deleteDatabase({bool reset = false}) async {
    await appDatabase.batch((batch) {
      batch.deleteAll(appDatabase.collectionItemTable);
      batch.deleteAll(appDatabase.passwordFieldTable);
      batch.deleteAll(appDatabase.passwordTable);
      batch.deleteAll(appDatabase.cardTable);
      batch.deleteAll(appDatabase.cardFieldTable);
      batch.deleteAll(appDatabase.walletTable);
      if (reset) {
        batch.deleteAll(appDatabase.userTable);
        batch.deleteAll(appDatabase.collectionTable);
      }
    });
    List<String> expectedImages = [];
    if (!reset) {
      expectedImages.addAll(
        await appDatabase.collectionDao.getAllCollectionsImages(),
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
      await Future.delayed(Duration(milliseconds: 300));
      await sl.unregister<DatabaseEncryptorService>();
      return true;
    } catch (e) {
      return false;
    }
  }
}
