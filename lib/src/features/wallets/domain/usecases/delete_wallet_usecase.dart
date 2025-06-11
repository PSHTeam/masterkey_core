import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class DeleteWalletUsecase extends BaseUseCase<bool, int> {
  final WalletRepository repository;
  DeleteWalletUsecase(this.repository);

  @override
  FailureOr<bool> call(int walletId) => repository.delete(walletId);
}
