import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_filter.freezed.dart';
part 'dashboard_filter.g.dart';

@freezed
abstract class DashboardFilter with _$DashboardFilter {
  const factory DashboardFilter({
    @Default(DashboardTimeRange.thisMonth) DashboardTimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
    @Default([]) List<String> serviceCategories,
    @Default([]) List<String> providerIds,
    @Default('') String searchQuery,
  }) = _DashboardFilter;

  factory DashboardFilter.fromJson(Map<String, dynamic> json) =>
      _$DashboardFilterFromJson(json);
}

enum DashboardTimeRange {
  @JsonValue('today')
  today,
  @JsonValue('thisWeek')
  thisWeek,
  @JsonValue('thisMonth')
  thisMonth,
  @JsonValue('thisYear')
  thisYear,
  @JsonValue('custom')
  custom,
}

extension DashboardTimeRangeExtension on DashboardTimeRange {
  String get displayName {
    switch (this) {
      case DashboardTimeRange.today:
        return 'Today';
      case DashboardTimeRange.thisWeek:
        return 'This Week';
      case DashboardTimeRange.thisMonth:
        return 'This Month';
      case DashboardTimeRange.thisYear:
        return 'This Year';
      case DashboardTimeRange.custom:
        return 'Custom Range';
    }
  }

  DateTimeRange get dateRange {
    final now = DateTime.now();
    switch (this) {
      case DashboardTimeRange.today:
        final startOfDay = DateTime(now.year, now.month, now.day);
        final endOfDay = startOfDay.add(const Duration(days: 1));
        return DateTimeRange(start: startOfDay, end: endOfDay);
      case DashboardTimeRange.thisWeek:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final startOfWeekDay = DateTime(
          startOfWeek.year,
          startOfWeek.month,
          startOfWeek.day,
        );
        final endOfWeek = startOfWeekDay.add(const Duration(days: 7));
        return DateTimeRange(start: startOfWeekDay, end: endOfWeek);
      case DashboardTimeRange.thisMonth:
        final startOfMonth = DateTime(now.year, now.month, 1);
        final endOfMonth = DateTime(now.year, now.month + 1, 1);
        return DateTimeRange(start: startOfMonth, end: endOfMonth);
      case DashboardTimeRange.thisYear:
        final startOfYear = DateTime(now.year, 1, 1);
        final endOfYear = DateTime(now.year + 1, 1, 1);
        return DateTimeRange(start: startOfYear, end: endOfYear);
      case DashboardTimeRange.custom:
        // Return a default range, will be overridden by custom dates
        return DateTimeRange(
          start: now.subtract(const Duration(days: 30)),
          end: now,
        );
    }
  }
}
