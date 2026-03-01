import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:cupertino_components/cupertino_components.dart';
import '../widgets/code_example_card.dart';

/// Foundations gallery — colors, typography, spacing, brand switching.
class FoundationsPage extends StatelessWidget {
  const FoundationsPage({
    super.key,
    required this.onToggleDarkMode,
    required this.onCycleBrand,
    required this.currentBrand,
    required this.isDarkMode,
  });

  final VoidCallback? onToggleDarkMode;
  final VoidCallback? onCycleBrand;
  final BrandConfig? currentBrand;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Foundations'),
        backgroundColor: colors.bgPrimary.withOpacity(0.94),
      ),
      backgroundColor: colors.bgSecondary,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(FinSpacing.space16),
          children: [
            // ── Theme Controls ──
            _SectionTitle('Theme Controls'),
            const SizedBox(height: FinSpacing.space8),
            Container(
              padding: const EdgeInsets.all(FinSpacing.space16),
              decoration: BoxDecoration(
                color: colors.bgPrimary,
                borderRadius: FinRadius.borderRadiusMD,
              ),
              child: Column(
                children: [
                  FinListCell(
                    title: 'Dark Mode',
                    trailing: FinSwitch(
                      value: isDarkMode,
                      onChanged: (_) => onToggleDarkMode?.call(),
                    ),
                    showSeparator: true,
                    backgroundColor: colors.bgPrimary,
                  ),
                  FinListCell(
                    title: 'Brand',
                    trailing: Text(
                      currentBrand?.name ?? 'Default',
                      style: typo.bodyMedium.copyWith(color: colors.accentPrimary),
                    ),
                    onTap: onCycleBrand,
                    showDisclosure: true,
                    showSeparator: false,
                    backgroundColor: colors.bgPrimary,
                  ),
                ],
              ),
            ),
            const CodeExampleCard(
              title: 'Theme Setup',
              code: '''// Wrap your app with FinanceTheme:
final theme = FinanceThemeData.light(
  brand: Brands.bankA,
);

CupertinoApp(
  theme: theme,
  home: FinanceTheme(
    data: FinanceThemeDataExtension.light(
      brand: Brands.bankA,
    ),
    child: MyHomePage(),
  ),
);

// Access tokens anywhere:
final colors = FinanceTheme.of(context).colors;
final typo = FinanceTheme.of(context).typography;''',
            ),

            const SizedBox(height: FinSpacing.space24),

            // ── Colors ──
            _SectionTitle('Semantic Colors'),
            const SizedBox(height: FinSpacing.space8),
            _buildColorGrid(colors),
            const CodeExampleCard(
              title: 'Color Tokens Usage',
              code: '''final colors = FinanceTheme.of(context).colors;

// Backgrounds
colors.bgPrimary    // Main background
colors.bgSecondary  // Grouped list bg
colors.bgTertiary   // Input field bg

// Text
colors.textPrimary   // Body text
colors.textSecondary // Captions
colors.textOnAccent  // Text on buttons

// Status
colors.success / colors.successBg
colors.warning / colors.warningBg
colors.danger  / colors.dangerBg
colors.info    / colors.infoBg

// Brand override
FinSemanticColors.light.copyWith(
  accentPrimary: Color(0xFF00A86B),
);''',
            ),

            const SizedBox(height: FinSpacing.space24),

            // ── Typography ──
            _SectionTitle('Typography Scale'),
            const SizedBox(height: FinSpacing.space8),
            Container(
              padding: const EdgeInsets.all(FinSpacing.space16),
              decoration: BoxDecoration(
                color: colors.bgPrimary,
                borderRadius: FinRadius.borderRadiusMD,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Display Large (32)', style: typo.displayLarge),
                  const SizedBox(height: FinSpacing.space8),
                  Text('Headline Large (28)', style: typo.headlineLarge),
                  const SizedBox(height: FinSpacing.space8),
                  Text('Title Large (20)', style: typo.titleLarge),
                  const SizedBox(height: FinSpacing.space8),
                  Text('Title Medium (17)', style: typo.titleMedium),
                  const SizedBox(height: FinSpacing.space8),
                  Text('Body Large (17)', style: typo.bodyLarge),
                  const SizedBox(height: FinSpacing.space8),
                  Text('Body Medium (15)', style: typo.bodyMedium),
                  const SizedBox(height: FinSpacing.space8),
                  Text('Caption (12)', style: typo.caption),
                  const SizedBox(height: FinSpacing.space16),
                  Text('Mono Large: \$1,234,567.89', style: typo.monoLarge),
                  const SizedBox(height: FinSpacing.space8),
                  Text('Mono Medium: \$1,234.56', style: typo.monoMedium),
                  const SizedBox(height: FinSpacing.space8),
                  Text('Mono Small: \$99.99', style: typo.monoSmall),
                ],
              ),
            ),
            const CodeExampleCard(
              title: 'Typography Usage',
              code: '''final typo = FinanceTheme.of(context).typography;

Text('Balance', style: typo.titleLarge);
Text('\$1,234.56', style: typo.monoLarge);
Text('Yesterday', style: typo.caption);

// Monospace uses tabularFigures for 
// aligned currency columns.''',
            ),

            const SizedBox(height: FinSpacing.space24),

            // ── Spacing ──
            _SectionTitle('Spacing Scale (8px grid)'),
            const SizedBox(height: FinSpacing.space8),
            Container(
              padding: const EdgeInsets.all(FinSpacing.space16),
              decoration: BoxDecoration(
                color: colors.bgPrimary,
                borderRadius: FinRadius.borderRadiusMD,
              ),
              child: Column(
                children: [
                  _SpacingRow('space4', FinSpacing.space4, colors),
                  _SpacingRow('space8', FinSpacing.space8, colors),
                  _SpacingRow('space12', FinSpacing.space12, colors),
                  _SpacingRow('space16', FinSpacing.space16, colors),
                  _SpacingRow('space24', FinSpacing.space24, colors),
                  _SpacingRow('space32', FinSpacing.space32, colors),
                  _SpacingRow('space48', FinSpacing.space48, colors),
                ],
              ),
            ),
            const CodeExampleCard(
              title: 'Spacing Usage',
              code: '''// Direct values
SizedBox(height: FinSpacing.space16);
EdgeInsets.all(FinSpacing.space24);

// Named aliases
EdgeInsets.symmetric(
  horizontal: FinSpacing.pagePaddingH,  // 16
);
SizedBox(height: FinSpacing.sectionSpacing); // 32
SizedBox(height: FinSpacing.cardPadding);    // 16''',
            ),

            const SizedBox(height: FinSpacing.space24),

            // ── Brand ──
            _SectionTitle('Brand Configuration'),
            const SizedBox(height: FinSpacing.space8),
            Container(
              padding: const EdgeInsets.all(FinSpacing.space16),
              decoration: BoxDecoration(
                color: colors.bgPrimary,
                borderRadius: FinRadius.borderRadiusMD,
              ),
              child: Column(
                children: [
                  _BrandPreview('Default', Brands.defaultBrand, colors),
                  _BrandPreview('Bank A', Brands.bankA, colors),
                  _BrandPreview('Wallet B', Brands.walletB, colors),
                  _BrandPreview('Neo C', Brands.neoC, colors),
                ],
              ),
            ),
            const CodeExampleCard(
              title: 'Brand Config',
              code: '''// Define a brand
const myBrand = BrandConfig(
  name: 'MyBank',
  accentPrimary: Color(0xFF00A86B),
  accentDark: Color(0xFF34D399),
  fontFamily: 'Poppins',
);

// Apply to theme
FinanceThemeData.light(brand: myBrand);
FinanceThemeDataExtension.light(brand: myBrand);''',
            ),

            const SizedBox(height: FinSpacing.space48),
          ],
        ),
      ),
    );
  }

  Widget _buildColorGrid(FinSemanticColors colors) {
    final colorPairs = [
      ('accent', colors.accentPrimary),
      ('success', colors.success),
      ('warning', colors.warning),
      ('danger', colors.danger),
      ('info', colors.info),
      ('bgPrimary', colors.bgPrimary),
      ('bgSecondary', colors.bgSecondary),
      ('bgTertiary', colors.bgTertiary),
      ('textPrimary', colors.textPrimary),
      ('textSecondary', colors.textSecondary),
      ('border', colors.borderDefault),
      ('elevated', colors.surfaceElevated),
    ];

    return Wrap(
      spacing: FinSpacing.space8,
      runSpacing: FinSpacing.space8,
      children: colorPairs.map((pair) {
        return _ColorSwatch(name: pair.$1, color: pair.$2);
      }).toList(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    return Text(
      text,
      style: theme.typography.titleSmall.copyWith(
        color: theme.colors.textSecondary,
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.name, required this.color});
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    return Column(
      children: [
        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: FinRadius.borderRadiusSM,
            border: Border.all(color: theme.colors.borderSubtle, width: 0.5),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: theme.typography.caption.copyWith(
            color: theme.colors.textTertiary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _SpacingRow extends StatelessWidget {
  const _SpacingRow(this.name, this.value, this.colors);
  final String name;
  final double value;
  final FinSemanticColors colors;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$name (${value.toInt()})',
              style: theme.typography.caption.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          Container(
            width: value * 3,
            height: 16,
            decoration: BoxDecoration(
              color: colors.accentPrimary.withOpacity(0.3),
              borderRadius: FinRadius.borderRadiusXS,
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandPreview extends StatelessWidget {
  const _BrandPreview(this.name, this.brand, this.colors);
  final String name;
  final BrandConfig brand;
  final FinSemanticColors colors;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FinSpacing.space4),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: brand.accentPrimary,
              borderRadius: FinRadius.borderRadiusSM,
            ),
          ),
          const SizedBox(width: FinSpacing.space12),
          Text(
            name,
            style: theme.typography.bodyMedium.copyWith(color: colors.textPrimary),
          ),
          const Spacer(),
          Text(
            brand.name,
            style: theme.typography.caption.copyWith(color: colors.textTertiary),
          ),
        ],
      ),
    );
  }
}
