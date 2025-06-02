import 'package:control_panel/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/system.dart';
import '../controllers/system_controller.dart';
import '../providers/system_providers.dart';

class PlatformSettingsSection extends ConsumerStatefulWidget {
  final bool isDesktop;
  final bool isTablet;

  const PlatformSettingsSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  ConsumerState<PlatformSettingsSection> createState() =>
      _PlatformSettingsSectionState();
}

class _PlatformSettingsSectionState
    extends ConsumerState<PlatformSettingsSection> {
  SettingCategory? _selectedCategory;
  String? _searchQuery;

  @override
  Widget build(BuildContext context) {
    final platformSettingsState = ref.watch(platformSettingsControllerProvider);
    final systemConfig = ref.watch(systemConfigurationProvider);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.settings, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Platform Settings',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showCreateSettingDialog(),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => ref
                      .read(platformSettingsControllerProvider.notifier)
                      .refreshSettings(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Search and Filters
            _buildSearchAndFilters(),
            const SizedBox(height: 16),

            // System Configuration
            systemConfig.when(
              data: (config) => _buildSystemConfigCard(config),
              loading: () => const LinearProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
            const SizedBox(height: 16),

            // Settings List
            _buildSettingsList(platformSettingsState),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search settings...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.isEmpty ? null : value;
              });
              ref
                  .read(platformSettingsControllerProvider.notifier)
                  .searchSettings(_searchQuery ?? '');
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<SettingCategory?>(
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
              isDense: true,
            ),
            value: _selectedCategory,
            items: [
              const DropdownMenuItem<SettingCategory?>(
                value: null,
                child: Text('All Categories'),
              ),
              ...SettingCategory.values.map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name.toUpperCase()),
                ),
              ),
            ],
            onChanged: (category) {
              setState(() {
                _selectedCategory = category;
              });
              ref
                  .read(platformSettingsControllerProvider.notifier)
                  .filterByCategory(category);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSystemConfigCard(SystemConfiguration config) {
    return Card(
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Configuration',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildConfigChip('Environment', config.environment),
                _buildConfigChip('Version', config.version),
                _buildConfigChip(
                  'Maintenance Mode',
                  config.maintenanceMode ? 'Enabled' : 'Disabled',
                  color: config.maintenanceMode ? Colors.red : Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigChip(String label, String value, {Color? color}) {
    return Chip(
      label: Text('$label: $value'),
      backgroundColor: color?.widgetStateProperty(0.1),
      side: BorderSide(color: color ?? Colors.grey),
    );
  }

  Widget _buildSettingsList(PlatformSettingsState state) {
    if (state.isLoading && state.settings.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          children: [
            Text('Error: ${state.error}'),
            ElevatedButton(
              onPressed: () => ref
                  .read(platformSettingsControllerProvider.notifier)
                  .refreshSettings(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.settings.isEmpty) {
      return const Center(child: Text('No settings found'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.settings.length,
      itemBuilder: (context, index) {
        final setting = state.settings[index];
        return _buildSettingTile(setting);
      },
    );
  }

  Widget _buildSettingTile(PlatformSettingsListItem setting) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(setting.displayName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Key: ${setting.settingKey}'),
            Text('Value: ${setting.settingValue}'),
            Text(
              'Updated: ${setting.updatedAt.toString().split(' ')[0]}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        leading: Icon(
          _getCategoryIcon(setting.category),
          color: _getCategoryColor(setting.category),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (setting.isEditable)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _showEditSettingDialog(setting),
              ),
            Chip(
              label: Text(setting.category.name.toUpperCase()),
              backgroundColor: _getCategoryColor(
                setting.category,
              ).widgetStateProperty(0.1),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  IconData _getCategoryIcon(SettingCategory category) {
    switch (category) {
      case SettingCategory.general:
        return Icons.settings;
      case SettingCategory.security:
        return Icons.security;
      case SettingCategory.email:
        return Icons.email;
      case SettingCategory.payment:
        return Icons.payment;
      case SettingCategory.integration:
        return Icons.integration_instructions;
      case SettingCategory.analytics:
        return Icons.analytics;
      case SettingCategory.notification:
        return Icons.notifications;
      case SettingCategory.ui:
        return Icons.design_services;
      case SettingCategory.business:
        return Icons.business;
    }
  }

  Color _getCategoryColor(SettingCategory category) {
    switch (category) {
      case SettingCategory.general:
        return Colors.blue;
      case SettingCategory.security:
        return Colors.red;
      case SettingCategory.email:
        return Colors.green;
      case SettingCategory.payment:
        return Colors.orange;
      case SettingCategory.integration:
        return Colors.purple;
      case SettingCategory.analytics:
        return Colors.teal;
      case SettingCategory.notification:
        return Colors.amber;
      case SettingCategory.ui:
        return Colors.cyan;
      case SettingCategory.business:
        return Colors.indigo;
    }
  }

  void _showCreateSettingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Setting'),
        content: const Text('Setting creation dialog would go here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement setting creation
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEditSettingDialog(PlatformSettingsListItem setting) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${setting.displayName}'),
        content: const Text('Setting edit dialog would go here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement setting update
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
