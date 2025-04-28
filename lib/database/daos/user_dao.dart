import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:master_key/dependency_injection.dart';
import 'package:master_key/src/src.dart';

part 'user_dao.g.dart';

@DriftAccessor(
  tables: [
    UserTable,
    // card
    CardTable,
    CardFieldTable,
    // category
    CategoryTable,
    // password
    PasswordTable,
    PasswordFieldTable,
    // wallet
    WalletTable,
  ],
)
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<List<UserTableData>> getAllUsers() => select(userTable).get();

  Future<int> insertUser(UserTableCompanion user) =>
      into(userTable).insert(user);

  Future<UserTableData?> getUserById(int id) {
    return (select(userTable)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<UserTableData?> getUserByPassword(String password) async {
    final data = select(userTable);
    log('password: ${await data.get()}');
    return await (select(userTable)
      ..where((tbl) => tbl.password.equals(password))).getSingleOrNull();
  }

  Stream<ProgressModel> updateMasterKey({
    required int id,
    required String password,
  }) async* {
    try {
      ProgressModel progress = ProgressModel(
        step: ProgressStep.fetchStatistics,
      );
      yield progress;

      final passwordsCount = (await select(passwordTable).get()).length;
      final categoriesCount = (await select(categoryTable).get()).length;
      final cardsCount = (await select(cardTable).get()).length;
      final walletsCount = (await select(walletTable).get()).length;

      final total =
          passwordsCount + categoriesCount + cardsCount + walletsCount;

      progress = progress.copyWith(percent: 0, total: total);
      yield progress;

      final newEncryptor = DatabaseEncryptorService.initialize(password);

      final passwords = _updatePasswordsEncryptor(newEncryptor: newEncryptor);

      await for (var step in passwords) {
        final percent = double.parse((total / step.$2).toStringAsFixed(1));
        progress = progress.copyWith(
          percent: percent,
          total: total,
          doneItems: step.$1,
          totalItems: step.$2,
          step: ProgressStep.passwords,
        );

        yield progress;
      }

      final categories = _updateCategoriesEncryptor(newEncryptor: newEncryptor);

      await for (var step in categories) {
        final percent = double.parse((total / step.$1).toStringAsFixed(1));
        progress = progress.copyWith(
          percent: percent,
          doneItems: step.$1,
          totalItems: step.$2,
          step: ProgressStep.categories,
        );

        yield progress;
      }

      final cards = _updateCardsEncryptor(newEncryptor: newEncryptor);

      await for (var step in cards) {
        final percent = double.parse((total / step.$2).toStringAsFixed(1));
        progress = progress.copyWith(
          percent: percent,
          doneItems: step.$1,
          totalItems: step.$2,
          step: ProgressStep.cards,
        );

        yield progress;
      }

      final wallets = _updateWalletsEncryptor(newEncryptor: newEncryptor);

      await for (var step in wallets) {
        final percent = double.parse((total / step.$2).toStringAsFixed(1));
        progress = progress.copyWith(
          percent: percent,
          doneItems: step.$1,
          totalItems: step.$2,
          step: ProgressStep.wallets,
        );

        yield progress;
      }

      await sl.unregister<DatabaseEncryptorService>();
      sl.registerFactory<DatabaseEncryptorService>(() => newEncryptor);

      final encryptHachedPassword = MasterKeyEncryptorService.hashText(
        await MasterKeyEncryptorService.encryptTextFixed(password),
      );
      await (update(userTable)..where(
        (tbl) => tbl.id.equals(id),
      )).write(UserTableCompanion(password: Value(encryptHachedPassword)));

      yield progress.copyWith(step: ProgressStep.success);
    } catch (e) {
      log(e.toString(), name: "updateMasterKey");
      throw CustomFailure(e.toString());
    }
  }

  Future<(int, int)> updateHint({required String passwordHint}) async {
    try {
      final userTableData = await (select(userTable)).get();
      if (userTableData.isEmpty) throw NotFoundFailure();
      final userId = userTableData.first.id;

      final updateId = await (update(userTable)..where(
        (tbl) => tbl.id.equals(userId),
      )).write(UserTableCompanion(password: Value(passwordHint)));
      return (updateId, userId);
    } catch (e) {
      log(e.toString(), name: "updateMasterKey");
      throw CustomFailure(e.toString());
    }
  }

  Future<int> deleteUser(int id) {
    return (delete(userTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  StreamUpdate _updatePasswordsEncryptor({
    required DatabaseEncryptorService newEncryptor,
  }) async* {
    final encryptor = sl<DatabaseEncryptorService>();
    final passwords = await select(passwordTable).get();
    final length = passwords.length;
    int updated = 0;
    yield (updated, length);
    for (var password in passwords) {
      await (update(passwordTable)
        ..where((tbl) => tbl.id.equals(password.id))).write(
        PasswordTableCompanion(
          title: Value(
            newEncryptor.encryptText(encryptor.decryptText(password.title)),
          ),
          iconPath: Value(
            newEncryptor.encryptText(encryptor.decryptText(password.iconPath)),
          ),
          authKey:
              password.authKey != null
                  ? Value(
                    newEncryptor.encryptText(
                      encryptor.decryptText(password.authKey!),
                    ),
                  )
                  : Value.absent(),
        ),
      );

      final passwordFields =
          await (select(passwordFieldTable)
            ..where((tbl) => tbl.passwordId.equals(password.id))).get();
      for (var field in passwordFields) {
        await (update(passwordFieldTable)
          ..where((tbl) => tbl.id.equals(field.id))).write(
          PasswordFieldTableCompanion(
            value: Value(
              newEncryptor.encryptText(encryptor.decryptText(field.value)),
            ),
          ),
        );
      }

      updated++;
      yield (updated, length);
    }

    yield (updated, length);
  }

  StreamUpdate _updateCategoriesEncryptor({
    required DatabaseEncryptorService newEncryptor,
  }) async* {
    final encryptor = sl<DatabaseEncryptorService>();
    final categories = await select(categoryTable).get();
    final length = categories.length;
    int updated = 0;
    yield (updated, length);
    for (var category in categories) {
      await (update(categoryTable)
        ..where((tbl) => tbl.id.equals(category.id))).write(
        CategoryTableCompanion(
          name: Value(
            newEncryptor.encryptText(encryptor.decryptText(category.name!)),
          ),
          iconPath: Value(
            newEncryptor.encryptText(encryptor.decryptText(category.iconPath)),
          ),
        ),
      );

      updated++;
      yield (updated, length);
    }

    yield (updated, length);
  }

  StreamUpdate _updateCardsEncryptor({
    required DatabaseEncryptorService newEncryptor,
  }) async* {
    final encryptor = sl<DatabaseEncryptorService>();
    final cards = await select(cardTable).get();
    final length = cards.length;
    int updated = 0;
    yield (updated, length);
    for (var card in cards) {
      await (update(cardTable)..where((tbl) => tbl.id.equals(card.id))).write(
        CardTableCompanion(
          title: Value(
            newEncryptor.encryptText(encryptor.decryptText(card.title)),
          ),
          holderName: Value(
            newEncryptor.encryptText(encryptor.decryptText(card.holderName)),
          ),
          cvv: Value(newEncryptor.encryptText(encryptor.decryptText(card.cvv))),
          number: Value(
            newEncryptor.encryptText(encryptor.decryptText(card.number)),
          ),
          pin:
              card.pin != null
                  ? Value(
                    newEncryptor.encryptText(encryptor.decryptText(card.pin!)),
                  )
                  : Value.absent(),
        ),
      );

      final cardFields =
          await (select(cardFieldTable)
            ..where((tbl) => tbl.cardId.equals(card.id))).get();
      for (var field in cardFields) {
        await (update(cardFieldTable)
          ..where((tbl) => tbl.cardId.equals(card.id))).write(
          CardFieldTableCompanion(
            hintText:
                field.hintText != null
                    ? Value(
                      newEncryptor.encryptText(
                        encryptor.decryptText(field.hintText!),
                      ),
                    )
                    : Value.absent(),
            value: Value(
              newEncryptor.encryptText(encryptor.decryptText(field.value)),
            ),
          ),
        );
      }
      updated++;
      yield (updated, length);
    }

    yield (updated, length);
  }

  StreamUpdate _updateWalletsEncryptor({
    required DatabaseEncryptorService newEncryptor,
  }) async* {
    final encryptor = sl<DatabaseEncryptorService>();
    final wallets = await select(walletTable).get();
    final length = wallets.length;
    int updated = 0;
    for (var wallet in wallets) {
      await (update(walletTable)
        ..where((tbl) => tbl.id.equals(wallet.id))).write(
        WalletTableCompanion(
          title: Value(
            newEncryptor.encryptText(encryptor.decryptText(wallet.title)),
          ),
          seedPhrase: Value(
            newEncryptor.encryptText(encryptor.decryptText(wallet.seedPhrase)),
          ),
        ),
      );

      updated++;
      yield (updated, length);
    }

    yield (updated, length);
  }
}
