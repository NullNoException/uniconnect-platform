import '../../domain/models/dashboard_stats.dart';

class MockDashboardData {
  static DashboardData get sampleData => DashboardData(
    stats: sampleStats,
    requestChart: sampleRequestChart,
    categoryData: sampleCategoryData,
    recentRequests: sampleRecentRequests,
  );

  static DashboardStats get sampleStats => DashboardStats(
    totalUsers: 1245,
    activeProviders: 86,
    pendingRequests: 38,
    revenue: 24500.0,
    trends: const DashboardTrends(
      usersTrend: 12.5,
      providersTrend: 3.2,
      requestsTrend: -5.1,
      revenueTrend: 8.4,
    ),
    lastUpdated: DateTime.now().subtract(const Duration(minutes: 15)),
  );

  static ServiceRequestChart get sampleRequestChart =>
      const ServiceRequestChart(
        completed: [
          ChartData(label: 'Jan', value: 15, date: null),
          ChartData(label: 'Feb', value: 18, date: null),
          ChartData(label: 'Mar', value: 22, date: null),
          ChartData(label: 'Apr', value: 20, date: null),
          ChartData(label: 'May', value: 25, date: null),
          ChartData(label: 'Jun', value: 28, date: null),
          ChartData(label: 'Jul', value: 30, date: null),
          ChartData(label: 'Aug', value: 35, date: null),
          ChartData(label: 'Sep', value: 38, date: null),
          ChartData(label: 'Oct', value: 40, date: null),
          ChartData(label: 'Nov', value: 42, date: null),
          ChartData(label: 'Dec', value: 45, date: null),
        ],
        pending: [
          ChartData(label: 'Jan', value: 5, date: null),
          ChartData(label: 'Feb', value: 8, date: null),
          ChartData(label: 'Mar', value: 10, date: null),
          ChartData(label: 'Apr', value: 12, date: null),
          ChartData(label: 'May', value: 15, date: null),
          ChartData(label: 'Jun', value: 10, date: null),
          ChartData(label: 'Jul', value: 8, date: null),
          ChartData(label: 'Aug', value: 12, date: null),
          ChartData(label: 'Sep', value: 15, date: null),
          ChartData(label: 'Oct', value: 14, date: null),
          ChartData(label: 'Nov', value: 10, date: null),
          ChartData(label: 'Dec', value: 8, date: null),
        ],
        cancelled: [
          ChartData(label: 'Jan', value: 2, date: null),
          ChartData(label: 'Feb', value: 3, date: null),
          ChartData(label: 'Mar', value: 4, date: null),
          ChartData(label: 'Apr', value: 2, date: null),
          ChartData(label: 'May', value: 3, date: null),
          ChartData(label: 'Jun', value: 5, date: null),
          ChartData(label: 'Jul', value: 4, date: null),
          ChartData(label: 'Aug', value: 2, date: null),
          ChartData(label: 'Sep', value: 3, date: null),
          ChartData(label: 'Oct', value: 2, date: null),
          ChartData(label: 'Nov', value: 1, date: null),
          ChartData(label: 'Dec', value: 2, date: null),
        ],
      );

  static List<ServiceCategoryData> get sampleCategoryData => [
    const ServiceCategoryData(
      category: 'Tutoring',
      percentage: 30.0,
      count: 450,
      color: '#2196F3',
    ),
    const ServiceCategoryData(
      category: 'Assignment Help',
      percentage: 25.0,
      count: 375,
      color: '#4CAF50',
    ),
    const ServiceCategoryData(
      category: 'Project Support',
      percentage: 20.0,
      count: 300,
      color: '#FF9800',
    ),
    const ServiceCategoryData(
      category: 'Exam Preparation',
      percentage: 15.0,
      count: 225,
      color: '#9C27B0',
    ),
    const ServiceCategoryData(
      category: 'Career Guidance',
      percentage: 10.0,
      count: 150,
      color: '#F44336',
    ),
  ];

  static List<RecentServiceRequest> get sampleRecentRequests => [
    RecentServiceRequest(
      id: 'REQ001',
      studentName: 'John Doe',
      serviceName: 'Mathematics Tutoring',
      providerName: 'Math Masters Academy',
      status: 'Completed',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      amount: 50.0,
    ),
    RecentServiceRequest(
      id: 'REQ002',
      studentName: 'Jane Smith',
      serviceName: 'Physics Assignment Help',
      providerName: 'Science Support Center',
      status: 'In Progress',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      amount: 75.0,
    ),
    RecentServiceRequest(
      id: 'REQ003',
      studentName: 'Mike Johnson',
      serviceName: 'English Essay Review',
      providerName: 'Writing Workshop',
      status: 'Pending',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      amount: 30.0,
    ),
    RecentServiceRequest(
      id: 'REQ004',
      studentName: 'Sarah Wilson',
      serviceName: 'Chemistry Lab Report',
      providerName: 'Lab Report Experts',
      status: 'Completed',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      amount: 45.0,
    ),
    RecentServiceRequest(
      id: 'REQ005',
      studentName: 'David Brown',
      serviceName: 'Programming Project',
      providerName: 'Code Academy Plus',
      status: 'In Progress',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      amount: 120.0,
    ),
  ];
}
