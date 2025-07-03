import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class UpdatePasswordHintUsecase
    extends BaseUseCase<User, UpdatePasswordHintParams> {
  final AuthRepository repository;
  UpdatePasswordHintUsecase(this.repository);

  @override
  FailureOr<User> call(UpdatePasswordHintParams params) async {
    return await repository.updateHint(params);
  }
}

class UpdatePasswordHintParams {
  final String hint;

  UpdatePasswordHintParams({required this.hint});
}
