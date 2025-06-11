import 'dart:developer' show log;
import 'dart:io';
import 'dart:convert';

import 'package:path/path.dart' show join;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import 'package:masterkey_core/src/src.dart';

class SharedPreferencesService {
  final SharedPreferences prefs;
  final Directory cacheDir;
  const SharedPreferencesService(this.prefs, this.cacheDir);

  Future<File> exportData(DatabaseEncryptorService encryptor) async {
    final keys =
        prefs.getKeys().where((key) => prefs.get(key) != null).toList();
    Map<String, dynamic> data = {for (var key in keys) key: prefs.get(key)};
    final encryptedData = await encryptor.encrypt(jsonEncode(data));
    final sharedValues = await File(
      join(cacheDir.path, AppDatabaseWrapper.prefsName),
    ).writeAsString(encryptedData);
    return sharedValues;
  }

  Future<void> importData(
    List<int> data,
    DatabaseEncryptorService encryptor, {
    bool check = false,
  }) async {
    String decryptedData;
    try {
      decryptedData = await encryptor.decrypt(utf8.decode(data));
      if (check) return;
      await prefs.clear();
      final Map prefsData = await jsonDecode(decryptedData);
      for (var key in prefsData.keys) {
        final value = prefsData[key];
        if (value is int) {
          await prefs.setInt(key, value);
        } else if (value is double) {
          await prefs.setDouble(key, value);
        } else if (value is bool) {
          await prefs.setBool(key, value);
        } else if (value is String) {
          await prefs.setString(key, value);
        } else if (value is List<String>) {
          await prefs.setStringList(key, value);
        }
      }
    } on FormatException {
      throw DecryptRestoreFileFailureMsg();
    } on ArgumentError catch (e) {
      log(
        'Error importing shared preferences: ${e.message}',
        name: 'SharedPreferencesService',
      );
    } catch (e) {
      throw CustomFailure(e.toString());
    }
  }
}
