import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/users/presentation/screens/users_screen.dart';
import '../../features/users/presentation/screens/user_detail_screen.dart';
import '../../features/universities/presentation/screens/universities_screen.dart';
import '../../features/universities/presentation/screens/university_detail_screen.dart';
import '../../features/universities/presentation/screens/create_university_screen.dart';
import '../../features/universities/presentation/screens/edit_university_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final isAuthRoute =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.forgotPassword;

      if (!isAuthenticated && !isAuthRoute) {
        return AppRoutes.login;
      }

      if (isAuthenticated && isAuthRoute) {
        return AppRoutes.dashboard;
      }

      return null;
    },
    routes: [
      // Auth routes
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Main application routes
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),

      // Users routes
      GoRoute(
        path: AppRoutes.users,
        builder: (context, state) => const UsersScreen(),
      ),
      GoRoute(
        path: AppRoutes.userDetails,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return UserDetailScreen(userId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.createUser,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.editUser,
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          return const Placeholder(); // To be implemented
        },
      ),

      // Providers routes
      GoRoute(
        path: AppRoutes.providers,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.providerDetails,
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          return const Placeholder(); // To be implemented
        },
      ),
      GoRoute(
        path: AppRoutes.createProvider,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.editProvider,
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          return const Placeholder(); // To be implemented
        },
      ),

      // Services routes
      GoRoute(
        path: AppRoutes.services,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.serviceDetails,
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          return const Placeholder(); // To be implemented
        },
      ),
      GoRoute(
        path: AppRoutes.createService,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.editService,
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          return const Placeholder(); // To be implemented
        },
      ),

      // Service requests routes
      GoRoute(
        path: AppRoutes.serviceRequests,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.serviceRequestDetails,
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          return const Placeholder(); // To be implemented
        },
      ),

      // Transactions routes
      GoRoute(
        path: AppRoutes.transactions,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.transactionDetails,
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          return const Placeholder(); // To be implemented
        },
      ),

      // Universities routes
      GoRoute(
        path: AppRoutes.universities,
        builder: (context, state) => const UniversitiesScreen(),
      ),
      GoRoute(
        path: AppRoutes.universityDetails,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return UniversityDetailScreen(universityId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.createUniversity,
        builder: (context, state) => const CreateUniversityScreen(),
      ),
      GoRoute(
        path: AppRoutes.editUniversity,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return EditUniversityScreen(universityId: id);
        },
      ),

      // Academic levels routes
      GoRoute(
        path: AppRoutes.academicLevels,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.createAcademicLevel,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.editAcademicLevel,
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          return const Placeholder(); // To be implemented
        },
      ),

      // Majors routes
      GoRoute(
        path: AppRoutes.majors,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.createMajor,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.editMajor,
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          return const Placeholder(); // To be implemented
        },
      ),

      // University programs routes
      GoRoute(
        path: AppRoutes.universityPrograms,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
      GoRoute(
        path: AppRoutes.universityProgramDetails,
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          return const Placeholder(); // To be implemented
        },
      ),

      // Provider programs routes
      GoRoute(
        path: AppRoutes.providerPrograms,
        builder: (context, state) {
          // final providerId = state.pathParameters['providerId']!;
          return const Placeholder(); // To be implemented
        },
      ),
      GoRoute(
        path: AppRoutes.importProviderPrograms,
        builder: (context, state) {
          // final providerId = state.pathParameters['providerId']!;
          return const Placeholder(); // To be implemented
        },
      ),

      // Analytics routes
      GoRoute(
        path: AppRoutes.analytics,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),

      // Settings routes
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const Placeholder(), // To be implemented
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Not Found')),
          body: Center(
            child: Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
  );
});
