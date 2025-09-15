import 'package:masterkey_core/src/src.dart';

abstract class WalletRepository {
  FailureOr<Wallet> create(WalletParams wallet);
  FailureOr<Wallet> update(UpdateWalletParams params);
  FailureOr<bool> delete(int id);
  FailureOr<List<Wallet>> getAllWallets(GetAllWalletsParams params);
  FailureOr<Wallet> toggleWalletArchiveStatus(
    ToggleWalletArchiveStatusParams params,
  );
}
