import 'package:flutter/material.dart';
import '../../domain/models/service.dart';

class PackageDialog extends StatefulWidget {
  final ServicePackage? package;

  const PackageDialog({super.key, this.package});

  @override
  State<PackageDialog> createState() => _PackageDialogState();
}

class _PackageDialogState extends State<PackageDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _deliveryDaysController = TextEditingController();
  final _featuresController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.package != null) {
      _populateForm(widget.package!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _deliveryDaysController.dispose();
    _featuresController.dispose();
    super.dispose();
  }

  void _populateForm(ServicePackage package) {
    _nameController.text = package.name;
    _descriptionController.text = package.description;
    _priceController.text = package.price.toString();
    _deliveryDaysController.text = package.deliveryTime.inDays.toString();
    _featuresController.text = package.features?.join(', ') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.package != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Package' : 'Add Package'),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Package Name *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Package name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description *',
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price *',
                    prefixText: '\$ ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Price is required';
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _featuresController,
                  decoration: const InputDecoration(
                    labelText: 'Features',
                    hintText: 'Enter features separated by commas',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _savePackage,
          child: Text(isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }

  void _savePackage() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final features = _featuresController.text
        .split(',')
        .map((feature) => feature.trim())
        .where((feature) => feature.isNotEmpty)
        .toList();

    final package = ServicePackage(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      price: double.parse(_priceController.text),
      deliveryTime: Duration(days: int.parse(_deliveryDaysController.text)),
      features: features.isNotEmpty ? features : null,
    );

    Navigator.of(context).pop(package);
  }
}

class RequirementDialog extends StatefulWidget {
  final ServiceRequirement? requirement;

  const RequirementDialog({super.key, this.requirement});

  @override
  State<RequirementDialog> createState() => _RequirementDialogState();
}

class _RequirementDialogState extends State<RequirementDialog> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _optionsController = TextEditingController();

  ServiceRequirementType _type = ServiceRequirementType.text;
  bool _isRequired = false;

  @override
  void initState() {
    super.initState();
    if (widget.requirement != null) {
      _populateForm(widget.requirement!);
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _optionsController.dispose();
    super.dispose();
  }

  void _populateForm(ServiceRequirement requirement) {
    _questionController.text = requirement.question;
    _type = requirement.type;
    _isRequired = requirement.isRequired;
    _optionsController.text = requirement.options?.join(', ') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.requirement != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Requirement' : 'Add Requirement'),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _questionController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Question *',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Question is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<ServiceRequirementType>(
                  value: _type,
                  decoration: const InputDecoration(
                    labelText: 'Type *',
                    border: OutlineInputBorder(),
                  ),
                  items: ServiceRequirementType.values
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(_formatRequirementType(type)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _type = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                if (_type == ServiceRequirementType.multipleChoice)
                  TextFormField(
                    controller: _optionsController,
                    decoration: const InputDecoration(
                      labelText: 'Options *',
                      hintText: 'Enter options separated by commas',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (_type == ServiceRequirementType.multipleChoice &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Options are required for multiple choice';
                      }
                      return null;
                    },
                  ),
                if (_type == ServiceRequirementType.multipleChoice)
                  const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Required'),
                  subtitle: const Text('Make this requirement mandatory'),
                  value: _isRequired,
                  onChanged: (value) {
                    setState(() {
                      _isRequired = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveRequirement,
          child: Text(isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }

  String _formatRequirementType(ServiceRequirementType type) {
    switch (type) {
      case ServiceRequirementType.text:
        return 'Text';
      case ServiceRequirementType.number:
        return 'Number';
      case ServiceRequirementType.multipleChoice:
        return 'Multiple Choice';
      case ServiceRequirementType.file:
        return 'File';
    }
  }

  void _saveRequirement() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    List<String>? options;
    if (_type == ServiceRequirementType.multipleChoice) {
      options = _optionsController.text
          .split(',')
          .map((option) => option.trim())
          .where((option) => option.isNotEmpty)
          .toList();
    }

    final requirement = ServiceRequirement(
      question: _questionController.text.trim(),
      type: _type,
      isRequired: _isRequired,
      options: options,
    );

    Navigator.of(context).pop(requirement);
  }
}
