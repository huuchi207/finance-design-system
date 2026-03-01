import 'package:flutter/cupertino.dart';
import 'package:cupertino_components/cupertino_components.dart';

/// Determines how errors should be displayed based on context.
enum FinErrorDisplayMode {
  /// Show error inline (within the content area)
  inline,

  /// Show error as a CupertinoAlertDialog
  dialog,

  /// Show error as a toast notification
  toast,
}

/// Centralized error handling utilities for finance apps.
///
/// Provides consistent error UX patterns:
/// - Inline errors for form validation
/// - Dialogs for critical/blocking errors
/// - Toasts for transient errors
/// - Retry patterns with backoff
///
/// ```dart
/// try {
///   await transferMoney();
/// } catch (e) {
///   FinErrorHandler.handle(
///     context: context,
///     error: e.toString(),
///     mode: FinErrorDisplayMode.dialog,
///     onRetry: () => transferMoney(),
///   );
/// }
/// ```
class FinErrorHandler {
  FinErrorHandler._();

  /// Handle an error with the appropriate display mode.
  static void handle({
    required BuildContext context,
    required String error,
    FinErrorDisplayMode mode = FinErrorDisplayMode.toast,
    VoidCallback? onRetry,
    String? title,
  }) {
    switch (mode) {
      case FinErrorDisplayMode.inline:
        // Inline errors are handled by the widget itself via errorText prop
        break;
      case FinErrorDisplayMode.dialog:
        _showErrorDialog(
          context: context,
          title: title ?? 'Error',
          message: error,
          onRetry: onRetry,
        );
        break;
      case FinErrorDisplayMode.toast:
        FinToast.show(
          context: context,
          message: error,
          variant: FinToastVariant.error,
          actionLabel: onRetry != null ? 'Retry' : null,
          onAction: onRetry,
        );
        break;
    }
  }

  static Future<void> _showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onRetry,
  }) {
    return FinDialog.show(
      context: context,
      title: title,
      message: message,
      primaryAction: onRetry != null
          ? FinDialogAction(
              label: 'Retry',
              onPressed: onRetry,
            )
          : const FinDialogAction(label: 'OK'),
      secondaryAction: onRetry != null
          ? const FinDialogAction(label: 'Cancel')
          : null,
    );
  }

  /// Determine the appropriate display mode based on error severity.
  ///
  /// - Network errors → dialog with retry
  /// - Validation errors → inline
  /// - Transient errors → toast
  static FinErrorDisplayMode suggestMode({
    bool isNetworkError = false,
    bool isValidationError = false,
    bool isBlocking = false,
  }) {
    if (isBlocking || isNetworkError) return FinErrorDisplayMode.dialog;
    if (isValidationError) return FinErrorDisplayMode.inline;
    return FinErrorDisplayMode.toast;
  }
}

/// Retry helper with exponential backoff.
class FinRetry {
  FinRetry._();

  /// Execute an async operation with retry logic.
  ///
  /// ```dart
  /// final result = await FinRetry.execute(
  ///   operation: () => fetchTransactions(),
  ///   maxAttempts: 3,
  /// );
  /// ```
  static Future<T> execute<T>({
    required Future<T> Function() operation,
    int maxAttempts = 3,
    Duration initialDelay = const Duration(seconds: 1),
    double backoffMultiplier = 2.0,
  }) async {
    int attempt = 0;
    Duration delay = initialDelay;

    while (true) {
      try {
        attempt++;
        return await operation();
      } catch (e) {
        if (attempt >= maxAttempts) rethrow;
        await Future.delayed(delay);
        delay = Duration(
          milliseconds: (delay.inMilliseconds * backoffMultiplier).round(),
        );
      }
    }
  }
}
