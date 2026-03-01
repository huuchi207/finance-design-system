import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Inline message card for contextual feedback within content.
///
/// ```dart
/// FinInlineMessage(
///   message: 'Your daily limit is \$5,000.',
///   variant: FinInlineMessageVariant.info,
/// )
/// ```
enum FinInlineMessageVariant {
  info,
  success,
  warning,
  error,
}

class FinInlineMessage extends StatelessWidget {
  const FinInlineMessage({
    super.key,
    required this.message,
    this.variant = FinInlineMessageVariant.info,
    this.title,
    this.icon,
    this.actionLabel,
    this.onAction,
    this.semanticsLabel,
  });

  final String message;
  final FinInlineMessageVariant variant;
  final String? title;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final (defaultIcon, accentColor, bgColor) = _resolveVariant(colors);

    return Semantics(
      label: semanticsLabel ?? message,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(FinSpacing.space16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: FinRadius.borderRadiusMD,
          border: Border(
            left: BorderSide(color: accentColor, width: 3),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon ?? defaultIcon,
              size: FinIconSize.sm,
              color: accentColor,
            ),
            const SizedBox(width: FinSpacing.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) ...[
                    Text(
                      title!,
                      style: typo.titleSmall.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: FinSpacing.space4),
                  ],
                  Text(
                    message,
                    style: typo.bodySmall.copyWith(color: colors.textSecondary),
                  ),
                  if (actionLabel != null) ...[
                    const SizedBox(height: FinSpacing.space8),
                    GestureDetector(
                      onTap: onAction,
                      child: Text(
                        actionLabel!,
                        style: typo.labelSmall.copyWith(color: accentColor),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  (IconData, Color, Color) _resolveVariant(FinSemanticColors colors) {
    switch (variant) {
      case FinInlineMessageVariant.info:
        return (CupertinoIcons.info, colors.info, colors.infoBg);
      case FinInlineMessageVariant.success:
        return (CupertinoIcons.checkmark_circle, colors.success, colors.successBg);
      case FinInlineMessageVariant.warning:
        return (CupertinoIcons.exclamationmark_triangle, colors.warning, colors.warningBg);
      case FinInlineMessageVariant.error:
        return (CupertinoIcons.xmark_circle, colors.danger, colors.dangerBg);
    }
  }
}
