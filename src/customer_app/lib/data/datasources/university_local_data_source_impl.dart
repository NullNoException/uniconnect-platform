import 'dart:convert';

import 'package:drift/drift.dart';
import '../../core/errors/exceptions.dart';
import '../local/app_database.dart';
import '../models/university_model.dart';
import 'university_local_data_source.dart';

class UniversityLocalDataSourceImpl implements UniversityLocalDataSource {
  final AppDatabase database;

  UniversityLocalDataSourceImpl({required this.database});

  @override
  Future<List<UniversityModel>> getLastUniversities() async {
    try {
      final universities = await database.getAllUniversities();
      return universities
          .map((dbUniversity) => _dbUniversityToModel(dbUniversity))
          .toList();
    } catch (e) {
      throw CacheException(message: 'Failed to retrieve cached universities');
    }
  }

  @override
  Future<void> cacheUniversities(List<UniversityModel> universities) async {
    try {
      final dbUniversities =
          universities
              .map((university) => _modelToDbUniversity(university))
              .toList();
      await database.insertUniversities(dbUniversities);
    } catch (e) {
      throw CacheException(message: 'Failed to cache universities');
    }
  }

  @override
  Future<UniversityModel> getUniversity(String id) async {
    try {
      final university = await database.getUniversityById(id);
      return _dbUniversityToModel(university);
    } catch (e) {
      throw CacheException(message: 'University not found in cache');
    }
  }

  @override
  Future<void> cacheUniversity(UniversityModel university) async {
    try {
      await database.insertUniversity(_modelToDbUniversity(university));
    } catch (e) {
      throw CacheException(message: 'Failed to cache university');
    }
  }

  @override
  Future<List<UniversityModel>> getFeaturedUniversities() async {
    try {
      final universities = await database.getFeaturedUniversities();
      return universities
          .map((dbUniversity) => _dbUniversityToModel(dbUniversity))
          .toList();
    } catch (e) {
      throw CacheException(message: 'Failed to retrieve featured universities');
    }
  }

  @override
  Future<void> cacheFeaturedUniversities(
    List<UniversityModel> universities,
  ) async {
    try {
      final dbUniversities =
          universities.map((university) {
            return _modelToDbUniversity(university, isFeatured: true);
          }).toList();
      await database.insertUniversities(dbUniversities);
    } catch (e) {
      throw CacheException(message: 'Failed to cache featured universities');
    }
  }

  @override
  Future<List<UniversityModel>> getBookmarkedUniversities() async {
    try {
      final bookmarks = await database.getBookmarksByType('university');

      if (bookmarks.isEmpty) {
        return [];
      }

      final universities = await Future.wait(
        bookmarks.map(
          (bookmark) => database.getUniversityById(bookmark.itemId),
        ),
      );

      return universities
          .map((dbUniversity) => _dbUniversityToModel(dbUniversity))
          .toList();
    } catch (e) {
      throw CacheException(
        message: 'Failed to retrieve bookmarked universities',
      );
    }
  }

  @override
  Future<void> cacheBookmarkedUniversities(
    List<UniversityModel> universities,
  ) async {
    try {
      // First cache the university data
      await cacheUniversities(universities);

      // Remove existing bookmarks that might be outdated
      await (database.delete(database.bookmarks)
        ..where((b) => b.itemType.equals('university'))).go();

      // Add new bookmarks as a batch operation
      await database.batch((batch) {
        // Add new bookmarks
        for (final university in universities) {
          batch.insert(
            database.bookmarks,
            BookmarksCompanion.insert(
              itemId: university.id,
              itemType: 'university',
              createdAt: DateTime.now(),
            ),
          );
        }
      });
    } catch (e) {
      throw CacheException(message: 'Failed to cache bookmarked universities');
    }
  }

  @override
  Future<void> addBookmarkedUniversity(UniversityModel university) async {
    try {
      // Cache the university data
      await cacheUniversity(university);

      // Add bookmark entry
      await database.addBookmark(
        BookmarksCompanion.insert(
          itemId: university.id,
          itemType: 'university',
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      throw CacheException(message: 'Failed to add bookmarked university');
    }
  }

  @override
  Future<void> removeBookmarkedUniversity(String universityId) async {
    try {
      await database.removeBookmark(universityId, 'university');
    } catch (e) {
      throw CacheException(message: 'Failed to remove bookmarked university');
    }
  }

  // Helper method to convert DB entity to model
  UniversityModel _dbUniversityToModel(University dbUniversity) {
    return UniversityModel(
      id: dbUniversity.id,
      name: dbUniversity.name,
      country: dbUniversity.country,
      city: dbUniversity.city,
      logoUrl: dbUniversity.logoUrl,
      coverImageUrl: dbUniversity.coverImageUrl,
      foundedYear: dbUniversity.foundedYear,
      description: dbUniversity.description,
      ranking:
          dbUniversity.ranking != null
              ? jsonDecode(dbUniversity.ranking!)
              : null,
      facilities:
          dbUniversity.facilities != null
              ? List<String>.from(jsonDecode(dbUniversity.facilities!))
              : null,
      websiteUrl: dbUniversity.websiteUrl,
      contactEmail: dbUniversity.contactEmail,
      contactPhone: dbUniversity.contactPhone,
    );
  }

  // Helper method to convert model to DB entity
  UniversitiesCompanion _modelToDbUniversity(
    UniversityModel university, {
    bool isFeatured = false,
  }) {
    return UniversitiesCompanion.insert(
      id: university.id,
      name: university.name,
      country: university.country,
      city: university.city,
      logoUrl: Value(university.logoUrl),
      coverImageUrl: Value(university.coverImageUrl),
      foundedYear: Value(university.foundedYear),
      description: Value(university.description),
      ranking: Value(
        university.ranking != null ? jsonEncode(university.ranking) : null,
      ),
      facilities: Value(
        university.facilities != null
            ? jsonEncode(university.facilities)
            : null,
      ),
      websiteUrl: Value(university.websiteUrl),
      contactEmail: Value(university.contactEmail),
      contactPhone: Value(university.contactPhone),
      isFeatured: Value(isFeatured),
      lastUpdated: DateTime.now(),
    );
  }
}
