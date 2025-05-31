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
    try {
      final encryptionDB = sl<DatabaseEncryptorService>();
      final wallets = select(walletTable);
      if (force) {
        return (await wallets.get())
            .map(
              (e) => e.copyWith(
                title: encryptionDB.decrypt(e.title),
                seedPhrase: encryptionDB.decrypt(e.seedPhrase),
              ),
            )
            .toList();
      }
      final mode = params.reverse ? OrderingMode.asc : OrderingMode.desc;

      wallets.orderBy([
        switch (params.order) {
          OrderType.byName =>
            (w) => OrderingTerm(
              expression: w.title,
              mode: params.reverse ? OrderingMode.desc : OrderingMode.asc,
            ),
          OrderType.byCreationTime =>
            (w) => OrderingTerm(expression: w.createdAt, mode: mode),
          OrderType.byLastModified =>
            (w) => OrderingTerm(expression: w.updatedAt, mode: mode),
        },
      ]);

      wallets.limit(params.limit, offset: params.offset);
      wallets.where((tbl) => tbl.hasArchived.equals(params.hasArchived));
      final result = await wallets.get();
      final output =
          result
              .map(
                (wallet) => wallet.copyWith(
                  title: encryptionDB.decrypt(wallet.title),
                  seedPhrase: encryptionDB.decrypt(wallet.seedPhrase),
                ),
              )
              .toList();

      return output;
    } catch (e) {
      // log('Error: $e');
      return [];
    }
  }

  Future<int> insertWallet(WalletParams wallet) async {
    try {
      final encryptionDB = sl<DatabaseEncryptorService>();
      final input = WalletTableCompanion(
        title: Value(encryptionDB.encrypt(wallet.title)),
        seedPhrase: Value(encryptionDB.encrypt(wallet.seedPhrase)),
        hasArchived: Value(wallet.hasArchived),
        createdAt: Value(DateTime.now()),
      );
      final id = into(walletTable).insert(input);

      // log('Wallet : $input');
      return id;
    } catch (e) {
      // log('Error: $e');
      return 0;
    }
  }

  Future<List<WalletTableData>> getWalletsByArchiveStatus() async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    final wallets =
        await (select(walletTable)
          ..where((tbl) => tbl.hasArchived.equals(true))).get();
    return wallets
        .map(
          (wallet) => wallet.copyWith(
            title: encryptionDB.decrypt(wallet.title),
            seedPhrase: encryptionDB.decrypt(wallet.seedPhrase),
          ),
        )
        .toList();
  }

  Future<List<WalletTableData>> searchWalletsByArchiveStatus(
    String query, {
    int limit = 30,
    int offset = 0,
  }) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    final wallets =
        await (select(walletTable)
              ..where(
                (tbl) => tbl.title.like('%${encryptionDB.encrypt(query)}%'),
              )
              ..where((tbl) => tbl.hasArchived.equals(true))
              ..limit(limit, offset: offset))
            .get();
    return wallets
        .map(
          (wallet) => wallet.copyWith(
            title: encryptionDB.decrypt(wallet.title),
            seedPhrase: encryptionDB.decrypt(wallet.seedPhrase),
          ),
        )
        .toList();
  }

  Future<List<WalletTableData>> searchWallets(
    String query, {
    int limit = 30,
    int offset = 0,
  }) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    final wallets =
        await (select(walletTable)
              ..where(
                (tbl) => tbl.title.like('%${encryptionDB.encrypt(query)}%'),
              )
              ..limit(limit, offset: offset))
            .get();
    return wallets
        .map(
          (wallet) => wallet.copyWith(
            title: encryptionDB.decrypt(wallet.title),
            seedPhrase: encryptionDB.decrypt(wallet.seedPhrase),
          ),
        )
        .toList();
  }

  Future<WalletTableData?> getWalletById(int id) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    final wallet =
        await (select(walletTable)
          ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (wallet != null) {
      return wallet.copyWith(
        title: encryptionDB.decrypt(wallet.title),
        seedPhrase: encryptionDB.decrypt(wallet.seedPhrase),
      );
    }
    return null;
  }

  Future<int> updateWallet({
    required int id,
    String? walletName,
    String? seedPhrase,
  }) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    return await (update(walletTable)..where((tbl) => tbl.id.equals(id))).write(
      WalletTableCompanion(
        title:
            walletName != null
                ? Value(encryptionDB.encrypt(walletName))
                : const Value.absent(),
        seedPhrase:
            seedPhrase != null
                ? Value(encryptionDB.encrypt(seedPhrase))
                : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> toggleArchiveStatus({
    required ToggleWalletArchiveStatusParams params,
  }) async {
    return await (update(walletTable)
      ..where((tbl) => tbl.id.equals(params.id))).write(
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
