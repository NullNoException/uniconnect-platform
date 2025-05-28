import 'package:control_panel/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import '../widgets/dashboard_layout.dart';
import '../widgets/stat_card.dart';
import '../widgets/recent_requests_table.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1100;

    return DashboardLayout(
      title: 'Dashboard',
      selectedIndex: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
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
            const SizedBox(height: 32),

            // Stats cards
            _buildStatsCards(context, isMobile, isTablet),
            const SizedBox(height: 32),

            // Charts section
            _buildChartsSection(context, isMobile, isTablet),
            const SizedBox(height: 32),

            // Recent service requests
            _buildRecentRequests(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context, bool isMobile, bool isTablet) {
    return GridView.count(
      crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        StatCard(
          title: 'Total Users',
          value: '1,245',
          icon: Icons.people_outlined,
          trend: 12.5,
          trendText: 'vs last month',
          color: Colors.blue,
        ),
        StatCard(
          title: 'Active Providers',
          value: '86',
          icon: Icons.business_outlined,
          trend: 3.2,
          trendText: 'vs last month',
          color: Colors.green,
        ),
        StatCard(
          title: 'Pending Requests',
          value: '38',
          icon: Icons.pending_actions_outlined,
          trend: -5.1,
          trendText: 'vs last month',
          isNegativeTrendGood: true,
          color: Colors.orange,
        ),
        StatCard(
          title: 'Revenue',
          value: '\$24,500',
          icon: Icons.attach_money_outlined,
          trend: 8.4,
          trendText: 'vs last month',
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildChartsSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
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

  Widget _buildRecentRequests(BuildContext context) {
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
        const RecentRequestsTable(),
      ],
    );
  }
}
