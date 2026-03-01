/// Spacing tokens based on 8px grid system.
///
/// All spacing values follow multiples of 8 for consistency.
/// Exception: `space4` (4px) is allowed for micro spacing (icon gaps, tight layouts).
///
/// Usage:
/// ```dart
/// Padding(padding: EdgeInsets.all(FinSpacing.space16))
/// SizedBox(height: FinSpacing.space24)
/// ```
class FinSpacing {
  FinSpacing._();

  /// 4px — Micro spacing: icon-to-text gaps, tight internal padding
  static const double space4 = 4.0;

  /// 8px — Tight spacing: compact list items, small gaps
  static const double space8 = 8.0;

  /// 12px — Compact internal padding (between 8 and 16)
  static const double space12 = 12.0;

  /// 16px — Default content padding, standard gaps
  static const double space16 = 16.0;

  /// 20px — Medium spacing
  static const double space20 = 20.0;

  /// 24px — Section spacing, card internal padding
  static const double space24 = 24.0;

  /// 32px — Large section gaps
  static const double space32 = 32.0;

  /// 40px — Screen-level spacing, large separations
  static const double space40 = 40.0;

  /// 48px — Hero areas, top margins
  static const double space48 = 48.0;

  /// 56px — Extra large spacing
  static const double space56 = 56.0;

  /// 64px — Maximum spacing (e.g., top of onboarding screens)
  static const double space64 = 64.0;

  // ---------------------------------------------------------------------------
  // Named aliases for common use cases
  // ---------------------------------------------------------------------------

  /// Horizontal page padding (leading/trailing safe area)
  static const double pagePaddingH = space16;

  /// Vertical page padding (top/bottom)
  static const double pagePaddingV = space24;

  /// Internal card padding
  static const double cardPadding = space16;

  /// Gap between cells in a list
  static const double listItemSpacing = space8;

  /// Gap between form fields
  static const double formFieldSpacing = space16;

  /// Section title to content gap
  static const double sectionTitleGap = space8;

  /// Gap between action buttons (horizontal)
  static const double buttonGapH = space12;

  /// Gap between action buttons (vertical)
  static const double buttonGapV = space12;
}
