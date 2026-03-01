import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Cupertino-styled alert dialog with token-based styling.
///
/// ```dart
/// FinDialog.show(
///   context: context,
///   title: 'Confirm Transfer',
///   message: 'Are you sure you want to transfer \$500?',
///   primaryAction: FinDialogAction(
///     label: 'Transfer',
///     onPressed: () => doTransfer(),
///   ),
///   secondaryAction: FinDialogAction(
///     label: 'Cancel',
///     isDestructive: false,
///   ),
/// );
/// ```
class FinDialogAction {
  const FinDialogAction({
    required this.label,
    this.onPressed,
    this.isDestructive = false,
    this.isDefault = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isDestructive;
  final bool isDefault;
}

class FinDialog {
  FinDialog._();

  /// Show a Cupertino-styled alert dialog.
  static Future<void> show({
    required BuildContext context,
    required String title,
    String? message,
    required FinDialogAction primaryAction,
    FinDialogAction? secondaryAction,
  }) {
    return showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(title),
        content: message != null
            ? Padding(
                padding: const EdgeInsets.only(top: FinSpacing.space8),
                child: Text(message),
              )
            : null,
        actions: [
          if (secondaryAction != null)
            CupertinoDialogAction(
              isDestructiveAction: secondaryAction.isDestructive,
              isDefaultAction: secondaryAction.isDefault,
              onPressed: () {
                Navigator.of(ctx).pop();
                secondaryAction.onPressed?.call();
              },
              child: Text(secondaryAction.label),
            ),
          CupertinoDialogAction(
            isDestructiveAction: primaryAction.isDestructive,
            isDefaultAction: primaryAction.isDefault || secondaryAction == null,
            onPressed: () {
              Navigator.of(ctx).pop();
              primaryAction.onPressed?.call();
            },
            child: Text(primaryAction.label),
          ),
        ],
      ),
    );
  }

  /// Show a confirmation dialog with standard Yes/No pattern.
  static Future<bool> confirm({
    required BuildContext context,
    required String title,
    String? message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    bool result = false;
    await show(
      context: context,
      title: title,
      message: message,
      primaryAction: FinDialogAction(
        label: confirmLabel,
        isDestructive: isDestructive,
        onPressed: () => result = true,
      ),
      secondaryAction: FinDialogAction(
        label: cancelLabel,
      ),
    );
    return result;
  }
}
