import 'package:drift/drift.dart';
import 'package:masterkey_core/src/src.dart';

class CollectionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get iconPath => text()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}

class CollectionItemTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get collectionId => integer().references(CollectionTable, #id)();
  IntColumn get passwordId => integer().references(PasswordTable, #id)();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
