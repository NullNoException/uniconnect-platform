import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/models/service_request.dart';
import '../providers/service_request_providers.dart';

class ServiceRequestFiltersWidget extends ConsumerStatefulWidget {
  final VoidCallback onFiltersChanged;

  const ServiceRequestFiltersWidget({
    super.key,
    required this.onFiltersChanged,
  });

  @override
  ConsumerState<ServiceRequestFiltersWidget> createState() =>
      _ServiceRequestFiltersWidgetState();
}

class _ServiceRequestFiltersWidgetState
    extends ConsumerState<ServiceRequestFiltersWidget> {
  ServiceRequestStatus? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedStudent;
  String? _selectedProvider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

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
              Icon(Icons.filter_list, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Filters',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _clearFilters,
                child: const Text('Clear All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              // Status Filter
              SizedBox(
                width: isMobile ? double.infinity : 200,
                child: _buildStatusFilter(theme),
              ),
              // Date Range Filter
              SizedBox(
                width: isMobile ? double.infinity : 250,
                child: _buildDateRangeFilter(theme),
              ),
              // Student Filter (for admin/provider staff view)
              SizedBox(
                width: isMobile ? double.infinity : 200,
                child: _buildStudentFilter(theme),
              ),
              // Provider Filter (for admin view)
              SizedBox(
                width: isMobile ? double.infinity : 200,
                child: _buildProviderFilter(theme),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        DropdownButtonFormField<ServiceRequestStatus?>(
          value: _selectedStatus,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          hint: const Text('All Statuses'),
          items: [
            const DropdownMenuItem<ServiceRequestStatus?>(
              value: null,
              child: Text('All Statuses'),
            ),
            ...ServiceRequestStatus.values.map((status) {
              return DropdownMenuItem<ServiceRequestStatus>(
                value: status,
                child: Text(status.displayName),
              );
            }),
          ],
          onChanged: (status) {
            setState(() {
              _selectedStatus = status;
            });
            ref
                .read(serviceRequestControllerProvider.notifier)
                .setStatusFilter(status);
            widget.onFiltersChanged();
          },
        ),
      ],
    );
  }

  Widget _buildDateRangeFilter(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date Range', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _selectStartDate(context),
                icon: const Icon(Icons.calendar_today, size: 16),
                label: Text(
                  _startDate != null
                      ? DateFormat.yMd().format(_startDate!)
                      : 'Start Date',
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _selectEndDate(context),
                icon: const Icon(Icons.calendar_today, size: 16),
                label: Text(
                  _endDate != null
                      ? DateFormat.yMd().format(_endDate!)
                      : 'End Date',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStudentFilter(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Student', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Search student...',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            prefixIcon: Icon(Icons.person_search),
          ),
          onChanged: (value) {
            setState(() {
              _selectedStudent = value.isEmpty ? null : value;
            });
            ref
                .read(serviceRequestControllerProvider.notifier)
                .setStudentFilter(_selectedStudent);
            widget.onFiltersChanged();
          },
        ),
      ],
    );
  }

  Widget _buildProviderFilter(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Provider', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Search provider...',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            prefixIcon: Icon(Icons.business),
          ),
          onChanged: (value) {
            setState(() {
              _selectedProvider = value.isEmpty ? null : value;
            });
            ref
                .read(serviceRequestControllerProvider.notifier)
                .setProviderFilter(_selectedProvider);
            widget.onFiltersChanged();
          },
        ),
      ],
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate:
          _startDate ?? DateTime.now().subtract(const Duration(days: 30)),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _startDate = date;
      });
      ref
          .read(serviceRequestControllerProvider.notifier)
          .setDateFilter(_startDate, _endDate);
      widget.onFiltersChanged();
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _endDate = date;
      });
      ref
          .read(serviceRequestControllerProvider.notifier)
          .setDateFilter(_startDate, _endDate);
      widget.onFiltersChanged();
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedStatus = null;
      _startDate = null;
      _endDate = null;
      _selectedStudent = null;
      _selectedProvider = null;
    });
    ref.read(serviceRequestControllerProvider.notifier).clearFilters();
    widget.onFiltersChanged();
  }
}
