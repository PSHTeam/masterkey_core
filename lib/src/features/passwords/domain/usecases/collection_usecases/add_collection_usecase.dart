import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class AddCollectionUsecase extends BaseUseCase<Collection, CollectionModel> {
  final CollectionRepository repository;
  AddCollectionUsecase(this.repository);

  @override
  FailureOr<Collection> call(CollectionModel params) =>
      repository.addCollection(params);
}
