import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class GetAllWalletsUsecase
    extends BaseUseCase<List<Wallet>, GetAllWalletsParams> {
  final WalletRepository repository;
  GetAllWalletsUsecase(this.repository);

  @override
  FailureOr<List<Wallet>> call(GetAllWalletsParams params) =>
      repository.getAllWallets(params);
}

class GetAllWalletsParams extends Equatable {
  final int limit;
  final int offset;
  final OrderType order;
  final bool reverse;
  final bool hasArchived;

  const GetAllWalletsParams({
    this.limit = 100,
    this.offset = 0,
    required this.order,
    required this.reverse,
    this.hasArchived = false,
  });

  @override
  List<Object?> get props => [limit, offset, order, reverse, hasArchived];
}
