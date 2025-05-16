import 'package:drift/drift.dart';

class Universities extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get country => text()();
  TextColumn get city => text()();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get coverImageUrl => text().nullable()();
  IntColumn get foundedYear => integer().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get ranking => text().nullable()(); // JSON string
  TextColumn get facilities => text().nullable()(); // JSON string
  TextColumn get websiteUrl => text().nullable()();
  TextColumn get contactEmail => text().nullable()();
  TextColumn get contactPhone => text().nullable()();
  BoolColumn get isFeatured => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
