import 'package:control_panel/core/utils/color_utils.dart';
import 'package:control_panel/core/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../dashboard/presentation/widgets/dashboard_layout.dart';
import '../../domain/models/user_list_item.dart';

class UserDetailScreen extends ConsumerStatefulWidget {
  final String userId;

  const UserDetailScreen({required this.userId, super.key});

  @override
  ConsumerState<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends ConsumerState<UserDetailScreen> {
  UserListItem? user;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final userRepository = ref.read(userRepositoryProvider);
      final loadedUser = await userRepository.getUserById(widget.userId);

      if (mounted) {
        setState(() {
          user = loadedUser;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = e.toString();
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DashboardLayout(
      title: 'User Details',
      selectedIndex: 1, // Users section
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? _buildErrorView(theme)
          : _buildUserDetails(theme),
    );
  }

  Widget _buildErrorView(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Text('Error loading user', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(error!),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _loadUser, child: const Text('Try Again')),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => context.go(AppRoutes.users),
            child: const Text('Back to Users'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetails(ThemeData theme) {
    if (user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_off_outlined, size: 60, color: Colors.grey),
            const SizedBox(height: 16),
            Text('User not found', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.users),
              child: const Text('Back to Users'),
            ),
          ],
        ),
      );
    }

    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with user name and actions
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go(AppRoutes.users),
                tooltip: 'Back to users',
              ),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 24,
                backgroundColor: theme.colorScheme.primary.widgetStateProperty(
                  0.2,
                ),
                child: Text(
                  user!.name.isNotEmpty ? user!.name[0].toUpperCase() : '?',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    _buildRoleBadges(user!.roles),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit User'),
                onPressed: () =>
                    context.go('${AppRoutes.users}/${user!.id}/edit'),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // User information
          _buildInformationCard(theme),
          const SizedBox(height: 24),

          // User activity
          _buildActivityCard(theme, dateFormat, timeFormat),
        ],
      ),
    );
  }

  Widget _buildRoleBadges(List<String> roles) {
    return Wrap(
      spacing: 8,
      children: roles.map((role) {
        Color color;
        String label;

        switch (role) {
          case Roles.admin:
            color = Colors.purple;
            label = 'Admin';
            break;
          case Roles.provider:
            color = Colors.blue;
            label = 'Provider';
            break;
          case Roles.providerStaff:
            color = Colors.teal;
            label = 'Staff';
            break;
          case Roles.moderator:
            color = Colors.amber;
            label = 'Moderator';
            break;
          case Roles.student:
            color = Colors.green;
            label = 'Student';
            break;
          default:
            color = Colors.grey;
            label = role;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.widgetStateProperty(0.1),
            border: Border.all(color: color.widgetStateProperty(0.5)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInformationCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Information',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoRow('Email', user!.email, Icons.email, theme),
            const SizedBox(height: 16),
            _buildInfoRow(
              'Phone',
              user!.phoneNumber ?? 'Not provided',
              Icons.phone,
              theme,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              'Status',
              user!.isActive ? 'Active' : 'Inactive',
              user!.isActive ? Icons.check_circle : Icons.cancel,
              theme,
              valueColor: user!.isActive ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  icon: Icon(user!.isActive ? Icons.block : Icons.check_circle),
                  label: Text(user!.isActive ? 'Deactivate' : 'Activate'),
                  onPressed: () => _showStatusChangeDialog(),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  icon: const Icon(Icons.lock_reset),
                  label: const Text('Reset Password'),
                  onPressed: () => _showResetPasswordDialog(),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete User'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _showDeleteDialog(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    ThemeData theme,
    DateFormat dateFormat,
    DateFormat timeFormat,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Activity',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoRow(
              'Account Created',
              '${dateFormat.format(user!.createdAt)} at ${timeFormat.format(user!.createdAt)}',
              Icons.calendar_today,
              theme,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              'Last Login',
              user!.lastLogin != null
                  ? '${dateFormat.format(user!.lastLogin!)} at ${timeFormat.format(user!.lastLogin!)}'
                  : 'Never',
              Icons.login,
              theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    IconData icon,
    ThemeData theme, {
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.widgetStateProperty(0.6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: valueColor,
                fontWeight: valueColor != null ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showStatusChangeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user!.isActive ? 'Deactivate User' : 'Activate User'),
        content: Text(
          user!.isActive
              ? 'Are you sure you want to deactivate ${user!.name}? They will no longer be able to log in.'
              : 'Are you sure you want to activate ${user!.name}? They will be able to log in again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              setState(() {
                isLoading = true;
              });

              try {
                final userRepository = ref.read(userRepositoryProvider);
                await userRepository.updateUserStatus(
                  user!.id,
                  !user!.isActive,
                );
                await _loadUser();

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        user!.isActive
                            ? 'User has been activated'
                            : 'User has been deactivated',
                      ),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  setState(() {
                    error = e.toString();
                    isLoading = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: Text(user!.isActive ? 'Deactivate' : 'Activate'),
          ),
        ],
      ),
    );
  }

  void _showResetPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: Text(
          'This will send a password reset email to ${user!.email}. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset email has been sent'),
                ),
              );
            },
            child: const Text('Send Email'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text(
          'Are you sure you want to delete ${user!.name}? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              try {
                final userRepository = ref.read(userRepositoryProvider);
                await userRepository.deleteUser(user!.id);

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User has been deleted')),
                  );
                  context.go(AppRoutes.users);
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error deleting user: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
