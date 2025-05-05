import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class RestoreBackupUsecase extends BaseUseCase<bool, RestoreBackupParams> {
  final ManageDataRepository repository;
  RestoreBackupUsecase(this.repository);

  @override
  FailureOr<bool> call(RestoreBackupParams params) =>
      repository.restoreBackup(params);
}

class RestoreBackupParams extends Equatable {
  final String path;
  final String password;

  const RestoreBackupParams({required this.path, required this.password});

  @override
  List<Object?> get props => [path, password];
}
