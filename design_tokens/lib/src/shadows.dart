import 'package:flutter/cupertino.dart';

/// Shadow tokens for the Finance Design System.
///
/// "Calm finance" aesthetic — minimal elevation. We rely on borders and
/// background color differentiation rather than shadows for depth hierarchy.
///
/// Only two shadow levels are provided:
/// - [shadowNone]: Default for all components (elevation = 0)
/// - [shadowSubtle]: For floating elements (bottom sheets, popovers, toasts)
class FinShadows {
  FinShadows._();

  /// No shadow — default for all components.
  /// Per thruthesky-flutter-skill: elevation = 0 always.
  static const List<BoxShadow> shadowNone = [];

  /// Subtle shadow for floating UI elements.
  /// Used only for: bottom sheets, action sheets, popovers, toasts.
  static const List<BoxShadow> shadowSubtle = [
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity black
      blurRadius: 8,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x08000000), // 3% opacity black
      blurRadius: 24,
      offset: Offset(0, 8),
      spreadRadius: 0,
    ),
  ];

  /// Dark mode subtle shadow (slightly more visible on dark backgrounds)
  static const List<BoxShadow> shadowSubtleDark = [
    BoxShadow(
      color: Color(0x33000000), // 20% opacity black
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];
}
