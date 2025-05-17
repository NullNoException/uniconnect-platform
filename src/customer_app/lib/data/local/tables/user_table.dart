import 'package:drift/drift.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get profileImage => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isEmailVerified =>
      boolean().withDefault(const Constant(false))();
  TextColumn get authToken => text().nullable()();
  DateTimeColumn get lastLoggedIn => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
