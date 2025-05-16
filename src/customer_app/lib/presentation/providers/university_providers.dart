import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:customer_app/core/data/mock_university_repository.dart';
import 'package:customer_app/domain/entities/university.dart';
import 'package:customer_app/domain/repositories/university_repository.dart';
import 'package:customer_app/domain/usecases/university_usecases.dart';

// University search state
final universitySearchQueryProvider = StateProvider<String>((ref) => '');

final universitySearchResultsProvider = FutureProvider<List<University>>((ref) {
  final query = ref.watch(universitySearchQueryProvider);
  final getUniversitiesUseCase = ref.watch(getUniversitiesUseCaseProvider);

  if (query.isEmpty) {
    return [];
  }

  return getUniversitiesUseCase(query: query).then(
    (result) => result.fold((failure) => [], (universities) => universities),
  );
});

// Featured universities provider
final featuredUniversitiesProvider = FutureProvider<List<University>>((ref) {
  final getFeaturedUniversitiesUseCase = ref.watch(
    getFeaturedUniversitiesUseCaseProvider,
  );

  return getFeaturedUniversitiesUseCase().then(
    (result) => result.fold((failure) => [], (universities) => universities),
  );
});

// University details provider
final universityDetailsProvider = FutureProvider.family<University?, String>((
  ref,
  id,
) {
  if (id.isEmpty) return null;

  final getUniversityUseCase = ref.watch(getUniversityUseCaseProvider);

  return getUniversityUseCase(id).then(
    (result) => result.fold((failure) => null, (university) => university),
  );
});

// Bookmarked universities
final bookmarkedUniversitiesProvider = FutureProvider<List<University>>((ref) {
  final getBookmarkedUniversitiesUseCase = ref.watch(
    getBookmarkedUniversitiesUseCaseProvider,
  );

  return getBookmarkedUniversitiesUseCase().then(
    (result) => result.fold((failure) => [], (universities) => universities),
  );
});

// University bookmark state
class BookmarkState {
  final Map<String, bool> bookmarks;
  final bool isLoading;
  final String? error;

  BookmarkState({required this.bookmarks, this.isLoading = false, this.error});

  BookmarkState copyWith({
    Map<String, bool>? bookmarks,
    bool? isLoading,
    String? error,
  }) {
    return BookmarkState(
      bookmarks: bookmarks ?? this.bookmarks,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

final universityBookmarkStateProvider =
    StateNotifierProvider<UniversityBookmarkNotifier, BookmarkState>((ref) {
      final toggleBookmarkUseCase = ref.watch(
        toggleUniversityBookmarkUseCaseProvider,
      );
      return UniversityBookmarkNotifier(toggleBookmarkUseCase);
    });

class UniversityBookmarkNotifier extends StateNotifier<BookmarkState> {
  final ToggleUniversityBookmarkUseCase toggleBookmarkUseCase;

  UniversityBookmarkNotifier(this.toggleBookmarkUseCase)
    : super(BookmarkState(bookmarks: {}));

  Future<bool> toggleBookmark(String universityId) async {
    state = state.copyWith(isLoading: true);

    final result = await toggleBookmarkUseCase(universityId);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (isBookmarked) {
        final updatedBookmarks = Map<String, bool>.from(state.bookmarks);
        updatedBookmarks[universityId] = isBookmarked;

        state = state.copyWith(
          bookmarks: updatedBookmarks,
          isLoading: false,
          error: null,
        );

        return isBookmarked;
      },
    );
  }

  // Initialize bookmark states from a list of universities
  void initializeFrom(
    List<University> universities,
    List<String> bookmarkedIds,
  ) {
    final bookmarks = <String, bool>{};

    for (final university in universities) {
      bookmarks[university.id] = bookmarkedIds.contains(university.id);
    }

    state = state.copyWith(bookmarks: bookmarks);
  }

  bool isBookmarked(String universityId) {
    return state.bookmarks[universityId] ?? false;
  }
}

// Use case providers
// These will be replaced with actual implementations when available
final getUniversitiesUseCaseProvider = Provider<GetUniversitiesUseCase>((ref) {
  final repository = ref.watch(universityRepositoryProvider);
  return GetUniversitiesUseCase(repository);
});

final getUniversityUseCaseProvider = Provider<GetUniversityUseCase>((ref) {
  final repository = ref.watch(universityRepositoryProvider);
  return GetUniversityUseCase(repository);
});

final getFeaturedUniversitiesUseCaseProvider =
    Provider<GetFeaturedUniversitiesUseCase>((ref) {
      final repository = ref.watch(universityRepositoryProvider);
      return GetFeaturedUniversitiesUseCase(repository);
    });

final getBookmarkedUniversitiesUseCaseProvider =
    Provider<GetBookmarkedUniversitiesUseCase>((ref) {
      final repository = ref.watch(universityRepositoryProvider);
      return GetBookmarkedUniversitiesUseCase(repository);
    });

final toggleUniversityBookmarkUseCaseProvider =
    Provider<ToggleUniversityBookmarkUseCase>((ref) {
      final repository = ref.watch(universityRepositoryProvider);
      return ToggleUniversityBookmarkUseCase(repository);
    });

// Mock repository provider
// Will be replaced with a real implementation
final universityRepositoryProvider = Provider<UniversityRepository>((ref) {
  return MockUniversityRepository();
});
