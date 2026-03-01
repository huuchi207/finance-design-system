import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Risk warning banner severity levels.
enum FinRiskLevel {
  /// Blue — informational notice (e.g., terms update)
  info,

  /// Amber — caution (e.g., KYC reminder)
  warning,

  /// Red — critical risk or compliance block (e.g., AML hold)
  critical,
}

/// A compliance/risk warning banner for KYC, AML, and regulatory notices.
///
/// Finance-specific: designed for legal notices that must be visible
/// and Not easily dismissed for critical levels.
///
/// ```dart
/// FinRiskWarningBanner(
///   level: FinRiskLevel.warning,
///   title: 'Identity Verification Required',
///   message: 'Please verify your identity to continue using transfer services.',
///   actionLabel: 'Verify Now',
///   onAction: () => navigateToKYC(),
/// )
/// ```
class FinRiskWarningBanner extends StatelessWidget {
  const FinRiskWarningBanner({
    super.key,
    required this.level,
    this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
    this.icon,
    this.semanticsLabel,
  });

  final FinRiskLevel level;
  final String? title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  /// Dismiss callback. Set to null for non-dismissible banners (critical).
  final VoidCallback? onDismiss;

  final IconData? icon;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final (defaultIcon, accentColor, bgColor) = _resolveLevel(colors);

    return Semantics(
      label: semanticsLabel ?? message,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(FinSpacing.space16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: FinRadius.borderRadiusMD,
          border: Border.all(
            color: accentColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? defaultIcon,
                size: FinIconSize.sm,
                color: accentColor,
              ),
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
                    const SizedBox(height: FinSpacing.space12),
                    GestureDetector(
                      onTap: onAction,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: FinSpacing.space12,
                          vertical: FinSpacing.space8,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: FinRadius.borderRadiusSM,
                        ),
                        child: Text(
                          actionLabel!,
                          style: typo.labelSmall.copyWith(
                            color: CupertinoColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
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

  (IconData, Color, Color) _resolveLevel(FinSemanticColors colors) {
    switch (level) {
      case FinRiskLevel.info:
        return (CupertinoIcons.info, colors.info, colors.infoBg);
      case FinRiskLevel.warning:
        return (CupertinoIcons.exclamationmark_triangle, colors.warning, colors.warningBg);
      case FinRiskLevel.critical:
        return (CupertinoIcons.exclamationmark_shield, colors.danger, colors.dangerBg);
    }
  }
}
