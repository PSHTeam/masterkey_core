import 'dart:io' show Directory, File;

import 'package:drift/drift.dart';
import 'package:masterkey_core/dependency_injection.dart';
import 'package:path/path.dart' show join;

import 'package:masterkey_core/src/src.dart';

part 'password_dao.g.dart';

@DriftAccessor(tables: [PasswordTable, PasswordFieldTable, CollectionItemTable])
class PasswordDao extends DatabaseAccessor<AppDatabase>
    with _$PasswordDaoMixin {
  PasswordDao(super.db);

  Future<List<PasswordTableData>> getPasswords(
    GetAllPasswordsParams params, {
    bool force = false,
  }) async {
    final encryptor = sl<DatabaseEncryptorService>();
    final passwords = select(passwordTable);
    if (force) {
      final passwordList = await passwords.get();
      return Future.wait(
        passwordList.map((password) async {
          return password.copyWith(
            title: await encryptor.decrypt(password.title),
            iconPath: await encryptor.decrypt(password.iconPath),
            authKey: password.authKey != null
                ? Value(await encryptor.decrypt(password.authKey!))
                : const Value.absent(),
          );
        }),
      );
    }

    passwords.where((tbl) => tbl.hasArchived.equals(params.hasArchived));
    final mode = params.reverse ? OrderingMode.asc : OrderingMode.desc;
    passwords.orderBy([
      switch (params.order) {
        OrderType.byName => (c) => OrderingTerm(
          expression: c.title,
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
    passwords.limit(params.limit, offset: params.offset);

    final output = await passwords.get();
    return Future.wait(
      output.map(
        (password) async => password.copyWith(
          title: await encryptor.decrypt(password.title),
          iconPath: await encryptor.decrypt(password.iconPath),
          authKey: Value(await encryptor.decryptOrNull(password.authKey)),
        ),
      ),
    );
  }

  Future<int> insertPassword(PasswordTableCompanion password) async {
    final encryptionDB = sl<DatabaseEncryptorService>();

    return await into(passwordTable).insert(
      password.copyWith(
        title: Value(await encryptionDB.encrypt(password.title.value)),
        iconPath: Value(await encryptionDB.encrypt(password.iconPath.value)),
        authKey:
            (password.authKey.value != null &&
                password.authKey.value!.isNotEmpty)
            ? Value(await encryptionDB.encrypt(password.authKey.value!))
            : Value.absent(),
      ),
    );
  }

  Future<void> insertPasswordFields({
    required int passwordId,
    required List<PasswordFieldTableCompanion> passwordFields,
  }) async {
    // 1) Fetch existing fields to determine the current max order
    final encryptor = sl<DatabaseEncryptorService>();
    final existingFields = await (select(
      passwordFieldTable,
    )..where((tbl) => tbl.passwordId.equals(passwordId))).get();

    // 2) Find the current max order
    final maxOrder = existingFields.isEmpty
        ? -1
        : existingFields.map((f) => f.order).reduce((a, b) => a > b ? a : b);

    // 3) Insert each new field with an incremented order
    await batch((batch) async {
      for (int i = 0; i < passwordFields.length; i++) {
        final originalCompanion = passwordFields[i];

        // Assign order = (maxOrder + 1 + i)
        final adjustedCompanion = originalCompanion.copyWith(
          order: Value(maxOrder + 1 + i),
          value: Value(await encryptor.encrypt(originalCompanion.value.value)),
        );

        batch.insert(passwordFieldTable, adjustedCompanion);
      }
    });
  }

  Future<PasswordTableData?> getPasswordById(int id) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    final password = await (select(
      passwordTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (password != null) {
      return password.copyWith(
        title: await encryptionDB.decrypt(password.title),
        iconPath: await encryptionDB.decrypt(password.iconPath),
        authKey: password.authKey != null
            ? Value(await encryptionDB.decrypt(password.authKey!))
            : const Value.absent(),
      );
    }
    return password;
  }

  Future<List<PasswordFieldTableData>> getPasswordFields(int passwordId) async {
    final query = select(passwordFieldTable)
      ..where((tbl) => tbl.passwordId.equals(passwordId))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.order)]);

    final rows = await query.get();

    final encryptor = sl<DatabaseEncryptorService>();
    return await Future.wait(
      rows.map((field) async {
        return field.copyWith(value: await encryptor.decrypt(field.value));
      }),
    );
  }

  Future<int> updatePassword(UpdatePasswordParams params) async {
    final encryptionDB = sl<DatabaseEncryptorService>();

    // 1) Update Password
    final password = params.password;
    final updateId =
        await (update(
          passwordTable,
        )..where((tbl) => tbl.id.equals(params.id))).write(
          PasswordTableCompanion(
            title: Value(await encryptionDB.encrypt(password.title)),
            iconPath: Value(
              await encryptionDB.encrypt(password.iconPath.value),
            ),
            updatedAt: Value(DateTime.now()),
          ),
        );

    final fields = params.fields;

    // 2) Fetch the old fields from the DB
    final dbOldFields = await getPasswordFields(params.id);
    final oldFieldMap = {for (var f in dbOldFields) f.type: f};

    // 3) Update existing fields and insert new fields
    // Delete old fields that are no longer present in the updated list
    final updatedFieldIds = params.fields
        .map((f) => f.id)
        .whereType<int>()
        .toSet();
    final oldFieldIds = dbOldFields.map((f) => f.id).toSet();
    final fieldsToDelete = oldFieldIds.difference(updatedFieldIds);

    await batch((batch) async {
      for (var fieldId in fieldsToDelete) {
        batch.deleteWhere(passwordFieldTable, (tbl) => tbl.id.equals(fieldId));
      }

      for (var field in fields) {
        final int typeIndex = field.type.index;
        if (oldFieldMap.containsKey(typeIndex) && field.id != null) {
          bool hasUpdated = oldFieldMap[typeIndex]!.value != field.value;
          batch.update(
            passwordFieldTable,
            PasswordFieldTableCompanion(
              order: Value(field.order),
              value: Value(await encryptionDB.encrypt(field.value)),
              updatedAt: hasUpdated ? Value(DateTime.now()) : Value.absent(),
            ),
            where: (tbl) => tbl.id.equals(field.id!),
          );
        } else {
          batch.insert(
            passwordFieldTable,
            PasswordFieldModel.fromEntity(field).toTableCompanion().copyWith(
              value: Value(await encryptionDB.encrypt(field.value)),
              createdAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
            ),
          );
        }
      }
    });
    final sortedFieldIds = [for (var field in params.fields) field.id ?? -1];
    await reorderPasswordFields(sortedFieldIds);
    return updateId;
  }

  /// Reorder fields for a given password, storing the new order in DB.
  Future<void> reorderPasswordFields(List<int> sortedFieldIds) async {
    // sortedFieldIds is the new order of field IDs, e.g. [26, 27, 28] after dragging
    await batch((batch) {
      for (int i = 0; i < sortedFieldIds.length; i++) {
        final fieldId = sortedFieldIds[i];
        if (fieldId != -1) {
          batch.update(
            passwordFieldTable,
            PasswordFieldTableCompanion(order: Value(i)),
            where: (tbl) => tbl.id.equals(fieldId),
          );
        }
      }
    });
  }

  Future<int> toggle2FA(Toggle2FAParams params) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    final updateId =
        await (update(
          passwordTable,
        )..where((tbl) => tbl.id.equals(params.id))).write(
          PasswordTableCompanion(
            has2fa: Value(params.status),
            authKey: Value(
              params.authKey.isEmpty
                  ? null
                  : await encryptionDB.encrypt(params.authKey),
            ),
            updatedAt: Value(DateTime.now()),
          ),
        );
    return updateId;
  }

  Future<int> toggleArchiveStatus(TogglePasswordArchiveParams params) async {
    return await (update(
      passwordTable,
    )..where((tbl) => tbl.id.equals(params.id))).write(
      PasswordTableCompanion(
        hasArchived: Value(params.status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deletePassword(int id, Directory resourcesDir) async {
    final password = await (select(
      passwordTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

    if (password == null) throw NotFoundFailure();

    if (password.iconPath.isImage) {
      await File(join(resourcesDir.path, password.iconPath)).delete();
    }

    await (delete(
      collectionItemTable,
    )..where((tbl) => tbl.passwordId.equals(id))).go();
    await (delete(
      passwordFieldTable,
    )..where((tbl) => tbl.passwordId.equals(id))).go();

    return await (delete(
      passwordTable,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deletePasswords() async {
    await delete(collectionItemTable).go(); // Delete all collection items first
    await delete(passwordFieldTable).go(); // Delete all password fields first
    return await delete(passwordTable).go(); // Then delete all passwords
  }
}
