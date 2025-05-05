import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
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
  static const String backupName = "${name}_backup.sqlite";
  static const String backupNameZip = "${name}_backup.zip";
  static const String prefsName = "extractable_info.key";

  static List<String> necessaryFiles = [extractable(backupName), prefsName];

  static String extractable(String name) => "extractable_$name";

  static QueryExecutor _openConnection() {
    // get path by `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: name);
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    // onCreate: (migrator) async => await migrator.createAll(),
    // onUpgrade: (migrator, from, to) async {},
  );
}
