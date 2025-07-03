import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class UpdatePasswordUsecase
    extends BaseUseCase<Password, UpdatePasswordParams> {
  final PasswordRepository repository;
  UpdatePasswordUsecase(this.repository);

  @override
  FailureOr<Password> call(UpdatePasswordParams params) =>
      repository.updatePassword(params);
}

class UpdatePasswordParams extends Equatable {
  final int id;
  final PasswordModel password;
  final List<PasswordField> fields;

  const UpdatePasswordParams({
    required this.id,
    required this.password,
    required this.fields,
  });

  @override
  List<Object?> get props => [id, password, fields];
}
