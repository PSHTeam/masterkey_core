import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';

import 'package:path/path.dart' show join;
import 'package:file_picker/file_picker.dart' show FilePicker;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import 'package:masterkey_core/dependency_injection.dart';
import 'package:masterkey_core/src/src.dart';

class BackupRestoreService {
  static Future<bool> backup({
    required String zipName,
    required Directory cacheDir,
    required SharedPreferences prefs,
  }) async {
    DatabaseEncryptorService databaseEncryptorService =
        sl<DatabaseEncryptorService>();
    final password = databaseEncryptorService.masterKey;
    final CSVExporter csvExporter = CSVExporter();
    final SharedPreferencesService prefsService = SharedPreferencesService(
      prefs,
      cacheDir,
    );

    late final File backupFile;
    late final File sharedValues;

    final dbPath = join(cacheDir.path, '${AppDatabaseWrapper.name}.sqlite');
    final databaseFile = File(dbPath);
    if (!await databaseFile.exists()) {
      throw CustomFailure("Database file not found");
    }
    try {
      sharedValues = await prefsService.exportData(databaseEncryptorService);
      backupFile = await File(
        join(
          cacheDir.path,
          AppDatabaseWrapper.extractable(AppDatabaseWrapper.backupName),
        ),
      ).writeAsBytes(await databaseFile.readAsBytes());
      List<File> files =
          await csvExporter.export(",")
            ..addAll([backupFile, sharedValues])
            ..addAll(await backupImages(cacheDir));
      final archive = Archive();
      for (var file in files) {
        final data = await file.readAsBytes();
        archive.addFile(
          ArchiveFile(file.uri.pathSegments.last, data.length, data),
        );
      }
      final zippedBytes = ZipEncoder(password: password).encode(archive);
      final encryptedZipFile = await File(
        join(cacheDir.path, zipName),
      ).writeAsBytes(zippedBytes, flush: true);

      final savePath = await FilePicker.platform.saveFile(
        fileName: AppDatabaseWrapper.backupNameZip,
        allowedExtensions: ['zip'],
        bytes: await encryptedZipFile.readAsBytes(),
      );
      files.removeWhere((element) {
        final fileName = element.uri.pathSegments.last;
        return !["csv", "json", AppDatabaseWrapper.extractable("")].any(
          (prefix) =>
              fileName.startsWith(prefix) || fileName.startsWith(prefix),
        );
      });
      for (File file in files) {
        await file.delete();
      }
      await encryptedZipFile.delete();
      if (savePath == null) throw CancelledBackupFailure();

      return savePath.isNotEmpty;
    } catch (e) {
      if (e is CancelledBackupFailure) throw CancelledBackupFailure();

      // log('Error in backupDatabase: $e');
      throw CustomFailure(e.toString());
    }
  }

  static Future<bool> restore(
    String backupPath,
    String password, {
    required Directory cacheDir,
    required SharedPreferences prefs,
  }) async {
    if (backupPath.isEmpty || backupPath.split('.').last != 'zip') {
      throw InvalidRestoreFileFailure();
    }
    final cacheDir = sl<Directory>();
    final prefs = sl<SharedPreferences>();
    final SharedPreferencesService prefsService = SharedPreferencesService(
      prefs,
      cacheDir,
    );
    final DatabaseEncryptorService encryptor =
        await DatabaseEncryptorService.initialize(password);
    final file = File(backupPath);

    await file.writeAsBytes(await File(backupPath).readAsBytes());
    if ((await file.length()) == 0) throw RestoreFileIsEmptyFailure();
    final decryptedFile = await File(
      join(cacheDir.path, AppDatabaseWrapper.backupNameZip),
    ).writeAsBytes(await file.readAsBytes());
    try {
      final archive = ZipDecoder().decodeBytes(
        await decryptedFile.readAsBytes(),
        password: password,
      );

      // this for check password before delete old database
      bool checked = false;
      final missingFiles = <String>[];
      for (var necessaryFile in AppDatabaseWrapper.necessaryFiles) {
        bool exists = false;
        for (var file in archive) {
          if (file.name == AppDatabaseWrapper.prefsName && !checked) {
            checked = true;
            await prefsService.importData(
              file.content as List<int>,
              encryptor,
              check: true,
            );
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

      final allFiles = cacheDir.list(recursive: false, followLinks: false);
      await for (var file in allFiles) {
        if (file is File) {
          final name = file.uri.pathSegments.last;
          // log(name);
          if (!name.startsWith("extractable_") && !name.endsWith(".zip")) {
            await file.delete();
          }
        }
      }

      for (var file in archive) {
        final data = file.content as List<int>;
        final name = file.name;
        if (name.endsWith('.png')) {
          final imageFile = File(
            join(cacheDir.path, name.replaceAll("extractable_", "")),
          );
          await imageFile.writeAsBytes(data, flush: true);
        } else if (name.startsWith(
          AppDatabaseWrapper.extractable(AppDatabaseWrapper.backupName),
        )) {
          final dbFile = File(
            join(cacheDir.path, "${AppDatabaseWrapper.name}.sqlite"),
          );
          await dbFile.writeAsBytes(data, flush: true);
          await Future.delayed(const Duration(milliseconds: 500));
          if (file is File) {
            await (file as File).delete();
          }
        } else if (file.name.startsWith(AppDatabaseWrapper.prefsName)) {
          await prefs.clear();
          await prefsService.importData(data, encryptor);
        }
      }
      return true;
    } on Failure {
      rethrow;
    } catch (e) {
      if (e.toString().contains('password error')) {
        throw InvalidRestorePassword();
      }
      return false;
    } finally {
      await decryptedFile.delete();
    }
  }
}

Future<bool> isDirectory(String path) async {
  return (await FileSystemEntity.type(path)) == FileSystemEntityType.directory;
}

Future<List<File>> backupImages(Directory cacheDir) async {
  try {
    List<File> images = [];
    final allFiles = cacheDir.list(recursive: false, followLinks: false);
    await for (var file in allFiles) {
      if (file is File && file.path.endsWith('.png')) {
        final path = join(
          cacheDir.path,
          AppDatabaseWrapper.extractable(file.uri.pathSegments.last),
        );
        //          log('Image: ${file.uri.pathSegments.last}, Path: $path');
        images.add(await file.copy(path));
      }
    }

    return images;
  } catch (e) {
    // log('Error saving image to cache: $e');
    throw CustomFailure(e.toString());
  }
}
