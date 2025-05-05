import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class SearchCardUsecase
    extends BaseUseCase<List<CardEntity>, SearchCardParams> {
  final CardRepository repository;
  SearchCardUsecase(this.repository);

  @override
  FailureOr<List<CardEntity>> call(SearchCardParams params) async =>
      await repository.searchCards(params);
}

class SearchCardParams {
  final String query;
  final int limit;
  final int offset;

  SearchCardParams({
    required this.query,
    required this.limit,
    required this.offset,
  });
}
