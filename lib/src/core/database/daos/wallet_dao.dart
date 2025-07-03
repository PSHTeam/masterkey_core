import 'package:drift/drift.dart';

import 'package:masterkey_core/dependency_injection.dart';
import 'package:masterkey_core/src/src.dart';

part 'wallet_dao.g.dart';

@DriftAccessor(tables: [WalletTable])
class WalletDao extends DatabaseAccessor<AppDatabase> with _$WalletDaoMixin {
  WalletDao(super.db);

  Future<List<WalletTableData>> getAllWallets(
    GetAllWalletsParams params, {
    bool force = false,
  }) async {
    final encryptor = sl<DatabaseEncryptorService>();
    final wallets = select(walletTable);
    if (force) {
      final walletList = await wallets.get();
      return await Future.wait(
        walletList.map(
          (e) async => e.copyWith(
            title: await encryptor.decrypt(e.title),
            seedPhrase: await encryptor.decrypt(e.seedPhrase),
          ),
        ),
      );
    }
    final mode = params.reverse ? OrderingMode.asc : OrderingMode.desc;

    wallets.orderBy([
      switch (params.order) {
        OrderType.byName => (w) => OrderingTerm(
          expression: w.title,
          mode: params.reverse ? OrderingMode.desc : OrderingMode.asc,
        ),
        OrderType.byCreationTime => (w) => OrderingTerm(
          expression: w.createdAt,
          mode: mode,
        ),
        OrderType.byLastModified => (w) => OrderingTerm(
          expression: w.updatedAt,
          mode: mode,
        ),
      },
    ]);

    wallets.limit(params.limit, offset: params.offset);
    wallets.where((tbl) => tbl.hasArchived.equals(params.hasArchived));
    final result = await wallets.get();
    final output = await Future.wait(
      result.map(
        (wallet) async => wallet.copyWith(
          title: await encryptor.decrypt(wallet.title),
          seedPhrase: await encryptor.decrypt(wallet.seedPhrase),
        ),
      ),
    );

    return output;
  }

  Future<int> insertWallet(WalletParams wallet) async {
    final encryptor = sl<DatabaseEncryptorService>();
    final input = WalletTableCompanion(
      title: Value(await encryptor.encrypt(wallet.title)),
      seedPhrase: Value(await encryptor.encrypt(wallet.seedPhrase)),
      hasArchived: Value(wallet.hasArchived),
      createdAt: Value(DateTime.now()),
    );
    final id = into(walletTable).insert(input);

    return id;
  }

  Future<WalletTableData?> getWalletById(int id) async {
    final encryptor = sl<DatabaseEncryptorService>();
    final wallet = await (select(
      walletTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (wallet != null) {
      return wallet.copyWith(
        title: await encryptor.decrypt(wallet.title),
        seedPhrase: await encryptor.decrypt(wallet.seedPhrase),
      );
    }
    return null;
  }

  Future<int> updateWallet({
    required int id,
    String? walletName,
    String? seedPhrase,
  }) async {
    final encryptor = sl<DatabaseEncryptorService>();
    return await (update(walletTable)..where((tbl) => tbl.id.equals(id))).write(
      WalletTableCompanion(
        title: walletName != null
            ? Value(await encryptor.encrypt(walletName))
            : const Value.absent(),
        seedPhrase: seedPhrase != null
            ? Value(await encryptor.encrypt(seedPhrase))
            : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> toggleArchiveStatus({
    required ToggleWalletArchiveStatusParams params,
  }) async {
    return await (update(
      walletTable,
    )..where((tbl) => tbl.id.equals(params.id))).write(
      WalletTableCompanion(
        hasArchived: Value(params.status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteWallet(int id) async {
    return await (delete(walletTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
