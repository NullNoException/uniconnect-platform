import 'package:control_panel/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../controllers/universities_controller.dart';

class UniversityDetailScreen extends ConsumerStatefulWidget {
  final String universityId;

  const UniversityDetailScreen({super.key, required this.universityId});

  @override
  ConsumerState<UniversityDetailScreen> createState() =>
      _UniversityDetailScreenState();
}

class _UniversityDetailScreenState
    extends ConsumerState<UniversityDetailScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUniversity();
  }

  Future<void> _loadUniversity() async {
    setState(() {
      _isLoading = true;
    });

    await ref
        .read(universitiesControllerProvider.notifier)
        .getUniversityDetails(widget.universityId);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _deleteUniversity() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete University'),
        content: const Text(
          'Are you sure you want to delete this university? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await ref
          .read(universitiesControllerProvider.notifier)
          .deleteUniversity(widget.universityId);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('University deleted successfully')),
        );
        context.pop();
        context.go(AppRoutes.universities);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(universitiesControllerProvider);
    final university = state.selectedUniversity;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('University Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push(
              '${AppRoutes.universities}/${widget.universityId}/edit',
            ),
            tooltip: 'Edit University',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteUniversity,
            tooltip: 'Delete University',
          ),
        ],
      ),
      body: _isLoading || university == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (university.logoUrl != null)
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(university.logoUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary
                                .widgetStateProperty(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.school,
                              size: 48,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  university.name,
                                  style: theme.textTheme.headlineMedium,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: university.isActive
                                        ? Colors.green.widgetStateProperty(0.2)
                                        : Colors.red.widgetStateProperty(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    university.isActive ? 'Active' : 'Inactive',
                                    style: TextStyle(
                                      color: university.isActive
                                          ? Colors.green[700]
                                          : Colors.red[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${university.city}, ${university.country}',
                              style: theme.textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            if (university.website != null) ...[
                              InkWell(
                                onTap: () {
                                  // Handle website link tap
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.language, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      university.website!,
                                      style: theme.textTheme.bodyLarge!
                                          .copyWith(
                                            color: theme.colorScheme.primary,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            university.description ??
                                'No description available.',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'University Information',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('ID', university.id),
                          _buildInfoRow('Name', university.name),
                          _buildInfoRow('Country', university.country),
                          _buildInfoRow('City', university.city),
                          _buildInfoRow(
                            'Status',
                            university.isActive ? 'Active' : 'Inactive',
                          ),
                          _buildInfoRow(
                            'Created',
                            _formatDate(university.createdAt),
                          ),
                          _buildInfoRow(
                            'Last Updated',
                            _formatDate(university.updatedAt),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Programs', style: theme.textTheme.titleLarge),
                          const SizedBox(height: 16),
                          // Placeholder for programs - will be implemented later
                          const Center(
                            child: Text(
                              'University programs section will be implemented later.',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to programs
                              },
                              child: const Text('View Programs'),
                            ),
                          ),
                        ],
                      ),
                    ),
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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
