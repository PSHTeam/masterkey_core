import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class DeletePasswordUsecase extends BaseUseCase<bool, int> {
  final PasswordRepository repository;
  DeletePasswordUsecase(this.repository);

  @override
  FailureOr<bool> call(int params) => repository.deletePassword(params);
}
