import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/models/service_request.dart';
import '../widgets/milestone_update_dialog.dart';

class ServiceRequestMilestonesWidget extends ConsumerWidget {
  final ServiceRequest request;

  const ServiceRequestMilestonesWidget({super.key, required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Milestones (${request.milestones.length})',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddMilestoneDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Add Milestone'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (request.milestones.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.flag_outlined,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No milestones defined yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Milestones help track progress and deliverables',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: request.milestones.map((milestone) {
                return _buildMilestoneCard(context, ref, milestone, theme);
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildMilestoneCard(
    BuildContext context,
    WidgetRef ref,
    RequestMilestone milestone,
    ThemeData theme,
  ) {
    final isCompleted = milestone.status == MilestoneStatus.completed;
    final isOverdue =
        !isCompleted &&
        milestone.targetDate != null &&
        milestone.targetDate!.isBefore(DateTime.now());

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Status indicator
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getMilestoneColor(
                      milestone.status,
                      isOverdue,
                    ).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getMilestoneIcon(milestone.status),
                    color: _getMilestoneColor(milestone.status, isOverdue),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),

                // Title and description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        milestone.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      if (milestone.description?.isNotEmpty == true) ...[
                        const SizedBox(height: 4),
                        Text(
                          milestone.description!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Status chip
                _buildStatusChip(milestone.status, isOverdue, theme),
                const SizedBox(width: 8),

                // Actions menu
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) =>
                      _handleMilestoneAction(context, ref, value, milestone),
                  itemBuilder: (context) => [
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
                    if (!isCompleted)
                      const PopupMenuItem(
                        value: 'complete',
                        child: Row(
                          children: [
                            Icon(Icons.check_circle),
                            SizedBox(width: 8),
                            Text('Mark Complete'),
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
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Date information
            Wrap(
              spacing: 24,
              runSpacing: 8,
              children: [
                _buildDateInfo(
                  'Target Date',
                  milestone.targetDate,
                  Icons.schedule,
                  isOverdue ? Colors.red : null,
                ),
                if (milestone.completionDate != null)
                  _buildDateInfo(
                    'Completed',
                    milestone.completionDate!,
                    Icons.check_circle,
                    Colors.green,
                  ),
              ],
            ),

            // Progress bar
            if (!isCompleted) ...[
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Progress', style: theme.textTheme.labelLarge),
                      Text(
                        '${(milestone.progress * 100).toInt()}%',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: milestone.progress,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getMilestoneColor(milestone.status, isOverdue),
                    ),
                  ),
                ],
              ),
            ],

            // Notes
            if (milestone.notes?.isNotEmpty == true) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notes',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(milestone.notes!, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(
    MilestoneStatus status,
    bool isOverdue,
    ThemeData theme,
  ) {
    Color backgroundColor;
    Color textColor;
    String label;

    if (isOverdue && status != MilestoneStatus.completed) {
      backgroundColor = Colors.red.shade100;
      textColor = Colors.red.shade800;
      label = 'Overdue';
    } else {
      switch (status) {
        case MilestoneStatus.completed:
          backgroundColor = Colors.green.shade100;
          textColor = Colors.green.shade800;
          label = status.displayName;
          break;
        case MilestoneStatus.inProgress:
          backgroundColor = Colors.blue.shade100;
          textColor = Colors.blue.shade800;
          label = status.displayName;
          break;
        default:
          backgroundColor = Colors.grey.shade100;
          textColor = Colors.grey.shade800;
          label = status.displayName;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDateInfo(
    String label,
    DateTime? date, // Allow nullable date
    IconData icon,
    Color? color,
  ) {
    if (date == null) {
      return const SizedBox.shrink(); // Or display a placeholder like Text('$label: Not set')
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color ?? Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          '$label: ${DateFormat.yMd().format(date)}',
          style: TextStyle(
            fontSize: 12,
            color: color ?? Colors.grey.shade600,
            fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Color _getMilestoneColor(MilestoneStatus status, bool isOverdue) {
    if (isOverdue && status != MilestoneStatus.completed) {
      return Colors.red;
    }

    switch (status) {
      case MilestoneStatus.completed:
        return Colors.green;
      case MilestoneStatus.inProgress:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getMilestoneIcon(MilestoneStatus status) {
    switch (status) {
      case MilestoneStatus.completed:
        return Icons.check_circle;
      case MilestoneStatus.inProgress:
        return Icons.work;
      default:
        return Icons.flag;
    }
  }

  void _handleMilestoneAction(
    BuildContext context,
    WidgetRef ref,
    String action,
    RequestMilestone milestone,
  ) {
    switch (action) {
      case 'edit':
        _showEditMilestoneDialog(context, ref, milestone);
        break;
      case 'complete':
        _completeMilestone(ref, milestone, context);
        break;
      case 'delete':
        _showDeleteDialog(context, milestone);
        break;
    }
  }

  void _showEditMilestoneDialog(
    BuildContext context,
    WidgetRef ref,
    RequestMilestone milestone,
  ) {
    showDialog(
      context: context,
      builder: (context) => MilestoneUpdateDialog(
        requestId: request.id,
        milestone: milestone,
        onUpdate: (updatedMilestone) {
          // TODO: Implement milestone update
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Milestone updated')));
        },
      ),
    );
  }

  void _completeMilestone(
    WidgetRef ref,
    RequestMilestone milestone,
    BuildContext context,
  ) {
    // TODO: Implement milestone completion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${milestone.title} marked as complete')),
    );
  }

  void _showDeleteDialog(BuildContext context, RequestMilestone milestone) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Milestone'),
        content: Text('Are you sure you want to delete "${milestone.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteMilestone(milestone, context);
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

  void _deleteMilestone(RequestMilestone milestone, BuildContext context) {
    // TODO: Implement milestone deletion
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${milestone.title} deleted')));
  }

  void _showAddMilestoneDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => MilestoneUpdateDialog(
        requestId: request.id,
        onUpdate: (milestone) {
          // TODO: Implement milestone creation
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Milestone added')));
        },
      ),
    );
  }
}
