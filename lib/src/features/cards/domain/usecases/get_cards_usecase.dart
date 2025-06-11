import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class GetCardsUsecase extends BaseUseCase<List<CardEntity>, GetCardsParams> {
  final CardRepository repository;
  GetCardsUsecase(this.repository);

  @override
  FailureOr<List<CardEntity>> call(GetCardsParams params) =>
      repository.getCards(params);
}

class GetCardsParams extends Equatable {
  final int limit;
  final int offset;
  final OrderType order;
  final bool reverse;
  final bool hasArchived;

  const GetCardsParams({
    this.limit = 30,
    this.offset = 0,
    required this.order,
    required this.reverse,
    this.hasArchived = false,
  });

  @override
  List<Object?> get props => [limit, offset, order, reverse, hasArchived];
}
