/// Design Tokens for Finance Design System
///
/// This package provides all foundational design tokens including colors,
/// typography, spacing, radius, shadows, motion, and theming infrastructure.
///
/// Usage:
/// ```dart
/// import 'package:design_tokens/design_tokens.dart';
///
/// // Wrap your app with FinanceTheme
/// CupertinoApp(
///   theme: FinanceThemeData.light(),
///   // ...
/// );
///
/// // Access tokens in widgets
/// final colors = FinanceTheme.of(context).colors;
/// final typography = FinanceTheme.of(context).typography;
/// ```
library design_tokens;

export 'src/colors.dart';
export 'src/typography.dart';
export 'src/spacing.dart';
export 'src/radius.dart';
export 'src/shadows.dart';
export 'src/motion.dart';
export 'src/icons.dart';
export 'src/states.dart';
export 'src/brand.dart';
export 'src/theme.dart';
