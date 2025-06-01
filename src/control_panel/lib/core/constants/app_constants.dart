// API Endpoints
class ApiEndpoints {
  // Base URLs
  static const String baseUrl = '/api/v1';
  static const String controlPanelBaseUrl = '/api/control-panel/v1';

  // Auth endpoints (using control panel endpoints)
  static const String login = '$controlPanelBaseUrl/auth/login';
  static const String refreshToken = '$controlPanelBaseUrl/auth/refresh';
  static const String forgotPassword =
      '$controlPanelBaseUrl/auth/forgot-password';
  static const String resetPassword =
      '$controlPanelBaseUrl/auth/reset-password';
  static const String changePassword =
      '$controlPanelBaseUrl/auth/change-password';

  // User management
  static const String users = '$baseUrl/users';
  static const String registerUser = '$baseUrl/users/register';
  static const String userById = '$baseUrl/users/'; // Append ID

  // Service providers
  static const String providers = '$baseUrl/providers';
  static const String providerById = '$baseUrl/providers/'; // Append ID

  // Services
  static const String services = '$baseUrl/services';
  static const String serviceById = '$baseUrl/services/'; // Append ID

  // Service categories
  static const String serviceCategories = '$baseUrl/servicecategories';

  // Service requests
  static const String serviceRequests = '$baseUrl/servicerequests';
  static const String serviceRequestById =
      '$baseUrl/servicerequests/'; // Append ID
  static const String updateRequestStatus =
      '$baseUrl/servicerequests/'; // Append ID + /status

  // Transactions
  static const String transactions = '$baseUrl/transactions';
  static const String transactionById = '$baseUrl/transactions/'; // Append ID
  static const String updateTransactionStatus =
      '$baseUrl/transactions/'; // Append ID + /status

  // Universities
  static const String universities = '$baseUrl/universities';
  static const String universityById = '$baseUrl/universities/'; // Append ID

  // Academic levels
  static const String academicLevels = '$baseUrl/academiclevels';

  // Majors
  static const String majors = '$baseUrl/majors';

  // University programs
  static const String universityPrograms = '$baseUrl/universityprograms';

  // Semesters
  static const String semesters = '$baseUrl/semesters';

  // Provider university programs
  static const String providerPrograms =
      '$baseUrl/providers/'; // Append providerId + /programs
  static const String importPrograms =
      '$baseUrl/providers/'; // Append providerId + /programs/import
  static const String exportPrograms =
      '$baseUrl/providers/'; // Append providerId + /programs/export

  // Dashboard endpoints
  static const String dashboardData = '$controlPanelBaseUrl/dashboard/data';
  static const String dashboardStats = '$controlPanelBaseUrl/dashboard/stats';
  static const String dashboardChartData =
      '$controlPanelBaseUrl/dashboard/chart-data';
  static const String dashboardCategoryData =
      '$controlPanelBaseUrl/dashboard/category-data';
  static const String dashboardRecentRequests =
      '$controlPanelBaseUrl/dashboard/recent-requests';
  static const String dashboardExport = '$controlPanelBaseUrl/dashboard/export';
}

// Route names
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String authDemo = '/auth-demo';
  static const String dashboard = '/dashboard';

  static const String users = '/users';
  static const String userDetails = '/users/:id';
  static const String createUser = '/users/create';
  static const String editUser = '/users/:id/edit';

  static const String providers = '/providers';
  static const String providerDetails = '/providers/:id';
  static const String createProvider = '/providers/create';
  static const String editProvider = '/providers/:id/edit';

  static const String services = '/services';
  static const String serviceDetails = '/services/:id';
  static const String createService = '/services/create';
  static const String editService = '/services/:id/edit';

  static const String serviceRequests = '/service-requests';
  static const String serviceRequestDetails = '/service-requests/:id';

  static const String transactions = '/transactions';
  static const String transactionDetails = '/transactions/:id';

  static const String universities = '/universities';
  static const String universityDetails = '/universities/:id';
  static const String createUniversity = '/universities/create';
  static const String editUniversity = '/universities/:id/edit';

  static const String academicLevels = '/academic-levels';
  static const String createAcademicLevel = '/academic-levels/create';
  static const String editAcademicLevel = '/academic-levels/:id/edit';

  static const String majors = '/majors';
  static const String createMajor = '/majors/create';
  static const String editMajor = '/majors/:id/edit';

  static const String universityPrograms = '/university-programs';
  static const String universityProgramDetails = '/university-programs/:id';

  static const String providerPrograms = '/providers/:providerId/programs';
  static const String importProviderPrograms =
      '/providers/:providerId/programs/import';

  static const String analytics = '/analytics';
  static const String settings = '/settings';
}

// Shared preferences keys
class PreferenceKeys {
  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
  static const String userRole = 'user_role';
  static const String tokenExpiresAt = 'token_expires_at';
  static const String theme = 'theme';
  static const String locale = 'locale';
}

// Asset paths
class AssetPaths {
  static const String logo = 'assets/images/logo.png';
  static const String logoLight = 'assets/images/logo_light.png';
  static const String logoDark = 'assets/images/logo_dark.png';
  static const String loginBackground = 'assets/images/login_background.jpg';
  static const String placeholder = 'assets/images/placeholder.png';
  static const String noData = 'assets/images/no_data.svg';
  static const String error = 'assets/images/error.svg';
}

// Role constants
class Roles {
  static const String admin = 'Admin';
  static const String provider = 'ServiceProvider';
  static const String providerStaff = 'ProviderStaff';
  static const String moderator = 'Moderator';
  static const String student = 'Student';
}

// Error messages
class ErrorMessages {
  static const String serverError = 'Server error occurred';
  static const String connectionError =
      'Connection error. Please check your internet connection';
  static const String timeoutError = 'Request timed out';
  static const String authError = 'Authentication error';
  static const String notFoundError = 'Requested resource not found';
  static const String validationError = 'Validation error';
  static const String unknownError = 'Unknown error occurred';
}

// Success messages
class SuccessMessages {
  static const String loginSuccess = 'Login successful';
  static const String logoutSuccess = 'Logout successful';
  static const String createSuccess = 'Successfully created';
  static const String updateSuccess = 'Successfully updated';
  static const String deleteSuccess = 'Successfully deleted';
  static const String passwordChangeSuccess = 'Password changed successfully';
  static const String passwordResetSuccess =
      'Password reset email sent successfully';
}

// Pagination defaults
class PaginationDefaults {
  static const int itemsPerPage = 10;
  static const int maxPagesToShow = 5;
}

// Validation constants
class ValidationConstants {
  static const int minPasswordLength = 8;
  static const String passwordPattern =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[0-9]{10,15}$';
}

// Animation durations
class AnimationDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
}
