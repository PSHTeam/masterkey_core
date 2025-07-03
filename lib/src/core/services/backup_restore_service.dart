import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';

import 'package:path/path.dart' show join;
import 'package:file_picker/file_picker.dart' show FilePicker, FileType;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import 'package:masterkey_core/dependency_injection.dart';
import 'package:masterkey_core/src/src.dart';

class BackupRestoreService {
  static Future<bool> backup({
    required String zipName,
    required Directory resourcesDir,
    required SharedPreferences sharedPreferences,
  }) async {
    DatabaseEncryptorService databaseEncryptorService =
        sl<DatabaseEncryptorService>();
    final password = databaseEncryptorService.masterKey;
    final CSVExporter csvExporter = CSVExporter();
    final SharedPreferencesService sharedPreferencesService = SharedPreferencesService(
      sharedPreferences,
      resourcesDir,
    );
    final Directory cacheDir = await Directory.systemTemp;

    late final File backupFile;
    late final File sharedValues;

    final databaseFile = File(
      join(resourcesDir.path, '${AppDatabaseWrapper.name}.sqlite'),
    );
    if (!await databaseFile.exists()) {
      throw CustomFailure("Database file not found");
    }
    try {
      sharedValues = await sharedPreferencesService.exportData(databaseEncryptorService);
      backupFile = await File(
        join(
          resourcesDir.path,
          AppDatabaseWrapper.extractable(AppDatabaseWrapper.backupName),
        ),
      ).writeAsBytes(await databaseFile.readAsBytes());

      List<File> images = [];
      await for (var file in resourcesDir.list(
        recursive: false,
        followLinks: false,
      )) {
        if (file is File && file.path.isImage) {
          final path = join(
            cacheDir.path,
            AppDatabaseWrapper.extractable(file.uri.pathSegments.last),
          );
          images.add(await file.copy(path));
        }
      }
      List<File> files = await csvExporter.export(",")
        ..addAll([backupFile, sharedValues])
        ..addAll(images);
      final archive = Archive();
      for (var file in files) {
        final data = await file.readAsBytes();
        archive.addFile(
          ArchiveFile(file.uri.pathSegments.last, data.length, data),
        );
      }
      final zippedBytes = ZipEncoder(password: password).encode(archive);
      final encryptedZipFile = await File(
        join(resourcesDir.path, zipName),
      ).writeAsBytes(zippedBytes, flush: true);

      final savePath = await FilePicker.platform.saveFile(
        fileName: AppDatabaseWrapper.backupNameNowZip,
        allowedExtensions: ['zip'],
        type: FileType.custom,
        bytes: await encryptedZipFile.readAsBytes(),
      );
      files.removeWhere((element) {
        final fileName = element.uri.pathSegments.last;
        return ![
          "csv",
          "json",
          AppDatabaseWrapper.extractable(""),
        ].any((prefix) => fileName.startsWith(prefix));
      });
      for (File file in files) {
        await file.delete();
      }
      await encryptedZipFile.delete();
      if (savePath == null) throw CancelledBackupFailure();

      return savePath.isNotEmpty;
    } catch (e) {
      if (e is CancelledBackupFailure) throw CancelledBackupFailure();
      throw CustomFailure(e.toString());
    }
  }

  static Future<bool> restore(
    String backupPath,
    String password, {
    required Directory resourcesDir,
    required SharedPreferences sharedPreferences,
  }) async {
    bool success = true;
    if (backupPath.isEmpty || backupPath.split('.').last != 'zip') {
      throw InvalidRestoreFileFailure();
    }
    final SharedPreferencesService sharedPreferencesService = SharedPreferencesService(
      sharedPreferences,
      resourcesDir,
    );
    final DatabaseEncryptorService encryptor =
        await DatabaseEncryptorService.initialize(password);
    final file = File(backupPath);

    await file.writeAsBytes(await File(backupPath).readAsBytes());
    if ((await file.length()) == 0) throw RestoreFileIsEmptyFailure();
    final decryptedFile = await File(
      join(resourcesDir.path, AppDatabaseWrapper.backupNameZip),
    ).writeAsBytes(await file.readAsBytes());
    late final Archive archive;
    try {
      archive = ZipDecoder().decodeBytes(
        await decryptedFile.readAsBytes(),
        password: password,
      );

      // this for check password before delete old database
      bool checked = false;
      final missingFiles = <String>[];
      for (var necessaryFile in AppDatabaseWrapper.necessaryFiles) {
        bool exists = false;
        for (var file in archive) {
          if (file.name == AppDatabaseWrapper.preferencesName && !checked) {
            checked = true;
            try {
              await sharedPreferencesService.importData(
                file.content as List<int>,
                encryptor,
                check: true,
              );
            } catch (e) {
              success = false;
            }
          }
          if (file.name == necessaryFile) {
            exists = true;
            break;
          }
        }
        if (!exists) missingFiles.add(necessaryFile);
      }

      if (missingFiles.isNotEmpty) {
        throw RestoreMissingFileFailure(missingFiles.join(", "));
      }
    } on Failure {
      await decryptedFile.delete();
      rethrow;
    } catch (e) {
      if (e.toString().contains('password error')) {
        await decryptedFile.delete();
        throw InvalidRestorePassword();
      }
    }
    final allFiles = resourcesDir.list(recursive: false, followLinks: false);
    await for (var file in allFiles) {
      if (file is File) {
        final name = file.uri.pathSegments.last;
        if (!name.startsWith("extractable_") && !name.endsWith(".zip")) {
          try {
            await file.delete();
          } catch (e) {
            success = false;
          }
        }
      }
    }
    for (var file in archive) {
      final data = file.content as List<int>;
      final name = file.name;
      try {
        if (name.isImage) {
          final imageFile = File(
            join(resourcesDir.path, name.replaceAll("extractable_", "")),
          );
          await imageFile.writeAsBytes(data, flush: true);
        } else if (name.startsWith(
          AppDatabaseWrapper.extractable(AppDatabaseWrapper.backupName),
        )) {
          final dbFile = File(
            join(resourcesDir.path, "${AppDatabaseWrapper.name}.sqlite"),
          );
          await dbFile.writeAsBytes(data, flush: true);
          await Future.delayed(const Duration(milliseconds: 500));
          if (file is File) {
            await (file as File).delete();
          }
        } else if (file.name.startsWith(AppDatabaseWrapper.preferencesName)) {
          await sharedPreferences.clear();
          await sharedPreferencesService.importData(data, encryptor);
        }
      } catch (e) {
        success = false;
      }
    }
    await decryptedFile.delete();
    return success;
  }
}
