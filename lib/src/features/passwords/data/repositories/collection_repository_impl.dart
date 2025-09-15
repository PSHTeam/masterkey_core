import 'package:dartz/dartz.dart' show Left, Right;
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@LazySingleton(as: CollectionRepository)
class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionLocalDatasource datasource;

  CollectionRepositoryImpl(this.datasource);

  @override
  FailureOr<Collection> addCollection(CollectionModel collection) async {
    try {
      final response = await datasource.addCollection(collection);
      return Right(response.toEntity());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<bool> deleteCollection(int collectionId) async {
    try {
      final response = await datasource.deleteCollection(collectionId);
      return Right(response);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<List<Collection>> getAllCollections(
    GetCollectionsParams params,
  ) async {
    try {
      final List<CollectionModel> response = await datasource.getAllCollections(
        params,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }

  @override
  FailureOr<CollectionModel> updateCollection(
    CollectionModel collection,
  ) async {
    try {
      final response = await datasource.updateCollection(collection);
      return Right(response);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
