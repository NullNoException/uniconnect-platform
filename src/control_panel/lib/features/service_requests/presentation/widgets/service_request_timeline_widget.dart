import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/service_request.dart';

class ServiceRequestTimelineWidget extends StatelessWidget {
  final ServiceRequest request;

  const ServiceRequestTimelineWidget({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Request Timeline',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          _buildTimelineItem(
            theme,
            'Service Request Created',
            'Request initiated by ${request.studentName}',
            request.initiatedDate,
            Icons.play_arrow,
            Colors.blue,
            isFirst: true,
          ),

          if (request.assignedAdminId != null)
            _buildTimelineItem(
              theme,
              'Admin Assigned',
              'Request assigned to admin for review',
              request.initiatedDate.add(const Duration(hours: 1)),
              Icons.person_add,
              Colors.orange,
            ),

          // Document submission events
          ...request.documents.map((doc) {
            return _buildTimelineItem(
              theme,
              'Document ${doc.status == DocumentStatus.approved
                  ? 'Approved'
                  : doc.status == DocumentStatus.rejected
                  ? 'Rejected'
                  : 'Submitted'}',
              '${doc.fileName} - ${doc.documentType}',
              doc.submissionDate ?? request.initiatedDate,
              doc.status == DocumentStatus.approved
                  ? Icons.check_circle
                  : doc.status == DocumentStatus.rejected
                  ? Icons.cancel
                  : Icons.upload_file,
              doc.status == DocumentStatus.approved
                  ? Colors.green
                  : doc.status == DocumentStatus.rejected
                  ? Colors.red
                  : Colors.blue,
            );
          }),

          // Milestone events
          ...request.milestones.map((milestone) {
            return _buildTimelineItem(
              theme,
              milestone.status == MilestoneStatus.completed
                  ? 'Milestone Completed'
                  : 'Milestone ${milestone.status.displayName}',
              milestone.title,
              milestone.completionDate ??
                  milestone.targetDate ??
                  request.initiatedDate,
              milestone.status == MilestoneStatus.completed
                  ? Icons.check_circle
                  : Icons.flag,
              milestone.status == MilestoneStatus.completed
                  ? Colors.green
                  : milestone.status == MilestoneStatus.inProgress
                  ? Colors.blue
                  : Colors.grey,
            );
          }),

          // Transaction events
          ...request.transactions.map((transaction) {
            return _buildTimelineItem(
              theme,
              '${transaction.type.displayName} ${transaction.status == TransactionStatus.completed ? 'Completed' : transaction.status.displayName}',
              '\$${transaction.amount.toStringAsFixed(2)}',
              transaction.createdAt,
              transaction.type == TransactionType.payment
                  ? Icons.payment
                  : Icons.account_balance_wallet,
              transaction.status == TransactionStatus.completed
                  ? Colors.green
                  : transaction.status == TransactionStatus.failed
                  ? Colors.red
                  : Colors.orange,
            );
          }),

          if (request.status == ServiceRequestStatus.completed)
            _buildTimelineItem(
              theme,
              'Service Request Completed',
              'All requirements fulfilled',
              request.completedDate ?? DateTime.now(),
              Icons.check_circle,
              Colors.green,
              isLast: true,
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    ThemeData theme,
    String title,
    String description,
    DateTime date,
    IconData icon,
    Color color, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              if (!isFirst)
                Container(width: 2, height: 20, color: theme.dividerColor),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              if (!isLast)
                Expanded(child: Container(width: 2, color: theme.dividerColor)),
            ],
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat.yMMMd().add_jm().format(date),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
