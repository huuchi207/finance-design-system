import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:cupertino_components/cupertino_components.dart';

/// Result type: success or failure.
enum FinResultType { success, failure }

/// Result page template for showing operation outcomes.
///
/// ```dart
/// FinResultPage(
///   type: FinResultType.success,
///   title: 'Transfer Successful',
///   message: '\$1,000 has been sent to John Doe.',
///   primaryAction: FinResultAction(label: 'Done', onPressed: () => pop()),
///   secondaryAction: FinResultAction(label: 'View Receipt', onPressed: () => viewReceipt()),
/// )
/// ```
class FinResultAction {
  const FinResultAction({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;
}

class FinResultPage extends StatelessWidget {
  const FinResultPage({
    super.key,
    required this.type,
    required this.title,
    this.message,
    required this.primaryAction,
    this.secondaryAction,
    this.icon,
  });

  final FinResultType type;
  final String title;
  final String? message;
  final FinResultAction primaryAction;
  final FinResultAction? secondaryAction;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    final isSuccess = type == FinResultType.success;
    final statusColor = isSuccess ? colors.success : colors.danger;
    final defaultIcon = isSuccess
        ? CupertinoIcons.checkmark_circle_fill
        : CupertinoIcons.xmark_circle_fill;

    return CupertinoPageScaffold(
      backgroundColor: colors.bgPrimary,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: FinSpacing.space24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Icon
              Icon(
                icon ?? defaultIcon,
                size: FinIconSize.hero,
                color: statusColor,
              ),
              const SizedBox(height: FinSpacing.space24),

              // Title
              Text(
                title,
                style: typo.headlineMedium.copyWith(color: colors.textPrimary),
                textAlign: TextAlign.center,
              ),

              // Message
              if (message != null) ...[
                const SizedBox(height: FinSpacing.space12),
                Text(
                  message!,
                  style: typo.bodyMedium.copyWith(color: colors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ],

              const Spacer(flex: 3),

              // Actions
              FinButton(
                label: primaryAction.label,
                variant: FinButtonVariant.primary,
                size: FinButtonSize.large,
                expand: true,
                onPressed: primaryAction.onPressed,
              ),
              if (secondaryAction != null) ...[
                const SizedBox(height: FinSpacing.space12),
                FinButton(
                  label: secondaryAction!.label,
                  variant: FinButtonVariant.tertiary,
                  size: FinButtonSize.large,
                  expand: true,
                  onPressed: secondaryAction!.onPressed,
                ),
              ],
              const SizedBox(height: FinSpacing.space32),
            ],
          ),
        ),
      ),
    );
  }
}
