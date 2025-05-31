import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class DeleteCardUsecase extends BaseUseCase<bool, int> {
  final CardRepository repository;
  DeleteCardUsecase(this.repository);

  @override
  FailureOr<bool> call(int params) => repository.deleteCardById(params);
}
