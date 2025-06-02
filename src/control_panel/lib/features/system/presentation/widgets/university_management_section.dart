import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/system.dart';
import '../controllers/system_controller.dart';
import '../providers/system_providers.dart';

class UniversityManagementSection extends ConsumerStatefulWidget {
  final bool isDesktop;
  final bool isTablet;

  const UniversityManagementSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  ConsumerState<UniversityManagementSection> createState() =>
      _UniversityManagementSectionState();
}

class _UniversityManagementSectionState
    extends ConsumerState<UniversityManagementSection> {
  String? _searchQuery;
  String? _selectedCountry;
  bool? _isActiveFilter;

  @override
  Widget build(BuildContext context) {
    final universityState = ref.watch(universityControllerProvider);
    final countriesAsync = ref.watch(countriesProvider);
    final statsAsync = ref.watch(universitiesStatsProvider);

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
                const Icon(Icons.school, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'University Management',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showCreateUniversityDialog(),
                ),
                IconButton(
                  icon: const Icon(Icons.upload),
                  onPressed: () => _showImportDialog(),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => ref
                      .read(universityControllerProvider.notifier)
                      .refreshUniversities(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Statistics Cards
            statsAsync.when(
              data: (stats) => _buildStatsCards(stats),
              loading: () => const LinearProgressIndicator(),
              error: (error, stack) => Text('Error loading stats: $error'),
            ),
            const SizedBox(height: 16),

            // Search and Filters
            countriesAsync.when(
              data: (countries) => _buildSearchAndFilters(countries),
              loading: () => const LinearProgressIndicator(),
              error: (error, stack) => Text('Error loading countries: $error'),
            ),
            const SizedBox(height: 16),

            // Universities List
            _buildUniversitiesList(universityState),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(UniversityStats stats) {
    final cards = [
      _buildStatCard(
        'Total Universities',
        stats.totalUniversities,
        Icons.school,
        Colors.blue,
      ),
      _buildStatCard(
        'Active',
        stats.activeUniversities,
        Icons.check_circle,
        Colors.green,
      ),
      _buildStatCard(
        'Inactive',
        stats.inactiveUniversities,
        Icons.cancel,
        Colors.red,
      ),
      _buildStatCard(
        'Pending Review',
        stats.pendingUniversities,
        Icons.pending,
        Colors.orange,
      ),
    ];

    if (widget.isDesktop) {
      return Row(children: cards.map((card) => Expanded(child: card)).toList());
    } else {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: widget.isTablet ? 4 : 2,
        children: cards,
      );
    }
  }

  Widget _buildStatCard(String title, int value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters(List<String> countries) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search universities...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.isEmpty ? null : value;
                  });
                  ref
                      .read(universityControllerProvider.notifier)
                      .searchUniversities(_searchQuery ?? '');
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String?>(
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                value: _selectedCountry,
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('All Countries'),
                  ),
                  ...countries.map(
                    (country) =>
                        DropdownMenuItem(value: country, child: Text(country)),
                  ),
                ],
                onChanged: (country) {
                  setState(() {
                    _selectedCountry = country;
                  });
                  ref
                      .read(universityControllerProvider.notifier)
                      .filterByCountry(country);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Status: '),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('All'),
              selected: _isActiveFilter == null,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _isActiveFilter = null;
                  });
                  ref
                      .read(universityControllerProvider.notifier)
                      .filterByStatus(null);
                }
              },
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('Active'),
              selected: _isActiveFilter == true,
              onSelected: (selected) {
                setState(() {
                  _isActiveFilter = selected ? true : null;
                });
                ref
                    .read(universityControllerProvider.notifier)
                    .filterByStatus(_isActiveFilter);
              },
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('Inactive'),
              selected: _isActiveFilter == false,
              onSelected: (selected) {
                setState(() {
                  _isActiveFilter = selected ? false : null;
                });
                ref
                    .read(universityControllerProvider.notifier)
                    .filterByStatus(_isActiveFilter);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUniversitiesList(UniversityState state) {
    if (state.isLoading && state.universities.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          children: [
            Text('Error: ${state.error}'),
            ElevatedButton(
              onPressed: () => ref
                  .read(universityControllerProvider.notifier)
                  .refreshUniversities(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.universities.isEmpty) {
      return const Center(child: Text('No universities found'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.universities.length,
      itemBuilder: (context, index) {
        final university = state.universities[index];
        return _buildUniversityTile(university);
      },
    );
  }

  Widget _buildUniversityTile(UniversityListItem university) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(university.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${university.city}, ${university.country}'),
            Text('Type: ${university.type}'),
            if (university.description.isNotEmpty)
              Text(
                university.description,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        leading: CircleAvatar(
          backgroundColor: university.isActive ? Colors.green : Colors.red,
          child: Icon(Icons.school, color: Colors.white),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditUniversityDialog(university),
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'toggle_status',
                  child: Text(university.isActive ? 'Deactivate' : 'Activate'),
                ),
                const PopupMenuItem(
                  value: 'view_details',
                  child: Text('View Details'),
                ),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
              onSelected: (value) => _handleUniversityAction(value, university),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  void _handleUniversityAction(String action, UniversityListItem university) {
    switch (action) {
      case 'toggle_status':
        ref
            .read(universityControllerProvider.notifier)
            .toggleUniversityStatus(university.id, !university.isActive);
        break;
      case 'view_details':
        _showUniversityDetails(university);
        break;
      case 'delete':
        _showDeleteConfirmation(university);
        break;
    }
  }

  void _showCreateUniversityDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New University'),
        content: const Text('University creation dialog would go here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement university creation
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEditUniversityDialog(UniversityListItem university) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${university.name}'),
        content: const Text('University edit dialog would go here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement university update
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showImportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Universities'),
        content: const Text('University import dialog would go here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement university import
            },
            child: const Text('Import'),
          ),
        ],
      ),
    );
  }

  void _showUniversityDetails(UniversityListItem university) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(university.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Country: ${university.country}'),
            Text('City: ${university.city}'),
            Text('Type: ${university.type}'),
            Text('Status: ${university.isActive ? "Active" : "Inactive"}'),
            if (university.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Description:'),
              Text(university.description),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(UniversityListItem university) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete University'),
        content: Text('Are you sure you want to delete ${university.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
              ref
                  .read(universityControllerProvider.notifier)
                  .deleteUniversity(university.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
