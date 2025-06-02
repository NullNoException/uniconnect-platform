import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/models/service_request.dart';
import '../widgets/document_verification_dialog.dart';

class ServiceRequestDocumentsWidget extends ConsumerWidget {
  final ServiceRequest request;

  const ServiceRequestDocumentsWidget({super.key, required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Documents (${request.documents.length})',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showUploadDialog(context),
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload Document'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (request.documents.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.folder_open,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No documents uploaded yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Documents will appear here once uploaded',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            )
          else
            ...request.documents.map((document) {
              return _buildDocumentCard(context, ref, document, theme);
            }),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(
    BuildContext context,
    WidgetRef ref,
    RequestDocument document,
    ThemeData theme,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildDocumentIcon(document.fileName),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.fileName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        document.documentType,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(document.status, theme),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) =>
                      _handleDocumentAction(context, ref, value, document),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'download',
                      child: Row(
                        children: [
                          Icon(Icons.download),
                          SizedBox(width: 8),
                          Text('Download'),
                        ],
                      ),
                    ),
                    if (document.status == DocumentStatus.pendingVerification)
                      const PopupMenuItem(
                        value: 'verify',
                        child: Row(
                          children: [
                            Icon(Icons.verified),
                            SizedBox(width: 8),
                            Text('Verify'),
                          ],
                        ),
                      ),
                    const PopupMenuItem(
                      value: 'replace',
                      child: Row(
                        children: [
                          Icon(Icons.swap_horiz),
                          SizedBox(width: 8),
                          Text('Replace'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Document details
            Wrap(
              spacing: 24,
              runSpacing: 8,
              children: [
                _buildDetailItem(
                  'Submitted',
                  DateFormat.yMMMd().format(document.submissionDate),
                  Icons.calendar_today,
                ),
                if (document.verificationDate != null)
                  _buildDetailItem(
                    'Verified',
                    DateFormat.yMMMd().format(document.verificationDate!),
                    Icons.verified,
                  ),
                _buildDetailItem(
                  'Size',
                  _formatFileSize(document.fileSize),
                  Icons.storage,
                ),
              ],
            ),

            if (document.verificationNotes?.isNotEmpty == true) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verification Notes',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      document.verificationNotes!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentIcon(String fileName) {
    final extension = fileName.toLowerCase().split('.').last;
    IconData icon;
    Color color;

    switch (extension) {
      case 'pdf':
        icon = Icons.picture_as_pdf;
        color = Colors.red;
        break;
      case 'doc':
      case 'docx':
        icon = Icons.description;
        color = Colors.blue;
        break;
      case 'jpg':
      case 'jpeg':
      case 'png':
        icon = Icons.image;
        color = Colors.green;
        break;
      default:
        icon = Icons.insert_drive_file;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildStatusChip(DocumentStatus status, ThemeData theme) {
    Color backgroundColor;
    Color textColor;
    IconData? icon;

    switch (status) {
      case DocumentStatus.approved:
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        icon = Icons.check_circle;
        break;
      case DocumentStatus.rejected:
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        icon = Icons.cancel;
        break;
      case DocumentStatus.pendingVerification:
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        icon = Icons.pending;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            status.displayName,
            style: theme.textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          '$label: $value',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  void _handleDocumentAction(
    BuildContext context,
    WidgetRef ref,
    String action,
    RequestDocument document,
  ) {
    switch (action) {
      case 'download':
        _downloadDocument(document, context);
        break;
      case 'verify':
        _showVerificationDialog(context, ref, document);
        break;
      case 'replace':
        _replaceDocument(document, context);
        break;
      case 'delete':
        _showDeleteDialog(context, document);
        break;
    }
  }

  void _downloadDocument(RequestDocument document, BuildContext context) {
    // TODO: Implement document download
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading ${document.fileName}...')),
    );
  }

  void _showVerificationDialog(
    BuildContext context,
    WidgetRef ref,
    RequestDocument document,
  ) {
    showDialog(
      context: context,
      builder: (context) => DocumentVerificationDialog(
        document: document,
        onVerify: (approved, notes) {
          // TODO: Implement document verification
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Document ${approved ? 'approved' : 'rejected'}'),
            ),
          );
        },
      ),
    );
  }

  void _replaceDocument(RequestDocument document, BuildContext context) {
    // TODO: Implement document replacement
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Replace ${document.fileName}...')));
  }

  void _showDeleteDialog(BuildContext context, RequestDocument document) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Document'),
        content: Text('Are you sure you want to delete ${document.fileName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteDocument(document, context);
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

  void _deleteDocument(RequestDocument document, BuildContext context) {
    // TODO: Implement document deletion
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${document.fileName} deleted')));
  }

  void _showUploadDialog(BuildContext context) {
    // TODO: Implement document upload dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document upload feature coming soon')),
    );
  }
}
