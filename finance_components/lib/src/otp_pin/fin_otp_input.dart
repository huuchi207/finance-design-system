import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:design_tokens/design_tokens.dart';

/// OTP input with individual cells and auto-advance.
///
/// Secure defaults:
/// - No value in debug output
/// - Auto-clear on error
/// - Paste support for quick entry
///
/// ```dart
/// FinOTPInput(
///   length: 6,
///   onCompleted: (code) => verifyOTP(code),
///   errorText: otpError,
/// )
/// ```
class FinOTPInput extends StatefulWidget {
  const FinOTPInput({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.autofocus = true,
    this.obscureText = false,
    this.semanticsLabel,
  });

  /// Number of OTP digits (typically 4 or 6).
  final int length;

  /// Called when all digits are entered.
  final ValueChanged<String>? onCompleted;

  /// Called on each digit change.
  final ValueChanged<String>? onChanged;

  /// Error message (triggers error visual state + auto-clear).
  final String? errorText;

  /// Whether input is interactive.
  final bool enabled;

  /// Auto-focus the first cell on mount.
  final bool autofocus;

  /// Obscure entered digits (for sensitive OTP).
  final bool obscureText;

  /// Accessibility label.
  final String? semanticsLabel;

  @override
  State<FinOTPInput> createState() => _FinOTPInputState();
}

class _FinOTPInputState extends State<FinOTPInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void didUpdateWidget(FinOTPInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Auto-clear on new error
    if (widget.errorText != null &&
        widget.errorText != oldWidget.errorText &&
        widget.errorText!.isNotEmpty) {
      _clearAll();
      _focusNodes[0].requestFocus();
    }
  }

  void _clearAll() {
    for (final c in _controllers) {
      c.clear();
    }
  }

  String get _currentValue {
    return _controllers.map((c) => c.text).join();
  }

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      // Handle paste
      final chars = value.split('');
      for (int i = 0; i < chars.length && (index + i) < widget.length; i++) {
        _controllers[index + i].text = chars[i];
      }
      final nextIndex = (index + chars.length).clamp(0, widget.length - 1);
      _focusNodes[nextIndex].requestFocus();
    } else if (value.isNotEmpty) {
      // Single digit — advance to next
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    }

    final current = _currentValue;
    widget.onChanged?.call(current);
    if (current.length == widget.length) {
      widget.onCompleted?.call(current);
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Semantics(
      label: widget.semanticsLabel ?? 'OTP input',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.length, (index) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.length > 5 ? 3 : FinSpacing.space4,
                  ),
                  child: SizedBox(
                    height: 56,
                    child: KeyboardListener(
                      focusNode: FocusNode(),
                      onKeyEvent: (event) => _onKeyEvent(index, event),
                      child: CupertinoTextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        style: typo.monoMedium.copyWith(
                          color: hasError ? colors.danger : colors.textPrimary,
                        ),
                        maxLength: 1,
                        enabled: widget.enabled,
                        autofocus: widget.autofocus && index == 0,
                        obscureText: widget.obscureText,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        onChanged: (v) => _onChanged(index, v),
                        decoration: BoxDecoration(
                          color: colors.bgPrimary,
                          borderRadius: BorderRadius.circular(FinRadius.radiusSM),
                          border: Border.all(
                            color: hasError
                                ? colors.danger
                                : _focusNodes[index].hasFocus
                                    ? colors.borderFocused
                                    : colors.borderDefault,
                            width: _focusNodes[index].hasFocus ? 2 : 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          if (hasError) ...[
            const SizedBox(height: FinSpacing.space8),
            Text(
              widget.errorText!,
              style: typo.caption.copyWith(color: colors.danger),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // Secure: do NOT expose OTP value in debug output
    properties.add(IntProperty('length', widget.length));
    properties.add(FlagProperty('hasError',
        value: widget.errorText != null, ifTrue: 'has error'));
  }
}
