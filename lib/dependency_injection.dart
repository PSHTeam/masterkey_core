import 'dart:io' show Directory;

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:masterkey_core/src/src.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masterkey_core/dependency_injection.config.dart';

GetIt sl = GetIt.instance;

@InjectableInit()
Future<void> init({
  required GetIt serviceLocator,
  required Directory resourcesDir,
  required Dotenv dotenv,
}) async {
  sl = serviceLocator;
  sl.registerLazySingleton<Directory>(() => resourcesDir);
  sl.registerLazySingleton<Dotenv>(() => dotenv);
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  sl.init();
}

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
