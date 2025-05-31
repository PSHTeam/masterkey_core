import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:masterkey_core/src/src.dart';

@lazySingleton
class BackupDatabaseUsecase extends BaseUseCase<bool, BackupDatabaseParams> {
  final ManageDataRepository repository;
  BackupDatabaseUsecase(this.repository);

  @override
  FailureOr<bool> call(BackupDatabaseParams params) =>
      repository.backupDatabase(params);
}

class BackupDatabaseParams extends Equatable {
  final bool hasCSV;
  final bool hasSharedPreferences;

  const BackupDatabaseParams({
    this.hasCSV = true,
    this.hasSharedPreferences = true,
  });

  @override
  List<Object?> get props => [hasCSV, hasSharedPreferences];
}
