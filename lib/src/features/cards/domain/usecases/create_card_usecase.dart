import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class CreateCardUsecase extends BaseUseCase<CardEntity, CardModel> {
  final CardRepository repository;
  CreateCardUsecase(this.repository);

  @override
  FailureOr<CardEntity> call(CardModel params) => repository.createCard(params);
}
