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

  static String name = String.fromCharCodes(
    [109, 97, 115, 116, 101, 114, 95, 107, 101, 121],
  );

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


class AppDatabaseWrapper {
  AppDatabase db = AppDatabase();

  static String name = AppDatabase.name;
  static String backupName = String.fromCharCodes(
    [109, 97, 115, 116, 101, 114, 95, 107, 101, 121, 95, 98, 97, 99, 107, 117, 112, 46, 115, 113, 108, 105, 116, 101],
  );
  static String backupNameZip = String.fromCharCodes(
    [109, 97, 115, 116, 101, 114, 95, 107, 101, 121, 95, 98, 97, 99, 107, 117, 112, 46, 122, 105, 112],
  );
  static String prefsName = String.fromCharCodes(
    [101, 120, 116, 114, 97, 99, 116, 97, 98, 108, 101, 95, 105, 110, 102, 111, 46, 107, 101, 121],
  );

  static List<String> necessaryFiles = [extractable(backupName), prefsName];

  static String extractable(String name) => String.fromCharCodes(
    [101, 120, 116, 114, 97, 99, 116, 97, 98, 108, 101, 95, ...name.codeUnits],
  );

  static String backupNameNowZip = String.fromCharCodes([
    ...name.codeUnits,
    95, 98, 97, 99, 107, 117, 112, 95,
    ...DateFormat(String.fromCharCodes(
      [121, 121, 121, 121, 95, 77, 77, 95, 100, 100]
    ), String.fromCharCodes([101, 110])).format(DateTime.now()).codeUnits,
    46, 122, 105, 112
  ]);
}
