import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:masterkey_core/dependency_injection.dart';
import 'package:masterkey_core/src/src.dart';

part 'collection_dao.g.dart'; // Required for Drift to generate the mixin

@DriftAccessor(tables: [CollectionTable, CollectionItemTable])
class CollectionDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionDaoMixin {
  CollectionDao(super.db);

  Future<int> insertCollection(CollectionTableCompanion category) async {
    try {
      final encryptionDB = sl<DatabaseEncryptorService>();
      return await into(categoryTable).insert(
        category.copyWith(
          name: Value(encryptionDB.encryptText(category.name.value!)),
          iconPath: Value(encryptionDB.encryptText(category.iconPath.value)),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } catch (e) {
      // log(e.toString());
      throw Exception(e);
    }
  }

  Future<List<int>> insertCollectionItem(
    int categoryId, {
    List<int> passwords = const [],
  }) async {
    List<int> insertedId = [];
    for (int i in passwords) {
      final item = await into(categoryItemTable).insert(
        CollectionItemTableCompanion.insert(
          categoryId: categoryId,
          passwordId: i,
        ),
      );
      insertedId.add(item);
    }
    return insertedId;
  }

  Future<(CollectionTableData, List<CollectionItemTableData>)> getCollection(
    int id,
  ) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    final category =
        await (select(categoryTable)
          ..where((tbl) => tbl.id.equals(id))).getSingle();

    final items =
        await (select(categoryItemTable)
          ..where((tbl) => tbl.categoryId.equals(id))).get();

    return (
      category.copyWith(
        name: Value(encryptionDB.decryptText(category.name!)),
        iconPath: encryptionDB.decryptText(category.iconPath),
      ),
      items.toList(),
    );
  }

  Future<List<(CollectionTableData, List<CollectionItemTableData>)>>
  getCategories(GetAllCollectionsParams params) async {
    try {
      final collections = select(categoryTable);
      final mode = params.reverse ? OrderingMode.asc : OrderingMode.desc;
      collections.orderBy([
        switch (params.order) {
          OrderType.byName =>
            (c) => OrderingTerm(
              expression: c.name,
              mode: params.reverse ? OrderingMode.desc : OrderingMode.asc,
            ),
          OrderType.byCreationTime =>
            (c) => OrderingTerm(expression: c.createdAt, mode: mode),
          OrderType.byLastModified =>
            (c) => OrderingTerm(expression: c.updatedAt, mode: mode),
        },
      ]);
      collections.limit(params.limit, offset: params.offset);

      final result = await collections.get();
      List<(CollectionTableData, List<CollectionItemTableData>)> response = [
        for (CollectionTableData item in result) await getCollection(item.id),
      ];
      if (kDebugMode) {
        // log(response.toString(), name: "getCategories");
      }

      return response;
    } catch (e) {
      // s
      // log(e.toString(), name: "getCategories", stackTrace: s);

      throw Exception(e);
    }
  }

  Future<int> updateCollection(CollectionModel category) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    final updateCollection = await (update(categoryTable)
      ..where((tbl) => tbl.id.equals(category.id!))).write(
      CollectionTableCompanion(
        name: Value(encryptionDB.encryptText(category.name)),
        iconPath: Value(encryptionDB.encryptText(category.iconPath)),
        createdAt: Value(category.createdAt),
        updatedAt: Value(DateTime.now()),
      ),
    );

    final existingPasswordIds =
        (await (select(categoryItemTable)
              ..where((tbl) => tbl.categoryId.equals(category.id!))).get())
            .map((item) => item.passwordId)
            .toSet();

    // log(existingPasswordIds.toString(), name: "existingPasswordIds Items");
    final newPasswords = category.passwords.where(
      (p) => !existingPasswordIds.contains(p.id!),
    );

    // log(newPasswords.toString(), name: "newPasswords");

    // Insert new passwords
    for (final passwordId in newPasswords) {
      await into(categoryItemTable).insert(
        CollectionItemTableCompanion.insert(
          categoryId: category.id!,
          passwordId: passwordId.id!,
        ),
      );
    }

    // Delete passwords that no longer exist
    final newPasswordIds = category.passwords.map((p) => p.id!).toSet();
    final passwordsToDelete = existingPasswordIds.difference(newPasswordIds);

    for (final passwordId in passwordsToDelete) {
      await (delete(categoryItemTable)..where(
        (tbl) =>
            tbl.categoryId.equals(category.id!) &
            tbl.passwordId.equals(passwordId),
      )).go();
    }
    return updateCollection;
  }

  Future<int> deleteCollection(int id) async {
    await (delete(categoryItemTable)
      ..where((tbl) => tbl.categoryId.equals(id))).go();
    return await (delete(categoryTable)
      ..where((tbl) => tbl.id.equals(id))).go();
  }

  // get collections images
  Future<List<String>> getAllCategoriesImages() async {
    final collections = await select(categoryTable).get();
    return collections
        .map((e) => sl<DatabaseEncryptorService>().decryptText(e.iconPath))
        .toList();
  }
}
