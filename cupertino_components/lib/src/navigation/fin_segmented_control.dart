import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Cupertino sliding segmented control wrapper with token styling.
///
/// ```dart
/// FinSegmentedControl<int>(
///   segments: {
///     0: 'All',
///     1: 'Income',
///     2: 'Expense',
///   },
///   groupValue: selectedIndex,
///   onValueChanged: (v) => setState(() => selectedIndex = v),
/// )
/// ```
class FinSegmentedControl<T extends Object> extends StatelessWidget {
  const FinSegmentedControl({
    super.key,
    required this.segments,
    required this.groupValue,
    required this.onValueChanged,
    this.padding,
    this.semanticsLabel,
  });

  /// Map of segment values to their labels.
  final Map<T, String> segments;

  /// Currently selected value.
  final T groupValue;

  /// Called when selection changes.
  final ValueChanged<T> onValueChanged;

  /// Override padding around the control.
  final EdgeInsets? padding;

  /// Accessibility label.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return Semantics(
      label: semanticsLabel,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: SizedBox(
          width: double.infinity,
          child: CupertinoSlidingSegmentedControl<T>(
            groupValue: groupValue,
            onValueChanged: (value) {
              if (value != null) onValueChanged(value);
            },
            backgroundColor: colors.bgTertiary,
            thumbColor: colors.surfaceElevated,
            children: segments.map(
              (key, label) => MapEntry(
                key,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: FinSpacing.space12,
                    vertical: FinSpacing.space8,
                  ),
                  child: Text(
                    label,
                    style: typo.labelSmall.copyWith(
                      color: groupValue == key
                          ? colors.textPrimary
                          : colors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
