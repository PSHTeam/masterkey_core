import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class GetAllCollectionsUsecase
    extends BaseUseCase<List<Collection>, GetAllCollectionsParams> {
  final CollectionRepository repository;
  GetAllCollectionsUsecase(this.repository);

  @override
  FailureOr<List<Collection>> call(GetAllCollectionsParams params) =>
      repository.getAllCollections(params);
}

class GetAllCollectionsParams extends Equatable {
  final int limit;
  final int offset;
  final OrderType order;
  final bool reverse;

  const GetAllCollectionsParams({
    this.limit = 10,
    this.offset = 0,
    required this.order,
    required this.reverse,
  });

  @override
  List<Object?> get props => [limit, offset, order, reverse];
}
