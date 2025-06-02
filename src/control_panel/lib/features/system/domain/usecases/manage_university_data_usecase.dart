import '../repositories/system_repository.dart';
import 'system_usecases.dart';

// Composite use case for university data management (UC-3.4.2)
class ManageUniversityDataUseCase {
  final GetUniversitiesUseCase getUniversities;
  final GetUniversityByIdUseCase getUniversityById;
  final CreateUniversityUseCase createUniversity;
  final UpdateUniversityUseCase updateUniversity;
  final DeleteUniversityUseCase deleteUniversity;
  final ToggleUniversityStatusUseCase toggleUniversityStatus;
  final GetCountriesUseCase getCountries;
  final GetCitiesUseCase getCities;
  final ImportUniversitiesUseCase importUniversities;
  final ExportUniversitiesUseCase exportUniversities;
  final GetUniversityStatsUseCase getUniversityStats;

  ManageUniversityDataUseCase({
    required this.getUniversities,
    required this.getUniversityById,
    required this.createUniversity,
    required this.updateUniversity,
    required this.deleteUniversity,
    required this.toggleUniversityStatus,
    required this.getCountries,
    required this.getCities,
    required this.importUniversities,
    required this.exportUniversities,
    required this.getUniversityStats,
  });

  factory ManageUniversityDataUseCase.create(SystemRepository repository) {
    return ManageUniversityDataUseCase(
      getUniversities: GetUniversitiesUseCase(repository),
      getUniversityById: GetUniversityByIdUseCase(repository),
      createUniversity: CreateUniversityUseCase(repository),
      updateUniversity: UpdateUniversityUseCase(repository),
      deleteUniversity: DeleteUniversityUseCase(repository),
      toggleUniversityStatus: ToggleUniversityStatusUseCase(repository),
      getCountries: GetCountriesUseCase(repository),
      getCities: GetCitiesUseCase(repository),
      importUniversities: ImportUniversitiesUseCase(repository),
      exportUniversities: ExportUniversitiesUseCase(repository),
      getUniversityStats: GetUniversityStatsUseCase(repository),
    );
  }
}
