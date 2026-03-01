import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:design_tokens/design_tokens.dart';

/// PIN entry with dot-based obscured display.
///
/// Secure defaults:
/// - Always obscured display (dots)
/// - No value in debug output
/// - Auto-clear on error
/// - Haptic feedback
///
/// ```dart
/// FinPINInput(
///   length: 4,
///   onCompleted: (pin) => verifyPIN(pin),
/// )
/// ```
class FinPINInput extends StatefulWidget {
  const FinPINInput({
    super.key,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.autofocus = true,
    this.semanticsLabel,
  });

  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool enabled;
  final bool autofocus;
  final String? semanticsLabel;

  @override
  State<FinPINInput> createState() => _FinPINInputState();
}

class _FinPINInputState extends State<FinPINInput> {
  String _value = '';
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(FinPINInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != null &&
        widget.errorText != oldWidget.errorText &&
        widget.errorText!.isNotEmpty) {
      setState(() => _value = '');
      HapticFeedback.mediumImpact();
    }
  }

  void _handleKey(String digit) {
    if (_value.length >= widget.length) return;

    setState(() {
      _value += digit;
    });
    HapticFeedback.lightImpact();

    widget.onChanged?.call(_value);
    if (_value.length == widget.length) {
      widget.onCompleted?.call(_value);
    }
  }

  void _handleBackspace() {
    if (_value.isEmpty) return;
    setState(() {
      _value = _value.substring(0, _value.length - 1);
    });
    widget.onChanged?.call(_value);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Semantics(
      label: widget.semanticsLabel ?? 'PIN input',
      child: GestureDetector(
        onTap: () => _focusNode.requestFocus(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.length, (index) {
                final isFilled = index < _value.length;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: FinSpacing.space8,
                  ),
                  child: AnimatedContainer(
                    duration: FinMotion.durationFast,
                    curve: FinMotion.easingDefault,
                    width: isFilled ? 16 : 14,
                    height: isFilled ? 16 : 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hasError
                          ? colors.danger
                          : isFilled
                              ? colors.textPrimary
                              : CupertinoColors.transparent,
                      border: Border.all(
                        color: hasError
                            ? colors.danger
                            : isFilled
                                ? colors.textPrimary
                                : colors.borderDefault,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }),
            ),

            if (hasError) ...[
              const SizedBox(height: FinSpacing.space12),
              Text(
                widget.errorText!,
                style: typo.caption.copyWith(color: colors.danger),
                textAlign: TextAlign.center,
              ),
            ],

            // Hidden text field for keyboard input
            SizedBox(
              width: 1,
              height: 1,
              child: CupertinoTextField(
                focusNode: _focusNode,
                autofocus: widget.autofocus,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: widget.length,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (text) {
                  setState(() => _value = text);
                  widget.onChanged?.call(_value);
                  if (_value.length == widget.length) {
                    widget.onCompleted?.call(_value);
                  }
                },
                style: const TextStyle(
                  color: CupertinoColors.transparent,
                  fontSize: 1,
                ),
                decoration: const BoxDecoration(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // Secure: do NOT expose PIN value
    properties.add(IntProperty('length', widget.length));
    properties.add(IntProperty('filledCount', _value.length));
  }
}
