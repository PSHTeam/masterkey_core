import 'dart:io';
import 'dart:convert';

import 'package:path/path.dart' show join;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import 'package:masterkey_core/src/src.dart';

class SharedPreferencesService {
  final SharedPreferences sharedPreferences;
  final Directory cacheDir;
  const SharedPreferencesService(this.sharedPreferences, this.cacheDir);

  Future<File> exportData(DatabaseEncryptorService encryptor) async {
    final keys = sharedPreferences
        .getKeys()
        .where((key) => sharedPreferences.get(key) != null)
        .toList();
    Map<String, dynamic> data = {
      for (var key in keys) key: sharedPreferences.get(key),
    };
    final encryptedData = await encryptor.encrypt(jsonEncode(data));
    final sharedValues = await File(
      join(cacheDir.path, AppDatabaseWrapper.preferencesName),
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
      await sharedPreferences.clear();
      final Map preferencesData = await jsonDecode(decryptedData);
      for (var key in preferencesData.keys) {
        final value = preferencesData[key];
        if (value is int) {
          await sharedPreferences.setInt(key, value);
        } else if (value is double) {
          await sharedPreferences.setDouble(key, value);
        } else if (value is bool) {
          await sharedPreferences.setBool(key, value);
        } else if (value is String) {
          await sharedPreferences.setString(key, value);
        } else if (value is List<String>) {
          await sharedPreferences.setStringList(key, value);
        }
      }
    } on FormatException {
      throw DecryptRestoreFileFailureMsg();
    } catch (e) {
      throw CustomFailure(e.toString());
    }
  }
}
