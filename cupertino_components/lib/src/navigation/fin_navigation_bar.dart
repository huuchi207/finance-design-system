import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// A token-driven CupertinoNavigationBar with large-title support.
///
/// Wraps [CupertinoNavigationBar] and [CupertinoSliverNavigationBar]
/// with consistent styling from the Finance Design System tokens.
///
/// ```dart
/// FinNavigationBar(
///   title: 'Transactions',
///   leading: Icon(CupertinoIcons.back),
///   trailing: Icon(CupertinoIcons.bell),
/// )
/// ```
class FinNavigationBar extends StatelessWidget implements ObstructingPreferredSizeWidget {
  const FinNavigationBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.previousPageTitle,
    this.useTransparentBackground = false,
    this.border,
  });

  /// The title displayed in the navigation bar.
  final String title;

  /// Widget displayed on the leading (left) side.
  final Widget? leading;

  /// Widget displayed on the trailing (right) side.
  final Widget? trailing;

  /// Title of the previous page (for auto back button label).
  final String? previousPageTitle;

  /// If true, the bar uses a transparent background.
  final bool useTransparentBackground;

  /// Custom bottom border. If null, uses default subtle border.
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;

    return CupertinoNavigationBar(
      middle: Text(title),
      leading: leading,
      trailing: trailing,
      previousPageTitle: previousPageTitle,
      backgroundColor: useTransparentBackground
          ? const Color(0x00000000)
          : colors.bgPrimary.withOpacity(0.94),
      border: border ??
          Border(
            bottom: BorderSide(
              color: colors.borderSubtle,
              width: 0.5,
            ),
          ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44.0);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}

/// A large-title navigation bar for use with CustomScrollView / slivers.
///
/// Wraps [CupertinoSliverNavigationBar] with token-based styling.
///
/// ```dart
/// CustomScrollView(
///   slivers: [
///     FinSliverNavigationBar(
///       largeTitle: 'Home',
///       trailing: GestureDetector(
///         onTap: () => openProfile(),
///         child: Icon(CupertinoIcons.person_circle),
///       ),
///     ),
///     // ... other slivers
///   ],
/// )
/// ```
class FinSliverNavigationBar extends StatelessWidget {
  const FinSliverNavigationBar({
    super.key,
    required this.largeTitle,
    this.leading,
    this.trailing,
    this.previousPageTitle,
    this.useTransparentBackground = false,
  });

  /// Large title text (displayed below the standard bar when expanded).
  final String largeTitle;

  /// Leading widget (left side).
  final Widget? leading;

  /// Trailing widget (right side).
  final Widget? trailing;

  /// Title of the previous page.
  final String? previousPageTitle;

  /// If true, uses transparent background.
  final bool useTransparentBackground;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;

    return CupertinoSliverNavigationBar(
      largeTitle: Text(largeTitle),
      leading: leading,
      trailing: trailing,
      previousPageTitle: previousPageTitle,
      backgroundColor: useTransparentBackground
          ? const Color(0x00000000)
          : colors.bgPrimary.withOpacity(0.94),
      border: Border(
        bottom: BorderSide(
          color: colors.borderSubtle,
          width: 0.5,
        ),
      ),
    );
  }
}
