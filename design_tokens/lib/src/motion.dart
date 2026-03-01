import 'package:flutter/animation.dart';

/// Motion / animation tokens for the Finance Design System.
///
/// Consistent durations and easing curves ensure a polished, cohesive
/// feel across all interactions. Finance apps should feel responsive
/// but not flashy — animations serve clarity, not decoration.
class FinMotion {
  FinMotion._();

  // ---------------------------------------------------------------------------
  // Duration
  // ---------------------------------------------------------------------------

  /// 100ms — Instant feedback (toggle, checkmark)
  static const Duration durationInstant = Duration(milliseconds: 100);

  /// 150ms — Micro-interactions (button press, switch flip)
  static const Duration durationFast = Duration(milliseconds: 150);

  /// 250ms — Standard transitions (page content, fade in)
  static const Duration durationNormal = Duration(milliseconds: 250);

  /// 400ms — Complex transitions (bottom sheet slide, page push)
  static const Duration durationSlow = Duration(milliseconds: 400);

  /// 600ms — Emphasis animations (success checkmark, celebration)
  static const Duration durationEmphasis = Duration(milliseconds: 600);

  // ---------------------------------------------------------------------------
  // Easing Curves
  // ---------------------------------------------------------------------------

  /// Default easing for most animations
  static const Curve easingDefault = Curves.easeInOut;

  /// Elements entering the viewport
  static const Curve easingEnter = Curves.easeOut;

  /// Elements leaving the viewport
  static const Curve easingExit = Curves.easeIn;

  /// Emphasized/bouncy motion for success states
  static const Curve easingEmphasize = Curves.elasticOut;

  /// Linear for progress indicators
  static const Curve easingLinear = Curves.linear;

  /// iOS-style spring animation
  static const Curve easingSpring = Curves.fastOutSlowIn;

  // ---------------------------------------------------------------------------
  // Shimmer
  // ---------------------------------------------------------------------------

  /// Duration for skeleton shimmer loading animation cycle
  static const Duration shimmerDuration = Duration(milliseconds: 1500);
}
