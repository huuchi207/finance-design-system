import 'package:flutter/cupertino.dart';

/// Cupertino-styled action sheet wrapper.
///
/// ```dart
/// FinActionSheet.show(
///   context: context,
///   title: 'Share via',
///   actions: [
///     FinActionSheetItem(label: 'Copy Link', onPressed: () => copyLink()),
///     FinActionSheetItem(label: 'Share to WhatsApp', onPressed: () => share()),
///   ],
///   cancelLabel: 'Cancel',
/// );
/// ```
class FinActionSheetItem {
  const FinActionSheetItem({
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

class FinActionSheet {
  FinActionSheet._();

  /// Show a Cupertino action sheet.
  static Future<void> show({
    required BuildContext context,
    String? title,
    String? message,
    required List<FinActionSheetItem> actions,
    String cancelLabel = 'Cancel',
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: title != null ? Text(title) : null,
        message: message != null ? Text(message) : null,
        actions: actions
            .map(
              (item) => CupertinoActionSheetAction(
                isDestructiveAction: item.isDestructive,
                isDefaultAction: item.isDefault,
                onPressed: () {
                  Navigator.of(ctx).pop();
                  item.onPressed?.call();
                },
                child: Text(item.label),
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(cancelLabel),
        ),
      ),
    );
  }
}
