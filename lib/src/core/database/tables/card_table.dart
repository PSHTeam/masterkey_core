import 'package:drift/drift.dart';

class CardTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get holderName => text()();
  TextColumn get number => text()();
  DateTimeColumn get expireDate => dateTime()();
  TextColumn get cvv => text()();
  BoolColumn get hasPin => boolean().clientDefault(() => false)();
  TextColumn get pin => text().nullable()();
  BoolColumn get hasArchived => boolean().clientDefault(() => false)();
  IntColumn get styleIndex => integer()();

  //TODO: this Features is not implemented yet, but it's for new version of the app
  // BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  // BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}

class CardFieldTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId => integer().references(CardTable, #id)();
  // .customConstraint('REFERENCES card_table(id) ON DELETE CASCADE')();
  IntColumn get type => integer()();
  TextColumn get value => text()();
  TextColumn get hintText => text().nullable()();

  //TODO: this Features is not implemented yet, but it's for new version of the app
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  IntColumn get order => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
