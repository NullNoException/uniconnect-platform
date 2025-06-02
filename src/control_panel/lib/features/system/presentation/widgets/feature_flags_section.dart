import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/system_providers.dart';

class FeatureFlagsSection extends ConsumerStatefulWidget {
  final bool isDesktop;
  final bool isTablet;

  const FeatureFlagsSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  ConsumerState<FeatureFlagsSection> createState() =>
      _FeatureFlagsSectionState();
}

class _FeatureFlagsSectionState extends ConsumerState<FeatureFlagsSection> {
  String? _searchQuery;

  @override
  Widget build(BuildContext context) {
    final featureFlagsAsync = ref.watch(featureFlagsProvider);

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
                const Icon(Icons.flag, color: Colors.purple),
                const SizedBox(width: 8),
                Text(
                  'Feature Flags',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showCreateFeatureFlagDialog(),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => ref.refresh(featureFlagsProvider),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Search
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search feature flags...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.isEmpty ? null : value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Feature Flags List
            featureFlagsAsync.when(
              data: (featureFlags) => _buildFeatureFlagsList(featureFlags),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  children: [
                    Text('Error: $error'),
                    ElevatedButton(
                      onPressed: () => ref.refresh(featureFlagsProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureFlagsList(Map<String, bool> featureFlags) {
    // Filter flags based on search query
    final filteredFlags = _searchQuery == null
        ? featureFlags
        : Map.fromEntries(
            featureFlags.entries.where(
              (entry) =>
                  entry.key.toLowerCase().contains(_searchQuery!.toLowerCase()),
            ),
          );

    if (filteredFlags.isEmpty) {
      return const Center(child: Text('No feature flags found'));
    }

    final flagGroups = _groupFeatureFlags(filteredFlags);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: flagGroups.length,
      itemBuilder: (context, index) {
        final group = flagGroups[index];
        return _buildFeatureFlagGroup(group);
      },
    );
  }

  List<FeatureFlagGroup> _groupFeatureFlags(Map<String, bool> featureFlags) {
    final groups = <String, List<MapEntry<String, bool>>>{};

    for (final entry in featureFlags.entries) {
      final parts = entry.key.split('_');
      final groupName = parts.isNotEmpty ? parts[0] : 'general';

      groups.putIfAbsent(groupName, () => []).add(entry);
    }

    return groups.entries
        .map((e) => FeatureFlagGroup(name: e.key, flags: e.value))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  Widget _buildFeatureFlagGroup(FeatureFlagGroup group) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ExpansionTile(
        title: Text(
          _formatGroupName(group.name),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${group.flags.length} flag(s)'),
        leading: Icon(
          _getGroupIcon(group.name),
          color: _getGroupColor(group.name),
        ),
        children: group.flags
            .map((flag) => _buildFeatureFlagTile(flag))
            .toList(),
      ),
    );
  }

  Widget _buildFeatureFlagTile(MapEntry<String, bool> flag) {
    return ListTile(
      title: Text(_formatFlagName(flag.key)),
      subtitle: Text(flag.key),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Switch(
            value: flag.value,
            onChanged: (value) => _toggleFeatureFlag(flag.key, value),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
              const PopupMenuItem(
                value: 'history',
                child: Text('View History'),
              ),
            ],
            onSelected: (value) => _handleFeatureFlagAction(value, flag.key),
          ),
        ],
      ),
    );
  }

  String _formatGroupName(String groupName) {
    return groupName
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _formatFlagName(String flagName) {
    return flagName
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  IconData _getGroupIcon(String groupName) {
    switch (groupName.toLowerCase()) {
      case 'auth':
      case 'authentication':
        return Icons.security;
      case 'payment':
      case 'payments':
        return Icons.payment;
      case 'ui':
      case 'interface':
        return Icons.design_services;
      case 'api':
        return Icons.api;
      case 'notification':
      case 'notifications':
        return Icons.notifications;
      case 'analytics':
        return Icons.analytics;
      case 'experimental':
        return Icons.science;
      default:
        return Icons.flag;
    }
  }

  Color _getGroupColor(String groupName) {
    switch (groupName.toLowerCase()) {
      case 'auth':
      case 'authentication':
        return Colors.red;
      case 'payment':
      case 'payments':
        return Colors.green;
      case 'ui':
      case 'interface':
        return Colors.blue;
      case 'api':
        return Colors.orange;
      case 'notification':
      case 'notifications':
        return Colors.purple;
      case 'analytics':
        return Colors.teal;
      case 'experimental':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  void _toggleFeatureFlag(String flagKey, bool value) {
    // TODO: Implement feature flag toggle
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${value ? "Enable" : "Disable"} Feature Flag'),
        content: Text(
          'Are you sure you want to ${value ? "enable" : "disable"} the feature flag "$flagKey"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Call the actual toggle method from controller
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Feature flag "$flagKey" ${value ? "enabled" : "disabled"}',
                  ),
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _handleFeatureFlagAction(String action, String flagKey) {
    switch (action) {
      case 'edit':
        _showEditFeatureFlagDialog(flagKey);
        break;
      case 'delete':
        _showDeleteFeatureFlagDialog(flagKey);
        break;
      case 'history':
        _showFeatureFlagHistory(flagKey);
        break;
    }
  }

  void _showCreateFeatureFlagDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Feature Flag'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Flag Key',
                hintText: 'e.g., ui_new_dashboard',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Describe what this flag controls',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement feature flag creation
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEditFeatureFlagDialog(String flagKey) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Feature Flag: $flagKey'),
        content: const Text('Feature flag edit dialog would go here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement feature flag edit
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteFeatureFlagDialog(String flagKey) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Feature Flag'),
        content: Text(
          'Are you sure you want to delete the feature flag "$flagKey"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement feature flag deletion
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Feature flag "$flagKey" deleted')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showFeatureFlagHistory(String flagKey) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('History: $flagKey'),
        content: const Text('Feature flag history would go here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class FeatureFlagGroup {
  final String name;
  final List<MapEntry<String, bool>> flags;

  FeatureFlagGroup({required this.name, required this.flags});
}
