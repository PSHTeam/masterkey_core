import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class GetWalletUsecase extends BaseUseCase<Wallet, String> {
  final WalletRepository repository;
  GetWalletUsecase(this.repository);

  @override
  FailureOr<Wallet> call(String params) => repository.getWallet(params);
}
