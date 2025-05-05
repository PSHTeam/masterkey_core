import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import 'package:masterkey_core/dependency_injection.dart';
import 'package:masterkey_core/src/src.dart';

abstract class AuthLocalDatasource {
  Future<UserModel> register(UserModel user);
  Future<UserModel> login(String password);
  Stream<ProgressModel> update(UpdateUserParams params);
  Future<UserModel> updateHint(UpdatePasswordHintParams params);
}

@LazySingleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final AppDatabase appDatabase;
  final SharedPreferences sharedPreferences;

  AuthLocalDatasourceImpl(this.appDatabase, this.sharedPreferences);

  @override
  Future<UserModel> register(UserModel userModel) async {
    final masterkey = await MasterKeyEncryptorService.encryptTextFixed(
      userModel.masterPassword,
    );
    final DatabaseEncryptorService encrypter =
        DatabaseEncryptorService.initialize(userModel.masterPassword);

    if (sl.isRegistered<DatabaseEncryptorService>()) {
      sl.unregister<DatabaseEncryptorService>();
    }

    sl.registerFactory<DatabaseEncryptorService>(() => encrypter);

    final encryptHachedPassword = MasterKeyEncryptorService.hashText(masterkey);

    final userId = await appDatabase.userDao.insertUser(
      UserTableCompanion(
        password: Value(encryptHachedPassword),
        passwordHint:
            userModel.masterHint != null
                ? Value(userModel.masterHint)
                : const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
    final userTableData = await appDatabase.userDao.getUserById(userId);
    if (userTableData == null) throw AuthFailure();

    return UserModel.fromTableData(userTableData);
  }

  @override
  Future<UserModel> login(String password) async {
    final masterkey = await MasterKeyEncryptorService.encryptTextFixed(
      password,
    );
    final encryptHachedPassword = MasterKeyEncryptorService.hashText(masterkey);

    final userTableData = await appDatabase.userDao.getUserByPassword(
      encryptHachedPassword,
    );

    // log('userTableData: $userTableData');

    if (userTableData == null) throw AuthFailure();

    if (!sl.isRegistered<DatabaseEncryptorService>()) {
      sl.registerFactory<DatabaseEncryptorService>(
        () => DatabaseEncryptorService.initialize(password),
      );
    }

    return UserModel.fromTableData(userTableData);
  }

  @override
  Stream<ProgressModel> update(UpdateUserParams params) async* {
    final updateProgress = appDatabase.userDao.updateMasterKey(
      id: params.userId,
      password: params.password,
    );
    await for (var progress in updateProgress) {
      yield progress;
    }

    // return UserModel.fromTableData(updatedUser);
  }

  @override
  Future<UserModel> updateHint(UpdatePasswordHintParams params) async {
    final updateId = await appDatabase.userDao.updateHint(
      passwordHint: params.hint,
    );
    if (updateId.$1 == 0) throw NotFoundFailure();

    final updatedUser = await appDatabase.userDao.getUserById(updateId.$1);
    if (updatedUser == null) throw NotFoundFailure();

    return UserModel.fromTableData(updatedUser);
  }
}
