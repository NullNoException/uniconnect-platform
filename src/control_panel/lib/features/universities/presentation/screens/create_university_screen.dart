import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/models/university_request.dart';
import '../controllers/universities_controller.dart';
import '../widgets/university_form.dart';

class CreateUniversityScreen extends ConsumerStatefulWidget {
  const CreateUniversityScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateUniversityScreen> createState() =>
      _CreateUniversityScreenState();
}

class _CreateUniversityScreenState
    extends ConsumerState<CreateUniversityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _websiteController = TextEditingController();
  final _logoUrlController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isActive = true;

  bool _isSubmitting = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      final request = UniversityRequest(
        name: _nameController.text,
        country: _countryController.text,
        city: _cityController.text,
        website:
            _websiteController.text.isNotEmpty ? _websiteController.text : null,
        logoUrl:
            _logoUrlController.text.isNotEmpty ? _logoUrlController.text : null,
        description:
            _descriptionController.text.isNotEmpty
                ? _descriptionController.text
                : null,
        isActive: _isActive,
      );

      final success = await ref
          .read(universitiesControllerProvider.notifier)
          .createUniversity(request);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('University created successfully')),
        );
        context.go(AppRoutes.universities);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.read(universitiesControllerProvider).errorMessage ??
                  'Failed to create university',
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _websiteController.dispose();
    _logoUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Create University')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add New University', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 24),
              UniversityForm(
                formKey: _formKey,
                nameController: _nameController,
                countryController: _countryController,
                cityController: _cityController,
                websiteController: _websiteController,
                logoUrlController: _logoUrlController,
                descriptionController: _descriptionController,
                isActive: _isActive,
                onIsActiveChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
                isSubmitting: _isSubmitting,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed:
                        _isSubmitting
                            ? null
                            : () => context.go(AppRoutes.universities),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child:
                        _isSubmitting
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Text('Create University'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
