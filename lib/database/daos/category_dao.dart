import 'dart:developer' show log;

import 'package:drift/drift.dart';
import 'package:master_key/dependency_injection.dart';
import 'package:master_key/src/src.dart';

part 'category_dao.g.dart'; // Required for Drift to generate the mixin

@DriftAccessor(tables: [CategoryTable, CategoryItemTable])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);

  Future<int> insertCategory(CategoryTableCompanion category) async {
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
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<List<int>> insertCategoryItem(
    int categoryId, {
    List<int> passwords = const [],
  }) async {
    List<int> insertedId = [];
    for (int i in passwords) {
      final item = await into(categoryItemTable).insert(
        CategoryItemTableCompanion.insert(
          categoryId: categoryId,
          passwordId: i,
        ),
      );
      insertedId.add(item);
    }
    return insertedId;
  }

  Future<(CategoryTableData, List<CategoryItemTableData>)> getCategory(
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

  Future<List<(CategoryTableData, List<CategoryItemTableData>)>> getCategories(
    GetAllCategoriesParams params,
  ) async {
    final categories = select(categoryTable);
    final mode = params.reverse ? OrderingMode.asc : OrderingMode.desc;
    categories.orderBy([
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
    categories.limit(params.limit, offset: params.offset);

    final result = await categories.get();
    List<(CategoryTableData, List<CategoryItemTableData>)> response = [
      for (CategoryTableData item in result) await getCategory(item.id),
    ];

    return response;
  }

  Future<int> updateCategory(CategoryModel category) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    final updateCategory = await (update(categoryTable)
      ..where((tbl) => tbl.id.equals(category.id!))).write(
      CategoryTableCompanion(
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

    log(existingPasswordIds.toString(), name: "existingPasswordIds Items");
    final newPasswords = category.passwords.where(
      (p) => !existingPasswordIds.contains(p.id!),
    );

    log(newPasswords.toString(), name: "newPasswords");

    // Insert new passwords
    for (final passwordId in newPasswords) {
      await into(categoryItemTable).insert(
        CategoryItemTableCompanion.insert(
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
    return updateCategory;
  }

  Future<int> deleteCategory(int id) async {
    await (delete(categoryItemTable)
      ..where((tbl) => tbl.categoryId.equals(id))).go();
    return await (delete(categoryTable)
      ..where((tbl) => tbl.id.equals(id))).go();
  }

  // get categories images
  Future<List<String>> getAllCategoriesImages() async {
    final categories = await select(categoryTable).get();
    return categories
        .map((e) => sl<DatabaseEncryptorService>().decryptText(e.iconPath))
        .toList();
  }
}
