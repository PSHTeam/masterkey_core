import 'package:drift/drift.dart';

class PasswordTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get iconPath => text()();
  BoolColumn get has2fa => boolean().clientDefault(() => false)();
  TextColumn get authKey => text().nullable()();
  BoolColumn get hasArchived => boolean().clientDefault(() => false)();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  
  //TODO: this Features is not implemented yet, but it's for new version of the app
  // BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  // BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}

class PasswordFieldTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get passwordId => integer().references(PasswordTable, #id)();
  IntColumn get type => integer()();
  IntColumn get order => integer().withDefault(const Constant(0))();
  TextColumn get value => text()();
  
  //TODO: this Features is not implemented yet, but it's for new version of the app
  // BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  // BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
