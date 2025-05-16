import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

import '../../../domain/entities/application.dart';
import '../../providers/application_providers.dart';

class ApplicationScreen extends ConsumerWidget {
  final String applicationId;

  const ApplicationScreen({Key? key, required this.applicationId})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationAsync = ref.watch(
      applicationDetailProvider(applicationId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Show help dialog or navigate to help page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help resources coming soon!')),
              );
            },
          ),
        ],
      ),
      body: applicationAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) =>
                Center(child: Text('Error loading application: $error')),
        data: (application) {
          if (application == null) {
            return const Center(child: Text('Application not found'));
          }
          return ApplicationDetailView(application: application);
        },
      ),
    );
  }
}

class ApplicationDetailView extends ConsumerWidget {
  final Application application;

  const ApplicationDetailView({Key? key, required this.application})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // Application Header
          _buildApplicationHeader(context),

          // Tab Bar
          Material(
            color: Theme.of(context).colorScheme.surface,
            child: TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Documents'),
                Tab(text: 'Timeline'),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              children: [
                _buildOverviewTab(context, ref),
                _buildDocumentsTab(context, ref),
                _buildTimelineTab(context, ref),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // University and Program
          Text(
            application.universityName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            application.programName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),

          // Status and Completion
          Row(
            children: [
              _buildStatusChip(context, application.status),
              const Spacer(),
              _buildCompletionIndicator(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, ApplicationStatus status) {
    // Define colors for different statuses
    Color chipColor;
    switch (status) {
      case ApplicationStatus.draft:
        chipColor = Colors.grey;
        break;
      case ApplicationStatus.submitted:
        chipColor = Colors.blue;
        break;
      case ApplicationStatus.underReview:
        chipColor = Colors.amber;
        break;
      case ApplicationStatus.documentRequired:
        chipColor = Colors.deepOrange;
        break;
      case ApplicationStatus.interviewScheduled:
        chipColor = Colors.deepPurple;
        break;
      case ApplicationStatus.accepted:
        chipColor = Colors.green;
        break;
      case ApplicationStatus.rejected:
        chipColor = Colors.red;
        break;
    }

    return Chip(
      label: Text(
        application.statusText,
        style: TextStyle(
          color:
              chipColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: chipColor.withOpacity(0.2),
      side: BorderSide(color: chipColor),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildCompletionIndicator(BuildContext context) {
    final completionPercentage = application.completionPercentage;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$completionPercentage% Complete',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: completionPercentage / 100,
              backgroundColor: Colors.grey.shade200,
              color: Theme.of(context).colorScheme.primary,
              minHeight: 8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Application details card
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Application Details',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),
                _buildDetailRow(context, 'Application ID:', application.id),
                const SizedBox(height: 8),
                _buildDetailRow(
                  context,
                  'Submission Date:',
                  DateFormat.yMMMMd().format(application.submissionDate),
                ),
                const SizedBox(height: 8),
                _buildDetailRow(context, 'Status:', application.statusText),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Pending tasks
        if (application.tasks.any((task) => !task.isCompleted))
          _buildTasksList(context, ref),

        const SizedBox(height: 16),

        // Next steps
        _buildNextSteps(context, ref),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildTasksList(BuildContext context, WidgetRef ref) {
    final pendingTasks =
        application.tasks.where((task) => !task.isCompleted).toList();

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pending Tasks',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            ...pendingTasks.map((task) => _buildTaskItem(context, task, ref)),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(
    BuildContext context,
    ApplicationTask task,
    WidgetRef ref,
  ) {
    final completeTaskNotifier = ref.watch(completeTaskStateProvider.notifier);
    final isLoading = ref.watch(completeTaskStateProvider).isLoading;

    // Calculate days left or overdue
    String dueDateText;
    Color dueDateColor;

    if (task.isOverdue) {
      dueDateText = 'Overdue';
      dueDateColor = Colors.red;
    } else {
      dueDateText = '${task.daysLeft} days left';
      dueDateColor = task.daysLeft < 3 ? Colors.orange : Colors.blue;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: task.isCompleted,
            onChanged:
                isLoading
                    ? null
                    : (_) async {
                      final success = await completeTaskNotifier.completeTask(
                        applicationId: application.id,
                        taskId: task.id,
                      );

                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Task completed successfully'),
                          ),
                        );
                      }
                    },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(
                  task.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: dueDateColor),
                    const SizedBox(width: 4),
                    Text(
                      'Due: ${DateFormat.yMMMd().format(task.dueDate)}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: dueDateColor),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: dueDateColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: dueDateColor),
                      ),
                      child: Text(
                        dueDateText,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: dueDateColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextSteps(BuildContext context, WidgetRef ref) {
    String nextStepText;
    List<Widget> actions = [];

    switch (application.status) {
      case ApplicationStatus.draft:
        nextStepText =
            'Your application is in draft state. Complete all required information and submit.';
        actions.add(
          ElevatedButton(
            onPressed: () {
              // Implement submit action
            },
            child: const Text('Submit Application'),
          ),
        );
        break;

      case ApplicationStatus.submitted:
        nextStepText =
            'Your application has been submitted and is waiting for initial review.';
        break;

      case ApplicationStatus.underReview:
        nextStepText =
            'Your application is currently being reviewed by the university admissions team.';
        break;

      case ApplicationStatus.documentRequired:
        nextStepText =
            'The university requires additional documents. Please check the Documents tab.';
        actions.add(
          ElevatedButton(
            onPressed: () {
              DefaultTabController.of(context)?.animateTo(1);
            },
            child: const Text('View Required Documents'),
          ),
        );
        break;

      case ApplicationStatus.interviewScheduled:
        nextStepText =
            'Your interview has been scheduled. Please prepare according to the instructions.';
        actions.add(
          ElevatedButton(
            onPressed: () {
              // Show interview details
            },
            child: const Text('View Interview Details'),
          ),
        );
        break;

      case ApplicationStatus.accepted:
        nextStepText =
            'Congratulations! Your application has been accepted. Follow the next steps to confirm your enrollment.';
        actions.add(
          ElevatedButton(
            onPressed: () {
              // Show enrollment instructions
            },
            child: const Text('Enrollment Instructions'),
          ),
        );
        break;

      case ApplicationStatus.rejected:
        nextStepText =
            'Unfortunately, your application was not successful. You might want to explore other opportunities.';
        actions.add(
          ElevatedButton(
            onPressed: () {
              context.go('/home');
            },
            child: const Text('Explore Other Universities'),
          ),
        );
        break;
    }

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Next Steps', style: Theme.of(context).textTheme.titleMedium),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(nextStepText),
            ),
            if (actions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsTab(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Required Documents',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),
                ...application.documents.map(
                  (doc) => _buildDocumentItem(context, doc, ref),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentItem(
    BuildContext context,
    ApplicationDocument document,
    WidgetRef ref,
  ) {
    final uploadDocumentNotifier = ref.watch(
      uploadDocumentStateProvider.notifier,
    );
    final isLoading = ref.watch(uploadDocumentStateProvider).isLoading;

    // Define icon and color based on document status
    IconData statusIcon;
    Color statusColor;
    String statusText;

    switch (document.status) {
      case DocumentStatus.required:
        statusIcon = Icons.upload_file;
        statusColor = Colors.orange;
        statusText = 'Upload Required';
        break;
      case DocumentStatus.submitted:
        statusIcon = Icons.hourglass_bottom;
        statusColor = Colors.blue;
        statusText = 'Submitted';
        break;
      case DocumentStatus.verified:
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
        statusText = 'Verified';
        break;
      case DocumentStatus.rejected:
        statusIcon = Icons.error;
        statusColor = Colors.red;
        statusText = 'Rejected';
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(statusIcon, color: statusColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  statusText,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: statusColor),
                ),
                if (document.submissionDate != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Submitted on: ${DateFormat.yMMMd().format(document.submissionDate!)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
              ],
            ),
          ),
          if (document.status == DocumentStatus.required)
            ElevatedButton(
              onPressed:
                  isLoading
                      ? null
                      : () async {
                        // Use a file picker to let the user select a file
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.any,
                        );
                        if (result == null || result.files.isEmpty) return;
                        final filePath = result.files.single.path;
                        if (filePath == null) return;
                        final success = await uploadDocumentNotifier
                            .uploadDocument(
                              applicationId: application.id,
                              documentId: document.id,
                              filePath: '/path/to/file',
                            );

                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Document uploaded successfully'),
                            ),
                          );
                        }
                      },
              child:
                  isLoading
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Text('Upload'),
            )
          else if (document.fileUrl != null)
            IconButton(
              onPressed: () {
                // Open document
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening ${document.name}')),
                );
              },
              icon: const Icon(Icons.visibility),
              tooltip: 'View Document',
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineTab(BuildContext context, WidgetRef ref) {
    // Sort timeline by date descending (most recent first)
    final sortedTimeline = List<ApplicationTimeline>.from(application.timeline)
      ..sort((a, b) => b.date.compareTo(a.date));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedTimeline.length,
      itemBuilder: (context, index) {
        final timeline = sortedTimeline[index];
        final isLast = index == sortedTimeline.length - 1;

        return _buildTimelineItem(context, timeline, isLast);
      },
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    ApplicationTimeline timeline,
    bool isLast,
  ) {
    // Define color based on status
    Color statusColor;
    switch (timeline.status) {
      case ApplicationStatus.draft:
        statusColor = Colors.grey;
        break;
      case ApplicationStatus.submitted:
        statusColor = Colors.blue;
        break;
      case ApplicationStatus.underReview:
        statusColor = Colors.amber;
        break;
      case ApplicationStatus.documentRequired:
        statusColor = Colors.deepOrange;
        break;
      case ApplicationStatus.interviewScheduled:
        statusColor = Colors.deepPurple;
        break;
      case ApplicationStatus.accepted:
        statusColor = Colors.green;
        break;
      case ApplicationStatus.rejected:
        statusColor = Colors.red;
        break;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            DateFormat.yMMMd().format(timeline.date),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
            if (!isLast)
              Container(width: 2, height: 60, color: Colors.grey.shade300),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeline.statusText,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: statusColor),
                ),
                const SizedBox(height: 4),
                Text(
                  timeline.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
