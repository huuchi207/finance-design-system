import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import '../amount_input/fin_amount_formatter.dart';

/// Displays an account balance with optional masking for privacy.
///
/// Secure-by-default: balance is masked on first render if [initiallyMasked]
/// is true (recommended for finance apps).
///
/// ```dart
/// FinBalanceDisplay(
///   amount: 1234567.89,
///   currencySymbol: '\$',
///   label: 'Available Balance',
///   initiallyMasked: true,
///   showChange: true,
///   changeAmount: 250.00,
/// )
/// ```
class FinBalanceDisplay extends StatefulWidget {
  const FinBalanceDisplay({
    super.key,
    required this.amount,
    this.currencySymbol = '\$',
    this.label,
    this.initiallyMasked = true,
    this.showChange = false,
    this.changeAmount,
    this.formatter,
    this.semanticsLabel,
    this.onMaskToggle,
  });

  /// The balance value.
  final double amount;

  /// Currency symbol displayed before amount.
  final String currencySymbol;

  /// Label above the balance (e.g., "Available Balance").
  final String? label;

  /// Whether balance starts masked. Default: true (secure default for finance).
  final bool initiallyMasked;

  /// Whether to show a change indicator (delta).
  final bool showChange;

  /// The change amount (positive = gain, negative = loss).
  final double? changeAmount;

  /// Custom formatter override.
  final FinAmountFormatter? formatter;

  /// Accessibility label.
  final String? semanticsLabel;

  /// Called when mask state toggles.
  final ValueChanged<bool>? onMaskToggle;

  @override
  State<FinBalanceDisplay> createState() => _FinBalanceDisplayState();
}

class _FinBalanceDisplayState extends State<FinBalanceDisplay> {
  late bool _isMasked;

  @override
  void initState() {
    super.initState();
    _isMasked = widget.initiallyMasked;
  }

  void _toggleMask() {
    setState(() => _isMasked = !_isMasked);
    widget.onMaskToggle?.call(_isMasked);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final formatter = widget.formatter ??
        FinAmountFormatter(
          currencySymbol: widget.currencySymbol,
          symbolBefore: true,
        );

    final formattedAmount = _isMasked
        ? '${widget.currencySymbol}•••••••'
        : formatter.format(widget.amount);

    return Semantics(
      label: widget.semanticsLabel ??
          (_isMasked
              ? 'Balance hidden'
              : 'Balance ${formatter.format(widget.amount)}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label row with mask toggle
          if (widget.label != null)
            Row(
              children: [
                Text(
                  widget.label!,
                  style: typo.caption.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(width: FinSpacing.space8),
                GestureDetector(
                  onTap: _toggleMask,
                  child: Icon(
                    _isMasked ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    size: FinIconSize.xs,
                    color: colors.textTertiary,
                  ),
                ),
              ],
            ),
          if (widget.label != null) const SizedBox(height: FinSpacing.space4),

          // Amount display
          AnimatedSwitcher(
            duration: FinMotion.durationNormal,
            child: Text(
              formattedAmount,
              key: ValueKey(_isMasked ? 'masked' : formattedAmount),
              style: typo.monoLarge.copyWith(color: colors.textPrimary),
            ),
          ),

          // Change indicator
          if (widget.showChange && widget.changeAmount != null && !_isMasked) ...[
            const SizedBox(height: FinSpacing.space4),
            _ChangeIndicator(
              amount: widget.changeAmount!,
              formatter: formatter,
              colors: colors,
              typography: typo,
            ),
          ],
        ],
      ),
    );
  }
}

class _ChangeIndicator extends StatelessWidget {
  const _ChangeIndicator({
    required this.amount,
    required this.formatter,
    required this.colors,
    required this.typography,
  });

  final double amount;
  final FinAmountFormatter formatter;
  final FinSemanticColors colors;
  final FinTypography typography;

  @override
  Widget build(BuildContext context) {
    final isPositive = amount >= 0;
    final color = isPositive ? colors.success : colors.danger;
    final icon = isPositive ? CupertinoIcons.arrow_up_right : CupertinoIcons.arrow_down_right;
    final prefix = isPositive ? '+' : '';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 2),
        Text(
          '$prefix${formatter.format(amount.abs())}',
          style: typography.caption.copyWith(color: color),
        ),
      ],
    );
  }
}
