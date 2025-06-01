import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/dashboard_state.dart';
import '../../domain/models/dashboard_filter.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardController extends StateNotifier<DashboardState> {
  final DashboardRepository _repository;

  DashboardController(this._repository) : super(const DashboardState());

  /// Load complete dashboard data
  Future<void> loadDashboardData({DashboardFilter? filter}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final newFilter = filter ?? state.filter;
      final data = await _repository.getDashboardData(filter: newFilter);

      state = state.copyWith(
        isLoading: false,
        data: data,
        stats: data.stats,
        chartData: data.requestChart,
        categoryData: data.categoryData,
        recentRequests: data.recentRequests,
        filter: newFilter,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Refresh dashboard data
  Future<void> refreshDashboard() async {
    state = state.copyWith(isRefreshing: true, error: null);

    try {
      await loadDashboardData(filter: state.filter);
      state = state.copyWith(isRefreshing: false);
    } catch (e) {
      state = state.copyWith(isRefreshing: false, error: e.toString());
    }
  }

  /// Load dashboard stats only
  Future<void> loadDashboardStats() async {
    try {
      final stats = await _repository.getDashboardStats();
      state = state.copyWith(stats: stats);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Load chart data with specific time range
  Future<void> loadChartData({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final chartData = await _repository.getServiceRequestChart(
        timeRange: timeRange,
        startDate: startDate,
        endDate: endDate,
      );
      state = state.copyWith(chartData: chartData);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Load service category data
  Future<void> loadCategoryData({
    required DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final categoryData = await _repository.getServiceCategoryData(
        timeRange: timeRange,
        startDate: startDate,
        endDate: endDate,
      );
      state = state.copyWith(categoryData: categoryData);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Load recent service requests
  Future<void> loadRecentRequests({int limit = 10, int offset = 0}) async {
    try {
      final recentRequests = await _repository.getRecentServiceRequests(
        limit: limit,
        offset: offset,
      );
      state = state.copyWith(recentRequests: recentRequests);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Update dashboard filter
  void updateFilter(DashboardFilter newFilter) {
    state = state.copyWith(filter: newFilter);
    loadDashboardData(filter: newFilter);
  }

  /// Update time range filter
  void updateTimeRange(DashboardTimeRange timeRange) {
    final newFilter = state.filter.copyWith(timeRange: timeRange);
    updateFilter(newFilter);
  }

  /// Update custom date range
  void updateDateRange(DateTime startDate, DateTime endDate) {
    final newFilter = state.filter.copyWith(
      timeRange: DashboardTimeRange.custom,
      startDate: startDate,
      endDate: endDate,
    );
    updateFilter(newFilter);
  }

  /// Add service category filter
  void addServiceCategoryFilter(String category) {
    final currentCategories = state.filter.serviceCategories ?? [];
    if (!currentCategories.contains(category)) {
      final newCategories = [...currentCategories, category];
      final newFilter = state.filter.copyWith(serviceCategories: newCategories);
      updateFilter(newFilter);
    }
  }

  /// Remove service category filter
  void removeServiceCategoryFilter(String category) {
    final currentCategories = state.filter.serviceCategories ?? [];
    if (currentCategories.contains(category)) {
      final newCategories = currentCategories
          .where((c) => c != category)
          .toList();
      final newFilter = state.filter.copyWith(serviceCategories: newCategories);
      updateFilter(newFilter);
    }
  }

  /// Clear all filters
  void clearFilters() {
    const newFilter = DashboardFilter();
    updateFilter(newFilter);
  }

  /// Export dashboard data
  Future<String?> exportData(String format) async {
    state = state.copyWith(isExporting: true, error: null);

    try {
      final exportUrl = await _repository.exportDashboardData(
        filter: state.filter,
        format: format,
      );

      state = state.copyWith(isExporting: false, exportUrl: exportUrl);

      return exportUrl;
    } catch (e) {
      state = state.copyWith(isExporting: false, error: e.toString());
      return null;
    }
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Clear export URL
  void clearExportUrl() {
    state = state.copyWith(exportUrl: null);
  }
}
