import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// A bottom tab bar item configuration.
class FinTabBarItem {
  const FinTabBarItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });

  /// Default icon (unselected state).
  final IconData icon;

  /// Optional active icon (selected state). Falls back to [icon].
  final IconData? activeIcon;

  /// Label for the tab.
  final String label;
}

/// A token-driven CupertinoTabBar.
///
/// Wraps [CupertinoTabBar] with consistent styling from Finance Design System tokens.
///
/// ```dart
/// FinBottomTabBar(
///   items: [
///     FinTabBarItem(
///       icon: CupertinoIcons.house,
///       activeIcon: CupertinoIcons.house_fill,
///       label: 'Home',
///     ),
///     FinTabBarItem(
///       icon: CupertinoIcons.arrow_right_arrow_left,
///       label: 'Transactions',
///     ),
///     FinTabBarItem(
///       icon: CupertinoIcons.person,
///       activeIcon: CupertinoIcons.person_fill,
///       label: 'Profile',
///     ),
///   ],
///   currentIndex: 0,
///   onTap: (index) => setTab(index),
/// )
/// ```
class FinBottomTabBar extends StatelessWidget {
  const FinBottomTabBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.showLabels = true,
  });

  /// Tab items.
  final List<FinTabBarItem> items;

  /// Currently selected tab index.
  final int currentIndex;

  /// Called when a tab is tapped.
  final ValueChanged<int> onTap;

  /// Whether to show labels below icons.
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;

    return CupertinoTabBar(
      currentIndex: currentIndex,
      onTap: onTap,
      activeColor: colors.accentPrimary,
      inactiveColor: colors.textTertiary,
      backgroundColor: colors.bgPrimary.withOpacity(0.94),
      border: Border(
        top: BorderSide(
          color: colors.borderSubtle,
          width: 0.5,
        ),
      ),
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          activeIcon: item.activeIcon != null ? Icon(item.activeIcon) : null,
          label: showLabels ? item.label : null,
        );
      }).toList(),
    );
  }
}
