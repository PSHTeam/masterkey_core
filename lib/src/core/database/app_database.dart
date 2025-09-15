import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:masterkey_core/src/src.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UserTable,
    CollectionTable,
    CollectionItemTable,
    PasswordTable,
    PasswordFieldTable,
    CardTable,
    CardFieldTable,
    WalletTable,
    WalletFieldTable,
  ],
  daos: [UserDao, CollectionDao, PasswordDao, CardDao, WalletDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  static const String name = "master_key";

  static QueryExecutor _openConnection() {
    // get path by `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: name);
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async => await migrator.createAll(),
    onUpgrade: (migrator, from, to) async {},
  );
}

class AppDatabaseWrapper {
  AppDatabase db = AppDatabase();

  static const String name = AppDatabase.name;
  static const String backupName = "master_key_backup.sqlite";
  static const String backupNameZip = "master_key_backup.zip";
  static const String preferencesName = "extractable_info.key";

  static List<String> necessaryFiles = [
    extractable(backupName),
    preferencesName,
  ];

  static String extractable(String name) => "extractable_$name";

  static String backupNameNowZip =
      "${name}_backup_${DateFormat("yyyy_MM_dd", "en").format(DateTime.now())}.zip";
}
