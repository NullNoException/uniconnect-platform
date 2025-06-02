import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/service_request.dart';

class ServiceRequestStatsWidget extends StatelessWidget {
  final ServiceRequestStats stats;
  final int pendingDocumentCount;
  final int overdueRequestsCount;

  const ServiceRequestStatsWidget({
    super.key,
    required this.stats,
    required this.pendingDocumentCount,
    required this.overdueRequestsCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          _buildStatCard(
            context,
            'Total Requests',
            stats.totalRequests.toString(),
            Icons.assignment_outlined,
            theme.colorScheme.primary,
            isMobile ? double.infinity : null,
          ),
          _buildStatCard(
            context,
            'Pending',
            stats.pendingRequests.toString(),
            Icons.pending_outlined,
            Colors.orange,
            isMobile ? double.infinity : null,
          ),
          _buildStatCard(
            context,
            'In Progress',
            stats.inProgressRequests.toString(),
            Icons.work_outline,
            Colors.blue,
            isMobile ? double.infinity : null,
          ),
          _buildStatCard(
            context,
            'Completed',
            stats.completedRequests.toString(),
            Icons.check_circle_outline,
            Colors.green,
            isMobile ? double.infinity : null,
          ),
          _buildStatCard(
            context,
            'Disputed',
            stats.disputedRequests.toString(),
            Icons.report_problem_outlined,
            Colors.red,
            isMobile ? double.infinity : null,
          ),
          _buildStatCard(
            context,
            'Revenue',
            NumberFormat.currency(
              symbol: '\$',
              decimalDigits: 0,
            ).format(stats.totalRevenue),
            Icons.attach_money,
            Colors.teal,
            isMobile ? double.infinity : null,
          ),
          if (pendingDocumentCount > 0)
            _buildStatCard(
              context,
              'Documents to Review',
              pendingDocumentCount.toString(),
              Icons.folder_outlined,
              Colors.amber,
              isMobile ? double.infinity : null,
            ),
          if (overdueRequestsCount > 0)
            _buildStatCard(
              context,
              'Overdue Requests',
              overdueRequestsCount.toString(),
              Icons.schedule,
              Colors.red.shade700,
              isMobile ? double.infinity : null,
            ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    double? width,
  ) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width ?? 200,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.trending_up,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
