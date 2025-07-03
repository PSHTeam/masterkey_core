import 'dart:developer';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:masterkey_core/dependency_injection.dart';
import 'package:masterkey_core/src/src.dart';
import 'package:path/path.dart' show join;

part 'collection_dao.g.dart';

@DriftAccessor(tables: [CollectionTable, CollectionItemTable])
class CollectionDao extends DatabaseAccessor<AppDatabase>
    with _$CollectionDaoMixin {
  CollectionDao(super.db);

  Future<int> insertCollection(CollectionTableCompanion collection) async {
    try {
      final encryptor = sl<DatabaseEncryptorService>();
      return await into(collectionTable).insert(
        collection.copyWith(
          name: Value(await encryptor.encrypt(collection.name.value!)),
          iconPath: Value(await encryptor.encrypt(collection.iconPath.value)),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<int>> insertCollectionItem(
    int collectionId, {
    List<int> passwords = const [],
  }) async {
    List<int> insertedId = [];
    for (int i in passwords) {
      final item = await into(collectionItemTable).insert(
        CollectionItemTableCompanion.insert(
          collectionId: collectionId,
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
    final encryptor = sl<DatabaseEncryptorService>();
    final collection = await (select(
      collectionTable,
    )..where((tbl) => tbl.id.equals(id))).getSingle();

    final items =
        await (select(collectionItemTable)
              ..where((tbl) => tbl.collectionId.equals(id))
              ..where(
                (tbl) => existsQuery(
                  select(passwordTable)..where(
                    (password) =>
                        password.id.equalsExp(tbl.passwordId) &
                        password.hasArchived.equals(false),
                  ),
                ),
              ))
            .get();

    return (
      collection.copyWith(
        name: Value(await encryptor.decrypt(collection.name!)),
        iconPath: await encryptor.decrypt(collection.iconPath),
      ),
      items.toList(),
    );
  }

  Future<List<(CollectionTableData, List<CollectionItemTableData>)>>
  getCollections(GetCollectionsParams params) async {
    try {
      final collections = select(collectionTable);
      final mode = params.reverse ? OrderingMode.asc : OrderingMode.desc;
      collections.orderBy([
        switch (params.order) {
          OrderType.byName => (c) => OrderingTerm(
            expression: c.name,
            mode: params.reverse ? OrderingMode.desc : OrderingMode.asc,
          ),
          OrderType.byCreationTime => (c) => OrderingTerm(
            expression: c.createdAt,
            mode: mode,
          ),
          OrderType.byLastModified => (c) => OrderingTerm(
            expression: c.updatedAt,
            mode: mode,
          ),
        },
      ]);
      collections.limit(params.limit, offset: params.offset);

      final result = await collections.get();
      List<(CollectionTableData, List<CollectionItemTableData>)> response = [
        for (CollectionTableData item in result) await getCollection(item.id),
      ];
      if (kDebugMode) {}

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<(CollectionTableData, List<CollectionItemTableData>)>>
  getPasswordCollections(int passwordId) async {
    try {
      final collections = select(collectionTable);
      collections.orderBy([
        (c) => OrderingTerm(expression: c.updatedAt, mode: OrderingMode.desc),
      ]);
      collections.where(
        (tbl) => existsQuery(
          select(collectionItemTable)
            ..where((item) => item.collectionId.equalsExp(tbl.id))
            ..where((item) => item.passwordId.equals(passwordId)),
        ),
      );

      final result = await collections.get();
      List<(CollectionTableData, List<CollectionItemTableData>)> response = [
        for (CollectionTableData item in result) await getCollection(item.id),
      ];

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> updateCollection(CollectionModel collection) async {
    final encryptor = sl<DatabaseEncryptorService>();
    final updateCollection =
        await (update(
          collectionTable,
        )..where((tbl) => tbl.id.equals(collection.id!))).write(
          CollectionTableCompanion(
            name: Value(await encryptor.encrypt(collection.name)),
            iconPath: Value(await encryptor.encrypt(collection.iconPath.value)),
            createdAt: Value(collection.createdAt),
            updatedAt: Value(DateTime.now()),
          ),
        );

    final existingPasswordIds =
        (await (select(
              collectionItemTable,
            )..where((tbl) => tbl.collectionId.equals(collection.id!))).get())
            .map((item) => item.passwordId)
            .toSet();

    final newPasswords = collection.passwords.where(
      (p) => !existingPasswordIds.contains(p.id!),
    );

    // Insert new passwords
    for (final passwordId in newPasswords) {
      await into(collectionItemTable).insert(
        CollectionItemTableCompanion.insert(
          collectionId: collection.id!,
          passwordId: passwordId.id!,
        ),
      );
    }

    // Delete passwords that no longer exist
    final newPasswordIds = collection.passwords.map((p) => p.id!).toSet();
    final passwordsToDelete = existingPasswordIds.difference(newPasswordIds);

    for (final passwordId in passwordsToDelete) {
      await (delete(collectionItemTable)..where(
            (tbl) =>
                tbl.collectionId.equals(collection.id!) &
                tbl.passwordId.equals(passwordId),
          ))
          .go();
    }
    return updateCollection;
  }

  Future<int> deleteCollection(int id, Directory resourcesDir) async {
    final collection = await (select(
      collectionTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

    if (collection == null) throw NotFoundFailure();
    try {
      if (collection.iconPath.isImage) {
        await File(join(resourcesDir.path, collection.iconPath)).delete();
      }
    } catch (e) {
      if (kDebugMode) {
        log('Failed to delete: ${e.toString()}', error: e);
      }
    }

    await (delete(
      collectionItemTable,
    )..where((tbl) => tbl.collectionId.equals(id))).go();
    return await (delete(
      collectionTable,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  // get collections images
  Future<List<String>> getAllCollectionsImages() async {
    final collections = await select(collectionTable).get();
    return await Future.wait(
      collections.map((e) async {
        return sl<DatabaseEncryptorService>().decrypt(e.iconPath);
      }),
    );
  }
}
