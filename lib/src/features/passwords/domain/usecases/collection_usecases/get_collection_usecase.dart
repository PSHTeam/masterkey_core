import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class GetCollectionUsecase extends BaseUseCase<Collection, int> {
  final CollectionRepository repository;
  GetCollectionUsecase(this.repository);

  @override
  FailureOr<Collection> call(int params) => repository.getCollection(params);
}
