import 'dart:io';
import 'package:customer_app/domain/entities/university.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/universities_table.dart';
import 'tables/programs_table.dart';
import 'tables/bookmarks_table.dart';
import 'tables/user_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Universities, Programs, Bookmarks, Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Add future migrations here
      },
    );
  }

  // University methods
  Future<List<University>> getAllUniversities() => select(universities).get();

  Future<University> getUniversityById(String id) {
    return (select(universities)..where((u) => u.id.equals(id))).getSingle();
  }

  Future<int> insertUniversity(UniversitiesCompanion university) {
    return into(universities).insert(university, mode: InsertMode.replace);
  }

  Future<void> insertUniversities(
    List<UniversitiesCompanion> universitiesList,
  ) async {
    await batch((batch) {
      batch.insertAll(universities, universitiesList, mode: InsertMode.replace);
    });
  }

  Future<List<University>> getFeaturedUniversities() {
    return (select(universities)
      ..where((u) => u.isFeatured.equals(true))).get();
  }

  // Bookmark methods
  Future<List<Bookmark>> getBookmarksByType(String type) {
    return (select(bookmarks)..where((b) => b.itemType.equals(type))).get();
  }

  Future<bool> isBookmarked(String itemId, String type) async {
    final count = await (select(bookmarks)..where(
      (b) => b.itemId.equals(itemId) & b.itemType.equals(type),
    )).get().then((value) => value.length);
    return count > 0;
  }

  Future<int> addBookmark(BookmarksCompanion bookmark) {
    return into(bookmarks).insert(bookmark);
  }

  Future<int> removeBookmark(String itemId, String type) {
    return (delete(bookmarks)
      ..where((b) => b.itemId.equals(itemId) & b.itemType.equals(type))).go();
  }

  // Program methods
  Future<List<Program>> getAllPrograms() => select(programs).get();

  Future<Program> getProgramById(String id) {
    return (select(programs)..where((p) => p.id.equals(id))).getSingle();
  }

  Future<List<Program>> getProgramsByUniversity(String universityId) {
    return (select(programs)
      ..where((p) => p.universityId.equals(universityId))).get();
  }

  Future<int> insertProgram(ProgramsCompanion program) {
    return into(programs).insert(program, mode: InsertMode.replace);
  }

  Future<void> insertPrograms(List<ProgramsCompanion> programsList) async {
    await batch((batch) {
      batch.insertAll(programs, programsList, mode: InsertMode.replace);
    });
  }

  // User methods
  Future<User?> getCurrentUser() {
    return (select(users)).getSingleOrNull();
  }

  Future<int> insertUser(UsersCompanion user) {
    return into(users).insert(user, mode: InsertMode.replace);
  }

  Future<int> deleteUser() {
    return delete(users).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'uniconnect.sqlite'));
    return NativeDatabase(file);
  });
}
