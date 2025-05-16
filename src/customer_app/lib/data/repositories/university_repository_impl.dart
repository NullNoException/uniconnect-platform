import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/university.dart';
import '../../domain/repositories/university_repository.dart';
import '../datasources/university_local_data_source.dart';
import '../datasources/university_remote_data_source.dart';

class UniversityRepositoryImpl implements UniversityRepository {
  final UniversityRemoteDataSource remoteDataSource;
  final UniversityLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UniversityRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<University>>> getUniversities({
    String? query,
    String? country,
    int? limit,
    int? offset,
  }) async {
    if (await networkInfo.isConnected()) {
      try {
        final universities = await remoteDataSource.getUniversities(
          query: query,
          country: country,
          limit: limit,
          offset: offset,
        );
        localDataSource.cacheUniversities(universities);
        return Right(universities);
      } on Exception catch (e) {
        return Left(exceptionToFailure(e));
      }
    } else {
      try {
        final localUniversities = await localDataSource.getLastUniversities();
        return Right(localUniversities);
      } on CacheException {
        return const Left(CacheFailure('No cached data available'));
      }
    }
  }

  @override
  Future<Either<Failure, University>> getUniversity(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final university = await remoteDataSource.getUniversity(id);
        localDataSource.cacheUniversity(university);
        return Right(university);
      } on Exception catch (e) {
        return Left(exceptionToFailure(e));
      }
    } else {
      try {
        final localUniversity = await localDataSource.getUniversity(id);
        return Right(localUniversity);
      } on CacheException {
        return const Left(CacheFailure('No cached data available'));
      }
    }
  }

  @override
  Future<Either<Failure, List<University>>> getFeaturedUniversities() async {
    if (await networkInfo.isConnected()) {
      try {
        final universities = await remoteDataSource.getFeaturedUniversities();
        localDataSource.cacheFeaturedUniversities(universities);
        return Right(universities);
      } on Exception catch (e) {
        return Left(exceptionToFailure(e));
      }
    } else {
      try {
        final localUniversities =
            await localDataSource.getFeaturedUniversities();
        return Right(localUniversities);
      } on CacheException {
        return const Left(CacheFailure('No cached data available'));
      }
    }
  }

  @override
  Future<Either<Failure, List<University>>> getBookmarkedUniversities() async {
    if (await networkInfo.isConnected()) {
      try {
        final universities = await remoteDataSource.getBookmarkedUniversities();
        localDataSource.cacheBookmarkedUniversities(universities);
        return Right(universities);
      } on Exception catch (e) {
        return Left(exceptionToFailure(e));
      }
    } else {
      try {
        final localUniversities =
            await localDataSource.getBookmarkedUniversities();
        return Right(localUniversities);
      } on CacheException {
        return const Left(CacheFailure('No cached data available'));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> toggleBookmark(String universityId) async {
    if (await networkInfo.isConnected()) {
      try {
        final isBookmarked = await remoteDataSource.toggleBookmark(
          universityId,
        );
        if (isBookmarked) {
          final university = await remoteDataSource.getUniversity(universityId);
          localDataSource.addBookmarkedUniversity(university);
        } else {
          localDataSource.removeBookmarkedUniversity(universityId);
        }
        return Right(isBookmarked);
      } on Exception catch (e) {
        return Left(exceptionToFailure(e));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
