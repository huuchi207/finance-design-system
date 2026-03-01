import 'package:flutter/cupertino.dart';

/// Border radius tokens for the Finance Design System.
///
/// "Calm finance" aesthetic — rounded but not playful. Consistent
/// radius values ensure visual cohesion across components.
///
/// Usage:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: BorderRadius.circular(FinRadius.radiusMD),
///   ),
/// )
/// ```
class FinRadius {
  FinRadius._();

  /// 4px — Chips, badges, tiny elements
  static const double radiusXS = 4.0;

  /// 8px — Buttons, inputs, small containers
  static const double radiusSM = 8.0;

  /// 12px — Cards, containers, standard components
  static const double radiusMD = 12.0;

  /// 16px — Bottom sheets, modals
  static const double radiusLG = 16.0;

  /// 24px — Full-screen modals, large containers
  static const double radiusXL = 24.0;

  /// 999px — Circular elements (avatar, dot indicator)
  static const double radiusFull = 999.0;

  // ---------------------------------------------------------------------------
  // Pre-built BorderRadius instances
  // ---------------------------------------------------------------------------

  static final BorderRadius borderRadiusXS = BorderRadius.circular(radiusXS);
  static final BorderRadius borderRadiusSM = BorderRadius.circular(radiusSM);
  static final BorderRadius borderRadiusMD = BorderRadius.circular(radiusMD);
  static final BorderRadius borderRadiusLG = BorderRadius.circular(radiusLG);
  static final BorderRadius borderRadiusXL = BorderRadius.circular(radiusXL);
  static final BorderRadius borderRadiusFull = BorderRadius.circular(radiusFull);

  /// Top-only radius for bottom sheets
  static final BorderRadius bottomSheetRadius = BorderRadius.only(
    topLeft: Radius.circular(radiusLG),
    topRight: Radius.circular(radiusLG),
  );
}
