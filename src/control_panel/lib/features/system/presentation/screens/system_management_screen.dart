import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/system.dart';
import '../providers/system_providers.dart';
import '../widgets/platform_settings_section.dart';
import '../widgets/university_management_section.dart';
import '../widgets/system_stats_card.dart';
import '../widgets/feature_flags_section.dart';

class SystemManagementScreen extends ConsumerStatefulWidget {
  const SystemManagementScreen({super.key});

  @override
  ConsumerState<SystemManagementScreen> createState() =>
      _SystemManagementScreenState();
}

class _SystemManagementScreenState extends ConsumerState<SystemManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Management'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.settings), text: 'Platform Settings'),
            Tab(icon: Icon(Icons.school), text: 'Universities'),
            Tab(icon: Icon(Icons.flag), text: 'Feature Flags'),
            Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 1200;
          final isTablet =
              constraints.maxWidth > 800 && constraints.maxWidth <= 1200;

          return TabBarView(
            controller: _tabController,
            children: [
              // Platform Settings Tab
              PlatformSettingsSection(isDesktop: isDesktop, isTablet: isTablet),

              // University Management Tab
              UniversityManagementSection(
                isDesktop: isDesktop,
                isTablet: isTablet,
              ),

              // Feature Flags Tab
              FeatureFlagsSection(isDesktop: isDesktop, isTablet: isTablet),

              // Analytics Tab
              SystemStatsSection(isDesktop: isDesktop, isTablet: isTablet),
            ],
          );
        },
      ),
    );
  }
}

class SystemStatsSection extends ConsumerWidget {
  final bool isDesktop;
  final bool isTablet;

  const SystemStatsSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(universitiesStatsProvider);
    final systemConfigAsync = ref.watch(systemConfigurationProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System Analytics',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),

          Expanded(
            child: isDesktop
                ? _buildDesktopLayout(context, statsAsync, systemConfigAsync)
                : isTablet
                ? _buildTabletLayout(context, statsAsync, systemConfigAsync)
                : _buildMobileLayout(context, statsAsync, systemConfigAsync),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    AsyncValue<UniversityStats> statsAsync,
    AsyncValue systemConfigAsync,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildStatsCards(context, statsAsync, isDesktop, isTablet),
        ),
        const SizedBox(width: 16),
        Expanded(flex: 1, child: _buildSystemInfo(context, systemConfigAsync)),
      ],
    );
  }

  Widget _buildTabletLayout(
    BuildContext context,
    AsyncValue<UniversityStats> statsAsync,
    AsyncValue systemConfigAsync,
  ) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: _buildStatsCards(context, statsAsync, isDesktop, isTablet),
        ),
        const SizedBox(height: 16),
        Expanded(flex: 1, child: _buildSystemInfo(context, systemConfigAsync)),
      ],
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    AsyncValue<UniversityStats> statsAsync,
    AsyncValue systemConfigAsync,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildStatsCards(context, statsAsync, isDesktop, isTablet),
          const SizedBox(height: 16),
          _buildSystemInfo(context, systemConfigAsync),
        ],
      ),
    );
  }

  Widget _buildStatsCards(
    BuildContext context,
    AsyncValue<UniversityStats> statsAsync,
    bool isDesktop,
    bool isTablet,
  ) {
    return statsAsync.when(
      data: (stats) => GridView.count(
        crossAxisCount: isDesktop
            ? 4
            : isTablet
            ? 3
            : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SystemStatsCard(
            title: 'Total Universities',
            value: stats.totalUniversities.toString(),
            icon: Icons.school,
            color: Colors.blue,
          ),
          SystemStatsCard(
            title: 'Active Universities',
            value: stats.activeUniversities.toString(),
            icon: Icons.check_circle,
            color: Colors.green,
          ),
          SystemStatsCard(
            title: 'Inactive Universities',
            value: stats.inactiveUniversities.toString(),
            icon: Icons.cancel,
            color: Colors.orange,
          ),
          SystemStatsCard(
            title: 'Pending Universities',
            value: stats.pendingUniversities.toString(),
            icon: Icons.pending,
            color: Colors.amber,
          ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          Center(child: Text('Error loading statistics: $error')),
    );
  }

  Widget _buildSystemInfo(BuildContext context, AsyncValue systemConfigAsync) {
    return systemConfigAsync.when(
      data: (config) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'System Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Version', config.version),
              _buildInfoRow(
                'Maintenance Mode',
                config.maintenanceMode ? 'Enabled' : 'Disabled',
              ),
              _buildInfoRow('Last Updated', config.lastUpdated.toString()),
              const SizedBox(height: 16),
              Text(
                'Settings Summary',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...config.settings.entries
                  .take(5)
                  .map((entry) => _buildInfoRow(entry.key, entry.value)),
            ],
          ),
        ),
      ),
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, stack) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: Text('Error loading system info: $error')),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
