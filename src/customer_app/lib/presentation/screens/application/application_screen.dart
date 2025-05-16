import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';

import '../../../domain/entities/application.dart';
import '../../providers/application_providers.dart';

// Use application detail provider from application_providers.dart
final applicationProvider = applicationDetailProvider;

class ApplicationScreen extends ConsumerStatefulWidget {
  final String applicationId;

  const ApplicationScreen({required this.applicationId, super.key});

  @override
  ConsumerState<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends ConsumerState<ApplicationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationAsyncValue = ref.watch(
      applicationProvider(widget.applicationId),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Application Details')),
      body: applicationAsyncValue.when(
        data: (application) {
          if (application == null) {
            return const Center(child: Text('Application not found'));
          }
          return _buildContent(application);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) =>
                Center(child: Text('Error: ${error.toString()}')),
      ),
    );
  }

  Widget _buildContent(Application application) {
    return Column(
      children: [
        _buildApplicationHeader(application),
        TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
          tabs: const [
            Tab(text: 'Timeline'),
            Tab(text: 'Documents'),
            Tab(text: 'Tasks'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTimelineTab(application),
              _buildDocumentsTab(application),
              _buildTasksTab(application),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildApplicationHeader(Application application) {
    final statusColor = _getStatusColor(application.status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      application.programName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        context.go('/university/${application.universityId}');
                      },
                      child: Text(
                        application.universityName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  application.statusText,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                'Submitted on: ${_formatDate(application.submissionDate)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.numbers,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                'Application ID: ${application.id}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineTab(Application application) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: application.timeline.length,
      itemBuilder: (context, index) {
        final isLast = index == application.timeline.length - 1;
        final event = application.timeline[index];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color:
                        isLast
                            ? _getStatusColor(event.status)
                            : Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child:
                      isLast
                          ? const Icon(
                            Icons.check,
                            size: 14,
                            color: Colors.white,
                          )
                          : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 70,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.3),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.statusText,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color:
                          isLast
                              ? _getStatusColor(event.status)
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(event.date),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDocumentsTab(Application application) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: application.documents.length,
      itemBuilder: (context, index) {
        final document = application.documents[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _getDocumentIcon(document.name),
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getDocumentStatusColor(
                                document.status,
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              document.statusText,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: _getDocumentStatusColor(document.status),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (document.submissionDate != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              'Submitted: ${_formatDate(document.submissionDate!)}',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (document.status == DocumentStatus.required)
                        ElevatedButton.icon(
                          onPressed: () async {
                            final uploadNotifier = ref.read(
                              uploadDocumentStateProvider.notifier,
                            );
                            final result = await _pickAndUploadDocument(
                              uploadNotifier,
                              application.id,
                              document.id,
                            );
                            if (result && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Document uploaded successfully',
                                  ),
                                ),
                              );
                              // Refresh the application details
                              ref.invalidate(
                                applicationDetailProvider(application.id),
                              );
                            }
                          },
                          icon: const Icon(Icons.upload_file),
                          label: const Text('Upload'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                        )
                      else
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                if (document.fileUrl != null) {
                                  // In a real app, you would open the document in a viewer
                                  // For now, we'll just show a snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Viewing document: ${document.fileUrl}',
                                      ),
                                    ),
                                  );

                                  // You could use a package like url_launcher to open the URL
                                  // or display the PDF in an in-app viewer
                                }
                              },
                              icon: const Icon(Icons.remove_red_eye),
                              label: const Text('View'),
                            ),
                            const SizedBox(width: 8),
                            if (document.status != DocumentStatus.verified)
                              TextButton.icon(
                                onPressed: () async {
                                  final uploadNotifier = ref.read(
                                    uploadDocumentStateProvider.notifier,
                                  );
                                  final result = await _pickAndUploadDocument(
                                    uploadNotifier,
                                    application.id,
                                    document.id,
                                  );
                                  if (result && context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Document replaced successfully',
                                        ),
                                      ),
                                    );
                                    ref.invalidate(
                                      applicationDetailProvider(application.id),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text('Replace'),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTasksTab(Application application) {
    final completedTasks =
        application.tasks.where((task) => task.isCompleted).toList();
    final pendingTasks =
        application.tasks.where((task) => !task.isCompleted).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (pendingTasks.isNotEmpty) ...[
          Text('Pending Tasks', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...pendingTasks.map(
            (task) => _buildTaskCard(task, false, application),
          ),
          const SizedBox(height: 24),
        ],
        if (completedTasks.isNotEmpty) ...[
          Text(
            'Completed Tasks',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...completedTasks.map(
            (task) => _buildTaskCard(task, true, application),
          ),
        ],
        if (application.tasks.isEmpty)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Icon(
                  Icons.task_alt,
                  size: 64,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No pending tasks',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'You\'re all caught up!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTaskCard(
    ApplicationTask task,
    bool isCompleted,
    Application application,
  ) {
    final daysLeft = task.dueDate.difference(DateTime.now()).inDays;
    final isOverdue = daysLeft < 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
                Checkbox(
                  value: isCompleted,
                  onChanged: (value) async {
                    if (value == true) {
                      final completeTaskUseCase = ref.read(
                        completeApplicationTaskUseCaseProvider,
                      );
                      final result = await completeTaskUseCase(
                        applicationId: application.id,
                        taskId: task.id,
                      );

                      result.fold(
                        (failure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: ${failure.message}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        (updatedTask) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Task marked as completed'),
                            ),
                          );
                          ref.invalidate(
                            applicationDetailProvider(application.id),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    isCompleted
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : null,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color:
                      isOverdue && !isCompleted
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  'Due: ${_formatDate(task.dueDate)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        isOverdue && !isCompleted
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight:
                        isOverdue && !isCompleted ? FontWeight.bold : null,
                  ),
                ),
                if (!isCompleted && !isOverdue) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$daysLeft days left',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
                if (isOverdue && !isCompleted) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Overdue',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (!isCompleted) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final completeTaskUseCase = ref.read(
                    completeApplicationTaskUseCaseProvider,
                  );
                  final result = await completeTaskUseCase(
                    applicationId: application.id,
                    taskId: task.id,
                  );

                  result.fold(
                    (failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${failure.message}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    (updatedTask) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Task marked as completed'),
                        ),
                      );
                      ref.invalidate(applicationDetailProvider(application.id));
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Complete Task'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(ApplicationStatus status) {
    switch (status) {
      case ApplicationStatus.submitted:
        return Colors.blue;
      case ApplicationStatus.underReview:
        return Colors.orange;
      case ApplicationStatus.documentRequired:
        return Colors.deepOrange;
      case ApplicationStatus.interviewScheduled:
        return Colors.purple;
      case ApplicationStatus.accepted:
        return Colors.green;
      case ApplicationStatus.rejected:
        return Colors.red;
      case ApplicationStatus.draft:
        return Colors.grey;
    }
  }

  Color _getDocumentStatusColor(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.verified:
        return Colors.green;
      case DocumentStatus.submitted:
        return Colors.blue;
      case DocumentStatus.required:
        return Colors.orange;
      case DocumentStatus.rejected:
        return Colors.red;
    }
  }

  IconData _getDocumentIcon(String documentName) {
    switch (documentName.toLowerCase()) {
      case 'passport':
        return Icons.badge;
      case 'academic transcript':
        return Icons.school;
      case 'statement of purpose':
        return Icons.description;
      case 'recommendation letter':
        return Icons.mail;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatDate(DateTime date) {
    // In a real app, we'd use intl package to format dates properly
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<bool> _pickAndUploadDocument(
    UploadDocumentNotifier notifier,
    String applicationId,
    String documentId,
  ) async {
    try {
      // Use FilePicker to get a file from the device
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;

        // Call the upload method on the notifier
        return await notifier.uploadDocument(
          applicationId: applicationId,
          documentId: documentId,
          filePath: filePath,
        );
      }
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading document: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }
}
