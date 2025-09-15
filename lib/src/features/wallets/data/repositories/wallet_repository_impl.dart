import 'package:dartz/dartz.dart' show Left, Right;
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl implements WalletRepository {
  final WalletLocalDatasource datasource;

  WalletRepositoryImpl(this.datasource);

  @override
  FailureOr<List<Wallet>> getAllWallets(GetAllWalletsParams params) async {
    try {
      final List<WalletModel> responce = await datasource.getAllWallets(params);

      return Right(responce.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<Wallet> create(WalletParams wallet) async {
    try {
      final responce = await datasource.create(wallet);
      return Right(responce.toEntity());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<Wallet> update(UpdateWalletParams wallet) async {
    try {
      final responce = await datasource.update(wallet);
      return Right(responce.toEntity());
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<bool> delete(int wallet) async {
    try {
      final responce = await datasource.delete(wallet);
      return Right(responce);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<Wallet> toggleWalletArchiveStatus(
    ToggleWalletArchiveStatusParams params,
  ) async {
    try {
      final responce = await datasource.toggleWalletArchiveStatus(params);
      return Right(responce.toEntity());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
