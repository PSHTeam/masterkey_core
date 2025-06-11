import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class UpdateWalletUsecase extends BaseUseCase<Wallet, UpdateWalletParams> {
  final WalletRepository repository;
  UpdateWalletUsecase(this.repository);

  @override
  FailureOr<Wallet> call(UpdateWalletParams params) =>
      repository.update(params);
}

class UpdateWalletParams extends Equatable {
  final int walletId;
  final String title;
  final String seedPhrase;

  const UpdateWalletParams({
    required this.walletId,
    required this.title,
    required this.seedPhrase,
  });

  @override
  List<Object?> get props => [walletId, title, seedPhrase];
}
