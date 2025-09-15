import 'package:drift/drift.dart';

class WalletTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get icon => text().nullable()();
  TextColumn get title => text()();
  TextColumn get seedPhrase => text()();
  BoolColumn get hasArchived => boolean().clientDefault(() => false)();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}

class WalletFieldTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get walletId => integer().references(WalletTable, #id)();
  IntColumn get type => integer()();
  TextColumn get value => text()();
  TextColumn get hintText => text().nullable()();
  IntColumn get order => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
