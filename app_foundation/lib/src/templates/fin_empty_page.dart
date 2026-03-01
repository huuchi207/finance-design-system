import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:cupertino_components/cupertino_components.dart';

/// Empty/no-data page template with illustration, title, and optional CTA.
///
/// ```dart
/// FinEmptyPage(
///   icon: CupertinoIcons.wifi_slash,
///   title: 'No Internet Connection',
///   message: 'Please check your connection and try again.',
///   actionLabel: 'Retry',
///   onAction: () => retryConnection(),
/// )
/// ```
class FinEmptyPage extends StatelessWidget {
  const FinEmptyPage({
    super.key,
    this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.iconWidget,
  });

  final IconData? icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  /// Custom widget instead of icon (e.g., illustration).
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(FinSpacing.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget ??
                Icon(
                  icon ?? CupertinoIcons.tray,
                  size: FinIconSize.hero,
                  color: colors.textTertiary,
                ),
            const SizedBox(height: FinSpacing.space24),
            Text(
              title,
              style: typo.titleLarge.copyWith(color: colors.textPrimary),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: FinSpacing.space8),
              Text(
                message!,
                style: typo.bodyMedium.copyWith(color: colors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null) ...[
              const SizedBox(height: FinSpacing.space24),
              FinButton(
                label: actionLabel!,
                variant: FinButtonVariant.primary,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
