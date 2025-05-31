import 'dart:io' show Directory;

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:masterkey_core/src/src.dart';

import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:masterkey_core/dependency_injection.config.dart';

final sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => sl.init();

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  AppDatabase get database => AppDatabase();

  @lazySingleton
  Future<Directory> cacheDir() async =>
      await getApplicationDocumentsDirectory();
}
