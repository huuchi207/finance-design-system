import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Cupertino-styled switch with token-based colors.
///
/// ```dart
/// FinSwitch(
///   value: isEnabled,
///   onChanged: (v) => setState(() => isEnabled = v),
///   label: 'Push Notifications',
/// )
/// ```
class FinSwitch extends StatelessWidget {
  const FinSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.semanticsLabel,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool enabled;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;

    return Semantics(
      toggled: value,
      enabled: enabled,
      label: semanticsLabel ?? label,
      child: CupertinoSwitch(
        value: value,
        onChanged: enabled ? onChanged : null,
        activeTrackColor: colors.accentPrimary,
      ),
    );
  }
}

/// Cupertino-styled checkbox.
///
/// ```dart
/// FinCheckbox(
///   value: isChecked,
///   onChanged: (v) => setState(() => isChecked = v),
/// )
/// ```
class FinCheckbox extends StatelessWidget {
  const FinCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.semanticsLabel,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool enabled;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return Semantics(
      checked: value,
      enabled: enabled,
      label: semanticsLabel ?? label,
      child: GestureDetector(
        onTap: enabled ? () => onChanged?.call(!value) : null,
        child: AnimatedOpacity(
          duration: FinMotion.durationFast,
          opacity: enabled ? 1.0 : FinStateOpacity.disabled,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: FinMotion.durationFast,
                curve: FinMotion.easingDefault,
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: value ? colors.accentPrimary : CupertinoColors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: value ? colors.accentPrimary : colors.borderDefault,
                    width: 2,
                  ),
                ),
                child: value
                    ? const Icon(
                        CupertinoIcons.checkmark,
                        size: 14,
                        color: CupertinoColors.white,
                      )
                    : null,
              ),
              if (label != null) ...[
                const SizedBox(width: FinSpacing.space8),
                Text(
                  label!,
                  style: typo.bodyMedium.copyWith(color: colors.textPrimary),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Cupertino-styled radio button.
///
/// ```dart
/// FinRadio<String>(
///   value: 'option1',
///   groupValue: selectedOption,
///   onChanged: (v) => setState(() => selectedOption = v),
///   label: 'Option 1',
/// )
/// ```
class FinRadio<T> extends StatelessWidget {
  const FinRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.semanticsLabel,
  });

  final T value;
  final T groupValue;
  final ValueChanged<T>? onChanged;
  final String? label;
  final bool enabled;
  final String? semanticsLabel;

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return Semantics(
      selected: _isSelected,
      enabled: enabled,
      label: semanticsLabel ?? label,
      child: GestureDetector(
        onTap: enabled ? () => onChanged?.call(value) : null,
        child: AnimatedOpacity(
          duration: FinMotion.durationFast,
          opacity: enabled ? 1.0 : FinStateOpacity.disabled,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: FinMotion.durationFast,
                curve: FinMotion.easingDefault,
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isSelected
                        ? colors.accentPrimary
                        : colors.borderDefault,
                    width: 2,
                  ),
                ),
                child: _isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.accentPrimary,
                          ),
                        ),
                      )
                    : null,
              ),
              if (label != null) ...[
                const SizedBox(width: FinSpacing.space8),
                Text(
                  label!,
                  style: typo.bodyMedium.copyWith(color: colors.textPrimary),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
