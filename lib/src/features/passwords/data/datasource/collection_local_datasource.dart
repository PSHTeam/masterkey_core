import 'dart:io';

import 'package:injectable/injectable.dart';

import 'package:masterkey_core/src/src.dart';

abstract class CollectionLocalDatasource {
  Future<List<CollectionModel>> getAllCollections(
    GetAllCollectionsParams params,
  );
  Future<CollectionModel> getCollection(int paramsId);
  Future<CollectionModel> addCollection(CollectionModel collection);
  Future<CollectionModel> updateCollection(CollectionModel collection);
  Future<bool> deleteCollection(int collectionId);
}

@LazySingleton(as: CollectionLocalDatasource)
class CollectionLocalDatasourceImpl implements CollectionLocalDatasource {
  final AppDatabase appDatabase;
  final Directory cacheDir;
  CollectionLocalDatasourceImpl(this.appDatabase, this.cacheDir);

  @override
  Future<List<CollectionModel>> getAllCollections(
    GetAllCollectionsParams params,
  ) async {
    try {
      final collectionData = await appDatabase.collectionDao.getCollections(
        params,
      );

      final List<CollectionModel> collections = [];
      for ((CollectionTableData, List<CollectionItemTableData>) item
          in collectionData) {
        final ids = item.$2;
        List<PasswordModel> collectionItems = [];
        if (ids.isNotEmpty) {
          collectionItems.addAll(await getCollectionPasswords(ids));
        }

        collections.add(
          CollectionModel.fromTableData(
            item.$1,
            passwords: collectionItems,
            cacheDir: cacheDir,
          ),
        );
      }
      return collections;
    } catch (e) {
      // log("$e", name: "CollectionLocalDatasourceImpl");
      throw CustomFailure(e.toString());
    }
  }

  @override
  Future<CollectionModel> addCollection(CollectionModel params) async {
    final newCollectionId = await appDatabase.collectionDao.insertCollection(
      params.toTableCompanion(),
    );

    final passwordIds = await appDatabase.collectionDao.insertCollectionItem(
      newCollectionId,
      passwords: params.passwords.map((e) => e.id!).toList(),
    );

    if (passwordIds.length != params.passwords.length) {
      throw UnknownFailure();
    }

    return await getCollectionInfo(newCollectionId);
  }

  @override
  Future<CollectionModel> getCollection(int paramsId) async {
    return getCollectionInfo(paramsId);
  }

  @override
  Future<CollectionModel> updateCollection(CollectionModel collection) async {
    final updateId = await appDatabase.collectionDao.updateCollection(
      collection,
    );
    if (updateId == 0) throw UnknownFailure();
    final b = await getCollectionInfo(collection.id!);

    return b;
  }

  @override
  Future<bool> deleteCollection(int collectionId) async {
    final responce = await appDatabase.collectionDao.deleteCollection(
      collectionId,
    );
    if (responce == 0) throw UnknownFailure();

    return true;
  }

  Future<CollectionModel> getCollectionInfo(int collectionId) async {
    final collectionData = await appDatabase.collectionDao.getCollection(
      collectionId,
    );

    final passwords = collectionData.$2;
    if (passwords.isEmpty) {
      return CollectionModel.fromTableData(
        collectionData.$1,
        cacheDir: cacheDir,
      );
    }

    List<PasswordModel> passwordList = await getCollectionPasswords(passwords);
    return CollectionModel.fromTableData(
      collectionData.$1,
      passwords: passwordList,
      cacheDir: cacheDir,
    );
  }

  Future<List<PasswordModel>> getCollectionPasswords(
    List<CollectionItemTableData> items,
  ) async {
    final passwordList = items;
    if (passwordList.isEmpty) return [];

    List<PasswordModel> passwords = [];
    for (CollectionItemTableData item in passwordList) {
      final newPassword = await appDatabase.passwordDao.getPasswordById(
        item.passwordId,
      );
      if (newPassword == null) continue;
      List<PasswordFieldTableData> getFields = await appDatabase.passwordDao
          .getPasswordFields(item.passwordId);
      final List<PasswordFieldModel> passwordFields = [];
      for (PasswordFieldTableData field in getFields) {
        passwordFields.add(PasswordFieldModel.fromTableData(field));
      }

      passwords.add(
        PasswordModel.fromTableData(
          newPassword,
          passwordFields: passwordFields,
          cacheDir: cacheDir,
        ),
      );
    }

    return passwords;
  }
}
