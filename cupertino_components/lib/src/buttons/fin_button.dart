import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Button variants controlling visual hierarchy.
enum FinButtonVariant {
  /// Filled accent background — primary CTA
  primary,

  /// Outlined with accent border — secondary action
  secondary,

  /// Text-only — tertiary/link action
  tertiary,

  /// Filled danger background — destructive action
  destructive,
}

/// Button sizes.
enum FinButtonSize {
  /// Height 36, compact padding
  small,

  /// Height 48, standard padding (default)
  medium,

  /// Height 56, prominent padding
  large,
}

/// A Cupertino-styled button with variant, size, and full state support.
///
/// All visual properties are derived from [FinanceTheme] tokens.
///
/// ```dart
/// FinButton(
///   label: 'Confirm Payment',
///   variant: FinButtonVariant.primary,
///   size: FinButtonSize.large,
///   onPressed: () => confirmPayment(),
///   isLoading: isProcessing,
/// )
/// ```
class FinButton extends StatefulWidget {
  const FinButton({
    super.key,
    required this.label,
    this.variant = FinButtonVariant.primary,
    this.size = FinButtonSize.medium,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.expand = false,
    this.semanticsLabel,
  });

  /// Button text label.
  final String label;

  /// Visual variant controlling colors and borders.
  final FinButtonVariant variant;

  /// Size controlling height and padding.
  final FinButtonSize size;

  /// Tap callback. Null or [isDisabled]=true makes the button non-interactive.
  final VoidCallback? onPressed;

  /// Shows a loading indicator and disables interaction.
  final bool isLoading;

  /// Disables the button without loading indicator.
  final bool isDisabled;

  /// Widget displayed before the label (typically an icon).
  final Widget? leadingIcon;

  /// Widget displayed after the label (typically an icon).
  final Widget? trailingIcon;

  /// Whether the button should expand to fill available width.
  final bool expand;

  /// Accessibility label override.
  final String? semanticsLabel;

  bool get _isInteractive => onPressed != null && !isLoading && !isDisabled;

  @override
  State<FinButton> createState() => _FinButtonState();
}

class _FinButtonState extends State<FinButton> {
  bool _isPressed = false;

  double get _height {
    switch (widget.size) {
      case FinButtonSize.small:
        return 36;
      case FinButtonSize.medium:
        return 48;
      case FinButtonSize.large:
        return 56;
    }
  }

  EdgeInsets get _padding {
    switch (widget.size) {
      case FinButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case FinButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
      case FinButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final backgroundColor = _resolveBackgroundColor(colors);
    final foregroundColor = _resolveForegroundColor(colors);
    final borderColor = _resolveBorderColor(colors);
    final opacity = widget._isInteractive ? 1.0 : FinStateOpacity.disabled;

    final textStyle = widget.size == FinButtonSize.small
        ? typo.labelSmall
        : typo.labelLarge;

    Widget child = Semantics(
      button: true,
      enabled: widget._isInteractive,
      label: widget.semanticsLabel ?? widget.label,
      child: GestureDetector(
        onTapDown: widget._isInteractive
            ? (_) => setState(() => _isPressed = true)
            : null,
        onTapUp: widget._isInteractive
            ? (_) {
                setState(() => _isPressed = false);
                widget.onPressed?.call();
              }
            : null,
        onTapCancel: widget._isInteractive
            ? () => setState(() => _isPressed = false)
            : null,
        child: AnimatedOpacity(
          duration: FinMotion.durationFast,
          opacity: opacity,
          child: AnimatedScale(
            scale: _isPressed ? 0.97 : 1.0,
            duration: FinMotion.durationFast,
            curve: FinMotion.easingDefault,
            child: Container(
              height: _height,
              padding: _padding,
              decoration: BoxDecoration(
                color: _isPressed
                    ? _resolvePressedBackgroundColor(colors)
                    : backgroundColor,
                borderRadius: BorderRadius.circular(
                    widget.size == FinButtonSize.small
                        ? FinRadius.radiusSM
                        : FinRadius.radiusSM),
                border: borderColor != null
                    ? Border.all(color: borderColor, width: 1.5)
                    : null,
              ),
              child: Row(
                mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLoading) ...[
                    CupertinoActivityIndicator(
                      color: foregroundColor,
                      radius: widget.size == FinButtonSize.small ? 8 : 10,
                    ),
                    const SizedBox(width: FinSpacing.space8),
                  ] else if (widget.leadingIcon != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        color: foregroundColor,
                        size: FinIconSize.sm,
                      ),
                      child: widget.leadingIcon!,
                    ),
                    const SizedBox(width: FinSpacing.space8),
                  ],
                  Text(
                    widget.label,
                    style: textStyle.copyWith(color: foregroundColor),
                  ),
                  if (widget.trailingIcon != null && !widget.isLoading) ...[
                    const SizedBox(width: FinSpacing.space8),
                    IconTheme(
                      data: IconThemeData(
                        color: foregroundColor,
                        size: FinIconSize.sm,
                      ),
                      child: widget.trailingIcon!,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.expand) {
      child = SizedBox(width: double.infinity, child: child);
    }

    return child;
  }

  Color _resolveBackgroundColor(FinSemanticColors colors) {
    switch (widget.variant) {
      case FinButtonVariant.primary:
        return colors.accentPrimary;
      case FinButtonVariant.secondary:
        return CupertinoColors.transparent;
      case FinButtonVariant.tertiary:
        return CupertinoColors.transparent;
      case FinButtonVariant.destructive:
        return colors.danger;
    }
  }

  Color _resolvePressedBackgroundColor(FinSemanticColors colors) {
    switch (widget.variant) {
      case FinButtonVariant.primary:
        return colors.accentPrimaryPressed;
      case FinButtonVariant.secondary:
        return colors.accentSecondary;
      case FinButtonVariant.tertiary:
        return colors.bgTertiary;
      case FinButtonVariant.destructive:
        return colors.danger.withOpacity(0.85);
    }
  }

  Color _resolveForegroundColor(FinSemanticColors colors) {
    switch (widget.variant) {
      case FinButtonVariant.primary:
        return colors.textOnAccent;
      case FinButtonVariant.secondary:
        return colors.accentPrimary;
      case FinButtonVariant.tertiary:
        return colors.accentPrimary;
      case FinButtonVariant.destructive:
        return colors.textOnAccent;
    }
  }

  Color? _resolveBorderColor(FinSemanticColors colors) {
    switch (widget.variant) {
      case FinButtonVariant.secondary:
        return colors.accentPrimary;
      default:
        return null;
    }
  }
}
