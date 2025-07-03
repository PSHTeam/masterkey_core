import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class ToggleWalletArchiveStatusUsecase
    extends BaseUseCase<Wallet, ToggleWalletArchiveStatusParams> {
  final WalletRepository repository;
  ToggleWalletArchiveStatusUsecase(this.repository);

  @override
  FailureOr<Wallet> call(ToggleWalletArchiveStatusParams params) =>
      repository.toggleWalletArchiveStatus(params);
}

class ToggleWalletArchiveStatusParams extends Equatable {
  final int id;
  final bool status;

  const ToggleWalletArchiveStatusParams({
    required this.id,
    required this.status,
  });

  @override
  List<Object?> get props => [id, status];
}
