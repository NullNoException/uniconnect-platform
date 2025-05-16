import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:customer_app/core/data/mock_program_repository.dart';
import 'package:customer_app/domain/entities/program.dart';
import 'package:customer_app/domain/repositories/program_repository.dart';
import 'package:customer_app/domain/usecases/program_usecases.dart';

// Program search state
final programSearchQueryProvider = StateProvider<String>((ref) => '');

final programSearchResultsProvider = FutureProvider<List<Program>>((ref) {
  final query = ref.watch(programSearchQueryProvider);
  final getProgramsUseCase = ref.watch(getProgramsUseCaseProvider);

  if (query.isEmpty) {
    return [];
  }

  return getProgramsUseCase(
    query: query,
  ).then((result) => result.fold((failure) => [], (programs) => programs));
});

// Program level filter
final programLevelFilterProvider = StateProvider<ProgramLevel?>((ref) => null);

// Featured programs provider
final featuredProgramsProvider = FutureProvider<List<Program>>((ref) {
  final getFeaturedProgramsUseCase = ref.watch(
    getFeaturedProgramsUseCaseProvider,
  );

  return getFeaturedProgramsUseCase().then(
    (result) => result.fold((failure) => [], (programs) => programs),
  );
});

// Programs by university provider
final programsByUniversityProvider =
    FutureProvider.family<List<Program>, String>((ref, universityId) {
      if (universityId.isEmpty) return [];

      final getProgramsByUniversityUseCase = ref.watch(
        getProgramsByUniversityUseCaseProvider,
      );

      return getProgramsByUniversityUseCase(
        universityId,
      ).then((result) => result.fold((failure) => [], (programs) => programs));
    });

// Program details provider
final programDetailsProvider = FutureProvider.family<Program?, String>((
  ref,
  id,
) {
  if (id.isEmpty) return null;

  final getProgramUseCase = ref.watch(getProgramUseCaseProvider);

  return getProgramUseCase(
    id,
  ).then((result) => result.fold((failure) => null, (program) => program));
});

// Bookmarked programs
final bookmarkedProgramsProvider = FutureProvider<List<Program>>((ref) {
  final getBookmarkedProgramsUseCase = ref.watch(
    getBookmarkedProgramsUseCaseProvider,
  );

  return getBookmarkedProgramsUseCase().then(
    (result) => result.fold((failure) => [], (programs) => programs),
  );
});

// Program bookmark state
final programBookmarkStateProvider =
    StateNotifierProvider<ProgramBookmarkNotifier, Map<String, bool>>((ref) {
      final toggleBookmarkUseCase = ref.watch(
        toggleProgramBookmarkUseCaseProvider,
      );
      return ProgramBookmarkNotifier(toggleBookmarkUseCase);
    });

class ProgramBookmarkNotifier extends StateNotifier<Map<String, bool>> {
  final ToggleProgramBookmarkUseCase toggleBookmarkUseCase;

  ProgramBookmarkNotifier(this.toggleBookmarkUseCase) : super({});

  Future<bool> toggleBookmark(String programId) async {
    final result = await toggleBookmarkUseCase(programId);

    return result.fold((failure) => state[programId] ?? false, (isBookmarked) {
      state = {...state, programId: isBookmarked};
      return isBookmarked;
    });
  }

  // Initialize bookmark states from a list of programs
  void initializeFrom(List<Program> programs, List<String> bookmarkedIds) {
    final bookmarks = <String, bool>{};

    for (final program in programs) {
      bookmarks[program.id] = bookmarkedIds.contains(program.id);
    }

    state = {...state, ...bookmarks};
  }

  bool isBookmarked(String programId) {
    return state[programId] ?? false;
  }
}

// Use case providers
// These will be replaced with actual implementations when available
final getProgramsUseCaseProvider = Provider<GetProgramsUseCase>((ref) {
  final repository = ref.watch(programRepositoryProvider);
  return GetProgramsUseCase(repository);
});

final getProgramUseCaseProvider = Provider<GetProgramUseCase>((ref) {
  final repository = ref.watch(programRepositoryProvider);
  return GetProgramUseCase(repository);
});

final getProgramsByUniversityUseCaseProvider =
    Provider<GetProgramsByUniversityUseCase>((ref) {
      final repository = ref.watch(programRepositoryProvider);
      return GetProgramsByUniversityUseCase(repository);
    });

final getFeaturedProgramsUseCaseProvider = Provider<GetFeaturedProgramsUseCase>(
  (ref) {
    final repository = ref.watch(programRepositoryProvider);
    return GetFeaturedProgramsUseCase(repository);
  },
);

final getBookmarkedProgramsUseCaseProvider =
    Provider<GetBookmarkedProgramsUseCase>((ref) {
      final repository = ref.watch(programRepositoryProvider);
      return GetBookmarkedProgramsUseCase(repository);
    });

final toggleProgramBookmarkUseCaseProvider =
    Provider<ToggleProgramBookmarkUseCase>((ref) {
      final repository = ref.watch(programRepositoryProvider);
      return ToggleProgramBookmarkUseCase(repository);
    });

// Mock repository provider
// Will be replaced with a real implementation
final programRepositoryProvider = Provider<ProgramRepository>((ref) {
  return MockProgramRepository();
});
