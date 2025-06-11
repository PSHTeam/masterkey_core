import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class UpdateCardUsecase extends BaseUseCase<CardEntity, CardModel> {
  final CardRepository repository;
  UpdateCardUsecase(this.repository);

  @override
  FailureOr<CardEntity> call(CardModel params) => repository.updateCard(params);
}
