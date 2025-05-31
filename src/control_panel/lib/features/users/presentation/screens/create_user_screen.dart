import 'package:control_panel/core/utils/color_utils.dart';
import 'package:control_panel/core/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../dashboard/presentation/widgets/dashboard_layout.dart';

class CreateUserScreen extends ConsumerStatefulWidget {
  const CreateUserScreen({super.key});

  @override
  ConsumerState<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends ConsumerState<CreateUserScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isSubmitting = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final List<String> _selectedRoles = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DashboardLayout(
      title: 'Create User',
      selectedIndex: 1, // Users section
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.go(AppRoutes.users),
                      tooltip: 'Back to users',
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Create New User',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Form
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Basic information section
                          Text(
                            'Basic Information',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Name field
                          FormBuilderTextField(
                            name: 'name',
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              hintText: 'Enter user\'s full name',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(2),
                              FormBuilderValidators.maxLength(100),
                            ]),
                          ),
                          const SizedBox(height: 16),

                          // Email field
                          FormBuilderTextField(
                            name: 'email',
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter user\'s email address',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                              FormBuilderValidators.maxLength(255),
                            ]),
                          ),
                          const SizedBox(height: 16),

                          // Phone field
                          FormBuilderTextField(
                            name: 'phoneNumber',
                            decoration: const InputDecoration(
                              labelText: 'Phone Number (optional)',
                              hintText: 'Enter user\'s phone number',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.maxLength(20),
                            ]),
                          ),
                          const SizedBox(height: 32),

                          // Password section
                          Text(
                            'Password',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Password field
                          FormBuilderTextField(
                            name: 'password',
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter password',
                              prefixIcon: const Icon(Icons.lock),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_isPasswordVisible,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(8),
                              FormBuilderValidators.match(
                                RegExp(ValidationConstants.passwordPattern),
                                errorText:
                                    'Password must contain at least one letter and one number',
                              ),
                            ]),
                          ),
                          const SizedBox(height: 16),

                          // Confirm password field
                          FormBuilderTextField(
                            name: 'confirmPassword',
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              hintText: 'Confirm password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_isConfirmPasswordVisible,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              (value) {
                                if (value !=
                                    _formKey
                                        .currentState
                                        ?.fields['password']
                                        ?.value) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ]),
                          ),
                          const SizedBox(height: 32),

                          // Roles section
                          Text(
                            'Roles',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          Text(
                            'Select at least one role for the user',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .widgetStateProperty(0.6),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Role checkboxes
                          FormBuilderField(
                            name: 'roles',
                            validator: (value) {
                              if (_selectedRoles.isEmpty) {
                                return 'Please select at least one role';
                              }
                              return null;
                            },
                            initialValue: _selectedRoles,
                            builder: (FormFieldState<dynamic> field) {
                              return Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  _buildRoleChip(Roles.admin, 'Administrator'),
                                  _buildRoleChip(Roles.moderator, 'Moderator'),
                                  _buildRoleChip(
                                    Roles.provider,
                                    'Service Provider',
                                  ),
                                  _buildRoleChip(
                                    Roles.providerStaff,
                                    'Provider Staff',
                                  ),
                                  _buildRoleChip(Roles.student, 'Student'),
                                ],
                              );
                            },
                          ),
                          if (_formKey
                                  .currentState
                                  ?.fields['roles']
                                  ?.hasError ??
                              false)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                _formKey
                                        .currentState
                                        ?.fields['roles']
                                        ?.errorText ??
                                    '',
                                style: TextStyle(
                                  color: theme.colorScheme.error,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          const SizedBox(height: 32),

                          // Status section
                          Text(
                            'Account Status',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          FormBuilderSwitch(
                            name: 'isActive',
                            title: Text(
                              'Active Account',
                              style: theme.textTheme.bodyLarge,
                            ),
                            subtitle: Text(
                              'User will be able to log in immediately',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .widgetStateProperty(0.6),
                              ),
                            ),
                            initialValue: true,
                            activeColor: theme.colorScheme.primary,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Send welcome email option
                          FormBuilderSwitch(
                            name: 'sendWelcomeEmail',
                            title: Text(
                              'Send Welcome Email',
                              style: theme.textTheme.bodyLarge,
                            ),
                            subtitle: Text(
                              'Send an email with login instructions to the user',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .widgetStateProperty(0.6),
                              ),
                            ),
                            initialValue: true,
                            activeColor: theme.colorScheme.primary,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Form actions
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () => context.go(AppRoutes.users),
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: _isSubmitting ? null : _handleSubmit,
                                child: _isSubmitting
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Create User'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleChip(String role, String label) {
    final isSelected = _selectedRoles.contains(role);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedRoles.add(role);
          } else {
            _selectedRoles.remove(role);
          }
          // Update form field value
          _formKey.currentState?.fields['roles']?.didChange(_selectedRoles);
        });
      },
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        final formData = _formKey.currentState!.value;

        // Prepare user data for API
        final userData = {
          'name': formData['name'],
          'email': formData['email'],
          'phoneNumber': formData['phoneNumber'],
          'password': formData['password'],
          'roles': _selectedRoles,
          'isActive': formData['isActive'],
          'sendWelcomeEmail': formData['sendWelcomeEmail'],
        };

        // Create user
        final userRepository = ref.read(userRepositoryProvider);
        final userId = await userRepository.createUser(userData);

        if (mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User created successfully'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to user details page
          context.go('${AppRoutes.users}/$userId');
        }
      } catch (e) {
        if (mounted) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error creating user: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );

          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }
}
