import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Persistent banner notification (top or bottom of screen content).
///
/// ```dart
/// FinBanner(
///   message: 'Your account requires verification.',
///   variant: FinBannerVariant.warning,
///   actionLabel: 'Verify Now',
///   onAction: () => navigateToKYC(),
///   onDismiss: () => dismissBanner(),
/// )
/// ```
enum FinBannerVariant {
  info,
  success,
  warning,
  error,
}

class FinBanner extends StatelessWidget {
  const FinBanner({
    super.key,
    required this.message,
    this.variant = FinBannerVariant.info,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
    this.icon,
    this.semanticsLabel,
  });

  final String message;
  final FinBannerVariant variant;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onDismiss;
  final IconData? icon;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final (defaultIcon, iconColor, bgColor) = _resolveVariant(colors);

    return Semantics(
      label: semanticsLabel ?? message,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: FinSpacing.space16,
          vertical: FinSpacing.space12,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(
            bottom: BorderSide(
              color: iconColor.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon ?? defaultIcon, size: FinIconSize.sm, color: iconColor),
            const SizedBox(width: FinSpacing.space12),
            Expanded(
              child: Text(
                message,
                style: typo.bodySmall.copyWith(color: colors.textPrimary),
              ),
            ),
            if (actionLabel != null) ...[
              const SizedBox(width: FinSpacing.space8),
              GestureDetector(
                onTap: onAction,
                child: Text(
                  actionLabel!,
                  style: typo.labelSmall.copyWith(color: iconColor),
                ),
              ),
            ],
            if (onDismiss != null) ...[
              const SizedBox(width: FinSpacing.space8),
              GestureDetector(
                onTap: onDismiss,
                child: Icon(
                  CupertinoIcons.xmark,
                  size: FinIconSize.xs,
                  color: colors.textTertiary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  (IconData, Color, Color) _resolveVariant(FinSemanticColors colors) {
    switch (variant) {
      case FinBannerVariant.info:
        return (CupertinoIcons.info, colors.info, colors.infoBg);
      case FinBannerVariant.success:
        return (CupertinoIcons.checkmark_circle, colors.success, colors.successBg);
      case FinBannerVariant.warning:
        return (CupertinoIcons.exclamationmark_triangle, colors.warning, colors.warningBg);
      case FinBannerVariant.error:
        return (CupertinoIcons.xmark_circle, colors.danger, colors.dangerBg);
    }
  }
}
