import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../dashboard/presentation/widgets/dashboard_layout.dart';
import '../../domain/models/service.dart';
import '../providers/service_providers.dart';

class ServiceDetailScreen extends ConsumerStatefulWidget {
  final String serviceId;

  const ServiceDetailScreen({super.key, required this.serviceId});

  @override
  ConsumerState<ServiceDetailScreen> createState() =>
      _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends ConsumerState<ServiceDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(serviceControllerProvider.notifier)
          .getServiceById(widget.serviceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final serviceState = ref.watch(serviceControllerProvider);
    final service = serviceState.selectedService;

    return DashboardLayout(
      title: 'Service Details',
      selectedIndex: 3,
      child: service == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, theme, service),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildBasicInfo(theme, service),
                            const SizedBox(height: 24),
                            _buildDescription(theme, service),
                            const SizedBox(height: 24),
                            if (service.packages?.isNotEmpty == true)
                              _buildPackages(theme, service),
                            if (service.requirements?.isNotEmpty == true) ...[
                              const SizedBox(height: 24),
                              _buildRequirements(theme, service),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          children: [
                            _buildStatusCard(theme, service),
                            const SizedBox(height: 24),
                            _buildProviderInfo(theme, service),
                            const SizedBox(height: 24),
                            _buildMetrics(theme, service),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, Service service) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Service ID: ${service.id}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) => _handleAction(value, service),
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit Service')),
            const PopupMenuItem(
              value: 'toggle_status',
              child: Text('Toggle Status'),
            ),
            const PopupMenuItem(
              value: 'toggle_featured',
              child: Text('Toggle Featured'),
            ),
            const PopupMenuItem(value: 'delete', child: Text('Delete Service')),
          ],
          child: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  Widget _buildBasicInfo(ThemeData theme, Service service) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              'Category',
              service.categoryId,
            ), // In real app, you'd resolve the name
            _buildInfoRow('Subcategory', service.subcategoryId),
            _buildInfoRow(
              'Base Price',
              '\$${service.basePrice.toStringAsFixed(2)}',
            ),
            _buildInfoRow('Pricing Type', service.pricingType.name),
            _buildInfoRow(
              'Delivery Time',
              '${service.deliveryTime.inDays} days',
            ),
            if (service.tags?.isNotEmpty == true)
              _buildTagsRow('Tags', service.tags!),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(ThemeData theme, Service service) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(service.description, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildPackages(ThemeData theme, Service service) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service Packages',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...service.packages!.map(
              (package) => _buildPackageCard(theme, package),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(ThemeData theme, ServicePackage package) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                package.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${package.price.toStringAsFixed(2)}',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(package.description),
          const SizedBox(height: 8),
          Text(
            'Delivery: ${package.deliveryTime.inDays} days',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          if (package.features?.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: package.features!
                  .map(
                    (feature) => Chip(
                      label: Text(feature),
                      backgroundColor: theme.colorScheme.primaryContainer,
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRequirements(ThemeData theme, Service service) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Requirements',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...service.requirements!.map(
              (req) => _buildRequirementCard(theme, req),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementCard(
    ThemeData theme,
    ServiceRequirement requirement,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  requirement.question,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (requirement.isRequired)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Required',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onError,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Type: ${requirement.type.name}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          if (requirement.options?.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: requirement.options!
                  .map(
                    (option) => Chip(
                      label: Text(option),
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusCard(ThemeData theme, Service service) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatusChip(theme, service.approvalStatus),
            const SizedBox(height: 12),
            _buildInfoRow('Active', service.isActive == true ? 'Yes' : 'No'),
            _buildInfoRow(
              'Featured',
              service.isFeatured == true ? 'Yes' : 'No',
            ),
            if (service.approvalDate != null)
              _buildInfoRow(
                'Approved On',
                DateFormat.yMMMd().format(service.approvalDate!),
              ),
            if (service.rejectionReason != null) ...[
              const SizedBox(height: 12),
              Text(
                'Rejection Reason:',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                service.rejectionReason!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProviderInfo(ThemeData theme, Service service) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Provider Information',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Provider ID', service.providerId),
            if (service.providerName != null)
              _buildInfoRow('Name', service.providerName!),
            if (service.providerEmail != null)
              _buildInfoRow('Email', service.providerEmail!),
          ],
        ),
      ),
    );
  }

  Widget _buildMetrics(ThemeData theme, Service service) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Metrics',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (service.averageRating != null)
              _buildInfoRow(
                'Average Rating',
                '${service.averageRating!.toStringAsFixed(1)}/5',
              ),
            if (service.totalReviews != null)
              _buildInfoRow('Total Reviews', service.totalReviews.toString()),
            if (service.totalOrders != null)
              _buildInfoRow('Total Orders', service.totalOrders.toString()),
            _buildInfoRow(
              'Created',
              DateFormat.yMMMd().format(service.createdAt),
            ),
            _buildInfoRow(
              'Updated',
              DateFormat.yMMMd().format(service.updatedAt),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsRow(String label, List<String> tags) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: tags
                .map(
                  (tag) => Chip(
                    label: Text(tag),
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(ThemeData theme, ServiceApprovalStatus status) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
      case ServiceApprovalStatus.approved:
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        label = 'Approved';
        break;
      case ServiceApprovalStatus.pending:
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        label = 'Pending';
        break;
      case ServiceApprovalStatus.rejected:
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        label = 'Rejected';
        break;
      case ServiceApprovalStatus.inReview:
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        label = 'In Review';
        break;
      case ServiceApprovalStatus.requiresChanges:
        backgroundColor = Colors.purple.withOpacity(0.1);
        textColor = Colors.purple;
        label = 'Requires Changes';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _handleAction(String action, Service service) {
    switch (action) {
      case 'edit':
        context.push('/services/${service.id}/edit');
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
        _showDeleteConfirmation(service);
        break;
    }
  }

  void _showDeleteConfirmation(Service service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Service'),
        content: Text('Are you sure you want to delete "${service.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement delete functionality
              ref
                  .read(serviceControllerProvider.notifier)
                  .deleteService(service.id);
              context.pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
