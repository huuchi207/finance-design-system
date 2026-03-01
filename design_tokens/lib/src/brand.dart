import 'package:flutter/cupertino.dart';
import 'colors.dart';

/// Brand configuration for white-label / multi-brand support.
///
/// A [BrandConfig] defines the customizable subset of design tokens
/// that differentiate one brand from another. All components read
/// tokens through the theme, so switching brands requires no code
/// changes in components.
///
/// Usage:
/// ```dart
/// // Apply Brand A
/// CupertinoApp(
///   theme: FinanceThemeData.light(brand: Brands.bankA),
/// );
///
/// // Apply Brand B
/// CupertinoApp(
///   theme: FinanceThemeData.light(brand: Brands.walletB),
/// );
/// ```
class BrandConfig {
  const BrandConfig({
    required this.name,
    required this.accentPrimary,
    required this.accentPrimaryPressed,
    this.accentSecondary,
    this.fontFamily,
    this.monoFontFamily,
    this.borderRadiusOverride,
    this.lightColorOverrides,
    this.darkColorOverrides,
  });

  /// Human-readable brand name
  final String name;

  /// Primary accent color (buttons, links, active states)
  final Color accentPrimary;

  /// Pressed state of primary accent
  final Color accentPrimaryPressed;

  /// Secondary accent (backgrounds, highlights) — defaults to accent @ 10%
  final Color? accentSecondary;

  /// Override the default system font
  final String? fontFamily;

  /// Override the monospace font used for amounts
  final String? monoFontFamily;

  /// Override default border radius for all components
  final double? borderRadiusOverride;

  /// Additional light theme color overrides
  final FinSemanticColors Function(FinSemanticColors base)? lightColorOverrides;

  /// Additional dark theme color overrides
  final FinSemanticColors Function(FinSemanticColors base)? darkColorOverrides;
}

/// Predefined brand configurations for demonstration.
///
/// In production, brands would be loaded from configuration or
/// defined in the consuming app's codebase.
class Brands {
  Brands._();

  /// Default Finance DS brand — blue accent, system font
  static const BrandConfig defaultBrand = BrandConfig(
    name: 'Finance DS',
    accentPrimary: FinPrimitiveColors.blue500,
    accentPrimaryPressed: FinPrimitiveColors.blue600,
  );

  /// Brand A: Traditional bank — deep blue
  static const BrandConfig bankA = BrandConfig(
    name: 'Bank Alpha',
    accentPrimary: Color(0xFF003D99),
    accentPrimaryPressed: Color(0xFF002966),
    accentSecondary: Color(0xFFE6EDF7),
  );

  /// Brand B: Digital wallet — purple accent
  static const BrandConfig walletB = BrandConfig(
    name: 'Wallet Beta',
    accentPrimary: FinPrimitiveColors.purple500,
    accentPrimaryPressed: FinPrimitiveColors.purple600,
    accentSecondary: Color(0xFFF0ECFF),
  );

  /// Brand C: Neo-bank — teal accent
  static const BrandConfig neoC = BrandConfig(
    name: 'Neo Gamma',
    accentPrimary: FinPrimitiveColors.teal500,
    accentPrimaryPressed: Color(0xFF0B7A70),
    accentSecondary: Color(0xFFE6F7F5),
  );
}
