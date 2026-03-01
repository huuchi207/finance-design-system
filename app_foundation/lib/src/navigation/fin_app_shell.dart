import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Tab definition for the app shell.
class FinTabItem {
  const FinTabItem({
    required this.title,
    required this.icon,
    this.activeIcon,
    required this.builder,
  });

  final String title;
  final IconData icon;
  final IconData? activeIcon;
  final WidgetBuilder builder;
}

/// CupertinoTabScaffold-based app shell with nested navigation.
///
/// Each tab maintains its own navigation stack via [CupertinoTabView].
///
/// ```dart
/// FinAppShell(
///   tabs: [
///     FinTabItem(
///       title: 'Home',
///       icon: CupertinoIcons.house,
///       activeIcon: CupertinoIcons.house_fill,
///       builder: (_) => HomePage(),
///     ),
///     FinTabItem(
///       title: 'Transactions',
///       icon: CupertinoIcons.arrow_right_arrow_left,
///       builder: (_) => TransactionsPage(),
///     ),
///   ],
/// )
/// ```
class FinAppShell extends StatelessWidget {
  const FinAppShell({
    super.key,
    required this.tabs,
    this.onTabChanged,
  });

  final List<FinTabItem> tabs;
  final ValueChanged<int>? onTabChanged;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: colors.bgPrimary.withOpacity(0.94),
        activeColor: colors.accentPrimary,
        inactiveColor: colors.textTertiary,
        border: Border(
          top: BorderSide(
            color: colors.borderSubtle,
            width: 0.5,
          ),
        ),
        onTap: onTabChanged,
        items: tabs.map((tab) {
          return BottomNavigationBarItem(
            icon: Icon(tab.icon),
            activeIcon: tab.activeIcon != null
                ? Icon(tab.activeIcon)
                : null,
            label: tab.title,
          );
        }).toList(),
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: tabs[index].builder,
        );
      },
    );
  }
}
