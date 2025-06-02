import 'package:flutter/material.dart';

/// A comprehensive error widget with various error states and retry functionality
class CustomErrorWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final String? details;
  final VoidCallback? onRetry;
  final String? retryButtonText;
  final IconData? icon;
  final bool showDetails;
  final Color? primaryColor;
  final Color? backgroundColor;
  final Widget? customAction;
  final ErrorType type;

  const CustomErrorWidget({
    super.key,
    this.title,
    this.message,
    this.details,
    this.onRetry,
    this.retryButtonText,
    this.icon,
    this.showDetails = false,
    this.primaryColor,
    this.backgroundColor,
    this.customAction,
    this.type = ErrorType.general,
  });

  const CustomErrorWidget.network({
    super.key,
    this.title = 'Connection Error',
    this.message = 'Please check your internet connection and try again.',
    this.details,
    this.onRetry,
    this.retryButtonText = 'Retry',
    this.icon = Icons.wifi_off_rounded,
    this.showDetails = false,
    this.primaryColor,
    this.backgroundColor,
    this.customAction,
  }) : type = ErrorType.network;

  const CustomErrorWidget.notFound({
    super.key,
    this.title = 'Not Found',
    this.message = 'The requested resource could not be found.',
    this.details,
    this.onRetry,
    this.retryButtonText = 'Go Back',
    this.icon = Icons.search_off_rounded,
    this.showDetails = false,
    this.primaryColor,
    this.backgroundColor,
    this.customAction,
  }) : type = ErrorType.notFound;

  const CustomErrorWidget.unauthorized({
    super.key,
    this.title = 'Access Denied',
    this.message = 'You do not have permission to access this resource.',
    this.details,
    this.onRetry,
    this.retryButtonText = 'Login',
    this.icon = Icons.lock_outline_rounded,
    this.showDetails = false,
    this.primaryColor,
    this.backgroundColor,
    this.customAction,
  }) : type = ErrorType.unauthorized;

  const CustomErrorWidget.server({
    super.key,
    this.title = 'Server Error',
    this.message = 'Something went wrong on our end. Please try again later.',
    this.details,
    this.onRetry,
    this.retryButtonText = 'Retry',
    this.icon = Icons.error_outline_rounded,
    this.showDetails = false,
    this.primaryColor,
    this.backgroundColor,
    this.customAction,
  }) : type = ErrorType.server;

  const CustomErrorWidget.validation({
    super.key,
    this.title = 'Validation Error',
    this.message = 'Please check your input and try again.',
    this.details,
    this.onRetry,
    this.retryButtonText = 'OK',
    this.icon = Icons.warning_amber_rounded,
    this.showDetails = true,
    this.primaryColor,
    this.backgroundColor,
    this.customAction,
  }) : type = ErrorType.validation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectivePrimaryColor =
        primaryColor ?? _getTypeColor(type, colorScheme);
    final effectiveBackgroundColor = backgroundColor ?? colorScheme.surface;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: effectivePrimaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Error Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: effectivePrimaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? _getTypeIcon(type),
              size: 48,
              color: effectivePrimaryColor,
            ),
          ),

          const SizedBox(height: 24),

          // Title
          if (title != null)
            Text(
              title!,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: effectivePrimaryColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

          if (title != null) const SizedBox(height: 12),

          // Message
          if (message != null)
            Text(
              message!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

          // Details (collapsible)
          if (details != null && showDetails) ...[
            const SizedBox(height: 16),
            ExpansionTile(
              title: Text(
                'Details',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    details!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (customAction != null) ...[
                customAction!,
                if (onRetry != null) const SizedBox(width: 12),
              ],

              if (onRetry != null)
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: Icon(_getRetryIcon(type)),
                  label: Text(retryButtonText ?? 'Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: effectivePrimaryColor,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(ErrorType type, ColorScheme colorScheme) {
    switch (type) {
      case ErrorType.network:
        return colorScheme.primary;
      case ErrorType.notFound:
        return colorScheme.tertiary;
      case ErrorType.unauthorized:
        return colorScheme.error;
      case ErrorType.server:
        return colorScheme.error;
      case ErrorType.validation:
        return Colors.orange;
      case ErrorType.general:
        return colorScheme.error;
    }
  }

  IconData _getTypeIcon(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Icons.wifi_off_rounded;
      case ErrorType.notFound:
        return Icons.search_off_rounded;
      case ErrorType.unauthorized:
        return Icons.lock_outline_rounded;
      case ErrorType.server:
        return Icons.error_outline_rounded;
      case ErrorType.validation:
        return Icons.warning_amber_rounded;
      case ErrorType.general:
        return Icons.error_outline_rounded;
    }
  }

  IconData _getRetryIcon(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Icons.refresh_rounded;
      case ErrorType.notFound:
        return Icons.arrow_back_rounded;
      case ErrorType.unauthorized:
        return Icons.login_rounded;
      case ErrorType.server:
        return Icons.refresh_rounded;
      case ErrorType.validation:
        return Icons.check_rounded;
      case ErrorType.general:
        return Icons.refresh_rounded;
    }
  }
}

/// Compact error widget for inline display
class CompactErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;
  final Color? color;

  const CompactErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveColor = color ?? colorScheme.error;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: effectiveColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: effectiveColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            icon ?? Icons.error_outline_rounded,
            size: 20,
            color: effectiveColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(color: effectiveColor),
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              iconSize: 16,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              color: effectiveColor,
            ),
          ],
        ],
      ),
    );
  }
}

/// Error boundary widget for handling widget tree errors
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(FlutterErrorDetails)? errorBuilder;
  final void Function(FlutterErrorDetails)? onError;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
    this.onError,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  FlutterErrorDetails? _errorDetails;

  @override
  void initState() {
    super.initState();

    FlutterError.onError = (FlutterErrorDetails details) {
      widget.onError?.call(details);
      setState(() {
        _errorDetails = details;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_errorDetails != null) {
      return widget.errorBuilder?.call(_errorDetails!) ??
          CustomErrorWidget(
            title: 'Something went wrong',
            message: 'An unexpected error occurred.',
            details: _errorDetails!.toString(),
            showDetails: true,
            onRetry: () {
              setState(() {
                _errorDetails = null;
              });
            },
          );
    }

    return widget.child;
  }
}

enum ErrorType { general, network, notFound, unauthorized, server, validation }
