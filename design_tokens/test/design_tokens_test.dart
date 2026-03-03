import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_tokens/design_tokens.dart';

void main() {
  // ═══════════════════════════════════════════════════════════════════
  // PRIMITIVE COLORS
  // ═══════════════════════════════════════════════════════════════════
  group('FinPrimitiveColors', () {
    test('blue palette has 10 shades from 50 to 900', () {
      expect(FinPrimitiveColors.blue50, const Color(0xFFEBF2FF));
      expect(FinPrimitiveColors.blue100, const Color(0xFFCCDFFF));
      expect(FinPrimitiveColors.blue200, const Color(0xFF99BFFF));
      expect(FinPrimitiveColors.blue300, const Color(0xFF669FFF));
      expect(FinPrimitiveColors.blue400, const Color(0xFF3D8BFF));
      expect(FinPrimitiveColors.blue500, const Color(0xFF0066FF));
      expect(FinPrimitiveColors.blue600, const Color(0xFF0052CC));
      expect(FinPrimitiveColors.blue700, const Color(0xFF003D99));
      expect(FinPrimitiveColors.blue800, const Color(0xFF002966));
      expect(FinPrimitiveColors.blue900, const Color(0xFF001433));
    });

    test('green palette has 10 shades', () {
      expect(FinPrimitiveColors.green50, const Color(0xFFE6F7EF));
      expect(FinPrimitiveColors.green500, const Color(0xFF00A86B));
      expect(FinPrimitiveColors.green900, const Color(0xFF002215));
    });

    test('red palette has 10 shades', () {
      expect(FinPrimitiveColors.red50, const Color(0xFFFEF2F2));
      expect(FinPrimitiveColors.red500, const Color(0xFFEF4444));
      expect(FinPrimitiveColors.red900, const Color(0xFF7F1D1D));
    });

    test('amber palette has 10 shades', () {
      expect(FinPrimitiveColors.amber50, const Color(0xFFFFFBEB));
      expect(FinPrimitiveColors.amber500, const Color(0xFFF59E0B));
      expect(FinPrimitiveColors.amber900, const Color(0xFF78350F));
    });

    test('neutral palette includes extremes', () {
      expect(FinPrimitiveColors.neutral0, const Color(0xFFFFFFFF));
      expect(FinPrimitiveColors.neutral50, const Color(0xFFF9F9FB));
      expect(FinPrimitiveColors.neutral100, const Color(0xFFF5F5F7));
      expect(FinPrimitiveColors.neutral200, const Color(0xFFEBEBF0));
      expect(FinPrimitiveColors.neutral300, const Color(0xFFE0E0E8));
      expect(FinPrimitiveColors.neutral400, const Color(0xFFC5C5D0));
      expect(FinPrimitiveColors.neutral500, const Color(0xFF9999AD));
      expect(FinPrimitiveColors.neutral600, const Color(0xFF6B6B80));
      expect(FinPrimitiveColors.neutral700, const Color(0xFF4A4A5A));
      expect(FinPrimitiveColors.neutral800, const Color(0xFF2C2C35));
      expect(FinPrimitiveColors.neutral850, const Color(0xFF1C1C23));
      expect(FinPrimitiveColors.neutral900, const Color(0xFF0F0F14));
      expect(FinPrimitiveColors.neutral950, const Color(0xFF0A0A0F));
    });

    test('purple and teal alt accents', () {
      expect(FinPrimitiveColors.purple500, const Color(0xFF6B4EFF));
      expect(FinPrimitiveColors.purple400, const Color(0xFF8B73FF));
      expect(FinPrimitiveColors.purple600, const Color(0xFF5538E0));
      expect(FinPrimitiveColors.teal500, const Color(0xFF0D9488));
      expect(FinPrimitiveColors.teal400, const Color(0xFF2DD4BF));
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // SEMANTIC COLORS
  // ═══════════════════════════════════════════════════════════════════
  group('FinSemanticColors', () {
    test('light theme maps all fields correctly', () {
      final c = FinSemanticColors.light;
      expect(c.bgPrimary, FinPrimitiveColors.neutral0);
      expect(c.bgSecondary, FinPrimitiveColors.neutral100);
      expect(c.bgTertiary, FinPrimitiveColors.neutral200);
      expect(c.textPrimary, const Color(0xFF1A1A2E));
      expect(c.textSecondary, FinPrimitiveColors.neutral600);
      expect(c.textTertiary, FinPrimitiveColors.neutral500);
      expect(c.textOnAccent, FinPrimitiveColors.neutral0);
      expect(c.borderDefault, FinPrimitiveColors.neutral300);
      expect(c.borderSubtle, FinPrimitiveColors.neutral200);
      expect(c.borderFocused, FinPrimitiveColors.blue500);
      expect(c.accentPrimary, FinPrimitiveColors.blue500);
      expect(c.accentPrimaryPressed, FinPrimitiveColors.blue600);
      expect(c.accentSecondary, FinPrimitiveColors.blue50);
      expect(c.success, FinPrimitiveColors.green500);
      expect(c.successBg, FinPrimitiveColors.green50);
      expect(c.warning, FinPrimitiveColors.amber500);
      expect(c.warningBg, FinPrimitiveColors.amber50);
      expect(c.danger, FinPrimitiveColors.red600);
      expect(c.dangerBg, FinPrimitiveColors.red50);
      expect(c.info, FinPrimitiveColors.blue500);
      expect(c.infoBg, FinPrimitiveColors.blue50);
      expect(c.surfaceElevated, FinPrimitiveColors.neutral0);
      expect(c.surfaceOverlay, const Color(0x33000000));
      expect(c.interactiveDisabled, FinPrimitiveColors.neutral200);
      expect(c.textDisabled, FinPrimitiveColors.neutral400);
    });

    test('dark theme maps all fields correctly', () {
      final c = FinSemanticColors.dark;
      expect(c.bgPrimary, FinPrimitiveColors.neutral950);
      expect(c.bgSecondary, FinPrimitiveColors.neutral850);
      expect(c.bgTertiary, FinPrimitiveColors.neutral800);
      expect(c.textOnAccent, FinPrimitiveColors.neutral0);
      expect(c.accentPrimary, FinPrimitiveColors.blue400);
      expect(c.accentPrimaryPressed, FinPrimitiveColors.blue500);
      expect(c.success, const Color(0xFF34D399));
      expect(c.danger, FinPrimitiveColors.red500);
      expect(c.info, const Color(0xFF60A5FA));
    });

    test('copyWith overrides individual colors', () {
      final original = FinSemanticColors.light;
      const override = Color(0xFFFF0000);
      final modified = original.copyWith(accentPrimary: override);
      expect(modified.accentPrimary, override);
      expect(modified.bgPrimary, original.bgPrimary);
    });

    test('copyWith preserves all fields when no args given', () {
      final original = FinSemanticColors.light;
      final copy = original.copyWith();
      expect(copy.bgPrimary, original.bgPrimary);
      expect(copy.bgSecondary, original.bgSecondary);
      expect(copy.bgTertiary, original.bgTertiary);
      expect(copy.textPrimary, original.textPrimary);
      expect(copy.textSecondary, original.textSecondary);
      expect(copy.textTertiary, original.textTertiary);
      expect(copy.textOnAccent, original.textOnAccent);
      expect(copy.borderDefault, original.borderDefault);
      expect(copy.borderSubtle, original.borderSubtle);
      expect(copy.borderFocused, original.borderFocused);
      expect(copy.accentPrimary, original.accentPrimary);
      expect(copy.accentPrimaryPressed, original.accentPrimaryPressed);
      expect(copy.accentSecondary, original.accentSecondary);
      expect(copy.success, original.success);
      expect(copy.successBg, original.successBg);
      expect(copy.warning, original.warning);
      expect(copy.warningBg, original.warningBg);
      expect(copy.danger, original.danger);
      expect(copy.dangerBg, original.dangerBg);
      expect(copy.info, original.info);
      expect(copy.infoBg, original.infoBg);
      expect(copy.surfaceElevated, original.surfaceElevated);
      expect(copy.surfaceOverlay, original.surfaceOverlay);
      expect(copy.interactiveDisabled, original.interactiveDisabled);
      expect(copy.textDisabled, original.textDisabled);
    });

    test('copyWith overrides all 24 fields', () {
      const c = Color(0xFF123456);
      final modified = FinSemanticColors.light.copyWith(
        bgPrimary: c,
        bgSecondary: c,
        bgTertiary: c,
        textPrimary: c,
        textSecondary: c,
        textTertiary: c,
        textOnAccent: c,
        borderDefault: c,
        borderSubtle: c,
        borderFocused: c,
        accentPrimary: c,
        accentPrimaryPressed: c,
        accentSecondary: c,
        success: c,
        successBg: c,
        warning: c,
        warningBg: c,
        danger: c,
        dangerBg: c,
        info: c,
        infoBg: c,
        surfaceElevated: c,
        surfaceOverlay: c,
        interactiveDisabled: c,
        textDisabled: c,
      );
      expect(modified.bgPrimary, c);
      expect(modified.bgSecondary, c);
      expect(modified.bgTertiary, c);
      expect(modified.textPrimary, c);
      expect(modified.textSecondary, c);
      expect(modified.textTertiary, c);
      expect(modified.textOnAccent, c);
      expect(modified.borderDefault, c);
      expect(modified.borderSubtle, c);
      expect(modified.borderFocused, c);
      expect(modified.accentPrimary, c);
      expect(modified.accentPrimaryPressed, c);
      expect(modified.accentSecondary, c);
      expect(modified.success, c);
      expect(modified.successBg, c);
      expect(modified.warning, c);
      expect(modified.warningBg, c);
      expect(modified.danger, c);
      expect(modified.dangerBg, c);
      expect(modified.info, c);
      expect(modified.infoBg, c);
      expect(modified.surfaceElevated, c);
      expect(modified.surfaceOverlay, c);
      expect(modified.interactiveDisabled, c);
      expect(modified.textDisabled, c);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // TYPOGRAPHY
  // ═══════════════════════════════════════════════════════════════════
  group('FinTypography', () {
    test('create returns all 16 text styles with correct sizes', () {
      final typo = FinTypography.create();
      expect(typo.displayLarge.fontSize, 32);
      expect(typo.headlineLarge.fontSize, 28);
      expect(typo.headlineMedium.fontSize, 24);
      expect(typo.titleLarge.fontSize, 20);
      expect(typo.titleMedium.fontSize, 17);
      expect(typo.titleSmall.fontSize, 15);
      expect(typo.bodyLarge.fontSize, 17);
      expect(typo.bodyMedium.fontSize, 15);
      expect(typo.bodySmall.fontSize, 13);
      expect(typo.caption.fontSize, 12);
      expect(typo.labelLarge.fontSize, 17);
      expect(typo.labelMedium.fontSize, 15);
      expect(typo.labelSmall.fontSize, 13);
      expect(typo.monoLarge.fontSize, 28);
      expect(typo.monoMedium.fontSize, 20);
      expect(typo.monoSmall.fontSize, 15);
    });

    test('create uses default color', () {
      final typo = FinTypography.create();
      expect(typo.displayLarge.color, const Color(0xFF1A1A2E));
      expect(typo.bodyMedium.color, const Color(0xFF1A1A2E));
    });

    test('create with custom color applies to all styles', () {
      const custom = Color(0xFFAABBCC);
      final typo = FinTypography.create(color: custom);
      expect(typo.displayLarge.color, custom);
      expect(typo.bodyMedium.color, custom);
      expect(typo.monoLarge.color, custom);
    });

    test('create with fontFamily applies to non-mono styles', () {
      final typo = FinTypography.create(fontFamily: 'Poppins');
      expect(typo.displayLarge.fontFamily, 'Poppins');
      expect(typo.bodyMedium.fontFamily, 'Poppins');
    });

    test('create without fontFamily uses null (system default)', () {
      final typo = FinTypography.create();
      expect(typo.displayLarge.fontFamily, null);
    });

    test('create with monoFontFamily overrides mono styles', () {
      final typo = FinTypography.create(monoFontFamily: 'JetBrains Mono');
      expect(typo.monoLarge.fontFamily, 'JetBrains Mono');
      expect(typo.monoMedium.fontFamily, 'JetBrains Mono');
      expect(typo.monoSmall.fontFamily, 'JetBrains Mono');
    });

    test('create without monoFontFamily uses .SF Mono', () {
      final typo = FinTypography.create();
      expect(typo.monoLarge.fontFamily, '.SF Mono');
    });

    test('mono styles contain tabularFigures feature', () {
      final typo = FinTypography.create();
      expect(typo.monoLarge.fontFeatures,
          contains(const FontFeature.tabularFigures()));
      expect(typo.monoMedium.fontFeatures,
          contains(const FontFeature.tabularFigures()));
      expect(typo.monoSmall.fontFeatures,
          contains(const FontFeature.tabularFigures()));
    });

    test('withColor changes color on all 16 styles', () {
      final typo = FinTypography.create();
      const newColor = Color(0xFFFF0000);
      final recolored = typo.withColor(newColor);

      expect(recolored.displayLarge.color, newColor);
      expect(recolored.headlineLarge.color, newColor);
      expect(recolored.headlineMedium.color, newColor);
      expect(recolored.titleLarge.color, newColor);
      expect(recolored.titleMedium.color, newColor);
      expect(recolored.titleSmall.color, newColor);
      expect(recolored.bodyLarge.color, newColor);
      expect(recolored.bodyMedium.color, newColor);
      expect(recolored.bodySmall.color, newColor);
      expect(recolored.caption.color, newColor);
      expect(recolored.labelLarge.color, newColor);
      expect(recolored.labelMedium.color, newColor);
      expect(recolored.labelSmall.color, newColor);
      expect(recolored.monoLarge.color, newColor);
      expect(recolored.monoMedium.color, newColor);
      expect(recolored.monoSmall.color, newColor);
    });

    test('withColor preserves font sizes', () {
      final typo = FinTypography.create();
      final recolored = typo.withColor(const Color(0xFFFF0000));
      expect(recolored.displayLarge.fontSize, 32);
      expect(recolored.monoLarge.fontSize, 28);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // SPACING
  // ═══════════════════════════════════════════════════════════════════
  group('FinSpacing', () {
    test('core values match spec', () {
      expect(FinSpacing.space4, 4);
      expect(FinSpacing.space8, 8);
      expect(FinSpacing.space12, 12);
      expect(FinSpacing.space16, 16);
      expect(FinSpacing.space20, 20);
      expect(FinSpacing.space24, 24);
      expect(FinSpacing.space32, 32);
      expect(FinSpacing.space40, 40);
      expect(FinSpacing.space48, 48);
      expect(FinSpacing.space56, 56);
      expect(FinSpacing.space64, 64);
    });

    test('named aliases map correctly', () {
      expect(FinSpacing.pagePaddingH, FinSpacing.space16);
      expect(FinSpacing.pagePaddingV, FinSpacing.space24);
      expect(FinSpacing.cardPadding, FinSpacing.space16);
      expect(FinSpacing.listItemSpacing, FinSpacing.space8);
      expect(FinSpacing.formFieldSpacing, FinSpacing.space16);
      expect(FinSpacing.sectionTitleGap, FinSpacing.space8);
      expect(FinSpacing.buttonGapH, FinSpacing.space12);
      expect(FinSpacing.buttonGapV, FinSpacing.space12);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // RADIUS
  // ═══════════════════════════════════════════════════════════════════
  group('FinRadius', () {
    test('raw values scale correctly', () {
      expect(FinRadius.radiusXS, 4);
      expect(FinRadius.radiusSM, 8);
      expect(FinRadius.radiusMD, 12);
      expect(FinRadius.radiusLG, 16);
      expect(FinRadius.radiusXL, 24);
      expect(FinRadius.radiusFull, 999);
    });

    test('pre-built BorderRadius instances use correct values', () {
      expect(FinRadius.borderRadiusXS, BorderRadius.circular(4));
      expect(FinRadius.borderRadiusSM, BorderRadius.circular(8));
      expect(FinRadius.borderRadiusMD, BorderRadius.circular(12));
      expect(FinRadius.borderRadiusLG, BorderRadius.circular(16));
      expect(FinRadius.borderRadiusXL, BorderRadius.circular(24));
      expect(FinRadius.borderRadiusFull, BorderRadius.circular(999));
    });

    test('bottomSheetRadius has only top corners', () {
      final r = FinRadius.bottomSheetRadius;
      expect(r.topLeft, const Radius.circular(16));
      expect(r.topRight, const Radius.circular(16));
      expect(r.bottomLeft, Radius.zero);
      expect(r.bottomRight, Radius.zero);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // SHADOWS
  // ═══════════════════════════════════════════════════════════════════
  group('FinShadows', () {
    test('shadowNone is empty', () {
      expect(FinShadows.shadowNone, isEmpty);
    });

    test('shadowSubtle has 2 layers', () {
      expect(FinShadows.shadowSubtle.length, 2);
      expect(FinShadows.shadowSubtle[0].blurRadius, 8);
      expect(FinShadows.shadowSubtle[1].blurRadius, 24);
    });

    test('shadowSubtleDark has 1 layer', () {
      expect(FinShadows.shadowSubtleDark.length, 1);
      expect(FinShadows.shadowSubtleDark[0].blurRadius, 12);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // MOTION
  // ═══════════════════════════════════════════════════════════════════
  group('FinMotion', () {
    test('durations ordered fast to slow', () {
      final durations = [
        FinMotion.durationInstant,
        FinMotion.durationFast,
        FinMotion.durationNormal,
        FinMotion.durationSlow,
        FinMotion.durationEmphasis,
      ];
      for (var i = 0; i < durations.length - 1; i++) {
        expect(durations[i].inMilliseconds < durations[i + 1].inMilliseconds,
            true,
            reason:
                '${durations[i]} should be shorter than ${durations[i + 1]}');
      }
    });

    test('duration values match spec', () {
      expect(FinMotion.durationInstant.inMilliseconds, 100);
      expect(FinMotion.durationFast.inMilliseconds, 150);
      expect(FinMotion.durationNormal.inMilliseconds, 250);
      expect(FinMotion.durationSlow.inMilliseconds, 400);
      expect(FinMotion.durationEmphasis.inMilliseconds, 600);
    });

    test('easing curves are correct types', () {
      expect(FinMotion.easingDefault, Curves.easeInOut);
      expect(FinMotion.easingEnter, Curves.easeOut);
      expect(FinMotion.easingExit, Curves.easeIn);
      expect(FinMotion.easingEmphasize, Curves.elasticOut);
      expect(FinMotion.easingLinear, Curves.linear);
      expect(FinMotion.easingSpring, Curves.fastOutSlowIn);
    });

    test('shimmer duration is 1500ms', () {
      expect(FinMotion.shimmerDuration.inMilliseconds, 1500);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // ICON SIZE
  // ═══════════════════════════════════════════════════════════════════
  group('FinIconSize', () {
    test('all sizes match spec', () {
      expect(FinIconSize.xs, 16);
      expect(FinIconSize.sm, 20);
      expect(FinIconSize.md, 24);
      expect(FinIconSize.lg, 32);
      expect(FinIconSize.xl, 40);
      expect(FinIconSize.xxl, 56);
      expect(FinIconSize.hero, 80);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // INTERACTION STATES
  // ═══════════════════════════════════════════════════════════════════
  group('FinInteractionState', () {
    test('has all 8 states', () {
      expect(FinInteractionState.values.length, 8);
      expect(FinInteractionState.values,
          contains(FinInteractionState.defaultState));
      expect(
          FinInteractionState.values, contains(FinInteractionState.hovered));
      expect(
          FinInteractionState.values, contains(FinInteractionState.pressed));
      expect(
          FinInteractionState.values, contains(FinInteractionState.focused));
      expect(
          FinInteractionState.values, contains(FinInteractionState.disabled));
      expect(
          FinInteractionState.values, contains(FinInteractionState.loading));
      expect(FinInteractionState.values, contains(FinInteractionState.error));
      expect(
          FinInteractionState.values, contains(FinInteractionState.success));
    });
  });

  group('FinStateOpacity', () {
    test('opacity values', () {
      expect(FinStateOpacity.enabled, 1.0);
      expect(FinStateOpacity.hovered, 0.08);
      expect(FinStateOpacity.pressed, 0.12);
      expect(FinStateOpacity.disabled, 0.38);
      expect(FinStateOpacity.loading, 0.6);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // BRAND CONFIG
  // ═══════════════════════════════════════════════════════════════════
  group('BrandConfig', () {
    test('default brand uses blue500', () {
      expect(Brands.defaultBrand.accentPrimary, FinPrimitiveColors.blue500);
      expect(
          Brands.defaultBrand.accentPrimaryPressed, FinPrimitiveColors.blue600);
      expect(Brands.defaultBrand.name, 'Finance DS');
      expect(Brands.defaultBrand.fontFamily, null);
      expect(Brands.defaultBrand.monoFontFamily, null);
      expect(Brands.defaultBrand.borderRadiusOverride, null);
      expect(Brands.defaultBrand.lightColorOverrides, null);
      expect(Brands.defaultBrand.darkColorOverrides, null);
    });

    test('all predefined brands have unique accents', () {
      final accents = [
        Brands.defaultBrand.accentPrimary,
        Brands.bankA.accentPrimary,
        Brands.walletB.accentPrimary,
        Brands.neoC.accentPrimary,
        Brands.viettelMoney.accentPrimary,
      ];
      expect(accents.toSet().length, accents.length,
          reason: 'All brands should have unique accent colors');
    });

    test('all predefined brands have non-empty names', () {
      for (final brand in [
        Brands.defaultBrand,
        Brands.bankA,
        Brands.walletB,
        Brands.neoC,
        Brands.viettelMoney,
      ]) {
        expect(brand.name.isNotEmpty, true,
            reason: '${brand.name} should not be empty');
      }
    });

    test('bankA has deep blue accent with secondary', () {
      expect(Brands.bankA.accentPrimary, const Color(0xFF003D99));
      expect(Brands.bankA.accentSecondary, const Color(0xFFE6EDF7));
    });

    test('walletB uses purple accent', () {
      expect(Brands.walletB.accentPrimary, FinPrimitiveColors.purple500);
    });

    test('neoC uses teal accent', () {
      expect(Brands.neoC.accentPrimary, FinPrimitiveColors.teal500);
    });

    test('viettelMoney uses red accent #ED0233', () {
      expect(Brands.viettelMoney.accentPrimary, const Color(0xFFED0233));
      expect(Brands.viettelMoney.accentPrimaryPressed, const Color(0xFFC50029));
      expect(Brands.viettelMoney.accentSecondary, const Color(0xFFFDE8EC));
      expect(Brands.viettelMoney.name, 'Viettel Money');
    });

    test('BrandConfig with lightColorOverrides', () {
      final brand = BrandConfig(
        name: 'Test',
        accentPrimary: const Color(0xFF000000),
        accentPrimaryPressed: const Color(0xFF111111),
        lightColorOverrides: (base) =>
            base.copyWith(success: const Color(0xFF00FF00)),
      );
      expect(brand.lightColorOverrides, isNotNull);
    });

    test('BrandConfig with darkColorOverrides', () {
      final brand = BrandConfig(
        name: 'Test',
        accentPrimary: const Color(0xFF000000),
        accentPrimaryPressed: const Color(0xFF111111),
        darkColorOverrides: (base) =>
            base.copyWith(danger: const Color(0xFFFF0000)),
      );
      expect(brand.darkColorOverrides, isNotNull);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // THEME
  // ═══════════════════════════════════════════════════════════════════
  group('FinanceThemeDataExtension', () {
    test('light factory with default brand', () {
      final ext = FinanceThemeDataExtension.light();
      expect(ext.brightness, Brightness.light);
      expect(ext.isDark, false);
      expect(ext.brand.name, Brands.defaultBrand.name);
      expect(ext.colors.accentPrimary, Brands.defaultBrand.accentPrimary);
    });

    test('dark factory with default brand', () {
      final ext = FinanceThemeDataExtension.dark();
      expect(ext.brightness, Brightness.dark);
      expect(ext.isDark, true);
      expect(ext.brand.name, Brands.defaultBrand.name);
    });

    test('light factory with custom brand applies accent', () {
      final ext = FinanceThemeDataExtension.light(brand: Brands.viettelMoney);
      expect(ext.colors.accentPrimary, Brands.viettelMoney.accentPrimary);
      expect(ext.colors.accentPrimaryPressed,
          Brands.viettelMoney.accentPrimaryPressed);
      expect(ext.colors.borderFocused, Brands.viettelMoney.accentPrimary);
      expect(ext.brand.name, 'Viettel Money');
    });

    test('dark factory with custom brand applies accent', () {
      final ext = FinanceThemeDataExtension.dark(brand: Brands.bankA);
      expect(ext.colors.accentPrimary, Brands.bankA.accentPrimary);
      expect(ext.colors.borderFocused, Brands.bankA.accentPrimary);
    });

    test('light factory applies lightColorOverrides', () {
      final brand = BrandConfig(
        name: 'Override',
        accentPrimary: const Color(0xFF000000),
        accentPrimaryPressed: const Color(0xFF111111),
        lightColorOverrides: (base) =>
            base.copyWith(success: const Color(0xFF00FF00)),
      );
      final ext = FinanceThemeDataExtension.light(brand: brand);
      expect(ext.colors.success, const Color(0xFF00FF00));
    });

    test('dark factory applies darkColorOverrides', () {
      final brand = BrandConfig(
        name: 'Override',
        accentPrimary: const Color(0xFF000000),
        accentPrimaryPressed: const Color(0xFF111111),
        darkColorOverrides: (base) =>
            base.copyWith(danger: const Color(0xFFAA0000)),
      );
      final ext = FinanceThemeDataExtension.dark(brand: brand);
      expect(ext.colors.danger, const Color(0xFFAA0000));
    });

    test('light factory without colorOverrides skips override', () {
      final ext = FinanceThemeDataExtension.light(brand: Brands.defaultBrand);
      expect(ext.colors.success, FinSemanticColors.light.success);
    });

    test('dark factory without colorOverrides skips override', () {
      final ext = FinanceThemeDataExtension.dark(brand: Brands.defaultBrand);
      // Dark theme has its own success color
      expect(ext.colors.success, const Color(0xFF34D399));
    });

    test('light with brand fontFamily applies to typography', () {
      final brand = BrandConfig(
        name: 'FontTest',
        accentPrimary: const Color(0xFF000000),
        accentPrimaryPressed: const Color(0xFF111111),
        fontFamily: 'Inter',
        monoFontFamily: 'Fira Code',
      );
      final ext = FinanceThemeDataExtension.light(brand: brand);
      expect(ext.typography.bodyMedium.fontFamily, 'Inter');
      expect(ext.typography.monoLarge.fontFamily, 'Fira Code');
    });

    test('accentSecondary from brand is applied in light theme', () {
      final ext = FinanceThemeDataExtension.light(brand: Brands.bankA);
      expect(ext.colors.accentSecondary, Brands.bankA.accentSecondary);
    });
  });

  group('FinanceThemeData', () {
    test('light returns CupertinoThemeData with light brightness', () {
      final theme = FinanceThemeData.light();
      expect(theme.brightness, Brightness.light);
      expect(theme.primaryColor, FinSemanticColors.light.accentPrimary);
    });

    test('dark returns CupertinoThemeData with dark brightness', () {
      final theme = FinanceThemeData.dark();
      expect(theme.brightness, Brightness.dark);
    });

    test('light with brand applies brand accent to primaryColor', () {
      final theme = FinanceThemeData.light(brand: Brands.viettelMoney);
      expect(theme.primaryColor, Brands.viettelMoney.accentPrimary);
    });

    test('dark with brand applies brand accent to primaryColor', () {
      final theme = FinanceThemeData.dark(brand: Brands.bankA);
      expect(theme.primaryColor, Brands.bankA.accentPrimary);
    });

    test('light textTheme uses body large for textStyle', () {
      final theme = FinanceThemeData.light();
      expect(theme.textTheme.textStyle.fontSize, 17);
    });
  });

  group('FinanceTheme InheritedWidget', () {
    testWidgets('of() returns theme data from ancestor', (tester) async {
      late FinanceThemeDataExtension captured;
      final ext = FinanceThemeDataExtension.light();

      await tester.pumpWidget(
        FinanceTheme(
          data: ext,
          child: Builder(builder: (context) {
            captured = FinanceTheme.of(context);
            return const SizedBox();
          }),
        ),
      );

      expect(captured.brightness, Brightness.light);
    });

    testWidgets('maybeOf() returns null when no ancestor', (tester) async {
      FinanceThemeDataExtension? captured;

      await tester.pumpWidget(
        Builder(builder: (context) {
          captured = FinanceTheme.maybeOf(context);
          return const SizedBox();
        }),
      );

      expect(captured, isNull);
    });

    testWidgets('maybeOf() returns theme data when ancestor exists',
        (tester) async {
      FinanceThemeDataExtension? captured;
      final ext = FinanceThemeDataExtension.dark();

      await tester.pumpWidget(
        FinanceTheme(
          data: ext,
          child: Builder(builder: (context) {
            captured = FinanceTheme.maybeOf(context);
            return const SizedBox();
          }),
        ),
      );

      expect(captured, isNotNull);
      expect(captured!.isDark, true);
    });

    testWidgets('updateShouldNotify returns true when data changes',
        (tester) async {
      final light = FinanceThemeDataExtension.light();
      final dark = FinanceThemeDataExtension.dark();

      final lightWidget = FinanceTheme(data: light, child: const SizedBox());
      final darkWidget = FinanceTheme(data: dark, child: const SizedBox());

      expect(lightWidget.updateShouldNotify(darkWidget), true);
    });

    testWidgets('updateShouldNotify returns false when same data',
        (tester) async {
      final ext = FinanceThemeDataExtension.light();

      final w1 = FinanceTheme(data: ext, child: const SizedBox());
      final w2 = FinanceTheme(data: ext, child: const SizedBox());

      expect(w1.updateShouldNotify(w2), false);
    });
  });
}
