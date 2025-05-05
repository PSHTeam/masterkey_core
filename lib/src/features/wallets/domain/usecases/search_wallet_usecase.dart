import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class SearchWalletUsecase
    extends BaseUseCase<List<Wallet>, SearchWalletParams> {
  final WalletRepository repository;
  SearchWalletUsecase(this.repository);

  @override
  FailureOr<List<Wallet>> call(SearchWalletParams params) async =>
      await repository.searchWallet(params);
}

class SearchWalletParams {
  final String query;
  final int limit;
  final int offset;

  SearchWalletParams({
    required this.query,
    required this.limit,
    required this.offset,
  });
}
