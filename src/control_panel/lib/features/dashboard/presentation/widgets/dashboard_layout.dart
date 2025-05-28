import 'package:control_panel/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class DashboardLayout extends ConsumerStatefulWidget {
  final Widget child;
  final String title;
  final int selectedIndex;

  const DashboardLayout({
    required this.child,
    required this.title,
    required this.selectedIndex,
    super.key,
  });

  @override
  ConsumerState<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends ConsumerState<DashboardLayout> {
  bool _isDrawerOpen = false;
  bool _isMobile = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _isMobile = size.width < 1100;
    final theme = Theme.of(context);
    final authController = ref.watch(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: _isMobile
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    _isDrawerOpen = true;
                  });
                },
              )
            : null,
        actions: [
          // Notifications
          IconButton(
            icon: const Badge(
              label: Text('3'),
              child: Icon(Icons.notifications_outlined),
            ),
            onPressed: () {
              // Show notifications panel
            },
          ),
          const SizedBox(width: 8),

          // User profile menu
          PopupMenuButton<String>(
            offset: const Offset(0, 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: theme.colorScheme.primary,
                    child: const Icon(
                      Icons.person,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  if (!_isMobile) ...[
                    const SizedBox(width: 8),
                    Text(
                      'Admin User', // Replace with actual user name
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down, size: 16),
                  ],
                ],
              ),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.account_circle_outlined, size: 20),
                    SizedBox(width: 8),
                    Text('My Profile'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined, size: 20),
                    SizedBox(width: 8),
                    Text('Settings'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 20),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 'logout') {
                await authController.logout();
                if (mounted) {
                  context.go(AppRoutes.login);
                }
              } else if (value == 'profile') {
                // Navigate to profile
              } else if (value == 'settings') {
                context.go(AppRoutes.settings);
              }
            },
          ),
        ],
      ),
      drawer: _isMobile ? _buildDrawer(context, authController) : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Side navigation for desktop
            if (!_isMobile) _buildSideNav(context, authController),

            // Main content area
            Expanded(
              child: Container(
                color: theme.scaffoldBackgroundColor,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideNav(BuildContext context, AuthController authController) {
    final theme = Theme.of(context);
    final isAdmin = authController.isAdmin();
    final isProvider =
        authController.isProvider() || authController.isProviderStaff();

    return Container(
      width: 260,
      height: double.infinity,
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          // App logo/branding
          if (!_isMobile) ...[
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.asset(
                    AssetPaths.logo,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.school, size: 32),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'UniConnect',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
          ],

          // Navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNavItem(
                  context,
                  'Dashboard',
                  Icons.dashboard_outlined,
                  AppRoutes.dashboard,
                  widget.selectedIndex == 0,
                ),
                if (isAdmin) ...[
                  _buildNavItem(
                    context,
                    'Users',
                    Icons.people_outlined,
                    AppRoutes.users,
                    widget.selectedIndex == 1,
                  ),
                ],
                if (isAdmin || isProvider) ...[
                  _buildNavItem(
                    context,
                    'Service Providers',
                    Icons.business_outlined,
                    AppRoutes.providers,
                    widget.selectedIndex == 2,
                  ),
                ],
                _buildNavItem(
                  context,
                  'Services',
                  Icons.design_services_outlined,
                  AppRoutes.services,
                  widget.selectedIndex == 3,
                ),
                _buildNavItem(
                  context,
                  'Service Requests',
                  Icons.assignment_outlined,
                  AppRoutes.serviceRequests,
                  widget.selectedIndex == 4,
                ),
                _buildNavItem(
                  context,
                  'Transactions',
                  Icons.receipt_long_outlined,
                  AppRoutes.transactions,
                  widget.selectedIndex == 5,
                ),

                // Universities section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'UNIVERSITIES',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                _buildNavItem(
                  context,
                  'Universities',
                  Icons.school_outlined,
                  AppRoutes.universities,
                  widget.selectedIndex == 6,
                ),
                _buildNavItem(
                  context,
                  'Academic Levels',
                  Icons.military_tech_outlined,
                  AppRoutes.academicLevels,
                  widget.selectedIndex == 7,
                ),
                _buildNavItem(
                  context,
                  'Majors',
                  Icons.menu_book_outlined,
                  AppRoutes.majors,
                  widget.selectedIndex == 8,
                ),
                _buildNavItem(
                  context,
                  'University Programs',
                  Icons.school_outlined,
                  AppRoutes.universityPrograms,
                  widget.selectedIndex == 9,
                ),

                // Analytics & reports section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'ANALYTICS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                _buildNavItem(
                  context,
                  'Analytics',
                  Icons.analytics_outlined,
                  AppRoutes.analytics,
                  widget.selectedIndex == 10,
                ),
                _buildNavItem(
                  context,
                  'Settings',
                  Icons.settings_outlined,
                  AppRoutes.settings,
                  widget.selectedIndex == 11,
                ),
              ],
            ),
          ),

          // App version
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'v1.0.0', // Replace with actual version
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.widgetStateProperty(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, AuthController authController) {
    return Drawer(child: _buildSideNav(context, authController));
  }

  Widget _buildNavItem(
    BuildContext context,
    String title,
    IconData icon,
    String route,
    bool isSelected,
  ) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface.widgetStateProperty(0.6),
          size: 20,
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
        ),
        selected: isSelected,
        selectedTileColor: theme.colorScheme.primary.widgetStateProperty(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: () {
          if (!isSelected) {
            context.go(route);
          }
          if (_isMobile && _isDrawerOpen) {
            setState(() {
              _isDrawerOpen = false;
            });
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
