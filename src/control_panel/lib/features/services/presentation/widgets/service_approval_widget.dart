import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/models/service.dart';
import '../providers/service_providers.dart';

class ServiceApprovalWidget extends ConsumerStatefulWidget {
  const ServiceApprovalWidget({super.key});

  @override
  ConsumerState<ServiceApprovalWidget> createState() =>
      _ServiceApprovalWidgetState();
}

class _ServiceApprovalWidgetState extends ConsumerState<ServiceApprovalWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(serviceApprovalControllerProvider.notifier)
          .loadPendingServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final approvalState = ref.watch(serviceApprovalControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with stats
          _buildHeader(theme, approvalState),
          const SizedBox(height: 24),

          // Approval Queue
          Expanded(child: _buildApprovalQueue(theme, approvalState)),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, approvalState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.pending_actions,
              size: 32,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Service Approval Queue',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Review and approve pending service submissions',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${approvalState.pendingServices.length}',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text('Pending', style: theme.textTheme.bodySmall),
              ],
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                ref
                    .read(serviceApprovalControllerProvider.notifier)
                    .refreshPendingServices();
              },
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApprovalQueue(ThemeData theme, approvalState) {
    if (approvalState.isLoading && approvalState.pendingServices.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (approvalState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Error loading approval queue',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              approvalState.error!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(serviceApprovalControllerProvider.notifier)
                    .refreshPendingServices();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (approvalState.pendingServices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text('No pending approvals', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'All services have been reviewed',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: approvalState.pendingServices.length,
      itemBuilder: (context, index) {
        final service = approvalState.pendingServices[index];
        return _buildApprovalCard(theme, service);
      },
    );
  }

  Widget _buildApprovalCard(ThemeData theme, ServiceListItem service) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'by ${service.providerName}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Category: ${service.categoryName}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${service.basePrice.toStringAsFixed(2)}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Submitted ${DateFormat.yMMMd().format(service.createdAt)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Service Status and Stats
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      service.approvalStatus,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getStatusColor(service.approvalStatus),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _getStatusText(service.approvalStatus),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _getStatusColor(service.approvalStatus),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                if (service.averageRating != null) ...[
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    service.averageRating!.toStringAsFixed(1),
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                ],
                if (service.totalOrders != null) ...[
                  Icon(
                    Icons.shopping_bag,
                    size: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${service.totalOrders} orders',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ],
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _showRejectDialog(service),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                  child: const Text('Reject'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => _showServiceDetails(service.id),
                  child: const Text('View Details'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _approveService(service),
                  icon: const Icon(Icons.check),
                  label: const Text('Approve'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(ServiceApprovalStatus status) {
    switch (status) {
      case ServiceApprovalStatus.pending:
        return Colors.orange;
      case ServiceApprovalStatus.inReview:
        return Colors.blue;
      case ServiceApprovalStatus.approved:
        return Colors.green;
      case ServiceApprovalStatus.rejected:
        return Colors.red;
      case ServiceApprovalStatus.requiresChanges:
        return Colors.amber;
    }
  }

  String _getStatusText(ServiceApprovalStatus status) {
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

  void _approveService(ServiceListItem service) async {
    final success = await ref
        .read(serviceApprovalControllerProvider.notifier)
        .approveService(
          serviceId: service.id,
          isApproved: true,
          approvedByAdminId: 'current-admin-id', // TODO: Get from auth
        );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Service "${service.title}" approved successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showRejectDialog(ServiceListItem service) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Service'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to reject "${service.title}"?'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Rejection Reason',
                hintText: 'Please provide a reason for rejection...',
                border: OutlineInputBorder(),
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
            onPressed: () async {
              final reason = reasonController.text.trim();
              if (reason.isNotEmpty) {
                final success = await ref
                    .read(serviceApprovalControllerProvider.notifier)
                    .approveService(
                      serviceId: service.id,
                      isApproved: false,
                      rejectionReason: reason,
                      approvedByAdminId:
                          'current-admin-id', // TODO: Get from auth
                    );

                Navigator.of(context).pop();

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Service "${service.title}" rejected'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  void _showServiceDetails(String serviceId) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        child: Container(
          width: 600,
          height: 500,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Service Details',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: FutureBuilder<Service>(
                  future: ref
                      .read(getServiceByIdUseCaseProvider)
                      .call(serviceId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error loading service details: ${snapshot.error}',
                        ),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: Text('Service not found'));
                    }

                    final service = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.title,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'by ${service.providerName ?? 'Unknown Provider'}',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            service.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          _buildServiceDetailsInfo(Theme.of(context), service),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceDetailsInfo(ThemeData theme, Service service) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Base Price',
                  '\$${service.basePrice.toStringAsFixed(2)}',
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  'Pricing Type',
                  service.pricingType.name,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Delivery Time',
                  '${service.deliveryTime.inDays} days',
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  'Status',
                  _getStatusText(service.approvalStatus),
                ),
              ),
            ],
          ),
          if (service.tags?.isNotEmpty == true) ...[
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tags',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: service.tags!
                      .map(
                        (tag) => Chip(
                          label: Text(tag),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 2),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
