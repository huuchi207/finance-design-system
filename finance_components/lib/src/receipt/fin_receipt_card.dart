import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import '../transaction_status/fin_transaction_chip.dart';

/// A transaction receipt card with dashed divider and summary layout.
///
/// ```dart
/// FinReceiptCard(
///   status: FinTransactionStatus.success,
///   title: 'Transfer Successful',
///   referenceId: 'TXN-20240101-001',
///   children: [
///     FinTransactionSummaryRow(label: 'From', value: 'Main Account'),
///     FinTransactionSummaryRow(label: 'To', value: 'John Doe'),
///     FinTransactionSummaryRow(label: 'Amount', value: '\$1,000.00'),
///   ],
/// )
/// ```
class FinReceiptCard extends StatelessWidget {
  const FinReceiptCard({
    super.key,
    this.status,
    this.title,
    this.referenceId,
    required this.children,
    this.bottomWidget,
    this.semanticsLabel,
  });

  /// Transaction status chip at top.
  final FinTransactionStatus? status;

  /// Receipt title.
  final String? title;

  /// Reference/transaction ID.
  final String? referenceId;

  /// Summary rows (typically [FinTransactionSummaryRow]).
  final List<Widget> children;

  /// Optional bottom widget (QR code, share button, etc.).
  final Widget? bottomWidget;

  /// Accessibility label.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return Semantics(
      label: semanticsLabel ?? title ?? 'Transaction receipt',
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.surfaceElevated,
          borderRadius: FinRadius.borderRadiusMD,
          border: Border.all(color: colors.borderSubtle, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(FinSpacing.space24),
              child: Column(
                children: [
                  if (status != null) ...[
                    FinTransactionChip(status: status!),
                    const SizedBox(height: FinSpacing.space12),
                  ],
                  if (title != null)
                    Text(
                      title!,
                      style: typo.titleMedium.copyWith(
                        color: colors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (referenceId != null) ...[
                    const SizedBox(height: FinSpacing.space4),
                    Text(
                      referenceId!,
                      style: typo.caption.copyWith(color: colors.textTertiary),
                    ),
                  ],
                ],
              ),
            ),

            // Dashed divider
            _DashedDivider(color: colors.borderDefault),

            // Summary rows
            Padding(
              padding: const EdgeInsets.all(FinSpacing.space24),
              child: Column(
                children: children,
              ),
            ),

            // Bottom widget
            if (bottomWidget != null) ...[
              _DashedDivider(color: colors.borderDefault),
              Padding(
                padding: const EdgeInsets.all(FinSpacing.space24),
                child: bottomWidget,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A key-value row for transaction summaries.
class FinTransactionSummaryRow extends StatelessWidget {
  const FinTransactionSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isHighlighted = false,
    this.isMono = false,
  });

  final String label;
  final String value;
  final bool isHighlighted;
  final bool isMono;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FinSpacing.space4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: typo.bodySmall.copyWith(color: colors.textSecondary),
          ),
          Flexible(
            child: Text(
              value,
              style: (isMono ? typo.monoSmall : typo.bodySmall).copyWith(
                color: isHighlighted
                    ? colors.textPrimary
                    : colors.textPrimary,
                fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w400,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

/// Dashed horizontal divider line.
class _DashedDivider extends StatelessWidget {
  const _DashedDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 1,
      child: CustomPaint(
        painter: _DashedPainter(color: color),
      ),
    );
  }
}

class _DashedPainter extends CustomPainter {
  _DashedPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
