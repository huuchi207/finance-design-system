import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import 'pages/foundations_page.dart';
import 'pages/core_components_page.dart';
import 'pages/finance_components_page.dart';
import 'pages/patterns_page.dart';

void main() {
  runApp(const FinanceDSGallery());
}

class FinanceDSGallery extends StatefulWidget {
  const FinanceDSGallery({super.key});

  @override
  State<FinanceDSGallery> createState() => _FinanceDSGalleryState();
}

class _FinanceDSGalleryState extends State<FinanceDSGallery> {
  BrandConfig _currentBrand = Brands.defaultBrand;
  bool _isDarkMode = false;

  void _cycleBrand() {
    setState(() {
      if (_currentBrand.name == Brands.defaultBrand.name) {
        _currentBrand = Brands.bankA;
      } else if (_currentBrand.name == Brands.bankA.name) {
        _currentBrand = Brands.walletB;
      } else if (_currentBrand.name == Brands.walletB.name) {
        _currentBrand = Brands.neoC;
      } else {
        _currentBrand = Brands.defaultBrand;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = _isDarkMode
        ? FinanceThemeData.dark(brand: _currentBrand)
        : FinanceThemeData.light(brand: _currentBrand);

    final themeExt = _isDarkMode
        ? FinanceThemeDataExtension.dark(brand: _currentBrand)
        : FinanceThemeDataExtension.light(brand: _currentBrand);

    return FinanceTheme(
      data: themeExt,
      child: CupertinoApp(
        title: 'Finance DS Gallery',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: _GalleryHome(
          currentBrand: _currentBrand,
          isDarkMode: _isDarkMode,
          onToggleDarkMode: () => setState(() => _isDarkMode = !_isDarkMode),
          onCycleBrand: _cycleBrand,
        ),
      ),
    );
  }
}

class _GalleryHome extends StatelessWidget {
  const _GalleryHome({
    required this.currentBrand,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.onCycleBrand,
  });

  final BrandConfig currentBrand;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;
  final VoidCallback onCycleBrand;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: colors.bgPrimary.withOpacity(0.94),
        activeColor: colors.accentPrimary,
        inactiveColor: colors.textTertiary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.paintbrush),
            label: 'Foundations',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_stack_3d_up),
            label: 'Core',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar_circle),
            label: 'Finance',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_grid_2x2),
            label: 'Patterns',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (ctx) {
            switch (index) {
              case 0:
                return FoundationsPage(
                  onToggleDarkMode: onToggleDarkMode,
                  onCycleBrand: onCycleBrand,
                  currentBrand: currentBrand,
                  isDarkMode: isDarkMode,
                );
              case 1:
                return const CoreComponentsPage();
              case 2:
                return const FinanceComponentsPage();
              case 3:
                return const PatternsPage();
              default:
                return const FoundationsPage(
                  onToggleDarkMode: null,
                  onCycleBrand: null,
                  currentBrand: null,
                  isDarkMode: false,
                );
            }
          },
        );
      },
    );
  }
}
