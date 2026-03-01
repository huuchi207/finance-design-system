import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Non-blocking toast notification.
///
/// Auto-dismisses after a duration. Supports icon + message + optional action.
///
/// ```dart
/// FinToast.show(
///   context: context,
///   message: 'Transfer successful',
///   variant: FinToastVariant.success,
/// );
/// ```
enum FinToastVariant {
  info,
  success,
  warning,
  error,
}

class FinToast {
  FinToast._();

  /// Show a toast at the top of the screen.
  static void show({
    required BuildContext context,
    required String message,
    FinToastVariant variant = FinToastVariant.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final overlay = Navigator.of(context).overlay;
    if (overlay == null) return;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) => _FinToastOverlay(
        message: message,
        variant: variant,
        actionLabel: actionLabel,
        onAction: onAction,
        onDismiss: () => entry.remove(),
        duration: duration,
      ),
    );

    overlay.insert(entry);
  }
}

class _FinToastOverlay extends StatefulWidget {
  const _FinToastOverlay({
    required this.message,
    required this.variant,
    required this.onDismiss,
    required this.duration,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final FinToastVariant variant;
  final VoidCallback onDismiss;
  final Duration duration;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  State<_FinToastOverlay> createState() => _FinToastOverlayState();
}

class _FinToastOverlayState extends State<_FinToastOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: FinMotion.durationNormal,
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: FinMotion.easingEnter,
    ));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) {
          if (mounted) widget.onDismiss();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final (iconData, iconColor, bgColor) = _resolveVariant(colors);

    return Positioned(
      top: MediaQuery.of(context).padding.top + FinSpacing.space8,
      left: FinSpacing.space16,
      right: FinSpacing.space16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: FinSpacing.space16,
              vertical: FinSpacing.space12,
            ),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: FinRadius.borderRadiusMD,
              boxShadow: FinShadows.shadowSubtle,
            ),
            child: Row(
              children: [
                Icon(iconData, size: FinIconSize.sm, color: iconColor),
                const SizedBox(width: FinSpacing.space12),
                Expanded(
                  child: Text(
                    widget.message,
                    style: typo.bodyMedium.copyWith(color: colors.textPrimary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.actionLabel != null) ...[
                  const SizedBox(width: FinSpacing.space8),
                  GestureDetector(
                    onTap: () {
                      widget.onAction?.call();
                      widget.onDismiss();
                    },
                    child: Text(
                      widget.actionLabel!,
                      style: typo.labelSmall.copyWith(
                        color: colors.accentPrimary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  (IconData, Color, Color) _resolveVariant(FinSemanticColors colors) {
    switch (widget.variant) {
      case FinToastVariant.info:
        return (CupertinoIcons.info, colors.info, colors.infoBg);
      case FinToastVariant.success:
        return (CupertinoIcons.checkmark_circle, colors.success, colors.successBg);
      case FinToastVariant.warning:
        return (CupertinoIcons.exclamationmark_triangle, colors.warning, colors.warningBg);
      case FinToastVariant.error:
        return (CupertinoIcons.xmark_circle, colors.danger, colors.dangerBg);
    }
  }
}
