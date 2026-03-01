import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// iOS-style list cell for grouped content.
///
/// Supports title, subtitle, leading/trailing widgets, and disclosure indicator.
/// Designed for settings screens, lists, and navigation menus.
///
/// ```dart
/// FinListCell(
///   title: 'Notifications',
///   subtitle: 'Manage your alerts',
///   leading: Icon(CupertinoIcons.bell),
///   trailing: FinSwitch(value: true, onChanged: (_) {}),
///   onTap: () => navigateToNotifications(),
/// )
/// ```
class FinListCell extends StatefulWidget {
  const FinListCell({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.showDisclosure = false,
    this.showSeparator = true,
    this.isDestructive = false,
    this.enabled = true,
    this.semanticsLabel,
    this.backgroundColor,
    this.padding,
  });

  /// Primary text.
  final String title;

  /// Secondary text displayed below the title.
  final String? subtitle;

  /// Widget displayed at the leading edge (icon, avatar).
  final Widget? leading;

  /// Widget displayed at the trailing edge (switch, value, badge).
  final Widget? trailing;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Shows a chevron disclosure indicator at the trailing edge.
  final bool showDisclosure;

  /// Whether to show a bottom separator line.
  final bool showSeparator;

  /// Renders in destructive/danger style.
  final bool isDestructive;

  /// Whether the cell is interactive.
  final bool enabled;

  /// Accessibility label override.
  final String? semanticsLabel;

  /// Custom background color override.
  final Color? backgroundColor;

  /// Custom padding override.
  final EdgeInsets? padding;

  @override
  State<FinListCell> createState() => _FinListCellState();
}

class _FinListCellState extends State<FinListCell> {
  bool _isPressed = false;

  bool get _isInteractive => widget.onTap != null && widget.enabled;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final titleColor = widget.isDestructive
        ? colors.danger
        : colors.textPrimary;
    final opacity = widget.enabled ? 1.0 : FinStateOpacity.disabled;

    return Semantics(
      button: _isInteractive,
      enabled: widget.enabled,
      label: widget.semanticsLabel ?? widget.title,
      child: GestureDetector(
        onTapDown: _isInteractive
            ? (_) => setState(() => _isPressed = true)
            : null,
        onTapUp: _isInteractive
            ? (_) {
                setState(() => _isPressed = false);
                widget.onTap?.call();
              }
            : null,
        onTapCancel: _isInteractive
            ? () => setState(() => _isPressed = false)
            : null,
        child: AnimatedOpacity(
          duration: FinMotion.durationFast,
          opacity: opacity,
          child: Container(
            color: _isPressed
                ? colors.bgTertiary
                : (widget.backgroundColor ?? colors.bgPrimary),
            padding: widget.padding ??
                const EdgeInsets.symmetric(
                  horizontal: FinSpacing.space16,
                  vertical: FinSpacing.space12,
                ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Leading
                    if (widget.leading != null) ...[
                      IconTheme(
                        data: IconThemeData(
                          color: widget.isDestructive
                              ? colors.danger
                              : colors.accentPrimary,
                          size: FinIconSize.md,
                        ),
                        child: widget.leading!,
                      ),
                      const SizedBox(width: FinSpacing.space12),
                    ],

                    // Title + Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: typo.bodyLarge.copyWith(color: titleColor),
                          ),
                          if (widget.subtitle != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              widget.subtitle!,
                              style: typo.bodySmall.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Trailing
                    if (widget.trailing != null) ...[
                      const SizedBox(width: FinSpacing.space8),
                      widget.trailing!,
                    ],

                    // Disclosure indicator
                    if (widget.showDisclosure) ...[
                      const SizedBox(width: FinSpacing.space8),
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: FinIconSize.xs,
                        color: colors.textTertiary,
                      ),
                    ],
                  ],
                ),

                // Separator
                if (widget.showSeparator)
                  Padding(
                    padding: EdgeInsets.only(
                      top: FinSpacing.space12,
                      left: widget.leading != null
                          ? FinIconSize.md + FinSpacing.space12
                          : 0,
                    ),
                    child: Container(
                      height: 0.5,
                      color: colors.borderSubtle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Convenience widget for iOS-style settings row with icon background.
///
/// ```dart
/// FinSettingsRow(
///   icon: CupertinoIcons.lock,
///   iconBackgroundColor: FinPrimitiveColors.green500,
///   title: 'Privacy',
///   value: 'On',
///   onTap: () => openPrivacy(),
/// )
/// ```
class FinSettingsRow extends StatelessWidget {
  const FinSettingsRow({
    super.key,
    required this.icon,
    this.iconBackgroundColor,
    required this.title,
    this.value,
    this.trailing,
    this.onTap,
    this.showSeparator = true,
  });

  /// Leading icon data.
  final IconData icon;

  /// Background color for the icon container.
  final Color? iconBackgroundColor;

  /// Row title.
  final String title;

  /// Optional value text displayed at trailing position.
  final String? value;

  /// Custom trailing widget (overrides value text).
  final Widget? trailing;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Show bottom separator.
  final bool showSeparator;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return FinListCell(
      title: title,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: iconBackgroundColor ?? colors.accentPrimary,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(
          icon,
          size: 18,
          color: CupertinoColors.white,
        ),
      ),
      trailing: trailing ??
          (value != null
              ? Text(
                  value!,
                  style: typo.bodyMedium.copyWith(color: colors.textTertiary),
                )
              : null),
      showDisclosure: onTap != null,
      showSeparator: showSeparator,
      onTap: onTap,
    );
  }
}
