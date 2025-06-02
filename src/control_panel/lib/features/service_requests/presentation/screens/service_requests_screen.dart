import 'package:control_panel/features/service_requests/presentation/controllers/service_request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/responsive_scaffold.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../domain/models/service_request.dart';
import '../providers/service_request_providers.dart';
import '../widgets/service_request_filters_widget.dart';
import '../widgets/service_request_stats_widget.dart';
import '../widgets/service_request_list_item_widget.dart';

class ServiceRequestsScreen extends ConsumerStatefulWidget {
  const ServiceRequestsScreen({super.key});

  @override
  ConsumerState<ServiceRequestsScreen> createState() =>
      _ServiceRequestsScreenState();
}

class _ServiceRequestsScreenState extends ConsumerState<ServiceRequestsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    ref.read(serviceRequestControllerProvider.notifier).loadServiceRequests();
    ref.read(serviceRequestControllerProvider.notifier).loadDashboardStats();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(serviceRequestControllerProvider);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;

    return ResponsiveScaffold(
      appBar: const CustomAppBar(
        title: 'Service Requests',
        showNotifications: true,
      ),
      body: Column(
        children: [
          // Stats Cards
          if (state.stats != null) ...[
            ServiceRequestStatsWidget(
              stats: ServiceRequestStats.fromJson(state.stats!),
              pendingDocumentCount: state.pendingDocumentCount,
              overdueRequestsCount: state.overdueRequestsCount,
            ),
            const SizedBox(height: 16),
          ],

          // Search and Filters Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search service requests...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onSubmitted: (value) {
                          ref
                              .read(serviceRequestControllerProvider.notifier)
                              .setSearchQuery(value);
                          ref
                              .read(serviceRequestControllerProvider.notifier)
                              .loadServiceRequests();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _showFilters = !_showFilters;
                        });
                      },
                      icon: Icon(
                        _showFilters
                            ? Icons.filter_list_off
                            : Icons.filter_list,
                      ),
                      tooltip: _showFilters ? 'Hide filters' : 'Show filters',
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.go('/service-requests/create');
                      },
                      icon: const Icon(Icons.add),
                      label: Text(isMobile ? 'New' : 'New Request'),
                    ),
                  ],
                ),
                if (_showFilters) ...[
                  const SizedBox(height: 16),
                  ServiceRequestFiltersWidget(
                    onFiltersChanged: () {
                      ref
                          .read(serviceRequestControllerProvider.notifier)
                          .loadServiceRequests();
                    },
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Service Requests Table
          Expanded(
            child: Card(
              elevation: 2,
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Service Requests (${state.totalCount})',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: state.isLoading
                                  ? null
                                  : () {
                                      ref
                                          .read(
                                            serviceRequestControllerProvider
                                                .notifier,
                                          )
                                          .refresh();
                                    },
                              icon: const Icon(Icons.refresh),
                              tooltip: 'Refresh',
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {
                                switch (value) {
                                  case 'export':
                                    _exportData();
                                    break;
                                  case 'import':
                                    _importData();
                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'export',
                                  child: Row(
                                    children: [
                                      Icon(Icons.download),
                                      SizedBox(width: 8),
                                      Text('Export'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'import',
                                  child: Row(
                                    children: [
                                      Icon(Icons.upload),
                                      SizedBox(width: 8),
                                      Text('Import'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Table Content
                  Expanded(child: _buildTableContent(state, theme, isMobile)),

                  // Pagination
                  if (state.totalCount > state.pageSize)
                    _buildPagination(state, theme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableContent(
    ServiceRequestState state,
    ThemeData theme,
    bool isMobile,
  ) {
    if (state.isLoading && state.serviceRequests.isEmpty) {
      return const Center(child: LoadingWidget());
    }

    if (state.hasError) {
      return Center(
        child: CustomErrorWidget(
          message: state.errorMessage ?? 'An error occurred',
          onRetry: () {
            ref.read(serviceRequestControllerProvider.notifier).refresh();
          },
        ),
      );
    }

    if (state.serviceRequests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No service requests found',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters or create a new request',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    if (isMobile) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: state.serviceRequests.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final request = state.serviceRequests[index];
          return ServiceRequestListItemWidget(
            request: request,
            onTap: () => _navigateToDetails(request.id),
          );
        },
      );
    }

    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 16,
      minWidth: 800,
      columns: [
        DataColumn2(
          label: const Text('ID'),
          size: ColumnSize.S,
          onSort: (columnIndex, ascending) {
            _sortBy('id', ascending);
          },
        ),
        DataColumn2(
          label: const Text('Service'),
          size: ColumnSize.L,
          onSort: (columnIndex, ascending) {
            _sortBy('serviceName', ascending);
          },
        ),
        DataColumn2(
          label: const Text('Student'),
          size: ColumnSize.M,
          onSort: (columnIndex, ascending) {
            _sortBy('studentName', ascending);
          },
        ),
        DataColumn2(
          label: const Text('Provider'),
          size: ColumnSize.M,
          onSort: (columnIndex, ascending) {
            _sortBy('providerName', ascending);
          },
        ),
        DataColumn2(
          label: const Text('Status'),
          size: ColumnSize.M,
          onSort: (columnIndex, ascending) {
            _sortBy('status', ascending);
          },
        ),
        DataColumn2(
          label: const Text('Amount'),
          size: ColumnSize.S,
          numeric: true,
          onSort: (columnIndex, ascending) {
            _sortBy('totalAmount', ascending);
          },
        ),
        DataColumn2(
          label: const Text('Date'),
          size: ColumnSize.M,
          onSort: (columnIndex, ascending) {
            _sortBy('initiatedDate', ascending);
          },
        ),
        const DataColumn2(
          label: Text('Actions'),
          size: ColumnSize.S,
          fixedWidth: 100,
        ),
      ],
      rows: state.serviceRequests.map((request) {
        return DataRow2(
          onTap: () => _navigateToDetails(request.id),
          cells: [
            DataCell(Text(request.id.substring(0, 8))),
            DataCell(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    request.serviceName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (request.hasUnreadMessages)
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'New messages',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            DataCell(Text(request.studentName)),
            DataCell(Text(request.providerName)),
            DataCell(_buildStatusChip(request.status, theme)),
            DataCell(Text('\$${request.totalAmount.toStringAsFixed(2)}')),
            DataCell(Text(_formatDate(request.initiatedDate))),
            DataCell(
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (action) => _handleRowAction(action, request),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'view',
                    child: Row(
                      children: [
                        Icon(Icons.visibility),
                        SizedBox(width: 8),
                        Text('View Details'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  if (request.status.requiresAction)
                    const PopupMenuItem(
                      value: 'process',
                      child: Row(
                        children: [
                          Icon(Icons.play_arrow),
                          SizedBox(width: 8),
                          Text('Process'),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildStatusChip(ServiceRequestStatus status, ThemeData theme) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case ServiceRequestStatus.completed:
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case ServiceRequestStatus.inProgress:
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;
      case ServiceRequestStatus.cancelled:
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      case ServiceRequestStatus.disputed:
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.displayName,
        style: theme.textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPagination(ServiceRequestState state, ThemeData theme) {
    final totalPages = (state.totalCount / state.pageSize).ceil();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing ${((state.currentPage - 1) * state.pageSize) + 1} to '
            '${(state.currentPage * state.pageSize).clamp(0, state.totalCount)} '
            'of ${state.totalCount} entries',
            style: theme.textTheme.bodySmall,
          ),
          Row(
            children: [
              IconButton(
                onPressed: state.currentPage > 1
                    ? () {
                        ref
                            .read(serviceRequestControllerProvider.notifier)
                            .previousPage();
                      }
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Text('${state.currentPage} of $totalPages'),
              IconButton(
                onPressed: state.currentPage < totalPages
                    ? () {
                        ref
                            .read(serviceRequestControllerProvider.notifier)
                            .nextPage();
                      }
                    : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sortBy(String field, bool ascending) {
    ref
        .read(serviceRequestControllerProvider.notifier)
        .setSorting(field, !ascending);
    ref.read(serviceRequestControllerProvider.notifier).loadServiceRequests();
  }

  void _navigateToDetails(String requestId) {
    context.go('/service-requests/$requestId');
  }

  void _handleRowAction(String action, ServiceRequestListItem request) {
    switch (action) {
      case 'view':
        _navigateToDetails(request.id);
        break;
      case 'edit':
        context.go('/service-requests/${request.id}/edit');
        break;
      case 'process':
        context.go('/service-requests/${request.id}/process');
        break;
    }
  }

  void _exportData() {
    // TODO: Implement export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export functionality coming soon')),
    );
  }

  void _importData() {
    // TODO: Implement import functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Import functionality coming soon')),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
