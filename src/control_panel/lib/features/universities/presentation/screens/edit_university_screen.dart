import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/models/university_request.dart';
import '../controllers/universities_controller.dart';
import '../widgets/university_form.dart';

class EditUniversityScreen extends ConsumerStatefulWidget {
  final String universityId;

  const EditUniversityScreen({Key? key, required this.universityId})
    : super(key: key);

  @override
  ConsumerState<EditUniversityScreen> createState() =>
      _EditUniversityScreenState();
}

class _EditUniversityScreenState extends ConsumerState<EditUniversityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _websiteController = TextEditingController();
  final _logoUrlController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isActive = true;

  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadUniversity();
  }

  Future<void> _loadUniversity() async {
    setState(() {
      _isLoading = true;
    });

    await ref
        .read(universitiesControllerProvider.notifier)
        .getUniversityDetails(widget.universityId);

    final university =
        ref.read(universitiesControllerProvider).selectedUniversity;

    if (university != null) {
      _nameController.text = university.name;
      _countryController.text = university.country;
      _cityController.text = university.city;
      _websiteController.text = university.website ?? '';
      _logoUrlController.text = university.logoUrl ?? '';
      _descriptionController.text = university.description ?? '';
      _isActive = university.isActive;
    }

    setState(() {
      _isLoading = false;
    });
  }

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
          .updateUniversity(widget.universityId, request);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('University updated successfully')),
        );
        context.go('${AppRoutes.universities}/${widget.universityId}');
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.read(universitiesControllerProvider).errorMessage ??
                  'Failed to update university',
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
    final university =
        ref.watch(universitiesControllerProvider).selectedUniversity;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit University')),
      body:
          _isLoading || university == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit University',
                        style: theme.textTheme.headlineMedium,
                      ),
                      Text(
                        university.name,
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
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
                                    : () => context.go(
                                      '${AppRoutes.universities}/${widget.universityId}',
                                    ),
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
                                    : const Text('Save Changes'),
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
