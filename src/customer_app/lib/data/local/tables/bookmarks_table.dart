import 'package:drift/drift.dart';

class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get itemId => text()();
  TextColumn get itemType => text()(); // 'university' or 'program'
  DateTimeColumn get createdAt => dateTime()();

  // Composite unique key on itemId and itemType
  @override
  List<Set<Column>> get uniqueKeys => [
    {itemId, itemType},
  ];
}
