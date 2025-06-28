import 'dart:io' show Directory;

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:masterkey_core/src/src.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masterkey_core/dependency_injection.config.dart';

final sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependenciesCore(Directory cacheDir) async {
  sl.registerLazySingleton<Directory>(() => cacheDir);
  sl.init();
}

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  AppDatabase get database => AppDatabase();
}
