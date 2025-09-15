import 'dart:io';

import 'package:injectable/injectable.dart';

import 'package:masterkey_core/src/src.dart';

abstract class CollectionLocalDatasource {
  Future<List<CollectionModel>> getAllCollections(GetCollectionsParams params);
  Future<CollectionModel> addCollection(CollectionModel collection);
  Future<CollectionModel> updateCollection(CollectionModel collection);
  Future<bool> deleteCollection(int collectionId);
  Future<List<CollectionModel>> getPasswordCollections(int passwordId);
}

@LazySingleton(as: CollectionLocalDatasource)
class CollectionLocalDatasourceImpl implements CollectionLocalDatasource {
  final AppDatabaseWrapper appDatabase;
  final Directory resourcesDir;
  CollectionLocalDatasourceImpl(this.appDatabase, this.resourcesDir);

  @override
  Future<List<CollectionModel>> getAllCollections(
    GetCollectionsParams params,
  ) async {
    try {
      final collectionData = await appDatabase.db.collectionDao.getCollections(
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
            resourcesDir: resourcesDir,
          ),
        );
      }
      return collections;
    } catch (e) {
      throw CustomFailure(e.toString());
    }
  }

  @override
  Future<CollectionModel> addCollection(CollectionModel params) async {
    final newCollectionId = await appDatabase.db.collectionDao.insertCollection(
      params.toTableCompanion(),
    );

    final passwordIds = await appDatabase.db.collectionDao.insertCollectionItem(
      newCollectionId,
      passwords: params.passwords.map((e) => e.id!).toList(),
    );

    if (passwordIds.length != params.passwords.length) throw UnknownFailure();

    return await getCollectionInfo(newCollectionId);
  }

  @override
  Future<CollectionModel> updateCollection(CollectionModel collection) async {
    final updateId = await appDatabase.db.collectionDao.updateCollection(
      collection,
    );
    if (updateId == 0) throw UnknownFailure();

    return await getCollectionInfo(collection.id!);
  }

  @override
  Future<bool> deleteCollection(int collectionId) async {
    final response = await appDatabase.db.collectionDao.deleteCollection(
      collectionId,
      resourcesDir,
    );
    if (response == 0) throw UnknownFailure();

    return true;
  }

  Future<CollectionModel> getCollectionInfo(int collectionId) async {
    final collectionData = await appDatabase.db.collectionDao.getCollection(
      collectionId,
    );

    final passwords = collectionData.$2;
    if (passwords.isEmpty) {
      return CollectionModel.fromTableData(
        collectionData.$1,
        resourcesDir: resourcesDir,
      );
    }

    List<PasswordModel> passwordList = await getCollectionPasswords(passwords);
    return CollectionModel.fromTableData(
      collectionData.$1,
      passwords: passwordList,
      resourcesDir: resourcesDir,
    );
  }

  Future<List<PasswordModel>> getCollectionPasswords(
    List<CollectionItemTableData> items,
  ) async {
    final passwordList = items;
    if (passwordList.isEmpty) return [];

    List<PasswordModel> passwords = [];
    for (CollectionItemTableData item in passwordList) {
      final newPassword = await appDatabase.db.passwordDao.getPasswordById(
        item.passwordId,
      );
      if (newPassword == null) continue;
      List<PasswordFieldTableData> getFields = await appDatabase.db.passwordDao
          .getPasswordFields(item.passwordId);
      final List<PasswordFieldModel> passwordFields = [];
      for (PasswordFieldTableData field in getFields) {
        passwordFields.add(PasswordFieldModel.fromTableData(field));
      }

      passwords.add(
        PasswordModel.fromTableData(
          newPassword,
          passwordFields: passwordFields,
          resourcesDir: resourcesDir,
        ),
      );
    }

    return passwords;
  }

  @override
  Future<List<CollectionModel>> getPasswordCollections(int passwordId) async {
    try {
      final collectionData = await appDatabase.db.collectionDao
          .getPasswordCollections(passwordId);

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
            resourcesDir: resourcesDir,
          ),
        );
      }
      return collections;
    } catch (e) {
      throw CustomFailure(e.toString());
    }
  }
}
