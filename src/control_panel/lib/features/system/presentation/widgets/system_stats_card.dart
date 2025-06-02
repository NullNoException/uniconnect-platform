import 'package:control_panel/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

class SystemStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isLoading;

  const SystemStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.widgetStateProperty(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const Spacer(),
                  if (onTap != null)
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                ],
              ),
              const SizedBox(height: 16),
              if (isLoading)
                const LinearProgressIndicator()
              else ...[
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Predefined system stats cards
class SystemStatsCards {
  static SystemStatsCard totalUsers({
    required String count,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return SystemStatsCard(
      title: 'Total Users',
      value: count,
      icon: Icons.people,
      color: Colors.blue,
      subtitle: 'Registered users',
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  static SystemStatsCard activeUniversities({
    required String count,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return SystemStatsCard(
      title: 'Active Universities',
      value: count,
      icon: Icons.school,
      color: Colors.green,
      subtitle: 'Currently active',
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  static SystemStatsCard systemHealth({
    required String status,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    final isHealthy =
        status.toLowerCase() == 'healthy' || status.toLowerCase() == 'good';
    return SystemStatsCard(
      title: 'System Health',
      value: status,
      icon: isHealthy ? Icons.health_and_safety : Icons.warning,
      color: isHealthy ? Colors.green : Colors.orange,
      subtitle: 'Current status',
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  static SystemStatsCard pendingRequests({
    required String count,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return SystemStatsCard(
      title: 'Pending Requests',
      value: count,
      icon: Icons.pending_actions,
      color: Colors.orange,
      subtitle: 'Awaiting review',
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  static SystemStatsCard revenue({
    required String amount,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return SystemStatsCard(
      title: 'Monthly Revenue',
      value: amount,
      icon: Icons.attach_money,
      color: Colors.green,
      subtitle: 'This month',
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  static SystemStatsCard apiCalls({
    required String count,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return SystemStatsCard(
      title: 'API Calls',
      value: count,
      icon: Icons.api,
      color: Colors.purple,
      subtitle: 'Last 24 hours',
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  static SystemStatsCard errorRate({
    required String percentage,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    final rate = double.tryParse(percentage.replaceAll('%', '')) ?? 0;
    final color = rate < 1
        ? Colors.green
        : rate < 5
        ? Colors.orange
        : Colors.red;

    return SystemStatsCard(
      title: 'Error Rate',
      value: percentage,
      icon: Icons.error_outline,
      color: color,
      subtitle: 'Last 24 hours',
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  static SystemStatsCard responseTime({
    required String time,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return SystemStatsCard(
      title: 'Avg Response Time',
      value: time,
      icon: Icons.speed,
      color: Colors.blue,
      subtitle: 'API endpoints',
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  static SystemStatsCard storageUsed({
    required String percentage,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    final usage = double.tryParse(percentage.replaceAll('%', '')) ?? 0;
    final color = usage < 50
        ? Colors.green
        : usage < 80
        ? Colors.orange
        : Colors.red;

    return SystemStatsCard(
      title: 'Storage Used',
      value: percentage,
      icon: Icons.storage,
      color: color,
      subtitle: 'Total capacity',
      onTap: onTap,
      isLoading: isLoading,
    );
  }

  static SystemStatsCard maintenanceMode({
    required bool isEnabled,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return SystemStatsCard(
      title: 'Maintenance Mode',
      value: isEnabled ? 'Enabled' : 'Disabled',
      icon: isEnabled ? Icons.construction : Icons.check_circle,
      color: isEnabled ? Colors.red : Colors.green,
      subtitle: 'System status',
      onTap: onTap,
      isLoading: isLoading,
    );
  }
}
