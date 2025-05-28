import 'package:control_panel/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../dashboard/presentation/widgets/dashboard_layout.dart';
import '../../domain/models/user_list_item.dart';
import '../controllers/users_controller.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  final _searchController = TextEditingController();
  List<String> selectedRoles = [];
  bool? activeFilter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUsers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadUsers() {
    ref.read(usersControllerProvider.notifier).loadUsers();
  }

  void _onSearchChanged(String query) {
    ref.read(usersControllerProvider.notifier).setSearchQuery(query);
    _loadUsers();
  }

  void _onRoleFilterChanged(List<String> roles) {
    setState(() {
      selectedRoles = roles;
    });
    ref
        .read(usersControllerProvider.notifier)
        .setRoleFilter(roles.isEmpty ? null : roles);
    _loadUsers();
  }

  void _onActiveFilterChanged(bool? isActive) {
    setState(() {
      activeFilter = isActive;
    });
    ref.read(usersControllerProvider.notifier).setActiveFilter(isActive);
    _loadUsers();
  }

  void _onSort(int columnIndex, bool ascending) {
    String? sortField;
    switch (columnIndex) {
      case 0:
        sortField = 'name';
        break;
      case 1:
        sortField = 'email';
        break;
      case 4:
        sortField = 'createdAt';
        break;
      case 5:
        sortField = 'lastLogin';
        break;
      default:
        sortField = null;
    }

    if (sortField != null) {
      ref
          .read(usersControllerProvider.notifier)
          .setSorting(sortField, ascending);
      _loadUsers();
    }
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      selectedRoles = [];
      activeFilter = null;
    });
    ref.read(usersControllerProvider.notifier).clearFilters();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final usersState = ref.watch(usersControllerProvider);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1200;

    return DashboardLayout(
      title: 'User Management',
      selectedIndex: 1,
      child: RefreshIndicator(
        onRefresh: () async => _loadUsers(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Users',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage user accounts and permissions',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.widgetStateProperty(0.6),
                ),
              ),
              const SizedBox(height: 24),

              // Actions Row
              _buildActionsRow(theme, isMobile),
              const SizedBox(height: 16),

              // Filters
              _buildFiltersSection(theme, isMobile, isTablet),
              const SizedBox(height: 16),

              // Users Table
              Expanded(
                child: usersState.isLoading && usersState.users.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : _buildUsersTable(theme),
              ),

              // Pagination
              const SizedBox(height: 16),
              _buildPagination(usersState, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionsRow(ThemeData theme, bool isMobile) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => _onSearchChanged(value),
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: Text(isMobile ? '' : 'Add User'),
            onPressed: () => context.go(AppRoutes.createUser),
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersSection(ThemeData theme, bool isMobile, bool isTablet) {
    final size = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.filter_list),
                const SizedBox(width: 8),
                Text(
                  'Filters',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _clearFilters,
                  child: const Text('Clear All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                // Role filter
                SizedBox(
                  width: isMobile
                      ? double.infinity
                      : (isTablet ? size.width * 0.4 : 250),
                  child: _buildRoleFilter(theme),
                ),

                // Status filter
                SizedBox(
                  width: isMobile
                      ? double.infinity
                      : (isTablet ? size.width * 0.4 : 250),
                  child: _buildStatusFilter(theme),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleFilter(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Role', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _buildRoleChip(Roles.admin, 'Admin'),
            _buildRoleChip(Roles.provider, 'Provider'),
            _buildRoleChip(Roles.providerStaff, 'Staff'),
            _buildRoleChip(Roles.moderator, 'Moderator'),
            _buildRoleChip(Roles.student, 'Student'),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleChip(String role, String label) {
    final isSelected = selectedRoles.contains(role);

    return FilterChip(
      selected: isSelected,
      label: Text(label),
      onSelected: (selected) {
        final newRoles = List<String>.from(selectedRoles);
        if (selected) {
          newRoles.add(role);
        } else {
          newRoles.remove(role);
        }
        _onRoleFilterChanged(newRoles);
      },
    );
  }

  Widget _buildStatusFilter(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        SegmentedButton<bool?>(
          segments: const [
            ButtonSegment<bool?>(value: null, label: Text('All')),
            ButtonSegment<bool?>(value: true, label: Text('Active')),
            ButtonSegment<bool?>(value: false, label: Text('Inactive')),
          ],
          selected: {activeFilter},
          onSelectionChanged: (Set<bool?> selected) {
            _onActiveFilterChanged(selected.first);
          },
        ),
      ],
    );
  }

  Widget _buildUsersTable(ThemeData theme) {
    final usersState = ref.watch(usersControllerProvider);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;

    if (usersState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 16),
            Text('Error loading users', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(usersState.error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadUsers,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (usersState.users.isEmpty && !usersState.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_off_outlined, size: 60, color: Colors.grey),
            const SizedBox(height: 16),
            Text('No users found', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters or add a new user',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.widgetStateProperty(0.6),
              ),
            ),
          ],
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 900,
          sortColumnIndex: usersState.sortBy == null
              ? null
              : _getSortColumnIndex(usersState.sortBy!),
          sortAscending: usersState.sortAscending,
          headingRowColor: WidgetStateProperty.all(theme.colorScheme.surface),
          columns: [
            DataColumn2(
              label: const Text('Name'),
              size: ColumnSize.L,
              onSort: (columnIndex, ascending) =>
                  _onSort(columnIndex, ascending),
            ),
            DataColumn2(
              label: const Text('Email'),
              size: ColumnSize.L,
              onSort: (columnIndex, ascending) =>
                  _onSort(columnIndex, ascending),
            ),
            const DataColumn2(label: Text('Role'), size: ColumnSize.S),
            const DataColumn2(label: Text('Status'), size: ColumnSize.S),
            DataColumn2(
              label: const Text('Created'),
              size: ColumnSize.M,
              onSort: (columnIndex, ascending) =>
                  _onSort(columnIndex, ascending),
            ),
            DataColumn2(
              label: const Text('Last Login'),
              size: ColumnSize.M,
              onSort: (columnIndex, ascending) =>
                  _onSort(columnIndex, ascending),
            ),
            const DataColumn2(label: Text('Actions'), size: ColumnSize.S),
          ],
          rows: usersState.users
              .map((user) => _buildUserRow(user, theme))
              .toList(),
          empty: Center(
            child: usersState.isLoading
                ? const CircularProgressIndicator()
                : const Text('No users found'),
          ),
        ),
      ),
    );
  }

  DataRow _buildUserRow(UserListItem user, ThemeData theme) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: theme.colorScheme.primary.widgetStateProperty(
                  0.2,
                ),
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(user.name, overflow: TextOverflow.ellipsis)),
            ],
          ),
          onTap: () => context.go('${AppRoutes.users}/${user.id}'),
        ),
        DataCell(
          Text(user.email, overflow: TextOverflow.ellipsis),
          onTap: () => context.go('${AppRoutes.users}/${user.id}'),
        ),
        DataCell(
          Wrap(
            spacing: 4,
            children: user.roles.map((role) => _buildRoleBadge(role)).toList(),
          ),
        ),
        DataCell(_buildStatusBadge(user.isActive)),
        DataCell(Text(dateFormat.format(user.createdAt))),
        DataCell(
          user.lastLogin != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dateFormat.format(user.lastLogin!)),
                    Text(
                      timeFormat.format(user.lastLogin!),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.widgetStateProperty(
                          0.6,
                        ),
                      ),
                    ),
                  ],
                )
              : const Text('Never'),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () =>
                    context.go('${AppRoutes.users}/${user.id}/edit'),
                tooltip: 'Edit',
              ),
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'view',
                    child: Row(
                      children: [
                        Icon(Icons.visibility_outlined, size: 20),
                        SizedBox(width: 8),
                        Text('View Details'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'status',
                    child: Row(
                      children: [
                        Icon(
                          user.isActive
                              ? Icons.block_outlined
                              : Icons.check_circle_outlined,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(user.isActive ? 'Deactivate' : 'Activate'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outlined,
                          size: 20,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  switch (value) {
                    case 'view':
                      context.go('${AppRoutes.users}/${user.id}');
                      break;
                    case 'status':
                      _showStatusChangeDialog(user);
                      break;
                    case 'delete':
                      _showDeleteDialog(user);
                      break;
                  }
                },
                tooltip: 'More actions',
                icon: const Icon(Icons.more_vert, size: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoleBadge(String role) {
    Color color;
    String label;

    switch (role) {
      case Roles.admin:
        color = Colors.purple;
        label = 'Admin';
        break;
      case Roles.provider:
        color = Colors.blue;
        label = 'Provider';
        break;
      case Roles.providerStaff:
        color = Colors.teal;
        label = 'Staff';
        break;
      case Roles.moderator:
        color = Colors.amber;
        label = 'Mod';
        break;
      case Roles.student:
        color = Colors.green;
        label = 'Student';
        break;
      default:
        color = Colors.grey;
        label = role;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.widgetStateProperty(0.1),
        border: Border.all(color: color.widgetStateProperty(0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green.widgetStateProperty(0.1)
            : Colors.red.widgetStateProperty(0.1),
        border: Border.all(
          color: isActive
              ? Colors.green.widgetStateProperty(0.5)
              : Colors.red.widgetStateProperty(0.5),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.cancel,
            size: 12,
            color: isActive ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            isActive ? 'Active' : 'Inactive',
            style: TextStyle(
              color: isActive ? Colors.green : Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(UsersState state, ThemeData theme) {
    final totalPages = (state.totalCount / state.pageSize).ceil();
    final hasMultiplePages = totalPages > 1;

    if (!hasMultiplePages) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${state.totalCount} users • Page ${state.currentPage} of $totalPages',
          style: theme.textTheme.bodySmall,
        ),
        Row(
          children: [
            DropdownButton<int>(
              value: state.pageSize,
              items: [10, 25, 50, 100].map((pageSize) {
                return DropdownMenuItem<int>(
                  value: pageSize,
                  child: Text('$pageSize per page'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(usersControllerProvider.notifier).setPageSize(value);
                }
              },
              underline: Container(),
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.first_page),
              onPressed: state.currentPage > 1
                  ? () => ref.read(usersControllerProvider.notifier).goToPage(1)
                  : null,
              tooltip: 'First page',
            ),
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: state.currentPage > 1
                  ? () => ref
                        .read(usersControllerProvider.notifier)
                        .previousPage()
                  : null,
              tooltip: 'Previous page',
            ),
            _buildPageNumberSelector(state, totalPages, theme),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: state.currentPage < totalPages
                  ? () => ref.read(usersControllerProvider.notifier).nextPage()
                  : null,
              tooltip: 'Next page',
            ),
            IconButton(
              icon: const Icon(Icons.last_page),
              onPressed: state.currentPage < totalPages
                  ? () => ref
                        .read(usersControllerProvider.notifier)
                        .goToPage(totalPages)
                  : null,
              tooltip: 'Last page',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPageNumberSelector(
    UsersState state,
    int totalPages,
    ThemeData theme,
  ) {
    return Row(
      children: [
        for (
          int i = _getStartPage(state.currentPage, totalPages);
          i <= _getEndPage(state.currentPage, totalPages);
          i++
        )
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: InkWell(
              onTap: i != state.currentPage
                  ? () => ref.read(usersControllerProvider.notifier).goToPage(i)
                  : null,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: i == state.currentPage
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$i',
                  style: TextStyle(
                    color: i == state.currentPage
                        ? theme.colorScheme.onPrimary
                        : null,
                    fontWeight: i == state.currentPage
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  int _getStartPage(int currentPage, int totalPages) {
    final maxPagesToShow = 5;

    if (totalPages <= maxPagesToShow) {
      return 1;
    }

    final middle = maxPagesToShow ~/ 2;

    if (currentPage <= middle + 1) {
      return 1;
    } else if (currentPage >= totalPages - middle) {
      return totalPages - maxPagesToShow + 1;
    } else {
      return currentPage - middle;
    }
  }

  int _getEndPage(int currentPage, int totalPages) {
    final maxPagesToShow = 5;

    if (totalPages <= maxPagesToShow) {
      return totalPages;
    }

    final middle = maxPagesToShow ~/ 2;

    if (currentPage <= middle + 1) {
      return maxPagesToShow;
    } else if (currentPage >= totalPages - middle) {
      return totalPages;
    } else {
      return currentPage + middle;
    }
  }

  void _showDeleteDialog(UserListItem user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text(
          'Are you sure you want to delete ${user.name}? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(usersControllerProvider.notifier).deleteUser(user.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showStatusChangeDialog(UserListItem user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user.isActive ? 'Deactivate User' : 'Activate User'),
        content: Text(
          user.isActive
              ? 'Are you sure you want to deactivate ${user.name}? They will no longer be able to log in.'
              : 'Are you sure you want to activate ${user.name}? They will be able to log in again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(usersControllerProvider.notifier)
                  .updateUserStatus(user.id, !user.isActive);
            },
            child: Text(user.isActive ? 'Deactivate' : 'Activate'),
          ),
        ],
      ),
    );
  }

  int? _getSortColumnIndex(String sortBy) {
    switch (sortBy) {
      case 'name':
        return 0;
      case 'email':
        return 1;
      case 'createdAt':
        return 4;
      case 'lastLogin':
        return 5;
      default:
        return null;
    }
  }
}
