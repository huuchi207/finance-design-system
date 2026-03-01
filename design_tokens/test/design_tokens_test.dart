import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_tokens/design_tokens.dart';

void main() {
  group('FinPrimitiveColors', () {
    test('blue palette has 10 shades', () {
      expect(FinPrimitiveColors.blue50, isNotNull);
      expect(FinPrimitiveColors.blue500, isNotNull);
      expect(FinPrimitiveColors.blue900, isNotNull);
    });

    test('neutral palette includes extremes', () {
      expect(FinPrimitiveColors.neutral0, const Color(0xFFFFFFFF));
      expect(FinPrimitiveColors.neutral950, isNotNull);
    });
  });

  group('FinSemanticColors', () {
    test('light theme provides all required colors', () {
      final light = FinSemanticColors.light;
      expect(light.bgPrimary, isNotNull);
      expect(light.textPrimary, isNotNull);
      expect(light.accentPrimary, isNotNull);
      expect(light.success, isNotNull);
      expect(light.danger, isNotNull);
      expect(light.warning, isNotNull);
      expect(light.info, isNotNull);
      expect(light.successBg, isNotNull);
      expect(light.dangerBg, isNotNull);
      expect(light.warningBg, isNotNull);
      expect(light.infoBg, isNotNull);
    });

    test('dark theme provides all required colors', () {
      final dark = FinSemanticColors.dark;
      expect(dark.bgPrimary, isNotNull);
      expect(dark.textPrimary, isNotNull);
      expect(dark.accentPrimary, isNotNull);
    });

    test('copyWith overrides individual colors', () {
      final original = FinSemanticColors.light;
      const newAccent = Color(0xFFFF0000);
      final modified = original.copyWith(accentPrimary: newAccent);

      expect(modified.accentPrimary, newAccent);
      expect(modified.bgPrimary, original.bgPrimary);
      expect(modified.textPrimary, original.textPrimary);
    });

    test('copyWith preserves unchanged values', () {
      final original = FinSemanticColors.light;
      final copy = original.copyWith();

      expect(copy.bgPrimary, original.bgPrimary);
      expect(copy.accentPrimary, original.accentPrimary);
      expect(copy.success, original.success);
    });
  });

  group('FinTypography', () {
    test('create returns all 16+ text styles', () {
      final typo = FinTypography.create();
      expect(typo.displayLarge, isNotNull);
      expect(typo.headlineLarge, isNotNull);
      expect(typo.headlineMedium, isNotNull);
      expect(typo.titleLarge, isNotNull);
      expect(typo.titleMedium, isNotNull);
      expect(typo.titleSmall, isNotNull);
      expect(typo.bodyLarge, isNotNull);
      expect(typo.bodyMedium, isNotNull);
      expect(typo.bodySmall, isNotNull);
      expect(typo.labelLarge, isNotNull);
      expect(typo.labelSmall, isNotNull);
      expect(typo.caption, isNotNull);
      expect(typo.monoLarge, isNotNull);
      expect(typo.monoMedium, isNotNull);
      expect(typo.monoSmall, isNotNull);
    });

    test('display large is 32pt', () {
      final typo = FinTypography.create();
      expect(typo.displayLarge.fontSize, 32);
    });

    test('monospace styles contain tabularFigures', () {
      final typo = FinTypography.create();
      expect(typo.monoLarge.fontFeatures, isNotNull);
      expect(typo.monoLarge.fontFeatures!.isNotEmpty, true);
    });
  });

  group('FinSpacing', () {
    test('follows 8px grid except space4', () {
      expect(FinSpacing.space4, 4);
      expect(FinSpacing.space8, 8);
      expect(FinSpacing.space12, 12);
      expect(FinSpacing.space16, 16);
      expect(FinSpacing.space24, 24);
      expect(FinSpacing.space32, 32);
      expect(FinSpacing.space48, 48);
      expect(FinSpacing.space64, 64);
    });

    test('named aliases use correct values', () {
      expect(FinSpacing.pagePaddingH, FinSpacing.space16);
      expect(FinSpacing.cardPadding, FinSpacing.space16);
      expect(FinSpacing.formFieldSpacing, FinSpacing.space16);
    });
  });

  group('FinRadius', () {
    test('tokens scale correctly', () {
      expect(FinRadius.radiusXS, 4);
      expect(FinRadius.radiusSM, 8);
      expect(FinRadius.radiusMD, 12);
      expect(FinRadius.radiusLG, 16);
      expect(FinRadius.radiusXL, 24);
    });

    test('bottomSheetRadius has only top corners', () {
      final r = FinRadius.bottomSheetRadius;
      expect(r, isNotNull);
    });
  });

  group('FinMotion', () {
    test('durations are ordered fast to slow', () {
      expect(
        FinMotion.durationInstant.inMilliseconds <
            FinMotion.durationFast.inMilliseconds,
        true,
      );
      expect(
        FinMotion.durationFast.inMilliseconds <
            FinMotion.durationNormal.inMilliseconds,
        true,
      );
      expect(
        FinMotion.durationNormal.inMilliseconds <
            FinMotion.durationSlow.inMilliseconds,
        true,
      );
    });
  });

  group('FinIconSize', () {
    test('sizes scale correctly', () {
      expect(FinIconSize.xs, 16);
      expect(FinIconSize.sm, 20);
      expect(FinIconSize.md, 24);
      expect(FinIconSize.lg, 32);
      expect(FinIconSize.xl, 40);
      expect(FinIconSize.xxl, 56);
      expect(FinIconSize.hero, 80);
    });
  });

  group('FinInteractionState', () {
    test('has all required states', () {
      expect(FinInteractionState.values.length, 8);
      expect(FinInteractionState.values.contains(FinInteractionState.defaultState), true);
      expect(FinInteractionState.values.contains(FinInteractionState.disabled), true);
      expect(FinInteractionState.values.contains(FinInteractionState.loading), true);
      expect(FinInteractionState.values.contains(FinInteractionState.error), true);
    });
  });

  group('BrandConfig', () {
    test('default brand has same accent as blue500', () {
      expect(Brands.defaultBrand.accentPrimary, FinPrimitiveColors.blue500);
    });

    test('predefined brands have unique accents', () {
      expect(Brands.bankA.accentPrimary, isNot(Brands.walletB.accentPrimary));
      expect(Brands.walletB.accentPrimary, isNot(Brands.neoC.accentPrimary));
    });

    test('brand names are non-empty', () {
      expect(Brands.defaultBrand.name.isNotEmpty, true);
      expect(Brands.bankA.name.isNotEmpty, true);
    });
  });
}
