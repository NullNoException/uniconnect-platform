import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/models/auth_state.dart';
import '../controllers/auth_controller.dart';

/// Demo screen that showcases the enhanced authentication system features
class AuthDemoScreen extends ConsumerStatefulWidget {
  const AuthDemoScreen({super.key});

  @override
  ConsumerState<AuthDemoScreen> createState() => _AuthDemoScreenState();
}

class _AuthDemoScreenState extends ConsumerState<AuthDemoScreen> {
  final _emailController = TextEditingController(text: 'admin@uniconnect.com');
  final _passwordController = TextEditingController(text: 'password123');
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _forgotEmailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _forgotEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication System Demo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Authentication Status Card
            _buildStatusCard(authState, authController),
            const SizedBox(height: 16),

            // Login Section
            if (!authState.isAuthenticated) ...[
              _buildLoginSection(authController),
              const SizedBox(height: 16),
              _buildForgotPasswordSection(authController),
            ],

            // Authenticated User Section
            if (authState.isAuthenticated) ...[
              _buildUserInfoSection(authState, authController),
              const SizedBox(height: 16),
              _buildRoleSection(authState, authController),
              const SizedBox(height: 16),
              _buildTokenSection(authState, authController),
              const SizedBox(height: 16),
              _buildChangePasswordSection(authController),
            ],

            const SizedBox(height: 16),
            _buildTestSection(authController),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(AuthState authState, AuthController authController) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Authentication Status',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  authState.isAuthenticated ? Icons.check_circle : Icons.cancel,
                  color: authState.isAuthenticated ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  authState.isAuthenticated
                      ? 'Authenticated'
                      : 'Not Authenticated',
                  style: TextStyle(
                    color: authState.isAuthenticated
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (authState.isLoading) ...[
              const SizedBox(height: 8),
              const Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('Loading...'),
                ],
              ),
            ],
            if (authState.error != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  border: Border.all(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red.shade700, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        authState.error!,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLoginSection(AuthController authController) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final success = await authController.login(
                    _emailController.text,
                    _passwordController.text,
                  );
                  if (success && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login successful!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordSection(AuthController authController) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forgot Password',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _forgotEmailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final success = await authController.forgotPassword(
                    _forgotEmailController.text,
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success
                              ? 'Password reset email sent!'
                              : 'Failed to send reset email',
                        ),
                        backgroundColor: success ? Colors.green : Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Send Reset Email'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection(
    AuthState authState,
    AuthController authController,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildInfoRow('User ID', authState.userId ?? 'N/A'),
            _buildInfoRow('Email', authState.email ?? 'N/A'),
            _buildInfoRow('Roles', authState.roles?.join(', ') ?? 'N/A'),
            if (authState.expiresAt != null)
              _buildInfoRow(
                'Token Expires',
                authState.expiresAt!.toLocal().toString(),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await authController.logout();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logged out successfully!'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ],
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
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildRoleSection(AuthState authState, AuthController authController) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Role-Based Access Control',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildRoleCheck('Admin', authController.isAdmin()),
            _buildRoleCheck('Provider', authController.isProvider()),
            _buildRoleCheck('Provider Staff', authController.isProviderStaff()),
            _buildRoleCheck('Moderator', authController.isModerator()),
            _buildRoleCheck(
              'Custom Role Check (Student)',
              authController.hasRole(Roles.student),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCheck(String role, bool hasRole) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            hasRole ? Icons.check_circle : Icons.cancel,
            color: hasRole ? Colors.green : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(role),
          if (hasRole) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Access Granted',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTokenSection(
    AuthState authState,
    AuthController authController,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Token Management',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              'Token Expired?',
              authController.isTokenExpired() ? 'Yes' : 'No',
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final success = await authController.refreshAuthToken();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success
                              ? 'Token refreshed successfully!'
                              : 'Failed to refresh token',
                        ),
                        backgroundColor: success ? Colors.green : Colors.red,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh Token'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final isValid = await authController.ensureValidToken();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isValid
                              ? 'Token is valid!'
                              : 'Token validation failed',
                        ),
                        backgroundColor: isValid ? Colors.green : Colors.red,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.verified),
                label: const Text('Validate Token'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangePasswordSection(AuthController authController) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Password',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _currentPasswordController,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(
                labelText: 'New Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_newPasswordController.text !=
                      _confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Passwords do not match!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final success = await authController.changePassword(
                    _currentPasswordController.text,
                    _newPasswordController.text,
                    _confirmPasswordController.text,
                  );

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success
                              ? 'Password changed successfully!'
                              : 'Failed to change password',
                        ),
                        backgroundColor: success ? Colors.green : Colors.red,
                      ),
                    );

                    if (success) {
                      _currentPasswordController.clear();
                      _newPasswordController.clear();
                      _confirmPasswordController.clear();
                    }
                  }
                },
                child: const Text('Change Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestSection(AuthController authController) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'API Integration Test',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text(
              'Test the automatic token refresh functionality by making API calls:',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // This would typically make an API call that could trigger token refresh
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'API call would be made here with automatic token handling',
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                  child: const Text('Test API Call'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go(AppRoutes.dashboard);
                  },
                  child: const Text('Go to Dashboard'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go(AppRoutes.login);
                  },
                  child: const Text('Go to Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
