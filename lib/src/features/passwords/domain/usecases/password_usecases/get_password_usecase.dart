import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class GetPasswordUsecase extends BaseUseCase<Password, int> {
  final PasswordRepository repository;
  GetPasswordUsecase(this.repository);

  @override
  FailureOr<Password> call(int params) => repository.getPassword(params);
}
