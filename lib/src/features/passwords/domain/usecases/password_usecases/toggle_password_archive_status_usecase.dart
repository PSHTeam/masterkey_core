import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class TogglePasswordArchiveStatusUsecase
    extends BaseUseCase<Password, TogglePasswordArchiveParams> {
  final PasswordRepository repository;
  TogglePasswordArchiveStatusUsecase(this.repository);

  @override
  FailureOr<Password> call(TogglePasswordArchiveParams params) async =>
      await repository.toggleArchiveStatus(params);
}

class TogglePasswordArchiveParams {
  final int id;
  final bool status;

  TogglePasswordArchiveParams({required this.id, required this.status});
}
