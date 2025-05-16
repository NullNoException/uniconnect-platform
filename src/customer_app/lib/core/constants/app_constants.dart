class AppConstants {
  // API related constants
  static const String baseUrl = 'https://api.uniconnect.edu';
  static const int apiTimeoutDuration = 30000; // in milliseconds
  static const int cacheDuration =
      24 * 60 * 60 * 1000; // 24 hours in milliseconds

  // Local storage keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String settingsKey = 'app_settings';
  static const String lastSyncKey = 'last_sync_timestamp';

  // Navigation routes
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
  static const String universityDetailsRoute = '/university/:id';
  static const String programDetailsRoute = '/program/:id';
  static const String bookmarksRoute = '/bookmarks';
  static const String applicationRoute = '/application/:id';

  // Assets paths
  static const String logoPath = 'assets/images/logo.png';
  static const String placeholderImagePath = 'assets/images/placeholder.png';

  // Feature flags
  static const bool enableDarkMode = true;
  static const bool enableOfflineMode = true;
  static const bool enablePushNotifications = true;

  // Pagination
  static const int defaultPageSize = 20;
}
