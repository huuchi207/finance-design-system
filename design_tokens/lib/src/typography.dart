import 'package:flutter/cupertino.dart';

// =============================================================================
// TYPOGRAPHY TOKENS
// Finance-optimized type scale with monospace for monetary values.
// All sizes use system font (SF Pro on iOS) unless overridden by brand.
// =============================================================================

class FinTypography {
  const FinTypography({
    required this.displayLarge,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.caption,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.monoLarge,
    required this.monoMedium,
    required this.monoSmall,
  });

  /// 32pt / w700 — Hero numbers, large balance displays
  final TextStyle displayLarge;

  /// 28pt / w600 — Primary screen titles
  final TextStyle headlineLarge;

  /// 24pt / w600 — Section headers
  final TextStyle headlineMedium;

  /// 20pt / w600 — Card titles
  final TextStyle titleLarge;

  /// 17pt / w600 — List cell titles, nav bar titles
  final TextStyle titleMedium;

  /// 15pt / w600 — Sub-headers
  final TextStyle titleSmall;

  /// 17pt / w400 — Primary body text
  final TextStyle bodyLarge;

  /// 15pt / w400 — Secondary body text
  final TextStyle bodyMedium;

  /// 13pt / w400 — Tertiary body, footnotes
  final TextStyle bodySmall;

  /// 12pt / w400 — Captions, timestamps, metadata
  final TextStyle caption;

  /// 17pt / w600 — Primary button labels
  final TextStyle labelLarge;

  /// 15pt / w500 — Secondary button labels
  final TextStyle labelMedium;

  /// 13pt / w500 — Small button labels, tags
  final TextStyle labelSmall;

  /// 28pt / w700 / monospace — Large balance/amount display
  final TextStyle monoLarge;

  /// 20pt / w600 / monospace — Medium amount display
  final TextStyle monoMedium;

  /// 15pt / w500 / monospace — Inline amounts, table values
  final TextStyle monoSmall;

  /// Factory for creating the default finance typography scale.
  /// [fontFamily] overrides the main text font.
  /// [monoFontFamily] overrides the monospace font for amounts.
  /// [color] sets the default text color for all styles.
  factory FinTypography.create({
    String? fontFamily,
    String? monoFontFamily,
    Color color = const Color(0xFF1A1A2E),
  }) {
    final String? textFont = fontFamily;
    const String monoFont = '.SF Mono'; // System monospace fallback

    return FinTypography(
      displayLarge: TextStyle(
        fontFamily: textFont,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
        color: color,
      ),
      headlineLarge: TextStyle(
        fontFamily: textFont,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.3,
        color: color,
      ),
      headlineMedium: TextStyle(
        fontFamily: textFont,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.2,
        color: color,
      ),
      titleLarge: TextStyle(
        fontFamily: textFont,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: -0.1,
        color: color,
      ),
      titleMedium: TextStyle(
        fontFamily: textFont,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0,
        color: color,
      ),
      titleSmall: TextStyle(
        fontFamily: textFont,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0,
        color: color,
      ),
      bodyLarge: TextStyle(
        fontFamily: textFont,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0,
        color: color,
      ),
      bodyMedium: TextStyle(
        fontFamily: textFont,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0,
        color: color,
      ),
      bodySmall: TextStyle(
        fontFamily: textFont,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.4,
        letterSpacing: 0,
        color: color,
      ),
      caption: TextStyle(
        fontFamily: textFont,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.3,
        letterSpacing: 0.1,
        color: color,
      ),
      labelLarge: TextStyle(
        fontFamily: textFont,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.0,
        letterSpacing: 0,
        color: color,
      ),
      labelMedium: TextStyle(
        fontFamily: textFont,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.0,
        letterSpacing: 0,
        color: color,
      ),
      labelSmall: TextStyle(
        fontFamily: textFont,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.0,
        letterSpacing: 0.1,
        color: color,
      ),
      monoLarge: TextStyle(
        fontFamily: monoFontFamily ?? monoFont,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
        fontFeatures: const [FontFeature.tabularFigures()],
        color: color,
      ),
      monoMedium: TextStyle(
        fontFamily: monoFontFamily ?? monoFont,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.3,
        fontFeatures: const [FontFeature.tabularFigures()],
        color: color,
      ),
      monoSmall: TextStyle(
        fontFamily: monoFontFamily ?? monoFont,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0,
        fontFeatures: const [FontFeature.tabularFigures()],
        color: color,
      ),
    );
  }

  /// Apply a color to all text styles (useful for theming)
  FinTypography withColor(Color color) {
    return FinTypography(
      displayLarge: displayLarge.copyWith(color: color),
      headlineLarge: headlineLarge.copyWith(color: color),
      headlineMedium: headlineMedium.copyWith(color: color),
      titleLarge: titleLarge.copyWith(color: color),
      titleMedium: titleMedium.copyWith(color: color),
      titleSmall: titleSmall.copyWith(color: color),
      bodyLarge: bodyLarge.copyWith(color: color),
      bodyMedium: bodyMedium.copyWith(color: color),
      bodySmall: bodySmall.copyWith(color: color),
      caption: caption.copyWith(color: color),
      labelLarge: labelLarge.copyWith(color: color),
      labelMedium: labelMedium.copyWith(color: color),
      labelSmall: labelSmall.copyWith(color: color),
      monoLarge: monoLarge.copyWith(color: color),
      monoMedium: monoMedium.copyWith(color: color),
      monoSmall: monoSmall.copyWith(color: color),
    );
  }
}
