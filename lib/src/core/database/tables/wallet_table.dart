import 'package:drift/drift.dart';

class WalletTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get icon => text().nullable()();
  TextColumn get title => text()();
  TextColumn get seedPhrase => text()();
  BoolColumn get hasArchived => boolean().clientDefault(() => false)();
  
  //TODO: this Features is not implemented yet, but it's for new version of the app
  // BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  // BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

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

  //TODO: this Features is not implemented yet, but it's for new version of the app
  // BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  // BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  IntColumn get order => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
