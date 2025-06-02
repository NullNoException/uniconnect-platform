import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../dashboard/presentation/widgets/dashboard_layout.dart';
import '../../domain/models/service.dart';
import '../providers/service_providers.dart';
import '../widgets/service_dialogs.dart';

class ServiceFormScreen extends ConsumerStatefulWidget {
  final String? serviceId; // null for create, populated for edit

  const ServiceFormScreen({super.key, this.serviceId});

  @override
  ConsumerState<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends ConsumerState<ServiceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _basePriceController = TextEditingController();
  final _deliveryDaysController = TextEditingController();
  final _tagsController = TextEditingController();

  String? _selectedCategoryId;
  String? _selectedSubcategoryId;
  ServicePricingType _pricingType = ServicePricingType.fixed;
  bool _isFeatured = false;
  bool _isLoading = false;

  List<ServicePackage> _packages = [];
  List<ServiceRequirement> _requirements = [];

  @override
  void initState() {
    super.initState();
    if (widget.serviceId != null) {
      _loadServiceForEdit();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _basePriceController.dispose();
    _deliveryDaysController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _loadServiceForEdit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() => _isLoading = true);

      try {
        final service = await ref
            .read(serviceControllerProvider.notifier)
            .getServiceById(widget.serviceId!);

        if (service != null) {
          _populateFormWithService(service);
        }
      } finally {
        setState(() => _isLoading = false);
      }
    });
  }

  void _populateFormWithService(Service service) {
    setState(() {
      _titleController.text = service.title;
      _descriptionController.text = service.description;
      _basePriceController.text = service.basePrice.toString();
      _deliveryDaysController.text = service.deliveryTime.inDays.toString();
      _selectedCategoryId = service.categoryId;
      _selectedSubcategoryId = service.subcategoryId;
      _pricingType = service.pricingType;
      _isFeatured = service.isFeatured ?? false;
      _packages = service.packages ?? [];
      _requirements = service.requirements ?? [];
      _tagsController.text = service.tags?.join(', ') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoriesAsync = ref.watch(serviceCategoriesProvider);
    final isEditing = widget.serviceId != null;

    return DashboardLayout(
      title: isEditing ? 'Edit Service' : 'Create Service',
      selectedIndex: 3,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, theme, isEditing),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _buildBasicInfoSection(theme),
                              const SizedBox(height: 24),
                              _buildDescriptionSection(theme),
                              const SizedBox(height: 24),
                              _buildPackagesSection(theme),
                              const SizedBox(height: 24),
                              _buildRequirementsSection(theme),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            children: [
                              _buildCategorySection(theme, categoriesAsync),
                              const SizedBox(height: 24),
                              _buildPricingSection(theme),
                              const SizedBox(height: 24),
                              _buildSettingsSection(theme),
                              const SizedBox(height: 24),
                              _buildActionButtons(theme, isEditing),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, bool isEditing) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEditing ? 'Edit Service' : 'Create New Service',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isEditing
                    ? 'Update service information and settings'
                    : 'Fill in the details to create a new service',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBasicInfoSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Service Title *',
                hintText: 'Enter service title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Title is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tagsController,
              decoration: const InputDecoration(
                labelText: 'Tags',
                hintText: 'Enter tags separated by commas',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Service Description *',
                hintText: 'Describe your service in detail',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Description is required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(
    ThemeData theme,
    AsyncValue<List<ServiceCategory>> categoriesAsync,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            categoriesAsync.when(
              data: (categories) => Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedCategoryId,
                    decoration: const InputDecoration(
                      labelText: 'Category *',
                      border: OutlineInputBorder(),
                    ),
                    items: categories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category.id,
                            child: Text(category.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategoryId = value;
                        _selectedSubcategoryId = null; // Reset subcategory
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Category is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  if (_selectedCategoryId != null)
                    _buildSubcategoryDropdown(theme, categories),
                ],
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text('Error loading categories: $error'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubcategoryDropdown(
    ThemeData theme,
    List<ServiceCategory> categories,
  ) {
    return FutureBuilder<List<ServiceSubcategory>>(
      future: ref
          .read(serviceCategoryControllerProvider.notifier)
          .getSubcategories(_selectedCategoryId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error loading subcategories: ${snapshot.error}');
        }

        final subcategories = snapshot.data ?? [];

        return DropdownButtonFormField<String>(
          value: _selectedSubcategoryId,
          decoration: const InputDecoration(
            labelText: 'Subcategory *',
            border: OutlineInputBorder(),
          ),
          items: subcategories
              .map(
                (subcategory) => DropdownMenuItem(
                  value: subcategory.id,
                  child: Text(subcategory.name),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedSubcategoryId = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Subcategory is required';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildPricingSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pricing',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ServicePricingType>(
              value: _pricingType,
              decoration: const InputDecoration(
                labelText: 'Pricing Type *',
                border: OutlineInputBorder(),
              ),
              items: ServicePricingType.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _pricingType = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _basePriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Base Price *',
                hintText: 'Enter base price',
                prefixText: '\$ ',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Base price is required';
                }
                if (double.tryParse(value) == null) {
                  return 'Enter a valid price';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _deliveryDaysController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Delivery Time (days) *',
                hintText: 'Enter delivery time in days',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Delivery time is required';
                }
                if (int.tryParse(value) == null) {
                  return 'Enter a valid number of days';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Featured Service'),
              subtitle: const Text('Mark this service as featured'),
              value: _isFeatured,
              onChanged: (value) {
                setState(() {
                  _isFeatured = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackagesSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Service Packages',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: _addPackage,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Package'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_packages.isEmpty)
              Text(
                'No packages added yet',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              )
            else
              ..._packages.asMap().entries.map((entry) {
                final index = entry.key;
                final package = entry.value;
                return _buildPackageCard(theme, package, index);
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(ThemeData theme, ServicePackage package, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  package.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    '\$${package.price.toStringAsFixed(2)}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _editPackage(index),
                    icon: const Icon(Icons.edit, size: 16),
                  ),
                  IconButton(
                    onPressed: () => _removePackage(index),
                    icon: const Icon(Icons.delete, size: 16),
                  ),
                ],
              ),
            ],
          ),
          Text(package.description),
          const SizedBox(height: 4),
          Text(
            'Delivery: ${package.deliveryTime.inDays} days',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Requirements',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: _addRequirement,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Requirement'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_requirements.isEmpty)
              Text(
                'No requirements added yet',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              )
            else
              ..._requirements.asMap().entries.map((entry) {
                final index = entry.key;
                final requirement = entry.value;
                return _buildRequirementCard(theme, requirement, index);
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementCard(
    ThemeData theme,
    ServiceRequirement requirement,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  requirement.question,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  if (requirement.isRequired)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Required',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onError,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _editRequirement(index),
                    icon: const Icon(Icons.edit, size: 16),
                  ),
                  IconButton(
                    onPressed: () => _removeRequirement(index),
                    icon: const Icon(Icons.delete, size: 16),
                  ),
                ],
              ),
            ],
          ),
          Text(
            'Type: ${requirement.type.name}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme, bool isEditing) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(isEditing ? 'Update Service' : 'Create Service'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  void _addPackage() async {
    final result = await showDialog<ServicePackage>(
      context: context,
      builder: (context) => const PackageDialog(),
    );

    if (result != null) {
      setState(() {
        _packages.add(result);
      });
    }
  }

  void _editPackage(int index) async {
    final result = await showDialog<ServicePackage>(
      context: context,
      builder: (context) => PackageDialog(package: _packages[index]),
    );

    if (result != null) {
      setState(() {
        _packages[index] = result;
      });
    }
  }

  void _removePackage(int index) {
    setState(() {
      _packages.removeAt(index);
    });
  }

  void _addRequirement() async {
    final result = await showDialog<ServiceRequirement>(
      context: context,
      builder: (context) => const RequirementDialog(),
    );

    if (result != null) {
      setState(() {
        _requirements.add(result);
      });
    }
  }

  void _editRequirement(int index) async {
    final result = await showDialog<ServiceRequirement>(
      context: context,
      builder: (context) =>
          RequirementDialog(requirement: _requirements[index]),
    );

    if (result != null) {
      setState(() {
        _requirements[index] = result;
      });
    }
  }

  void _removeRequirement(int index) {
    setState(() {
      _requirements.removeAt(index);
    });
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final tags = _tagsController.text
          .split(',')
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList();

      final request = ServiceRequest(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        categoryId: _selectedCategoryId!,
        subcategoryId: _selectedSubcategoryId!,
        basePrice: double.parse(_basePriceController.text),
        pricingType: _pricingType,
        deliveryTime: Duration(days: int.parse(_deliveryDaysController.text)),
        packages: _packages.isNotEmpty ? _packages : null,
        requirements: _requirements.isNotEmpty ? _requirements : null,
        tags: tags.isNotEmpty ? tags : null,
        isFeatured: _isFeatured,
      );

      if (widget.serviceId != null) {
        // Update existing service
        await ref
            .read(serviceControllerProvider.notifier)
            .updateService(widget.serviceId!, request);
      } else {
        // Create new service
        await ref
            .read(serviceControllerProvider.notifier)
            .createService(request);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.serviceId != null
                  ? 'Service updated successfully'
                  : 'Service created successfully',
            ),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
