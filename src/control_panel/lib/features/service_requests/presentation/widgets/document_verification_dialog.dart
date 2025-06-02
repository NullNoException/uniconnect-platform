import 'package:flutter/material.dart';

import '../../domain/models/service_request.dart';

class DocumentVerificationDialog extends StatefulWidget {
  final RequestDocument document;
  final Function(bool approved, String notes) onVerify;

  const DocumentVerificationDialog({
    super.key,
    required this.document,
    required this.onVerify,
  });

  @override
  State<DocumentVerificationDialog> createState() =>
      _DocumentVerificationDialogState();
}

class _DocumentVerificationDialogState
    extends State<DocumentVerificationDialog> {
  final _notesController = TextEditingController();
  bool _isApproved = true;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('Document Verification'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Document info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.insert_drive_file,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.document.fileName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.document.documentType,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Verification decision
            Text(
              'Verification Decision',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Approve'),
                    subtitle: const Text('Document is valid'),
                    value: true,
                    groupValue: _isApproved,
                    onChanged: (value) {
                      setState(() {
                        _isApproved = value!;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Reject'),
                    subtitle: const Text('Document needs revision'),
                    value: false,
                    groupValue: _isApproved,
                    onChanged: (value) {
                      setState(() {
                        _isApproved = value!;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Notes
            Text(
              'Verification Notes',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: _isApproved
                    ? 'Add any comments about the approved document...'
                    : 'Explain why the document was rejected and what needs to be fixed...',
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onVerify(_isApproved, _notesController.text);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _isApproved ? Colors.green : Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text(_isApproved ? 'Approve' : 'Reject'),
        ),
      ],
    );
  }
}
