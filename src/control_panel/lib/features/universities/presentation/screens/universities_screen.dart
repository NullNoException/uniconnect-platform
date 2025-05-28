import 'package:control_panel/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../../../core/constants/app_constants.dart';
import '../controllers/universities_controller.dart';
import '../widgets/university_filter_bar.dart';

class UniversitiesScreen extends ConsumerStatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  ConsumerState<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends ConsumerState<UniversitiesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _sortColumn = 'name';
  bool _sortDescending = false;
  int _currentPage = 1;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _loadUniversities());
  }

  Future<void> _loadUniversities() async {
    await ref
        .read(universitiesControllerProvider.notifier)
        .loadUniversities(
          page: _currentPage,
          pageSize: _pageSize,
          searchQuery: _searchController.text.trim(),
          sortBy: _sortColumn,
          sortDescending: _sortDescending,
        );
  }

  void _search() {
    _currentPage = 1;
    _loadUniversities();
  }

  void _sort(String column) {
    if (_sortColumn == column) {
      setState(() {
        _sortDescending = !_sortDescending;
      });
    } else {
      setState(() {
        _sortColumn = column;
        _sortDescending = false;
      });
    }
    _loadUniversities();
  }

  void _goToPage(int page) {
    setState(() {
      _currentPage = page;
    });
    _loadUniversities();
  }

  void _createUniversity() {
    context.push(AppRoutes.createUniversity);
  }

  void _viewDetails(String id) {
    context.push('${AppRoutes.universities}/$id');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(universitiesControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Universities')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Manage Universities',
                  style: theme.textTheme.headlineMedium,
                ),
                ElevatedButton.icon(
                  onPressed: _createUniversity,
                  icon: const Icon(Icons.add),
                  label: const Text('Add University'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            UniversityFilterBar(
              searchController: _searchController,
              onSearch: _search,
            ),
            const SizedBox(height: 16),
            if (state.isLoading && state.universities.isEmpty)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (state.hasError)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Error loading universities',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                      Text(
                        state.errorMessage ?? 'Unknown error',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadUniversities,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              )
            else if (state.universities.isEmpty)
              const Expanded(
                child: Center(child: Text('No universities found')),
              )
            else
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: DataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 600,
                        sortColumnIndex: _getSortColumnIndex(),
                        sortAscending: !_sortDescending,
                        columns: [
                          DataColumn2(
                            label: const Text('Name'),
                            size: ColumnSize.L,
                            onSort: (_, _) => _sort('name'),
                          ),
                          DataColumn2(
                            label: const Text('Country'),
                            onSort: (_, _) => _sort('country'),
                          ),
                          DataColumn2(
                            label: const Text('City'),
                            onSort: (_, _) => _sort('city'),
                          ),
                          const DataColumn2(
                            label: Text('Programs'),
                            numeric: true,
                          ),
                          const DataColumn2(label: Text('Status')),
                          const DataColumn2(
                            label: Text('Actions'),
                            size: ColumnSize.S,
                          ),
                        ],
                        rows: state.universities.map((university) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(university.name),
                                onTap: () => _viewDetails(university.id),
                              ),
                              DataCell(Text(university.country)),
                              DataCell(Text(university.city)),
                              DataCell(
                                Text(university.programCount.toString()),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: university.isActive
                                        ? Colors.green.widgetStateProperty(0.2)
                                        : Colors.red.widgetStateProperty(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    university.isActive ? 'Active' : 'Inactive',
                                    style: TextStyle(
                                      color: university.isActive
                                          ? Colors.green[700]
                                          : Colors.red[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, size: 20),
                                      onPressed: () => context.push(
                                        '${AppRoutes.universities}/${university.id}/edit',
                                      ),
                                      tooltip: 'Edit',
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.visibility,
                                        size: 20,
                                      ),
                                      onPressed: () =>
                                          _viewDetails(university.id),
                                      tooltip: 'View details',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPagination(state),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(dynamic state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (state.isLoading)
          const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: _currentPage > 1
              ? () => _goToPage(_currentPage - 1)
              : null,
        ),
        Text('Page $_currentPage'),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: state.universities.isNotEmpty
              ? () => _goToPage(_currentPage + 1)
              : null,
        ),
      ],
    );
  }

  int? _getSortColumnIndex() {
    switch (_sortColumn) {
      case 'name':
        return 0;
      case 'country':
        return 1;
      case 'city':
        return 2;
      default:
        return 0;
    }
  }
}
