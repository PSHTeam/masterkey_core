import 'package:drift/drift.dart';
import 'package:master_key/src/src.dart';

class CategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get iconPath => text()();

  //TODO: this Features is not implemented yet, but it's for new version of the app
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}

class CategoryItemTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(CategoryTable, #id)();
  IntColumn get passwordId => integer().references(PasswordTable, #id)();

  //TODO: this Features is not implemented yet, but it's for new version of the app
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
