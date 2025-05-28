import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/university.dart';
import '../../domain/models/university_list_item.dart';

part 'university_state.freezed.dart';

@freezed
abstract class UniversityState with _$UniversityState {
  const factory UniversityState({
    @Default(false) bool isLoading,
    @Default(false) bool isSubmitting,
    @Default([]) List<UniversityListItem> universities,
    University? selectedUniversity,
    @Default(1) int currentPage,
    @Default(0) int totalPages,
    @Default(false) bool hasError,
    String? errorMessage,
  }) = _UniversityState;
}
