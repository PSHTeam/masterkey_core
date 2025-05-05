import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class UpdateUserUsecase extends BaseStreamUsecase<Progress, UpdateUserParams> {
  final AuthRepository repository;
  UpdateUserUsecase(this.repository);

  @override
  StreamFailureOr<Progress> call(UpdateUserParams params) =>
      repository.update(params);
}

class UpdateUserParams {
  final int userId;
  final String password;

  UpdateUserParams({required this.userId, required this.password});
}
