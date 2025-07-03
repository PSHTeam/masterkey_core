import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

abstract class WalletLocalDatasource {
  Future<WalletModel> create(WalletParams wallet);
  Future<WalletModel> update(UpdateWalletParams params);
  Future<bool> delete(int params);

  Future<List<WalletModel>> getAllWallets(GetAllWalletsParams params);
  Future<WalletModel> toggleWalletArchiveStatus(
    ToggleWalletArchiveStatusParams params,
  );
}

@LazySingleton(as: WalletLocalDatasource)
class WalletLocalDatasourceImpl implements WalletLocalDatasource {
  final AppDatabase appDatabase;
  WalletLocalDatasourceImpl(this.appDatabase);

  @override
  Future<WalletModel> create(WalletParams wallet) async {
    final walletId = await appDatabase.walletDao.insertWallet(wallet);
    final walletTableData = await appDatabase.walletDao.getWalletById(walletId);

    if (walletTableData == null) throw UnknownFailure();

    return WalletModel.fromTableData(walletTableData);
  }

  @override
  Future<bool> delete(int params) async {
    final deleteId = await appDatabase.walletDao.deleteWallet(params);
    return deleteId != 0;
  }

  @override
  Future<List<WalletModel>> getAllWallets(GetAllWalletsParams params) async {
    final walletTableData = await appDatabase.walletDao.getAllWallets(params);
    if (walletTableData.isEmpty) return [];

    final allWallets = walletTableData.map((wallet) {
      return WalletModel.fromTableData(wallet);
    }).toList();

    return allWallets;
  }

  @override
  Future<WalletModel> update(UpdateWalletParams params) async {
    final updateId = await appDatabase.walletDao.updateWallet(
      id: params.walletId,
      walletName: params.title,
      seedPhrase: params.seedPhrase,
    );

    if (updateId == 0) throw UnknownFailure();

    final walletTableData = await appDatabase.walletDao.getWalletById(
      params.walletId,
    );

    if (walletTableData == null) throw UnknownFailure();

    return WalletModel.fromTableData(walletTableData);
  }

  @override
  Future<WalletModel> toggleWalletArchiveStatus(
    ToggleWalletArchiveStatusParams params,
  ) async {
    final updateId = await appDatabase.walletDao.toggleArchiveStatus(
      params: params,
    );

    if (updateId == 0) throw UnknownFailure();

    final walletTableData = await appDatabase.walletDao.getWalletById(
      params.id,
    );

    if (walletTableData == null) throw UnknownFailure();

    return WalletModel.fromTableData(walletTableData);
  }
}
