import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/service.dart';
import '../../domain/usecases/service_usecases.dart';

// Service Category State
class ServiceCategoryState {
  final List<ServiceCategory> categories;
  final List<ServiceSubcategory> subcategories;
  final bool isLoading;
  final String? error;
  final ServiceCategory? selectedCategory;
  final String? selectedCategoryId;

  const ServiceCategoryState({
    this.categories = const [],
    this.subcategories = const [],
    this.isLoading = false,
    this.error,
    this.selectedCategory,
    this.selectedCategoryId,
  });

  ServiceCategoryState copyWith({
    List<ServiceCategory>? categories,
    List<ServiceSubcategory>? subcategories,
    bool? isLoading,
    String? error,
    ServiceCategory? selectedCategory,
    String? selectedCategoryId,
  }) {
    return ServiceCategoryState(
      categories: categories ?? this.categories,
      subcategories: subcategories ?? this.subcategories,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }
}

// Service Category Controller
class ServiceCategoryController extends StateNotifier<ServiceCategoryState> {
  final GetServiceCategoriesUseCase _getServiceCategoriesUseCase;
  final CreateServiceCategoryUseCase _createServiceCategoryUseCase;
  final UpdateServiceCategoryUseCase _updateServiceCategoryUseCase;
  final DeleteServiceCategoryUseCase _deleteServiceCategoryUseCase;
  final GetServiceSubcategoriesUseCase _getServiceSubcategoriesUseCase;
  final CreateServiceSubcategoryUseCase _createServiceSubcategoryUseCase;
  final UpdateServiceSubcategoryUseCase _updateServiceSubcategoryUseCase;
  final DeleteServiceSubcategoryUseCase _deleteServiceSubcategoryUseCase;

  ServiceCategoryController(
    this._getServiceCategoriesUseCase,
    this._createServiceCategoryUseCase,
    this._updateServiceCategoryUseCase,
    this._deleteServiceCategoryUseCase,
    this._getServiceSubcategoriesUseCase,
    this._createServiceSubcategoryUseCase,
    this._updateServiceSubcategoryUseCase,
    this._deleteServiceSubcategoryUseCase,
  ) : super(const ServiceCategoryState());

  Future<void> loadCategories({bool? isActive}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final categories = await _getServiceCategoriesUseCase.call(
        isActive: isActive,
      );

      state = state.copyWith(categories: categories, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadSubcategories(String categoryId) async {
    state = state.copyWith(
      selectedCategoryId: categoryId,
      isLoading: true,
      error: null,
    );

    try {
      final subcategories = await _getServiceSubcategoriesUseCase.call(
        categoryId,
      );

      // Find and set the selected category
      final selectedCategory = state.categories
          .where((cat) => cat.id == categoryId)
          .firstOrNull;

      state = state.copyWith(
        subcategories: subcategories,
        selectedCategory: selectedCategory,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> createCategory(ServiceCategoryRequest request) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final newCategory = await _createServiceCategoryUseCase.call(request);

      // Add the new category to the list
      final updatedCategories = [...state.categories, newCategory];

      state = state.copyWith(categories: updatedCategories, isLoading: false);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> updateCategory(String id, ServiceCategoryRequest request) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final updatedCategory = await _updateServiceCategoryUseCase.call(
        id,
        request,
      );

      // Update the category in the list
      final updatedCategories = state.categories.map((category) {
        if (category.id == id) {
          return updatedCategory;
        }
        return category;
      }).toList();

      state = state.copyWith(categories: updatedCategories, isLoading: false);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> deleteCategory(String id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _deleteServiceCategoryUseCase.call(id);

      // Remove the category from the list
      final updatedCategories = state.categories
          .where((category) => category.id != id)
          .toList();

      state = state.copyWith(categories: updatedCategories, isLoading: false);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> createSubcategory(ServiceSubcategoryRequest request) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final newSubcategory = await _createServiceSubcategoryUseCase.call(
        request,
      );

      // Add the new subcategory to the list if it belongs to the selected category
      if (state.selectedCategoryId == request.categoryId) {
        final updatedSubcategories = [...state.subcategories, newSubcategory];
        state = state.copyWith(subcategories: updatedSubcategories);
      }

      state = state.copyWith(isLoading: false);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> updateSubcategory(
    String id,
    ServiceSubcategoryRequest request,
  ) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final updatedSubcategory = await _updateServiceSubcategoryUseCase.call(
        id,
        request,
      );

      // Update the subcategory in the list
      final updatedSubcategories = state.subcategories.map((subcategory) {
        if (subcategory.id == id) {
          return updatedSubcategory;
        }
        return subcategory;
      }).toList();

      state = state.copyWith(
        subcategories: updatedSubcategories,
        isLoading: false,
      );

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> deleteSubcategory(String id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _deleteServiceSubcategoryUseCase.call(id);

      // Remove the subcategory from the list
      final updatedSubcategories = state.subcategories
          .where((subcategory) => subcategory.id != id)
          .toList();

      state = state.copyWith(
        subcategories: updatedSubcategories,
        isLoading: false,
      );

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> refreshCategories() async {
    await loadCategories();
  }

  Future<void> refreshSubcategories() async {
    if (state.selectedCategoryId != null) {
      await loadSubcategories(state.selectedCategoryId!);
    }
  }

  Future<List<ServiceSubcategory>> getSubcategories(String categoryId) async {
    try {
      return await _getServiceSubcategoriesUseCase.call(categoryId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return [];
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSelectedCategory() {
    state = state.copyWith(
      selectedCategory: null,
      selectedCategoryId: null,
      subcategories: [],
    );
  }
}
