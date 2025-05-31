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
      final responce = await datasource.addCollection(collection);
      return Right(responce.toEntity());
    } catch (e) {
      // log(e.toString());
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<bool> deleteCollection(int collectionId) async {
    try {
      final responce = await datasource.deleteCollection(collectionId);
      return Right(responce);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<List<Collection>> getAllCollections(
    GetAllCollectionsParams params,
  ) async {
    try {
      final List<CollectionModel> responce = await datasource.getAllCollections(
        params,
      );
      return Right(responce.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      // log(e.toString());
      return Left(e);
    } catch (e) {
      // log(e.toString());
      return Left(CustomFailure(e.toString()));
    }
  }

  @override
  FailureOr<Collection> getCollection(int paramsId) async {
    try {
      final responce = await datasource.getCollection(paramsId);
      return Right(responce);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<CollectionModel> updateCollection(
    CollectionModel collection,
  ) async {
    try {
      final responce = await datasource.updateCollection(collection);
      return Right(responce);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
