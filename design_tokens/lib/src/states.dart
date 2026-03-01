/// Interactive state definitions for the Finance Design System.
///
/// Every interactive component must support these states. Components
/// should visually differentiate each state using tokens from the
/// color system (never hard-coded colors).
///
/// Usage:
/// ```dart
/// switch (state) {
///   case FinInteractionState.defaultState:
///     return colors.accentPrimary;
///   case FinInteractionState.pressed:
///     return colors.accentPrimaryPressed;
///   case FinInteractionState.disabled:
///     return colors.interactiveDisabled;
///   // ...
/// }
/// ```
enum FinInteractionState {
  /// Normal resting state
  defaultState,

  /// User is hovering (desktop/web)
  hovered,

  /// User is pressing/touching
  pressed,

  /// Component is focused (keyboard/accessibility)
  focused,

  /// Component is non-interactive
  disabled,

  /// Component is performing an async operation
  loading,

  /// Component is in an error state
  error,

  /// Component is in a success state (e.g., validated input)
  success,
}

/// Opacity values for interaction states.
///
/// Applied via `Opacity` or color alpha manipulation.
class FinStateOpacity {
  FinStateOpacity._();

  /// Full opacity — default state
  static const double enabled = 1.0;

  /// Hover state opacity overlay (desktop)
  static const double hovered = 0.08;

  /// Press state opacity overlay
  static const double pressed = 0.12;

  /// Disabled component opacity
  static const double disabled = 0.38;

  /// Loading shimmer overlay
  static const double loading = 0.6;
}
