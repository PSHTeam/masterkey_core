import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class DeleteDatabaseUsecase extends BaseUseCase<bool, NoParams> {
  final ManageDataRepository repository;

  DeleteDatabaseUsecase(this.repository);

  @override
  FailureOr<bool> call(NoParams params) async {
    return await repository.deleteDatabase();
  }
}
