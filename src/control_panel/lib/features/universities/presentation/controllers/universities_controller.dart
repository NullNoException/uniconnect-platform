import 'package:control_panel/core/utils/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/university_request.dart';
import '../../domain/repositories/university_repository.dart';
import 'university_state.dart';

final universitiesControllerProvider =
    StateNotifierProvider<UniversitiesController, UniversityState>(
      (ref) => UniversitiesController(ref.read(universityRepositoryProvider)),
    );

class UniversitiesController extends StateNotifier<UniversityState> {
  final UniversityRepository _repository;

  UniversitiesController(this._repository) : super(const UniversityState());

  Future<void> loadUniversities({
    int page = 1,
    int pageSize = 10,
    String? searchQuery,
    String? sortBy,
    bool? sortDescending,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
        errorMessage: null,
      );

      final universities = await _repository.getUniversities(
        page: page,
        pageSize: pageSize,
        searchQuery: searchQuery,
        sortBy: sortBy,
        sortDescending: sortDescending,
      );

      state = state.copyWith(
        universities: universities,
        currentPage: page,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> getUniversityDetails(String id) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
        errorMessage: null,
      );

      final university = await _repository.getUniversityById(id);

      state = state.copyWith(selectedUniversity: university, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<bool> createUniversity(UniversityRequest request) async {
    try {
      state = state.copyWith(
        isSubmitting: true,
        hasError: false,
        errorMessage: null,
      );

      await _repository.createUniversity(request);

      state = state.copyWith(isSubmitting: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        hasError: true,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> updateUniversity(String id, UniversityRequest request) async {
    try {
      state = state.copyWith(
        isSubmitting: true,
        hasError: false,
        errorMessage: null,
      );

      final updatedUniversity = await _repository.updateUniversity(id, request);

      state = state.copyWith(
        isSubmitting: false,
        selectedUniversity: updatedUniversity,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        hasError: true,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> deleteUniversity(String id) async {
    try {
      state = state.copyWith(
        isSubmitting: true,
        hasError: false,
        errorMessage: null,
      );

      await _repository.deleteUniversity(id);

      state = state.copyWith(isSubmitting: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        hasError: true,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(hasError: false, errorMessage: null);
  }
}
