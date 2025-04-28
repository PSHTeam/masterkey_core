import 'package:drift/drift.dart';

class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get password => text()();
  TextColumn get passwordHint => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
