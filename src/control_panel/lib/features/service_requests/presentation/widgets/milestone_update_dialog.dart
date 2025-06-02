import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/service_request.dart';

class MilestoneUpdateDialog extends StatefulWidget {
  final RequestMilestone? milestone;
  final String requestId;
  final Function(RequestMilestone milestone) onUpdate;

  const MilestoneUpdateDialog({
    super.key,
    this.milestone,
    required this.requestId,
    required this.onUpdate,
  });

  @override
  State<MilestoneUpdateDialog> createState() => _MilestoneUpdateDialogState();
}

class _MilestoneUpdateDialogState extends State<MilestoneUpdateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _targetDate;
  MilestoneStatus _selectedStatus = MilestoneStatus.pending;

  @override
  void initState() {
    super.initState();
    
    if (widget.milestone != null) {
      _titleController.text = widget.milestone!.milestoneName;
      _descriptionController.text = widget.milestone!.description ?? '';
      _targetDate = widget.milestone!.dueDate;
      _selectedStatus = widget.milestone!.status;
    } else {
      _targetDate = DateTime.now().add(const Duration(days: 7));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _isEditing => widget.milestone != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(_isEditing ? 'Edit Milestone' : 'Add Milestone'),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Milestone Name *',
                    hintText: 'Enter milestone name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Milestone name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Description
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter milestone description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Due Date
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Due Date *',
                            style: theme.textTheme.labelLarge,
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                            onPressed: () => _selectTargetDate(context),
                            icon: const Icon(Icons.calendar_today, size: 16),
                            label: Text(
                              _targetDate != null
                                  ? DateFormat.yMMMd().format(_targetDate!)
                                  : 'Select Date',
                            ),
                            style: OutlinedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              minimumSize: const Size(double.infinity, 48),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Status (only for editing)
                if (_isEditing) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status', style: theme.textTheme.labelLarge),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<MilestoneStatus>(
                        value: _selectedStatus,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: MilestoneStatus.values.map((status) {
                          return DropdownMenuItem<MilestoneStatus>(
                            value: status,
                            child: Text(status.displayName),
                          );
                        }).toList(),
                        onChanged: (status) {
                          setState(() {
                            _selectedStatus = status!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: Text(_isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }

  Future<void> _selectTargetDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _targetDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        _targetDate = date;
      });
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_targetDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a due date')),
      );
      return;
    }

    final now = DateTime.now();
    final milestone = RequestMilestone(
      id: widget.milestone?.id ?? 
          DateTime.now().millisecondsSinceEpoch.toString(),
      requestId: widget.requestId,
      milestoneName: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      dueDate: _targetDate,
      completionDate: _selectedStatus == MilestoneStatus.completed
          ? (widget.milestone?.completionDate ?? now)
          : null,
      status: _selectedStatus,
      createdAt: widget.milestone?.createdAt ?? now,
      updatedAt: now,
    );

    widget.onUpdate(milestone);
    Navigator.of(context).pop();
  }
}
