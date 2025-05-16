import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/details/university_details_screen.dart';
import '../screens/details/program_details_screen.dart';
import '../screens/bookmarks/bookmarks_screen.dart';
import '../screens/application/application_screen_new.dart' as new_app_screen;

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  // Add authentication logic here later to handle route guards
  final isAuthenticated = false; // Will be replaced with auth state provider

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppConstants.splashRoute,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppConstants.splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppConstants.loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppConstants.signupRoute,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppConstants.profileRoute,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppConstants.settingsRoute,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppConstants.universityDetailsRoute,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return UniversityDetailsScreen(universityId: id);
        },
      ),
      GoRoute(
        path: AppConstants.programDetailsRoute,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProgramDetailsScreen(programId: id);
        },
      ),
      GoRoute(
        path: AppConstants.bookmarksRoute,
        builder: (context, state) => const BookmarksScreen(),
      ),
      GoRoute(
        path: AppConstants.applicationRoute,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return new_app_screen.ApplicationScreen(applicationId: id);
        },
      ),
    ],
    // Redirect logic for authentication
    redirect: (context, state) {
      // Logic to protect routes and redirect
      final isLoggingIn = state.path == AppConstants.loginRoute;
      final isSigningUp = state.path == AppConstants.signupRoute;
      final isSplash = state.path == AppConstants.splashRoute;

      // Allow access to splash, login, and signup when not authenticated
      if (!isAuthenticated && (isLoggingIn || isSigningUp || isSplash)) {
        return null; // No redirection
      }

      // Redirect to login if trying to access protected route
      if (!isAuthenticated) {
        return AppConstants.loginRoute;
      }
    },
  );
});
