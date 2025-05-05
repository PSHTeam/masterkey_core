import 'package:masterkey_core/src/src.dart';

abstract class CollectionRepository {
  FailureOr<List<Collection>> getAllCategories(GetAllCollectionsParams params);
  FailureOr<Collection> getCollection(int paramsId);
  FailureOr<Collection> addCollection(CollectionModel category);
  FailureOr<Collection> updateCollection(CollectionModel category);
  FailureOr<bool> deleteCollection(int categoryId);
}
