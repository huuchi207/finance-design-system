import 'package:flutter/cupertino.dart';

// =============================================================================
// PRIMITIVE COLOR TOKENS
// Raw color values — never use directly in components.
// =============================================================================

class FinPrimitiveColors {
  FinPrimitiveColors._();

  // --- Blue (Primary) ---
  static const Color blue50 = Color(0xFFEBF2FF);
  static const Color blue100 = Color(0xFFCCDFFF);
  static const Color blue200 = Color(0xFF99BFFF);
  static const Color blue300 = Color(0xFF669FFF);
  static const Color blue400 = Color(0xFF3D8BFF);
  static const Color blue500 = Color(0xFF0066FF);
  static const Color blue600 = Color(0xFF0052CC);
  static const Color blue700 = Color(0xFF003D99);
  static const Color blue800 = Color(0xFF002966);
  static const Color blue900 = Color(0xFF001433);

  // --- Green (Success) ---
  static const Color green50 = Color(0xFFE6F7EF);
  static const Color green100 = Color(0xFFB3E8D0);
  static const Color green200 = Color(0xFF80D9B1);
  static const Color green300 = Color(0xFF4DCA92);
  static const Color green400 = Color(0xFF26BF7A);
  static const Color green500 = Color(0xFF00A86B);
  static const Color green600 = Color(0xFF008656);
  static const Color green700 = Color(0xFF006540);
  static const Color green800 = Color(0xFF00432B);
  static const Color green900 = Color(0xFF002215);

  // --- Red (Danger) ---
  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red100 = Color(0xFFFEE2E2);
  static const Color red200 = Color(0xFFFECACA);
  static const Color red300 = Color(0xFFFCA5A5);
  static const Color red400 = Color(0xFFF87171);
  static const Color red500 = Color(0xFFEF4444);
  static const Color red600 = Color(0xFFDC2626);
  static const Color red700 = Color(0xFFB91C1C);
  static const Color red800 = Color(0xFF991B1B);
  static const Color red900 = Color(0xFF7F1D1D);

  // --- Amber (Warning) ---
  static const Color amber50 = Color(0xFFFFFBEB);
  static const Color amber100 = Color(0xFFFEF3C7);
  static const Color amber200 = Color(0xFFFDE68A);
  static const Color amber300 = Color(0xFFFCD34D);
  static const Color amber400 = Color(0xFFFBBF24);
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color amber600 = Color(0xFFD97706);
  static const Color amber700 = Color(0xFFB45309);
  static const Color amber800 = Color(0xFF92400E);
  static const Color amber900 = Color(0xFF78350F);

  // --- Neutral ---
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF9F9FB);
  static const Color neutral100 = Color(0xFFF5F5F7);
  static const Color neutral200 = Color(0xFFEBEBF0);
  static const Color neutral300 = Color(0xFFE0E0E8);
  static const Color neutral400 = Color(0xFFC5C5D0);
  static const Color neutral500 = Color(0xFF9999AD);
  static const Color neutral600 = Color(0xFF6B6B80);
  static const Color neutral700 = Color(0xFF4A4A5A);
  static const Color neutral800 = Color(0xFF2C2C35);
  static const Color neutral850 = Color(0xFF1C1C23);
  static const Color neutral900 = Color(0xFF0F0F14);
  static const Color neutral950 = Color(0xFF0A0A0F);

  // --- Purple (Accent Alt) ---
  static const Color purple500 = Color(0xFF6B4EFF);
  static const Color purple400 = Color(0xFF8B73FF);
  static const Color purple600 = Color(0xFF5538E0);

  // --- Teal (Info Alt) ---
  static const Color teal500 = Color(0xFF0D9488);
  static const Color teal400 = Color(0xFF2DD4BF);
}

// =============================================================================
// SEMANTIC COLOR TOKENS
// Contextual meanings — use these in components via theme.
// =============================================================================

class FinSemanticColors {
  const FinSemanticColors({
    // Background
    required this.bgPrimary,
    required this.bgSecondary,
    required this.bgTertiary,
    // Text
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textOnAccent,
    // Border
    required this.borderDefault,
    required this.borderSubtle,
    required this.borderFocused,
    // Accent
    required this.accentPrimary,
    required this.accentPrimaryPressed,
    required this.accentSecondary,
    // Status
    required this.success,
    required this.successBg,
    required this.warning,
    required this.warningBg,
    required this.danger,
    required this.dangerBg,
    required this.info,
    required this.infoBg,
    // Surface
    required this.surfaceElevated,
    required this.surfaceOverlay,
    // Interactive
    required this.interactiveDisabled,
    required this.textDisabled,
  });

  // --- Background ---
  final Color bgPrimary;
  final Color bgSecondary;
  final Color bgTertiary;

  // --- Text ---
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textOnAccent;

  // --- Border ---
  final Color borderDefault;
  final Color borderSubtle;
  final Color borderFocused;

  // --- Accent ---
  final Color accentPrimary;
  final Color accentPrimaryPressed;
  final Color accentSecondary;

  // --- Status ---
  final Color success;
  final Color successBg;
  final Color warning;
  final Color warningBg;
  final Color danger;
  final Color dangerBg;
  final Color info;
  final Color infoBg;

  // --- Surface ---
  final Color surfaceElevated;
  final Color surfaceOverlay;

  // --- Interactive ---
  final Color interactiveDisabled;
  final Color textDisabled;

  /// Light theme semantic colors
  static const FinSemanticColors light = FinSemanticColors(
    bgPrimary: FinPrimitiveColors.neutral0,
    bgSecondary: FinPrimitiveColors.neutral100,
    bgTertiary: FinPrimitiveColors.neutral200,
    textPrimary: Color(0xFF1A1A2E),
    textSecondary: FinPrimitiveColors.neutral600,
    textTertiary: FinPrimitiveColors.neutral500,
    textOnAccent: FinPrimitiveColors.neutral0,
    borderDefault: FinPrimitiveColors.neutral300,
    borderSubtle: FinPrimitiveColors.neutral200,
    borderFocused: FinPrimitiveColors.blue500,
    accentPrimary: FinPrimitiveColors.blue500,
    accentPrimaryPressed: FinPrimitiveColors.blue600,
    accentSecondary: FinPrimitiveColors.blue50,
    success: FinPrimitiveColors.green500,
    successBg: FinPrimitiveColors.green50,
    warning: FinPrimitiveColors.amber500,
    warningBg: FinPrimitiveColors.amber50,
    danger: FinPrimitiveColors.red600,
    dangerBg: FinPrimitiveColors.red50,
    info: FinPrimitiveColors.blue500,
    infoBg: FinPrimitiveColors.blue50,
    surfaceElevated: FinPrimitiveColors.neutral0,
    surfaceOverlay: Color(0x33000000),
    interactiveDisabled: FinPrimitiveColors.neutral200,
    textDisabled: FinPrimitiveColors.neutral400,
  );

  /// Dark theme semantic colors
  static const FinSemanticColors dark = FinSemanticColors(
    bgPrimary: FinPrimitiveColors.neutral950,
    bgSecondary: FinPrimitiveColors.neutral850,
    bgTertiary: FinPrimitiveColors.neutral800,
    textPrimary: FinPrimitiveColors.neutral100,
    textSecondary: Color(0xFF8E8EA0),
    textTertiary: Color(0xFF5C5C6E),
    textOnAccent: FinPrimitiveColors.neutral0,
    borderDefault: Color(0xFF3A3A45),
    borderSubtle: Color(0xFF2A2A33),
    borderFocused: FinPrimitiveColors.blue400,
    accentPrimary: FinPrimitiveColors.blue400,
    accentPrimaryPressed: FinPrimitiveColors.blue500,
    accentSecondary: Color(0xFF1A2744),
    success: Color(0xFF34D399),
    successBg: Color(0xFF0D2E1F),
    warning: FinPrimitiveColors.amber400,
    warningBg: Color(0xFF2E2308),
    danger: FinPrimitiveColors.red500,
    dangerBg: Color(0xFF2E0D0D),
    info: Color(0xFF60A5FA),
    infoBg: Color(0xFF0D1A2E),
    surfaceElevated: Color(0xFF252530),
    surfaceOverlay: Color(0x66000000),
    interactiveDisabled: FinPrimitiveColors.neutral800,
    textDisabled: FinPrimitiveColors.neutral700,
  );

  /// Create a copy with overrides (for brand customization)
  FinSemanticColors copyWith({
    Color? bgPrimary,
    Color? bgSecondary,
    Color? bgTertiary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textOnAccent,
    Color? borderDefault,
    Color? borderSubtle,
    Color? borderFocused,
    Color? accentPrimary,
    Color? accentPrimaryPressed,
    Color? accentSecondary,
    Color? success,
    Color? successBg,
    Color? warning,
    Color? warningBg,
    Color? danger,
    Color? dangerBg,
    Color? info,
    Color? infoBg,
    Color? surfaceElevated,
    Color? surfaceOverlay,
    Color? interactiveDisabled,
    Color? textDisabled,
  }) {
    return FinSemanticColors(
      bgPrimary: bgPrimary ?? this.bgPrimary,
      bgSecondary: bgSecondary ?? this.bgSecondary,
      bgTertiary: bgTertiary ?? this.bgTertiary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textOnAccent: textOnAccent ?? this.textOnAccent,
      borderDefault: borderDefault ?? this.borderDefault,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderFocused: borderFocused ?? this.borderFocused,
      accentPrimary: accentPrimary ?? this.accentPrimary,
      accentPrimaryPressed: accentPrimaryPressed ?? this.accentPrimaryPressed,
      accentSecondary: accentSecondary ?? this.accentSecondary,
      success: success ?? this.success,
      successBg: successBg ?? this.successBg,
      warning: warning ?? this.warning,
      warningBg: warningBg ?? this.warningBg,
      danger: danger ?? this.danger,
      dangerBg: dangerBg ?? this.dangerBg,
      info: info ?? this.info,
      infoBg: infoBg ?? this.infoBg,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceOverlay: surfaceOverlay ?? this.surfaceOverlay,
      interactiveDisabled: interactiveDisabled ?? this.interactiveDisabled,
      textDisabled: textDisabled ?? this.textDisabled,
    );
  }
}
