import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/responsive_scaffold.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../domain/models/service_request.dart';
import '../providers/service_request_providers.dart';
import '../widgets/service_request_timeline_widget.dart';
import '../widgets/service_request_documents_widget.dart';
import '../widgets/service_request_milestones_widget.dart';
import '../widgets/service_request_transactions_widget.dart';

class ServiceRequestDetailScreen extends ConsumerStatefulWidget {
  final String requestId;

  const ServiceRequestDetailScreen({super.key, required this.requestId});

  @override
  ConsumerState<ServiceRequestDetailScreen> createState() =>
      _ServiceRequestDetailScreenState();
}

class _ServiceRequestDetailScreenState
    extends ConsumerState<ServiceRequestDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(serviceRequestControllerProvider.notifier)
          .loadServiceRequestDetails(widget.requestId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(serviceRequestControllerProvider);
    final theme = Theme.of(context);

    return ResponsiveScaffold(
      appBar: CustomAppBar(
        title: 'Service Request Details',
        showBackButton: true,
        actions: [
          if (state.selectedServiceRequest != null)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) =>
                  _handleMenuAction(value, state.selectedServiceRequest!),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit Request'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'duplicate',
                  child: Row(
                    children: [
                      Icon(Icons.copy),
                      SizedBox(width: 8),
                      Text('Duplicate'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'export',
                  child: Row(
                    children: [
                      Icon(Icons.download),
                      SizedBox(width: 8),
                      Text('Export PDF'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'cancel',
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'Cancel Request',
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
        showNotifications: true,
      ),
      body: state.isLoading && state.selectedServiceRequest == null
          ? const Center(child: LoadingWidget())
          : state.hasError && state.selectedServiceRequest == null
          ? Center(
              child: CustomErrorWidget(
                message: state.errorMessage ?? 'Failed to load service request',
                onRetry: () {
                  ref
                      .read(serviceRequestControllerProvider.notifier)
                      .loadServiceRequestDetails(widget.requestId);
                },
              ),
            )
          : state.selectedServiceRequest == null
          ? const Center(child: Text('Service request not found'))
          : _buildContent(state.selectedServiceRequest!, theme),
    );
  }

  Widget _buildContent(ServiceRequest request, ThemeData theme) {
    return Column(
      children: [
        // Header with basic info
        _buildHeader(request, theme),

        // Tab bar
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: theme.dividerColor)),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
            indicatorColor: theme.colorScheme.primary,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Documents'),
              Tab(text: 'Milestones'),
              Tab(text: 'Transactions'),
            ],
          ),
        ),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ServiceRequestTimelineWidget(request: request),
              ServiceRequestDocumentsWidget(request: request),
              ServiceRequestMilestonesWidget(request: request),
              ServiceRequestTransactionsWidget(
                transactions: request.transactions,
                currency: request.currency,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(ServiceRequest request, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and ID
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.serviceName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Request ID: ${request.id}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusChip(request.status, theme),
            ],
          ),
          const SizedBox(height: 24),

          // Key information grid
          Wrap(
            spacing: 32,
            runSpacing: 16,
            children: [
              _buildInfoItem('Student', request.studentName, Icons.person),
              _buildInfoItem('Provider', request.providerName, Icons.business),
              _buildInfoItem(
                'Amount',
                '\$${request.totalAmount.toStringAsFixed(2)}',
                Icons.attach_money,
              ),
              _buildInfoItem(
                'Date',
                DateFormat.yMMMd().format(request.initiatedDate),
                Icons.calendar_today,
              ),
              if (request.expectedCompletionDate != null)
                _buildInfoItem(
                  'Expected Completion',
                  DateFormat.yMMMd().format(request.expectedCompletionDate!),
                  Icons.schedule,
                ),
            ],
          ),

          if (request.description?.isNotEmpty == true) ...[
            const SizedBox(height: 24),
            Text(
              'Description',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(request.description!, style: theme.textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.displayName,
        style: theme.textTheme.labelLarge?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _handleMenuAction(String action, ServiceRequest request) {
    switch (action) {
      case 'edit':
        context.go('/service-requests/${request.id}/edit');
        break;
      case 'duplicate':
        _duplicateRequest(request);
        break;
      case 'export':
        _exportToPDF(request);
        break;
      case 'cancel':
        _showCancelDialog(request);
        break;
    }
  }

  void _duplicateRequest(ServiceRequest request) {
    // TODO: Implement duplication logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Duplication feature coming soon')),
    );
  }

  void _exportToPDF(ServiceRequest request) {
    // TODO: Implement PDF export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF export feature coming soon')),
    );
  }

  void _showCancelDialog(ServiceRequest request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Service Request'),
        content: const Text(
          'Are you sure you want to cancel this service request? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _cancelRequest(request);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cancel Request'),
          ),
        ],
      ),
    );
  }

  void _cancelRequest(ServiceRequest request) {
    // TODO: Implement cancel request logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request cancellation feature coming soon')),
    );
  }
}
