import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class LoginUsecase extends BaseUseCase<User, String> {
  final AuthRepository repository;
  LoginUsecase(this.repository);

  @override
  FailureOr<User> call(String params) => repository.login(params);
}
