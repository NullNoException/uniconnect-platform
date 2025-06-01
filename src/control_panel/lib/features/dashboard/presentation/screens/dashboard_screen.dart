import 'package:control_panel/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import '../widgets/dashboard_layout.dart';
import '../widgets/stat_card.dart';
import '../widgets/enhanced_recent_requests_table.dart';
import '../controllers/dashboard_controller.dart';
import '../../domain/models/dashboard_filter.dart';
import '../../domain/models/dashboard_state.dart';
import '../../../../core/utils/providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1100;

    final dashboardState = ref.watch(dashboardControllerProvider);
    final dashboardController = ref.read(dashboardControllerProvider.notifier);

    // Initialize dashboard data on first load
    ref.listen(dashboardControllerProvider, (previous, next) {
      if (previous == null && next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading dashboard: ${next.error}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    // Load dashboard data if not loaded
    if (!dashboardState.hasData && !dashboardState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        dashboardController.loadDashboardData();
      });
    }

    return DashboardLayout(
      title: 'Dashboard',
      selectedIndex: 0,
      child: RefreshIndicator(
        onRefresh: () => dashboardController.refreshDashboard(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(theme, dashboardState, dashboardController),
              const SizedBox(height: 32),

              // Stats cards
              _buildStatsCards(context, isMobile, isTablet, dashboardState),
              const SizedBox(height: 32),

              // Charts section
              _buildChartsSection(
                context,
                isMobile,
                isTablet,
                dashboardState,
                dashboardController,
              ),
              const SizedBox(height: 32),

              // Recent service requests
              _buildRecentRequests(context, dashboardState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    ThemeData theme,
    DashboardState state,
    DashboardController controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard Overview',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome to the UniConnect Admin Panel',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.widgetStateProperty(0.6),
                ),
              ),
              if (state.stats?.lastUpdated != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Last updated: ${_formatLastUpdated(state.stats!.lastUpdated)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.widgetStateProperty(0.5),
                  ),
                ),
              ],
            ],
          ),
        ),
        Row(
          children: [
            // Time range filter
            DropdownButton<DashboardTimeRange>(
              value: state.filter.timeRange,
              items: DashboardTimeRange.values.map((range) {
                return DropdownMenuItem(
                  value: range,
                  child: Text(range.displayName),
                );
              }).toList(),
              onChanged: (range) {
                if (range != null) {
                  controller.updateTimeRange(range);
                }
              },
            ),
            const SizedBox(width: 16),
            // Refresh button
            IconButton(
              onPressed: state.isRefreshing
                  ? null
                  : () => controller.refreshDashboard(),
              icon: state.isRefreshing
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh),
              tooltip: 'Refresh Dashboard',
            ),
            // Export button
            PopupMenuButton<String>(
              icon: const Icon(Icons.download),
              tooltip: 'Export Data',
              onSelected: (format) => controller.exportData(format),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'csv',
                  child: Row(
                    children: [
                      Icon(Icons.table_chart),
                      SizedBox(width: 8),
                      Text('Export as CSV'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'excel',
                  child: Row(
                    children: [
                      Icon(Icons.grid_on),
                      SizedBox(width: 8),
                      Text('Export as Excel'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String _formatLastUpdated(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  Widget _buildStatsCards(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    DashboardState state,
  ) {
    if (state.isLoading && !state.hasStats) {
      return GridView.count(
        crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(4, (index) => _LoadingStatCard()),
      );
    }

    final stats = state.stats;
    if (stats == null) {
      return const SizedBox.shrink();
    }

    return GridView.count(
      crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        StatCard(
          title: 'Total Users',
          value: _formatNumber(stats.totalUsers),
          icon: Icons.people_outlined,
          trend: stats.trends.usersTrend,
          trendText: 'vs last month',
          color: Colors.blue,
        ),
        StatCard(
          title: 'Active Providers',
          value: _formatNumber(stats.activeProviders),
          icon: Icons.business_outlined,
          trend: stats.trends.providersTrend,
          trendText: 'vs last month',
          color: Colors.green,
        ),
        StatCard(
          title: 'Pending Requests',
          value: _formatNumber(stats.pendingRequests),
          icon: Icons.pending_actions_outlined,
          trend: stats.trends.requestsTrend,
          trendText: 'vs last month',
          isNegativeTrendGood: true,
          color: Colors.orange,
        ),
        StatCard(
          title: 'Revenue',
          value: _formatCurrency(stats.revenue),
          icon: Icons.attach_money_outlined,
          trend: stats.trends.revenueTrend,
          trendText: 'vs last month',
          color: Colors.purple,
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(1)}K';
    }
    return '\$${amount.toStringAsFixed(0)}';
  }

  Widget _buildChartsSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    DashboardState state,
    DashboardController controller,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Analytics',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.start,
            children: [
              SizedBox(
                width: isMobile ? double.infinity : (isTablet ? 500 : 600),
                height: 300,
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Service Requests',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButton<String>(
                              value: 'This Month',
                              underline: const SizedBox(),
                              items: ['This Week', 'This Month', 'This Year']
                                  .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  })
                                  .toList(),
                              onChanged: (_) {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Expanded(child: _buildLineChart(theme)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: isMobile ? double.infinity : (isTablet ? 500 : 400),
                height: 300,
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Service Categories',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButton<String>(
                              value: 'This Month',
                              underline: const SizedBox(),
                              items: ['This Week', 'This Month', 'This Year']
                                  .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  })
                                  .toList(),
                              onChanged: (_) {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Expanded(child: _buildPieChart(theme)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLineChart(ThemeData theme) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 10,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: theme.dividerColor, strokeWidth: 1);
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: theme.dividerColor, strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                const labels = [
                  '',
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                  'Sep',
                  'Oct',
                  'Nov',
                  'Dec',
                  '',
                ];
                if (value < 1 || value >= labels.length - 1) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    labels[value.toInt()],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 10,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                );
              },
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: theme.dividerColor, width: 1),
        ),
        minX: 1,
        maxX: 12,
        minY: 0,
        maxY: 60,
        lineBarsData: [
          // Completed requests
          LineChartBarData(
            spots: const [
              FlSpot(1, 15),
              FlSpot(2, 18),
              FlSpot(3, 22),
              FlSpot(4, 20),
              FlSpot(5, 25),
              FlSpot(6, 28),
              FlSpot(7, 30),
              FlSpot(8, 35),
              FlSpot(9, 38),
              FlSpot(10, 40),
              FlSpot(11, 42),
              FlSpot(12, 45),
            ],
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.green.widgetStateProperty(0.1),
            ),
          ),
          // Pending requests
          LineChartBarData(
            spots: const [
              FlSpot(1, 5),
              FlSpot(2, 8),
              FlSpot(3, 10),
              FlSpot(4, 12),
              FlSpot(5, 15),
              FlSpot(6, 10),
              FlSpot(7, 8),
              FlSpot(8, 12),
              FlSpot(9, 15),
              FlSpot(10, 14),
              FlSpot(11, 10),
              FlSpot(12, 8),
            ],
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.orange.widgetStateProperty(0.1),
            ),
          ),
          // Cancelled requests
          LineChartBarData(
            spots: const [
              FlSpot(1, 2),
              FlSpot(2, 3),
              FlSpot(3, 4),
              FlSpot(4, 2),
              FlSpot(5, 3),
              FlSpot(6, 5),
              FlSpot(7, 4),
              FlSpot(8, 2),
              FlSpot(9, 3),
              FlSpot(10, 2),
              FlSpot(11, 1),
              FlSpot(12, 2),
            ],
            isCurved: true,
            color: Colors.red,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.red.widgetStateProperty(0.1),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => theme.colorScheme.surface,
            tooltipBorderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart(ThemeData theme) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            title: '30%',
            value: 30,
            color: Colors.blue,
            radius: 130,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            title: '25%',
            value: 25,
            color: Colors.green,
            radius: 130,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            title: '20%',
            value: 20,
            color: Colors.orange,
            radius: 130,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            title: '15%',
            value: 15,
            color: Colors.purple,
            radius: 130,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            title: '10%',
            value: 10,
            color: Colors.red,
            radius: 130,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
        centerSpaceRadius: 0,
        sectionsSpace: 2,
        startDegreeOffset: 180,
      ),
    );
  }

  Widget _buildRecentRequests(BuildContext context, DashboardState state) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Service Requests',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.visibility_outlined),
              label: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        EnhancedRecentRequestsTable(state: state),
      ],
    );
  }
}

class _LoadingStatCard extends StatelessWidget {
  const _LoadingStatCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: 120,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 80,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
