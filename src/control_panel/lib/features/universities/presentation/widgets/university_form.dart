import 'package:flutter/material.dart';

class UniversityForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController websiteController;
  final TextEditingController logoUrlController;
  final TextEditingController descriptionController;
  final bool isActive;
  final bool isSubmitting;
  final Function(bool) onIsActiveChanged;

  const UniversityForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.countryController,
    required this.cityController,
    required this.websiteController,
    required this.logoUrlController,
    required this.descriptionController,
    required this.isActive,
    required this.onIsActiveChanged,
    required this.isSubmitting,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Basic Information', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'University Name *',
                      hintText: 'Enter university name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'University name is required';
                      }
                      return null;
                    },
                    enabled: !isSubmitting,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: countryController,
                          decoration: const InputDecoration(
                            labelText: 'Country *',
                            hintText: 'Enter country',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Country is required';
                            }
                            return null;
                          },
                          enabled: !isSubmitting,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: cityController,
                          decoration: const InputDecoration(
                            labelText: 'City *',
                            hintText: 'Enter city',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'City is required';
                            }
                            return null;
                          },
                          enabled: !isSubmitting,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Active'),
                    subtitle: const Text(
                      'Toggle this to activate or deactivate the university',
                    ),
                    value: isActive,
                    onChanged: isSubmitting ? null : onIsActiveChanged,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Information',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: websiteController,
                    decoration: const InputDecoration(
                      labelText: 'Website',
                      hintText: 'Enter university website URL',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !isSubmitting,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: logoUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Logo URL',
                      hintText: 'Enter URL for university logo',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !isSubmitting,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter university description',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    enabled: !isSubmitting,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
