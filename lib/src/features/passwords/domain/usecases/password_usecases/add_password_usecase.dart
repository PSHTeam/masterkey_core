import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class AddPasswordUsecase extends BaseUseCase<Password, PasswordModel> {
  final PasswordRepository repository;
  AddPasswordUsecase(this.repository);

  @override
  FailureOr<Password> call(PasswordModel params) =>
      repository.addPassword(params);
}
