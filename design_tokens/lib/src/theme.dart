import 'package:flutter/cupertino.dart';
import 'colors.dart';
import 'typography.dart';
import 'spacing.dart';
import 'radius.dart';
import 'shadows.dart';
import 'motion.dart';
import 'icons.dart';
import 'brand.dart';

/// The central theme builder for the Finance Design System.
///
/// [FinanceThemeData] assembles all design tokens into a cohesive package
/// that can be accessed throughout the widget tree.
///
/// Usage:
/// ```dart
/// CupertinoApp(
///   theme: FinanceThemeData.light(brand: Brands.bankA),
///   builder: (context, child) {
///     return FinanceTheme(
///       data: FinanceThemeDataExtension.light(brand: Brands.bankA),
///       child: child!,
///     );
///   },
/// );
///
/// // In any widget:
/// final theme = FinanceTheme.of(context);
/// Text('Hello', style: theme.typography.bodyLarge);
/// Container(color: theme.colors.bgPrimary);
/// ```
class FinanceThemeDataExtension {
  const FinanceThemeDataExtension({
    required this.colors,
    required this.typography,
    required this.brightness,
    required this.brand,
  });

  final FinSemanticColors colors;
  final FinTypography typography;
  final Brightness brightness;
  final BrandConfig brand;

  // Expose spacing, radius, shadows, motion as static (they don't change per theme)
  // They are accessible without context for convenience.

  bool get isDark => brightness == Brightness.dark;

  /// Light theme extension data
  factory FinanceThemeDataExtension.light({BrandConfig? brand}) {
    final b = brand ?? Brands.defaultBrand;
    var colors = FinSemanticColors.light.copyWith(
      accentPrimary: b.accentPrimary,
      accentPrimaryPressed: b.accentPrimaryPressed,
      accentSecondary: b.accentSecondary,
      borderFocused: b.accentPrimary,
    );
    if (b.lightColorOverrides != null) {
      colors = b.lightColorOverrides!(colors);
    }
    return FinanceThemeDataExtension(
      colors: colors,
      typography: FinTypography.create(
        fontFamily: b.fontFamily,
        monoFontFamily: b.monoFontFamily,
        color: colors.textPrimary,
      ),
      brightness: Brightness.light,
      brand: b,
    );
  }

  /// Dark theme extension data
  factory FinanceThemeDataExtension.dark({BrandConfig? brand}) {
    final b = brand ?? Brands.defaultBrand;
    var colors = FinSemanticColors.dark.copyWith(
      accentPrimary: b.accentPrimary,
      accentPrimaryPressed: b.accentPrimaryPressed,
      borderFocused: b.accentPrimary,
    );
    if (b.darkColorOverrides != null) {
      colors = b.darkColorOverrides!(colors);
    }
    return FinanceThemeDataExtension(
      colors: colors,
      typography: FinTypography.create(
        fontFamily: b.fontFamily,
        monoFontFamily: b.monoFontFamily,
        color: colors.textPrimary,
      ),
      brightness: Brightness.dark,
      brand: b,
    );
  }
}

/// Builds a [CupertinoThemeData] from the Finance Design System tokens.
///
/// This maps our token system onto the native Cupertino theming layer
/// so that built-in Cupertino widgets also pick up our design tokens.
class FinanceThemeData {
  FinanceThemeData._();

  /// Light CupertinoThemeData built from tokens + optional brand override.
  static CupertinoThemeData light({BrandConfig? brand}) {
    final b = brand ?? Brands.defaultBrand;
    final ext = FinanceThemeDataExtension.light(brand: b);

    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: ext.colors.accentPrimary,
      primaryContrastingColor: ext.colors.textOnAccent,
      scaffoldBackgroundColor: ext.colors.bgPrimary,
      barBackgroundColor: ext.colors.bgPrimary.withOpacity(0.94),
      textTheme: CupertinoTextThemeData(
        primaryColor: ext.colors.accentPrimary,
        textStyle: ext.typography.bodyLarge,
        actionTextStyle: ext.typography.bodyLarge.copyWith(
          color: ext.colors.accentPrimary,
        ),
        tabLabelTextStyle: ext.typography.caption,
        navTitleTextStyle: ext.typography.titleMedium,
        navLargeTitleTextStyle: ext.typography.headlineLarge,
        navActionTextStyle: ext.typography.bodyLarge.copyWith(
          color: ext.colors.accentPrimary,
        ),
      ),
    );
  }

  /// Dark CupertinoThemeData built from tokens + optional brand override.
  static CupertinoThemeData dark({BrandConfig? brand}) {
    final b = brand ?? Brands.defaultBrand;
    final ext = FinanceThemeDataExtension.dark(brand: b);

    return CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: ext.colors.accentPrimary,
      primaryContrastingColor: ext.colors.textOnAccent,
      scaffoldBackgroundColor: ext.colors.bgPrimary,
      barBackgroundColor: ext.colors.bgPrimary.withOpacity(0.94),
      textTheme: CupertinoTextThemeData(
        primaryColor: ext.colors.accentPrimary,
        textStyle: ext.typography.bodyLarge,
        actionTextStyle: ext.typography.bodyLarge.copyWith(
          color: ext.colors.accentPrimary,
        ),
        tabLabelTextStyle: ext.typography.caption,
        navTitleTextStyle: ext.typography.titleMedium,
        navLargeTitleTextStyle: ext.typography.headlineLarge,
        navActionTextStyle: ext.typography.bodyLarge.copyWith(
          color: ext.colors.accentPrimary,
        ),
      ),
    );
  }
}

/// InheritedWidget that provides [FinanceThemeDataExtension] to the widget tree.
///
/// Wrap your app's root with this:
/// ```dart
/// FinanceTheme(
///   data: FinanceThemeDataExtension.light(brand: Brands.bankA),
///   child: CupertinoApp(...),
/// )
/// ```
class FinanceTheme extends InheritedWidget {
  const FinanceTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final FinanceThemeDataExtension data;

  /// Access the finance theme data from any widget context.
  ///
  /// Throws if no [FinanceTheme] ancestor is found.
  static FinanceThemeDataExtension of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<FinanceTheme>();
    assert(widget != null, 'No FinanceTheme found in widget tree. '
        'Wrap your app with FinanceTheme.');
    return widget!.data;
  }

  /// Access the finance theme data, returning null if not found.
  static FinanceThemeDataExtension? maybeOf(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<FinanceTheme>();
    return widget?.data;
  }

  @override
  bool updateShouldNotify(FinanceTheme oldWidget) {
    return data != oldWidget.data;
  }
}
