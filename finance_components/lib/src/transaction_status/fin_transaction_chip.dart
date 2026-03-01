import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Transaction status types.
enum FinTransactionStatus {
  pending,
  processing,
  success,
  failed,
  cancelled,
}

/// A pill-shaped chip displaying transaction status.
///
/// Colors are derived from tokens — each status maps to semantic colors.
///
/// ```dart
/// FinTransactionChip(status: FinTransactionStatus.success)
/// FinTransactionChip(
///   status: FinTransactionStatus.pending,
///   label: 'Awaiting Confirmation',
/// )
/// ```
class FinTransactionChip extends StatelessWidget {
  const FinTransactionChip({
    super.key,
    required this.status,
    this.label,
    this.showIcon = true,
    this.semanticsLabel,
  });

  /// Transaction status.
  final FinTransactionStatus status;

  /// Custom label override. Defaults to status name.
  final String? label;

  /// Whether to show a status icon.
  final bool showIcon;

  /// Accessibility label.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final (statusColor, bgColor, iconData, defaultLabel) =
        _resolveStatus(colors);

    return Semantics(
      label: semanticsLabel ?? label ?? defaultLabel,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: FinSpacing.space12,
          vertical: FinSpacing.space4,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: FinRadius.borderRadiusFull,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) ...[
              Icon(iconData, size: 12, color: statusColor),
              const SizedBox(width: FinSpacing.space4),
            ],
            Text(
              label ?? defaultLabel,
              style: typo.labelSmall.copyWith(color: statusColor),
            ),
          ],
        ),
      ),
    );
  }

  (Color, Color, IconData, String) _resolveStatus(FinSemanticColors colors) {
    switch (status) {
      case FinTransactionStatus.pending:
        return (
          colors.warning,
          colors.warningBg,
          CupertinoIcons.clock,
          'Pending',
        );
      case FinTransactionStatus.processing:
        return (
          colors.info,
          colors.infoBg,
          CupertinoIcons.arrow_2_circlepath,
          'Processing',
        );
      case FinTransactionStatus.success:
        return (
          colors.success,
          colors.successBg,
          CupertinoIcons.checkmark_circle,
          'Success',
        );
      case FinTransactionStatus.failed:
        return (
          colors.danger,
          colors.dangerBg,
          CupertinoIcons.xmark_circle,
          'Failed',
        );
      case FinTransactionStatus.cancelled:
        return (
          colors.textTertiary,
          colors.bgTertiary,
          CupertinoIcons.minus_circle,
          'Cancelled',
        );
    }
  }
}
