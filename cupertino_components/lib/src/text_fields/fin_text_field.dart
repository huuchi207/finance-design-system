import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Variants for the text field appearance and behavior.
enum FinTextFieldVariant {
  /// Standard text input
  normal,

  /// Optimized for amount/currency input with number keyboard
  amount,

  /// Password field with obscured text
  password,

  /// Search field with search icon and clear button
  search,
}

/// A Cupertino-styled text field with full theming and state support.
///
/// All visual properties are derived from [FinanceTheme] tokens.
///
/// ```dart
/// FinTextField(
///   label: 'Email',
///   placeholder: 'Enter your email',
///   onChanged: (v) => updateEmail(v),
///   errorText: emailError,
/// )
/// ```
class FinTextField extends StatefulWidget {
  const FinTextField({
    super.key,
    this.label,
    this.placeholder,
    this.variant = FinTextFieldVariant.normal,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.helperText,
    this.prefix,
    this.suffix,
    this.enabled = true,
    this.obscureText,
    this.keyboardType,
    this.textInputAction,
    this.maxLength,
    this.maxLines = 1,
    this.autofocus = false,
    this.semanticsLabel,
  });

  /// Label displayed above the field.
  final String? label;

  /// Placeholder text when empty.
  final String? placeholder;

  /// Variant controlling keyboard, formatting, and decorations.
  final FinTextFieldVariant variant;

  /// Text editing controller.
  final TextEditingController? controller;

  /// Focus node for focus management.
  final FocusNode? focusNode;

  /// Called when text changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits (e.g., presses done).
  final ValueChanged<String>? onSubmitted;

  /// Error message displayed below the field. Triggers error state.
  final String? errorText;

  /// Helper text displayed below the field (when no error).
  final String? helperText;

  /// Widget displayed before the text (e.g., currency symbol).
  final Widget? prefix;

  /// Widget displayed after the text (e.g., clear button, icon).
  final Widget? suffix;

  /// Whether the field is interactive.
  final bool enabled;

  /// Override obscure text behavior (auto-set for password variant).
  final bool? obscureText;

  /// Keyboard type override (auto-set per variant).
  final TextInputType? keyboardType;

  /// Text input action (done, next, search, etc.).
  final TextInputAction? textInputAction;

  /// Maximum character count.
  final int? maxLength;

  /// Maximum number of lines (1 = single line).
  final int maxLines;

  /// Whether to auto-focus on mount.
  final bool autofocus;

  /// Accessibility label.
  final String? semanticsLabel;

  @override
  State<FinTextField> createState() => _FinTextFieldState();
}

class _FinTextFieldState extends State<FinTextField> {
  late bool _obscureText;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ??
        widget.variant == FinTextFieldVariant.password;
  }

  bool get _hasError => widget.errorText != null && widget.errorText!.isNotEmpty;

  TextInputType get _keyboardType {
    if (widget.keyboardType != null) return widget.keyboardType!;
    switch (widget.variant) {
      case FinTextFieldVariant.amount:
        return const TextInputType.numberWithOptions(decimal: true);
      case FinTextFieldVariant.search:
        return TextInputType.text;
      case FinTextFieldVariant.password:
        return TextInputType.visiblePassword;
      case FinTextFieldVariant.normal:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final borderColor = _hasError
        ? colors.danger
        : _isFocused
            ? colors.borderFocused
            : colors.borderDefault;

    return Semantics(
      textField: true,
      enabled: widget.enabled,
      label: widget.semanticsLabel ?? widget.label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: typo.labelSmall.copyWith(
                color: _hasError ? colors.danger : colors.textSecondary,
              ),
            ),
            const SizedBox(height: FinSpacing.space8),
          ],

          // Input field
          Focus(
            onFocusChange: (focused) {
              setState(() => _isFocused = focused);
            },
            child: CupertinoTextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              placeholder: widget.placeholder,
              placeholderStyle: typo.bodyLarge.copyWith(
                color: colors.textTertiary,
              ),
              style: widget.variant == FinTextFieldVariant.amount
                  ? typo.monoMedium.copyWith(color: colors.textPrimary)
                  : typo.bodyLarge.copyWith(color: colors.textPrimary),
              enabled: widget.enabled,
              obscureText: _obscureText,
              keyboardType: _keyboardType,
              textInputAction: widget.textInputAction,
              maxLength: widget.maxLength,
              maxLines: widget.maxLines,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              padding: const EdgeInsets.symmetric(
                horizontal: FinSpacing.space16,
                vertical: FinSpacing.space12,
              ),
              decoration: BoxDecoration(
                color: widget.enabled ? colors.bgPrimary : colors.bgTertiary,
                borderRadius: BorderRadius.circular(FinRadius.radiusSM),
                border: Border.all(
                  color: borderColor,
                  width: _isFocused ? 2.0 : 1.0,
                ),
              ),
              prefix: _buildPrefix(colors),
              suffix: _buildSuffix(colors),
            ),
          ),

          // Error / Helper text
          if (_hasError || widget.helperText != null) ...[
            const SizedBox(height: FinSpacing.space4),
            Text(
              _hasError ? widget.errorText! : widget.helperText!,
              style: typo.caption.copyWith(
                color: _hasError ? colors.danger : colors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget? _buildPrefix(FinSemanticColors colors) {
    if (widget.prefix != null) {
      return Padding(
        padding: const EdgeInsets.only(left: FinSpacing.space12),
        child: widget.prefix,
      );
    }
    if (widget.variant == FinTextFieldVariant.search) {
      return Padding(
        padding: const EdgeInsets.only(left: FinSpacing.space12),
        child: Icon(
          CupertinoIcons.search,
          size: FinIconSize.sm,
          color: colors.textTertiary,
        ),
      );
    }
    return null;
  }

  Widget? _buildSuffix(FinSemanticColors colors) {
    if (widget.suffix != null) {
      return Padding(
        padding: const EdgeInsets.only(right: FinSpacing.space12),
        child: widget.suffix,
      );
    }
    if (widget.variant == FinTextFieldVariant.password) {
      return Padding(
        padding: const EdgeInsets.only(right: FinSpacing.space8),
        child: GestureDetector(
          onTap: () => setState(() => _obscureText = !_obscureText),
          child: Icon(
            _obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
            size: FinIconSize.sm,
            color: colors.textTertiary,
          ),
        ),
      );
    }
    return null;
  }
}
