import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class UpdateCollectionUsecase extends BaseUseCase<Collection, CollectionModel> {
  final CollectionRepository repository;
  UpdateCollectionUsecase(this.repository);

  @override
  FailureOr<Collection> call(CollectionModel params) =>
      repository.updateCollection(params);
}
