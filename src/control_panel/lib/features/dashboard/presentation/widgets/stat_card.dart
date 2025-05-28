import 'package:control_panel/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final double trend;
  final String trendText;
  final Color color;
  final bool isNegativeTrendGood;

  const StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.trend,
    required this.trendText,
    required this.color,
    this.isNegativeTrendGood = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTrendPositive = trend >= 0;
    final isTrendGood = isNegativeTrendGood
        ? !isTrendPositive
        : isTrendPositive;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.widgetStateProperty(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 16),

            // Value
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // Title
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.widgetStateProperty(0.7),
              ),
            ),
            const SizedBox(height: 16),

            // Trend
            Row(
              children: [
                Icon(
                  isTrendPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isTrendGood ? Colors.green : Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${isTrendPositive ? '+' : ''}${trend.toStringAsFixed(1)}%',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isTrendGood ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  trendText,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.widgetStateProperty(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
