import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class DeletePasswordsUsecase extends BaseUseCase<bool, NoParams> {
  final PasswordRepository repository;
  DeletePasswordsUsecase(this.repository);

  @override
  FailureOr<bool> call(NoParams params) => repository.deletePasswords(params);
}
