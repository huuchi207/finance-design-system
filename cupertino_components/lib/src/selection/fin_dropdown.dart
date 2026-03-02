import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Configuration for a single dropdown item.
class FinDropdownItem<T> {
  const FinDropdownItem({
    required this.value,
    required this.label,
    this.icon,
  });

  /// The value this item represents.
  final T value;

  /// Display label for the item.
  final String label;

  /// Optional leading icon.
  final IconData? icon;
}

/// A Cupertino-styled dropdown that presents options via an action sheet.
///
/// Uses the native iOS pattern of tapping a field to open a
/// [CupertinoActionSheet] with selectable options.
///
/// ```dart
/// FinDropdown<String>(
///   label: 'Currency',
///   placeholder: 'Select currency',
///   items: [
///     FinDropdownItem(value: 'USD', label: 'US Dollar'),
///     FinDropdownItem(value: 'VND', label: 'Vietnamese Dong'),
///   ],
///   selectedValue: selectedCurrency,
///   onChanged: (v) => setState(() => selectedCurrency = v),
/// )
/// ```
class FinDropdown<T> extends StatelessWidget {
  const FinDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.label,
    this.placeholder = 'Select...',
    this.isDisabled = false,
    this.semanticsLabel,
  });

  /// Available items to choose from.
  final List<FinDropdownItem<T>> items;

  /// Currently selected value, or null if nothing is selected.
  final T? selectedValue;

  /// Called when the user selects an item.
  final ValueChanged<T>? onChanged;

  /// Optional label displayed above the dropdown.
  final String? label;

  /// Placeholder text when no value is selected.
  final String placeholder;

  /// Whether the dropdown is disabled.
  final bool isDisabled;

  /// Accessibility label.
  final String? semanticsLabel;

  String? get _selectedLabel {
    if (selectedValue == null) return null;
    try {
      return items.firstWhere((i) => i.value == selectedValue).label;
    } catch (_) {
      return null;
    }
  }

  void _showPicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: label != null ? Text(label!) : null,
        actions: items.map((item) {
          final isSelected = item.value == selectedValue;
          return CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(ctx).pop();
              onChanged?.call(item.value);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (item.icon != null) ...[
                  Icon(item.icon, size: 20),
                  const SizedBox(width: FinSpacing.space8),
                ],
                Text(
                  item.label,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(width: FinSpacing.space8),
                  const Icon(CupertinoIcons.checkmark_alt,
                      size: 18, color: CupertinoColors.activeBlue),
                ],
              ],
            ),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;
    final displayLabel = _selectedLabel;

    return Semantics(
      label: semanticsLabel ?? label,
      enabled: !isDisabled,
      button: true,
      child: AnimatedOpacity(
        duration: FinMotion.durationFast,
        opacity: isDisabled ? FinStateOpacity.disabled : 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null) ...[
              Text(
                label!,
                style: typo.caption.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: FinSpacing.space4),
            ],
            GestureDetector(
              onTap: isDisabled ? null : () => _showPicker(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: FinSpacing.space12,
                  vertical: FinSpacing.space12,
                ),
                decoration: BoxDecoration(
                  color: colors.bgTertiary,
                  borderRadius: FinRadius.borderRadiusSM,
                  border: Border.all(
                    color: colors.borderDefault,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        displayLabel ?? placeholder,
                        style: typo.bodyMedium.copyWith(
                          color: displayLabel != null
                              ? colors.textPrimary
                              : colors.textTertiary,
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: FinIconSize.sm,
                      color: colors.textTertiary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
