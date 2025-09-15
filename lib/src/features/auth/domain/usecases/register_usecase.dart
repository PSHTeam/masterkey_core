import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class RegisterUsecase extends BaseUseCase<User, UserModel> {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  @override
  FailureOr<User> call(UserModel params) => repository.register(params);
}
