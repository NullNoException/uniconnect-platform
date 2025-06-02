import '../repositories/system_repository.dart';
import 'system_usecases.dart';

// Composite use case for platform settings configuration (UC-3.4.1)
class ConfigurePlatformSettingsUseCase {
  final GetSettingsUseCase getSettings;
  final GetSettingByIdUseCase getSettingById;
  final GetSettingByKeyUseCase getSettingByKey;
  final UpdateSettingUseCase updateSetting;
  final GetSystemConfigurationUseCase getSystemConfiguration;
  final UpdateSystemConfigurationUseCase updateSystemConfiguration;
  final GetFeatureFlagsUseCase getFeatureFlags;
  final UpdateFeatureFlagsUseCase updateFeatureFlags;
  final ToggleMaintenanceModeUseCase toggleMaintenanceMode;

  ConfigurePlatformSettingsUseCase({
    required this.getSettings,
    required this.getSettingById,
    required this.getSettingByKey,
    required this.updateSetting,
    required this.getSystemConfiguration,
    required this.updateSystemConfiguration,
    required this.getFeatureFlags,
    required this.updateFeatureFlags,
    required this.toggleMaintenanceMode,
  });

  factory ConfigurePlatformSettingsUseCase.create(SystemRepository repository) {
    return ConfigurePlatformSettingsUseCase(
      getSettings: GetSettingsUseCase(repository),
      getSettingById: GetSettingByIdUseCase(repository),
      getSettingByKey: GetSettingByKeyUseCase(repository),
      updateSetting: UpdateSettingUseCase(repository),
      getSystemConfiguration: GetSystemConfigurationUseCase(repository),
      updateSystemConfiguration: UpdateSystemConfigurationUseCase(repository),
      getFeatureFlags: GetFeatureFlagsUseCase(repository),
      updateFeatureFlags: UpdateFeatureFlagsUseCase(repository),
      toggleMaintenanceMode: ToggleMaintenanceModeUseCase(repository),
    );
  }
}
