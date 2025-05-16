import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app/core/constants/app_constants.dart';
import 'package:customer_app/core/utils/color_utils.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  // Mock user data for UI development
  final Map<String, dynamic> _userData = {
    'firstName': 'John',
    'lastName': 'Doe',
    'email': 'john.doe@example.com',
    'phone': '+1 (555) 123-4567',
    'profileImage': null,
    'applications': 3,
    'documents': 5,
    'notifications': 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.go(AppConstants.settingsRoute);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildActionCards(),
            const SizedBox(height: 24),
            _buildProfileMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // Profile image with edit button
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withPreciseOpacity(0.1),
              child: Text(
                '${(_userData['firstName'] as String)[0]}${(_userData['lastName'] as String)[0]}',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.camera_alt, size: 16),
                color: Colors.white,
                onPressed: () {
                  // TODO: Implement profile image upload
                },
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                padding: const EdgeInsets.all(8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // User name
        Text(
          '${_userData['firstName']} ${_userData['lastName']}',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 4),
        // User email
        Text(
          _userData['email'],
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        // Edit profile button
        OutlinedButton.icon(
          onPressed: () {
            // TODO: Navigate to edit profile screen
          },
          icon: const Icon(Icons.edit, size: 16),
          label: const Text('Edit Profile'),
        ),
      ],
    );
  }

  Widget _buildActionCards() {
    return Row(
      children: [
        _buildActionCard(
          'Applications',
          _userData['applications'].toString(),
          Icons.school_outlined,
          Colors.blue,
          () {
            // TODO: Navigate to applications list
          },
        ),
        _buildActionCard(
          'Documents',
          _userData['documents'].toString(),
          Icons.folder_outlined,
          Colors.amber,
          () {
            // TODO: Navigate to documents list
          },
        ),
        _buildActionCard(
          'Notifications',
          _userData['notifications'].toString(),
          Icons.notifications_outlined,
          Colors.red,
          () {
            // TODO: Navigate to notifications list
          },
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    String count,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(height: 8),
                Text(count, style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            'Account Settings',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              _buildMenuItem('Personal Information', Icons.person_outline, () {
                // TODO: Navigate to personal information screen
              }),
              _buildDivider(),
              _buildMenuItem('Security', Icons.lock_outline, () {
                // TODO: Navigate to security screen
              }),
              _buildDivider(),
              _buildMenuItem('Notifications', Icons.notifications_outlined, () {
                // TODO: Navigate to notification settings
              }),
              _buildDivider(),
              _buildMenuItem('Privacy', Icons.privacy_tip_outlined, () {
                // TODO: Navigate to privacy settings
              }),
              _buildDivider(),
              _buildMenuItem('Help & Support', Icons.help_outline, () {
                // TODO: Navigate to help & support
              }),
              _buildDivider(),
              _buildMenuItem('About', Icons.info_outline, () {
                // TODO: Navigate to about screen
              }),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          child: _buildMenuItem(
            'Log Out',
            Icons.logout,
            () {
              // Confirm logout
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Log Out'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // TODO: Implement logout logic
                            context.go(AppConstants.loginRoute);
                          },
                          child: const Text('Log Out'),
                        ),
                      ],
                    ),
              );
            },
            textColor: Theme.of(context).colorScheme.error,
            iconColor: Theme.of(context).colorScheme.error,
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            'Version 1.0.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon,
    VoidCallback onTap, {
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: textColor),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 56,
      endIndent: 0,
      color: Theme.of(context).colorScheme.outline.withPreciseOpacity(0.2),
    );
  }
}
