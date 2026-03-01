import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import 'fin_amount_formatter.dart';
import 'fin_amount_validator.dart';

/// A specialized text field for monetary amount input.
///
/// Features:
/// - Number keyboard with decimal support
/// - Live formatting with thousands separators
/// - Integrated validation
/// - Currency symbol display
/// - Monospace typography for number clarity
///
/// ```dart
/// FinAmountInput(
///   label: 'Transfer Amount',
///   currencySymbol: '\$',
///   validator: FinAmountValidators.transfer,
///   onAmountChanged: (amount) => updateAmount(amount),
/// )
/// ```
class FinAmountInput extends StatefulWidget {
  const FinAmountInput({
    super.key,
    this.label,
    this.currencySymbol = '\$',
    this.decimalDigits = 2,
    this.controller,
    this.focusNode,
    this.onAmountChanged,
    this.validator,
    this.errorText,
    this.helperText,
    this.enabled = true,
    this.maxAmount,
    this.placeholder = '0.00',
    this.autofocus = false,
    this.semanticsLabel,
  });

  final String? label;
  final String currencySymbol;
  final int decimalDigits;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<double?>? onAmountChanged;
  final FinAmountValidator? validator;
  final String? errorText;
  final String? helperText;
  final bool enabled;
  final double? maxAmount;
  final String placeholder;
  final bool autofocus;
  final String? semanticsLabel;

  @override
  State<FinAmountInput> createState() => _FinAmountInputState();
}

class _FinAmountInputState extends State<FinAmountInput> {
  late TextEditingController _controller;
  late FinAmountFormatter _formatter;
  late FinAmountTextInputFormatter _inputFormatter;
  String? _validationError;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _formatter = FinAmountFormatter(
      decimalDigits: widget.decimalDigits,
      currencySymbol: '',
    );
    _inputFormatter = FinAmountTextInputFormatter(
      decimalDigits: widget.decimalDigits,
      maxValue: widget.maxAmount,
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String text) {
    final value = _formatter.parse(text);
    widget.onAmountChanged?.call(value);

    if (widget.validator != null) {
      setState(() {
        _validationError = widget.validator!.validate(value);
      });
    }
  }

  String? get _displayError => widget.errorText ?? _validationError;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final hasError = _displayError != null && _displayError!.isNotEmpty;
    final borderColor = hasError
        ? colors.danger
        : _isFocused
            ? colors.borderFocused
            : colors.borderDefault;

    return Semantics(
      textField: true,
      enabled: widget.enabled,
      label: widget.semanticsLabel ?? widget.label ?? 'Amount input',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: typo.labelSmall.copyWith(
                color: hasError ? colors.danger : colors.textSecondary,
              ),
            ),
            const SizedBox(height: FinSpacing.space8),
          ],

          Focus(
            onFocusChange: (f) => setState(() => _isFocused = f),
            child: CupertinoTextField(
              controller: _controller,
              focusNode: widget.focusNode,
              placeholder: widget.placeholder,
              placeholderStyle: typo.monoMedium.copyWith(
                color: colors.textTertiary,
              ),
              style: typo.monoMedium.copyWith(color: colors.textPrimary),
              enabled: widget.enabled,
              autofocus: widget.autofocus,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [_inputFormatter],
              onChanged: _onChanged,
              textAlign: TextAlign.right,
              padding: const EdgeInsets.symmetric(
                horizontal: FinSpacing.space16,
                vertical: FinSpacing.space16,
              ),
              decoration: BoxDecoration(
                color: widget.enabled ? colors.bgPrimary : colors.bgTertiary,
                borderRadius: BorderRadius.circular(FinRadius.radiusSM),
                border: Border.all(
                  color: borderColor,
                  width: _isFocused ? 2 : 1,
                ),
              ),
              prefix: Padding(
                padding: const EdgeInsets.only(left: FinSpacing.space16),
                child: Text(
                  widget.currencySymbol,
                  style: typo.monoMedium.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ),
          ),

          if (hasError || widget.helperText != null) ...[
            const SizedBox(height: FinSpacing.space4),
            Text(
              hasError ? _displayError! : widget.helperText!,
              style: typo.caption.copyWith(
                color: hasError ? colors.danger : colors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
