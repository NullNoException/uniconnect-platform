import 'package:drift/drift.dart';

class Programs extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get universityId => text()();
  TextColumn get universityName => text().nullable()();
  TextColumn get level => text()(); // enum value as string
  TextColumn get studyMode => text()(); // enum value as string
  IntColumn get durationMonths => integer()();
  TextColumn get language => text()();
  RealColumn get tuitionFee => real().nullable()();
  TextColumn get currency => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get applicationDeadline => dateTime().nullable()();
  DateTimeColumn get startDate => dateTime().nullable()();
  TextColumn get requirements => text().nullable()(); // JSON string
  TextColumn get curriculum => text().nullable()(); // JSON string
  TextColumn get careerOpportunities => text().nullable()(); // JSON string
  RealColumn get applicationFee => real().nullable()();
  BoolColumn get isFeatured => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
