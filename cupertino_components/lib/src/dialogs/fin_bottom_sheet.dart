import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// A draggable bottom sheet with token-based styling.
///
/// ```dart
/// FinBottomSheet.show(
///   context: context,
///   child: TransferForm(),
/// );
/// ```
class FinBottomSheet {
  FinBottomSheet._();

  /// Show a modal bottom sheet with drag handle and rounded corners.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    bool useRootNavigator = true,
    double? maxHeight,
  }) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;

    return showCupertinoModalPopup<T>(
      context: context,
      builder: (ctx) => _FinBottomSheetContent(
        colors: colors,
        maxHeight: maxHeight,
        child: child,
      ),
    );
  }
}

class _FinBottomSheetContent extends StatelessWidget {
  const _FinBottomSheetContent({
    required this.colors,
    required this.child,
    this.maxHeight,
  });

  final FinSemanticColors colors;
  final Widget child;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight ??
            mediaQuery.size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: colors.bgPrimary,
        borderRadius: FinRadius.bottomSheetRadius,
        boxShadow: FinShadows.shadowSubtle,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Padding(
              padding: const EdgeInsets.only(
                top: FinSpacing.space8,
                bottom: FinSpacing.space4,
              ),
              child: Container(
                width: 36,
                height: 5,
                decoration: BoxDecoration(
                  color: colors.borderDefault,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            // Content
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}
