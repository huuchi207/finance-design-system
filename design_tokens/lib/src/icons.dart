/// Icon sizing tokens for the Finance Design System.
///
/// Consistent icon sizes aligned to the 8px grid.
/// All icons should use these sizes for visual consistency.
///
/// Usage:
/// ```dart
/// Icon(CupertinoIcons.bell, size: FinIconSize.md)
/// ```
class FinIconSize {
  FinIconSize._();

  /// 16px — Inline icons, trailing disclosure indicators
  static const double xs = 16.0;

  /// 20px — Standard small icon (buttons, cells)
  static const double sm = 20.0;

  /// 24px — Default icon size (navigation, actions)
  static const double md = 24.0;

  /// 32px — Prominent icons (list leading, tab bar)
  static const double lg = 32.0;

  /// 40px — Feature icons, empty states
  static const double xl = 40.0;

  /// 56px — Hero icons (result pages, onboarding)
  static const double xxl = 56.0;

  /// 80px — Illustration-scale icons (success/error result pages)
  static const double hero = 80.0;
}
