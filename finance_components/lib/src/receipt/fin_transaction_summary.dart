import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import '../amount_input/fin_amount_formatter.dart';
import '../transaction_status/fin_transaction_chip.dart';

/// A compact transaction summary widget for list views.
///
/// Shows: icon/avatar, title, subtitle, amount, and status in one row.
///
/// ```dart
/// FinTransactionSummary(
///   title: 'Transfer to John',
///   subtitle: 'Today, 14:30',
///   amount: -500000,
///   currencySymbol: '₫',
///   status: FinTransactionStatus.success,
///   leading: Icon(CupertinoIcons.arrow_up_right),
/// )
/// ```
class FinTransactionSummary extends StatelessWidget {
  const FinTransactionSummary({
    super.key,
    required this.title,
    this.subtitle,
    required this.amount,
    this.currencySymbol = '\$',
    this.status,
    this.leading,
    this.onTap,
    this.formatter,
    this.showSeparator = true,
    this.semanticsLabel,
  });

  final String title;
  final String? subtitle;
  final double amount;
  final String currencySymbol;
  final FinTransactionStatus? status;
  final Widget? leading;
  final VoidCallback? onTap;
  final FinAmountFormatter? formatter;
  final bool showSeparator;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final fmt = formatter ??
        FinAmountFormatter(currencySymbol: currencySymbol, symbolBefore: true);
    final isExpense = amount < 0;
    final formattedAmount = isExpense
        ? '-${fmt.format(amount.abs())}'
        : '+${fmt.format(amount)}';
    final amountColor = isExpense ? colors.textPrimary : colors.success;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: CupertinoColors.transparent, // hit area
        padding: const EdgeInsets.symmetric(
          horizontal: FinSpacing.space16,
          vertical: FinSpacing.space12,
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (leading != null) ...[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colors.bgSecondary,
                      shape: BoxShape.circle,
                    ),
                    child: IconTheme(
                      data: IconThemeData(
                        color: colors.textSecondary,
                        size: FinIconSize.sm,
                      ),
                      child: leading!,
                    ),
                  ),
                  const SizedBox(width: FinSpacing.space12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: typo.bodyMedium.copyWith(
                          color: colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: typo.caption.copyWith(
                            color: colors.textTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: FinSpacing.space8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formattedAmount,
                      style: typo.monoSmall.copyWith(color: amountColor),
                    ),
                    if (status != null) ...[
                      const SizedBox(height: 2),
                      FinTransactionChip(
                        status: status!,
                        showIcon: false,
                      ),
                    ],
                  ],
                ),
              ],
            ),
            if (showSeparator)
              Padding(
                padding: EdgeInsets.only(
                  top: FinSpacing.space12,
                  left: leading != null ? 40 + FinSpacing.space12 : 0,
                ),
                child: Container(
                  height: 0.5,
                  color: colors.borderSubtle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
