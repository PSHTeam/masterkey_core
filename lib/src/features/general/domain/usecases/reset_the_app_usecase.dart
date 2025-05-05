import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class ResetTheAppUsecase extends BaseUseCase<bool, NoParams> {
  final ManageDataRepository repository;

  ResetTheAppUsecase(this.repository);

  @override
  FailureOr<bool> call(NoParams params) async {
    return await repository.resetTheApp();
  }
}
