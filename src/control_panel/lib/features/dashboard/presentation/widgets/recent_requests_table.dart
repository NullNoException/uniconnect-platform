import 'package:control_panel/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';

class RecentRequestsTable extends StatelessWidget {
  const RecentRequestsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,
            smRatio: 0.75,
            lmRatio: 1.5,
            headingRowColor: WidgetStatePropertyAll(
              theme.colorScheme.surface,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: theme.dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            columns: [
              const DataColumn2(label: Text('ID'), size: ColumnSize.S),
              const DataColumn2(label: Text('Service'), size: ColumnSize.L),
              const DataColumn2(label: Text('Student'), size: ColumnSize.M),
              const DataColumn2(label: Text('Provider'), size: ColumnSize.M),
              const DataColumn2(label: Text('Status'), size: ColumnSize.S),
              const DataColumn2(label: Text('Date'), size: ColumnSize.M),
              const DataColumn2(label: Text('Actions'), size: ColumnSize.S),
            ],
            rows: [
              _buildDataRow(
                context,
                'SR-2025-001',
                'University Application Assistance',
                'John Smith',
                'EduConsult Inc.',
                'Pending',
                '2025-05-18',
              ),
              _buildDataRow(
                context,
                'SR-2025-002',
                'Visa Documentation Review',
                'Emma Johnson',
                'GlobalEdu Services',
                'In Progress',
                '2025-05-17',
              ),
              _buildDataRow(
                context,
                'SR-2025-003',
                'SOP & Essay Review',
                'Michael Brown',
                'Academic Advisors Ltd.',
                'Completed',
                '2025-05-15',
              ),
              _buildDataRow(
                context,
                'SR-2025-004',
                'Program Selection Consultation',
                'Sarah Davis',
                'EduConsult Inc.',
                'In Progress',
                '2025-05-14',
              ),
              _buildDataRow(
                context,
                'SR-2025-005',
                'Document Translation',
                'Ali Hassan',
                'GlobalEdu Services',
                'Pending',
                '2025-05-13',
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(
    BuildContext context,
    String id,
    String service,
    String student,
    String provider,
    String status,
    String date,
  ) {
    final theme = Theme.of(context);

    // Status color mapping
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'in progress':
        statusColor = Colors.blue;
        break;
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataRow(
      cells: [
        DataCell(Text(id)),
        DataCell(Text(service)),
        DataCell(Text(student)),
        DataCell(Text(provider)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.widgetStateProperty(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: theme.textTheme.bodySmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(Text(date)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.visibility_outlined, size: 20),
                onPressed: () {
                  // Extract ID number from the ID string (e.g., "SR-2025-001" -> "001")
                  final idNumber = id.split('-').last;
                  context.push(
                    AppRoutes.serviceRequestDetails.replaceAll(':id', idNumber),
                  );
                },
                tooltip: 'View Details',
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(4),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {
                  // Navigate to edit page
                },
                tooltip: 'Edit',
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
