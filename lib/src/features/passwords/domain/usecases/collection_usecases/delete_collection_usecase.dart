import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class DeleteCollectionUsecase extends BaseUseCase<bool, int> {
  final CollectionRepository repository;
  DeleteCollectionUsecase(this.repository);

  @override
  FailureOr<bool> call(int params) => repository.deleteCollection(params);
}
