import 'package:drift/drift.dart';
import 'package:masterkey_core/dependency_injection.dart';

import 'package:masterkey_core/src/src.dart';

part 'user_dao.g.dart';

@DriftAccessor(
  tables: [
    UserTable,
    // collection
    CollectionTable,
    // password
    PasswordTable,
    PasswordFieldTable,
    // collections
    CollectionTable,
    CollectionItemTable,
    // cards
    CardTable,
    CardFieldTable,
    // wallets
    WalletTable,
  ],
)
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<List<UserTableData>> getAllUsers() => select(userTable).get();

  Future<int> insertUser(UserTableCompanion user) =>
      into(userTable).insert(user);

  Future<UserTableData?> getUserById(int id) {
    return (select(
      userTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<UserTableData?> getUserByPassword(String password) async {
    final encryptHachedPassword = MasterKeyEncryptorService.hashText(
      await MasterKeyEncryptorService.encryptText(password),
    );
    final UserTableData? userData =
        await (select(userTable)
              ..where((tbl) => tbl.password.equals(encryptHachedPassword)))
            .getSingleOrNull();
    if (!sl.isRegistered<DatabaseEncryptorService>()) {
      await DatabaseEncryptorService.initialize(password);
    }
    return userData;
  }

  Future<void> changePassword({
    required int id,
    required String password,
  }) async {
    final encryptHachedPassword = MasterKeyEncryptorService.hashText(
      await MasterKeyEncryptorService.encryptText(password),
    );
    await (update(userTable)..where((tbl) => tbl.id.equals(id))).write(
      UserTableCompanion(password: Value(encryptHachedPassword)),
    );
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
      final categoriesCount = (await select(collectionTable).get()).length;
      final cardsCount = (await select(cardTable).get()).length;
      final walletsCount = (await select(walletTable).get()).length;

      final total =
          passwordsCount + categoriesCount + cardsCount + walletsCount;

      progress = progress.copyWith(percent: 0, total: total);
      yield progress;

      final newEncryptor = await DatabaseEncryptorService.initialize(password);

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

      final collections = _updateCategoriesEncryptor(
        newEncryptor: newEncryptor,
      );

      await for (var step in collections) {
        final percent = double.parse((total / step.$1).toStringAsFixed(1));
        progress = progress.copyWith(
          percent: percent,
          doneItems: step.$1,
          totalItems: step.$2,
          step: ProgressStep.collections,
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

      final encryptHashedPassword = MasterKeyEncryptorService.hashText(
        await MasterKeyEncryptorService.encryptText(password),
      );
      await (update(userTable)..where((tbl) => tbl.id.equals(id))).write(
        UserTableCompanion(password: Value(encryptHashedPassword)),
      );

      yield progress.copyWith(step: ProgressStep.success);
    } catch (e) {
      throw CustomFailure(e.toString());
    }
  }

  Future<(int, int)> updateHint({required String passwordHint}) async {
    try {
      final userTableData = await (select(userTable)).get();
      if (userTableData.isEmpty) throw NotFoundFailure();
      final userId = userTableData.first.id;

      final updateId =
          await (update(userTable)..where((tbl) => tbl.id.equals(userId)))
              .write(UserTableCompanion(password: Value(passwordHint)));
      return (updateId, userId);
    } catch (e) {
      throw CustomFailure(e.toString());
    }
  }

  Future<int> deleteUser(int id) async {
    return await (delete(userTable)..where((tbl) => tbl.id.equals(id))).go();
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
      await (update(
        passwordTable,
      )..where((tbl) => tbl.id.equals(password.id))).write(
        PasswordTableCompanion(
          title: Value(
            await newEncryptor.encrypt(await encryptor.decrypt(password.title)),
          ),
          iconPath: Value(
            await newEncryptor.encrypt(
              await encryptor.decrypt(password.iconPath),
            ),
          ),
          authKey: password.authKey != null
              ? Value(
                  await newEncryptor.encrypt(
                    await encryptor.decrypt(password.authKey!),
                  ),
                )
              : Value.absent(),
        ),
      );

      final passwordFields = await (select(
        passwordFieldTable,
      )..where((tbl) => tbl.passwordId.equals(password.id))).get();
      for (var field in passwordFields) {
        await (update(
          passwordFieldTable,
        )..where((tbl) => tbl.id.equals(field.id))).write(
          PasswordFieldTableCompanion(
            value: Value(
              await newEncryptor.encrypt(await encryptor.decrypt(field.value)),
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
    final collections = await select(collectionTable).get();
    final length = collections.length;
    int updated = 0;
    yield (updated, length);
    for (var collection in collections) {
      await (update(
        collectionTable,
      )..where((tbl) => tbl.id.equals(collection.id))).write(
        CollectionTableCompanion(
          name: Value(
            await newEncryptor.encrypt(
              await encryptor.decrypt(collection.name!),
            ),
          ),
          iconPath: Value(
            await newEncryptor.encrypt(
              await encryptor.decrypt(collection.iconPath),
            ),
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
            await newEncryptor.encrypt(await encryptor.decrypt(card.title)),
          ),
          holderName: Value(
            await newEncryptor.encrypt(
              await encryptor.decrypt(card.holderName),
            ),
          ),
          cvv: Value(
            await newEncryptor.encrypt(await encryptor.decrypt(card.cvv)),
          ),
          number: Value(
            await newEncryptor.encrypt(await encryptor.decrypt(card.number)),
          ),
          pin: card.pin != null
              ? Value(
                  await newEncryptor.encrypt(
                    await encryptor.decrypt(card.pin!),
                  ),
                )
              : Value.absent(),
        ),
      );

      final cardFields = await (select(
        cardFieldTable,
      )..where((tbl) => tbl.cardId.equals(card.id))).get();
      for (var field in cardFields) {
        await (update(
          cardFieldTable,
        )..where((tbl) => tbl.cardId.equals(card.id))).write(
          CardFieldTableCompanion(
            hintText: field.hintText != null
                ? Value(
                    await newEncryptor.encrypt(
                      await encryptor.decrypt(field.hintText!),
                    ),
                  )
                : Value.absent(),
            value: Value(
              await newEncryptor.encrypt(await encryptor.decrypt(field.value)),
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
      await (update(
        walletTable,
      )..where((tbl) => tbl.id.equals(wallet.id))).write(
        WalletTableCompanion(
          title: Value(
            await newEncryptor.encrypt(await encryptor.decrypt(wallet.title)),
          ),
          seedPhrase: Value(
            await newEncryptor.encrypt(
              await encryptor.decrypt(wallet.seedPhrase),
            ),
          ),
        ),
      );

      updated++;
      yield (updated, length);
    }

    yield (updated, length);
  }
}
