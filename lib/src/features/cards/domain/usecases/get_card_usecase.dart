import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class GetCardUsecase extends BaseUseCase<CardEntity, int> {
  final CardRepository repository;
  GetCardUsecase(this.repository);

  @override
  FailureOr<CardEntity> call(int params) => repository.getCardById(params);
}
