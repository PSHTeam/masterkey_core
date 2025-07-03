import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class CreateWalletUsecase extends BaseUseCase<Wallet, WalletParams> {
  final WalletRepository repository;
  CreateWalletUsecase(this.repository);

  @override
  FailureOr<Wallet> call(WalletParams params) => repository.create(params);
}

class WalletParams extends Equatable {
  final String title;
  final String seedPhrase;
  final String note;
  final bool hasArchived;

  const WalletParams({
    required this.title,
    required this.seedPhrase,
    required this.note,
    this.hasArchived = false,
  });

  @override
  List<Object?> get props => [title, seedPhrase, note, hasArchived];
}
