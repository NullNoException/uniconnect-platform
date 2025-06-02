import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/system.dart';
import '../../domain/usecases/configure_platform_settings_usecase.dart';
import '../../domain/usecases/manage_university_data_usecase.dart';

// Platform Settings State
class PlatformSettingsState {
  final List<PlatformSettingsListItem> settings;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMoreData;
  final SettingCategory? selectedCategory;
  final String? searchQuery;

  const PlatformSettingsState({
    this.settings = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMoreData = true,
    this.selectedCategory,
    this.searchQuery,
  });

  PlatformSettingsState copyWith({
    List<PlatformSettingsListItem>? settings,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMoreData,
    SettingCategory? selectedCategory,
    String? searchQuery,
  }) {
    return PlatformSettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

// Platform Settings Controller
class PlatformSettingsController extends StateNotifier<PlatformSettingsState> {
  final ConfigurePlatformSettingsUseCase _configurePlatformSettingsUseCase;

  PlatformSettingsController(this._configurePlatformSettingsUseCase)
    : super(const PlatformSettingsState());

  Future<void> loadSettings({bool refresh = false}) async {
    if (refresh) {
      state = state.copyWith(currentPage: 1, settings: []);
    }

    if (state.isLoading || (!state.hasMoreData && !refresh)) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _configurePlatformSettingsUseCase.getSettings(
        page: state.currentPage,
        pageSize: 20,
        category: state.selectedCategory,
        searchQuery: state.searchQuery,
        onlyEditable: null,
      );

      final newSettings = refresh ? result : [...state.settings, ...result];

      state = state.copyWith(
        settings: newSettings,
        isLoading: false,
        currentPage: state.currentPage + 1,
        hasMoreData: result.length == 20,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> searchSettings(String query) async {
    state = state.copyWith(
      searchQuery: query.isEmpty ? null : query,
      currentPage: 1,
      settings: [],
      hasMoreData: true,
    );
    await loadSettings();
  }

  Future<void> filterByCategory(SettingCategory? category) async {
    state = state.copyWith(
      selectedCategory: category,
      currentPage: 1,
      settings: [],
      hasMoreData: true,
    );
    await loadSettings();
  }

  Future<void> refreshSettings() async {
    await loadSettings(refresh: true);
  }

  Future<bool> updateSetting(String id, String value, String? reason) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final request = SettingsUpdateRequest(
        settingValue: value,
        reason: reason,
      );

      await _configurePlatformSettingsUseCase.updateSetting(id, request);

      // Refresh the settings list
      await loadSettings(refresh: true);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// University Management State
class UniversityState {
  final List<UniversityListItem> universities;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMoreData;
  final String? searchQuery;
  final String? selectedCountry;
  final bool? activeFilter;
  final University? selectedUniversity;

  const UniversityState({
    this.universities = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMoreData = true,
    this.searchQuery,
    this.selectedCountry,
    this.activeFilter,
    this.selectedUniversity,
  });

  UniversityState copyWith({
    List<UniversityListItem>? universities,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMoreData,
    String? searchQuery,
    String? selectedCountry,
    bool? activeFilter,
    University? selectedUniversity,
  }) {
    return UniversityState(
      universities: universities ?? this.universities,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      activeFilter: activeFilter ?? this.activeFilter,
      selectedUniversity: selectedUniversity ?? this.selectedUniversity,
    );
  }
}

// University Management Controller
class UniversityController extends StateNotifier<UniversityState> {
  final ManageUniversityDataUseCase _manageUniversityDataUseCase;

  UniversityController(this._manageUniversityDataUseCase)
    : super(const UniversityState());

  Future<void> loadUniversities({bool refresh = false}) async {
    if (refresh) {
      state = state.copyWith(currentPage: 1, universities: []);
    }

    if (state.isLoading || (!state.hasMoreData && !refresh)) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _manageUniversityDataUseCase.getUniversities(
        page: state.currentPage,
        pageSize: 20,
        searchQuery: state.searchQuery,
        country: state.selectedCountry,
        isActive: state.activeFilter,
        sortBy: 'name',
        sortDescending: false,
      );

      final newUniversities = refresh
          ? result
          : [...state.universities, ...result];

      state = state.copyWith(
        universities: newUniversities,
        isLoading: false,
        currentPage: state.currentPage + 1,
        hasMoreData: result.length == 20,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> searchUniversities(String query) async {
    state = state.copyWith(
      searchQuery: query.isEmpty ? null : query,
      currentPage: 1,
      universities: [],
      hasMoreData: true,
    );
    await loadUniversities();
  }

  Future<void> filterByCountry(String? country) async {
    state = state.copyWith(
      selectedCountry: country,
      currentPage: 1,
      universities: [],
      hasMoreData: true,
    );
    await loadUniversities();
  }

  Future<void> filterByStatus(bool? isActive) async {
    state = state.copyWith(
      activeFilter: isActive,
      currentPage: 1,
      universities: [],
      hasMoreData: true,
    );
    await loadUniversities();
  }

  Future<void> refreshUniversities() async {
    await loadUniversities(refresh: true);
  }

  Future<void> loadUniversityById(String id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final university = await _manageUniversityDataUseCase.getUniversityById(
        id,
      );

      state = state.copyWith(selectedUniversity: university, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> createUniversity(UniversityRequest request) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _manageUniversityDataUseCase.createUniversity(request);

      // Refresh the universities list
      await loadUniversities(refresh: true);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> updateUniversity(String id, UniversityRequest request) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _manageUniversityDataUseCase.updateUniversity(id, request);

      // Refresh the universities list and selected university
      await loadUniversities(refresh: true);
      if (state.selectedUniversity?.id == id) {
        await loadUniversityById(id);
      }

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> deleteUniversity(String id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _manageUniversityDataUseCase.deleteUniversity(id);

      // Refresh the universities list
      await loadUniversities(refresh: true);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> toggleUniversityStatus(String id, bool isActive) async {
    try {
      await _manageUniversityDataUseCase.toggleUniversityStatus(id, isActive);

      // Update the local state
      final updatedUniversities = state.universities.map((university) {
        if (university.id == id) {
          return university.copyWith(isActive: isActive);
        }
        return university;
      }).toList();

      state = state.copyWith(universities: updatedUniversities);

      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSelectedUniversity() {
    state = state.copyWith(selectedUniversity: null);
  }
}
