import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/models/service.dart';
import '../controllers/service_controller.dart';
import '../providers/service_providers.dart';

class ServiceListWidget extends ConsumerStatefulWidget {
  const ServiceListWidget({super.key});

  @override
  ConsumerState<ServiceListWidget> createState() => _ServiceListWidgetState();
}

class _ServiceListWidgetState extends ConsumerState<ServiceListWidget> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  ServiceApprovalStatus? _selectedStatus;
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(serviceControllerProvider.notifier).loadServices();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(serviceControllerProvider.notifier).loadServices();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final serviceState = ref.watch(serviceControllerProvider);
    final categoriesAsync = ref.watch(serviceCategoriesProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Actions and Filters
          _buildActionsRow(theme),
          const SizedBox(height: 16),
          _buildFiltersRow(theme, categoriesAsync),
          const SizedBox(height: 24),
          // Services List
          Expanded(child: _buildServicesList(theme, serviceState)),
        ],
      ),
    );
  }

  Widget _buildActionsRow(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search services...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref
                              .read(serviceControllerProvider.notifier)
                              .searchServices('');
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                ref
                    .read(serviceControllerProvider.notifier)
                    .searchServices(value);
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () {
            context.go(AppRoutes.createService);
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Service'),
        ),
      ],
    );
  }

  Widget _buildFiltersRow(
    ThemeData theme,
    AsyncValue<List<ServiceCategory>> categoriesAsync,
  ) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        // Status filter
        SizedBox(
          width: 200,
          child: DropdownButtonFormField<ServiceApprovalStatus?>(
            value: _selectedStatus,
            decoration: const InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(),
            ),
            items: [
              const DropdownMenuItem(value: null, child: Text('All Status')),
              ...ServiceApprovalStatus.values.map(
                (status) => DropdownMenuItem(
                  value: status,
                  child: Text(_formatStatus(status)),
                ),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedStatus = value;
              });
              ref
                  .read(serviceControllerProvider.notifier)
                  .filterByStatus(value);
            },
          ),
        ),
        // Category filter
        SizedBox(
          width: 200,
          child: categoriesAsync.when(
            data: (categories) => DropdownButtonFormField<String?>(
              value: _selectedCategoryId,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('All Categories'),
                ),
                ...categories.map(
                  (category) => DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategoryId = value;
                });
                ref
                    .read(serviceControllerProvider.notifier)
                    .filterByCategory(value);
              },
            ),
            loading: () => DropdownButtonFormField<String?>(
              value: null,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: const [],
              onChanged: null,
            ),
            error: (_, __) => DropdownButtonFormField<String?>(
              value: null,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: const [],
              onChanged: null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServicesList(ThemeData theme, ServiceState serviceState) {
    if (serviceState.isLoading && serviceState.services.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (serviceState.error != null && serviceState.services.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Error loading services',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              serviceState.error!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(serviceControllerProvider.notifier).refreshServices();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (serviceState.services.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.business_center_outlined,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text('No services found', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Create your first service to get started',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                context.go(AppRoutes.createService);
              },
              icon: const Icon(Icons.add),
              label: const Text('Create Service'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount:
          serviceState.services.length + (serviceState.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= serviceState.services.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final service = serviceState.services[index];
        return _buildServiceCard(theme, service);
      },
    );
  }

  Widget _buildServiceCard(ThemeData theme, ServiceListItem service) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              service.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _buildStatusChip(theme, service.approvalStatus),
                          if (service.isFeatured == true) ...[
                            const SizedBox(width: 8),
                            Chip(
                              label: const Text(
                                'Featured',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                              backgroundColor: Colors.amber.withOpacity(0.1),
                              side: const BorderSide(color: Colors.amber),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Category: ${service.categoryName}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 16,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            service.providerName,
                            style: theme.textTheme.bodySmall,
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.attach_money,
                            size: 16,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '\$${service.basePrice.toStringAsFixed(2)}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (service.averageRating != null) ...[
                            const SizedBox(width: 16),
                            Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              service.averageRating!.toStringAsFixed(1),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                          if (service.totalOrders != null &&
                              service.totalOrders! > 0) ...[
                            const SizedBox(width: 16),
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 16,
                              color: theme.colorScheme.outline,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${service.totalOrders} orders',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Created: ${DateFormat('MMM dd, yyyy').format(service.createdAt)}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                          if (service.approvalDate != null) ...[
                            const SizedBox(width: 16),
                            Text(
                              'Approved: ${DateFormat('MMM dd, yyyy').format(service.approvalDate!)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ],
                          const Spacer(),
                          if (service.isActive == false)
                            Chip(
                              label: const Text(
                                'Inactive',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              side: const BorderSide(color: Colors.grey),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
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
                    PopupMenuItem(
                      value: 'toggle_status',
                      child: Row(
                        children: [
                          Icon(
                            (service.isActive ?? false)
                                ? Icons.pause_circle
                                : Icons.play_circle,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            (service.isActive ?? false)
                                ? 'Deactivate'
                                : 'Activate',
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'toggle_featured',
                      child: Row(
                        children: [
                          Icon(
                            (service.isFeatured ?? false)
                                ? Icons.star
                                : Icons.star_border,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            (service.isFeatured ?? false)
                                ? 'Unfeature'
                                : 'Feature',
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) => _handleMenuAction(value, service),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(ThemeData theme, ServiceApprovalStatus status) {
    Color color;
    String label;

    switch (status) {
      case ServiceApprovalStatus.pending:
        color = Colors.orange;
        label = 'Pending';
        break;
      case ServiceApprovalStatus.inReview:
        color = Colors.blue;
        label = 'In Review';
        break;
      case ServiceApprovalStatus.approved:
        color = Colors.green;
        label = 'Approved';
        break;
      case ServiceApprovalStatus.rejected:
        color = Colors.red;
        label = 'Rejected';
        break;
      case ServiceApprovalStatus.requiresChanges:
        color = Colors.amber;
        label = 'Requires Changes';
        break;
    }

    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color),
    );
  }

  String _formatStatus(ServiceApprovalStatus status) {
    switch (status) {
      case ServiceApprovalStatus.pending:
        return 'Pending';
      case ServiceApprovalStatus.inReview:
        return 'In Review';
      case ServiceApprovalStatus.approved:
        return 'Approved';
      case ServiceApprovalStatus.rejected:
        return 'Rejected';
      case ServiceApprovalStatus.requiresChanges:
        return 'Requires Changes';
    }
  }

  void _handleMenuAction(String action, ServiceListItem service) {
    switch (action) {
      case 'view':
        context.go(AppRoutes.serviceDetails.replaceFirst(':id', service.id));
        break;
      case 'edit':
        context.go(AppRoutes.editService.replaceFirst(':id', service.id));
        break;
      case 'toggle_status':
        ref
            .read(serviceControllerProvider.notifier)
            .updateServiceStatus(service.id, !(service.isActive ?? false));
        break;
      case 'toggle_featured':
        ref
            .read(serviceControllerProvider.notifier)
            .updateServiceFeatured(service.id, !(service.isFeatured ?? false));
        break;
      case 'delete':
        _showDeleteDialog(service);
        break;
    }
  }

  void _showDeleteDialog(ServiceListItem service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Service'),
        content: Text(
          'Are you sure you want to delete "${service.title}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref
                  .read(serviceControllerProvider.notifier)
                  .deleteService(service.id);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
