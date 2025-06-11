import 'package:masterkey_core/src/src.dart';

abstract class CollectionRepository {
  FailureOr<List<Collection>> getAllCollections(GetCollectionsParams params);
  FailureOr<Collection> getCollection(int paramsId);
  FailureOr<Collection> addCollection(CollectionModel collection);
  FailureOr<Collection> updateCollection(CollectionModel collection);
  FailureOr<bool> deleteCollection(int collectionId);
}
