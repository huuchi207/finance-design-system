# Finance Design System — Walkthrough

> **Cupertino-first · Multi-brand · Security-focused**
>
> A comprehensive Flutter Design System for finance mobile apps, built as a multi-package monorepo.

---

## Monorepo Structure

```
design_system/
├── design_tokens/         ← Foundational tokens (colors, typography, spacing, theme)
├── cupertino_components/  ← 17 reusable Cupertino-styled components
├── finance_components/    ← Finance-specific widgets (amount, OTP, receipts)
├── app_foundation/        ← App-level patterns (shell, templates, error handling)
├── examples/              ← Gallery app demonstrating everything
└── walkthrough.md         ← This file
```

---

## Package 1: `design_tokens/`

Core visual foundation — every component reads from these tokens. No hardcoded colors/sizes anywhere.

| Token File | What It Provides |
|---|---|
| `colors.dart` | Primitives (50–900 palettes) + Semantics (light/dark) with `copyWith` for brand overrides |
| `typography.dart` | 16 styles incl. 3 monospace with `tabularFigures` for currency alignment |
| `spacing.dart` | 8px grid (`space4`–`space64`) + named aliases (`pagePaddingH`, `cardPadding`) |
| `radius.dart` | `radiusXS`–`radiusFull` + `bottomSheetRadius` |
| `shadows.dart` | Elevation=0 default; `shadowSubtle` for floating elements only |
| `motion.dart` | 5 durations + 6 easings + shimmer duration |
| `icons.dart` | 7 size tokens (`xs`–`hero`) aligned to 8px grid |
| `states.dart` | `FinInteractionState` enum (8 states) + opacity tokens |
| `brand.dart` | `BrandConfig` class + 4 presets (default, bankA, walletB, neoC) |
| `theme.dart` | `FinanceThemeData` → `CupertinoThemeData` builder + `FinanceTheme` InheritedWidget |

### Key usage pattern

```dart
// 1. Create theme from brand
final theme = FinanceThemeDataExtension.light(brand: Brands.bankA);

// 2. Wrap app
FinanceTheme(
  data: theme,
  child: CupertinoApp(theme: theme.cupertinoTheme, home: MyApp()),
);

// 3. Access tokens anywhere
final colors = FinanceTheme.of(context).colors;
final typo = FinanceTheme.of(context).typography;
```

---

## Package 2: `cupertino_components/`

17 token-driven components, all supporting disabled/loading/error states.

| Component | Key Features |
|---|---|
| `FinButton` | 4 variants (primary/secondary/tertiary/destructive), 3 sizes, loading state, press animation |
| `FinTextField` | 4 variants (normal/amount/password/search), focus border, error/helper text |
| `FinListCell` | title/subtitle/leading/trailing, disclosure indicator, press highlight |
| `FinSettingsRow` | iOS settings-style row with colored icon background |
| `FinSwitch` | CupertinoSwitch with token colors |
| `FinCheckbox` | Animated checkbox with label |
| `FinRadio<T>` | Generic radio button with animation |
| `FinSegmentedControl` | CupertinoSlidingSegmentedControl wrapper |
| `FinNavigationBar` | Compact nav bar with token background/border |
| `FinSliverNavigationBar` | Large-title nav bar for CustomScrollView |
| `FinBottomTabBar` | Tab bar with FinTabBarItem, active/inactive colors |
| `FinDialog` | Alert dialog + confirmation helper |
| `FinBottomSheet` | Drag handle, rounded corners |
| `FinActionSheet` | CupertinoActionSheet wrapper |
| `FinToast` | Animated overlay (slide+fade), 4 variants, auto-dismiss |
| `FinBanner` | Persistent notification with dismiss/action |
| `FinInlineMessage` | Left-accent-border card, 4 variants |
| `FinSkeleton` | Shimmer animation, 3 shapes + pre-composed layouts |

---

## Package 3: `finance_components/`

10 finance-specific components with **security-first** defaults.

| Component | Security Features |
|---|---|
| `FinAmountInput` | Live thousands formatting, monospace, currency prefix, validation |
| `FinAmountFormatter` | Format/parse with configurable separators and symbols |
| `FinAmountValidator` | Min/max/required/custom rules + presets (transfer, topUp, payment) |
| `FinBalanceDisplay` | **Masked by default** 🔒, toggle eye icon, change indicator (↗/↘) |
| `FinTransactionChip` | 5 status pills (pending/processing/success/failed/cancelled) |
| `FinOTPInput` | Auto-advance, paste, **auto-clear on error**, **no value in debug** 🔒 |
| `FinPINInput` | Dot display, **haptic feedback**, **PIN never in debug** 🔒 |
| `FinReceiptCard` | Dashed divider, status chip, reference ID, summary rows |
| `FinTransactionSummary` | Compact list row with signed amount color-coding |
| `FinRiskWarningBanner` | 3 severity levels, **non-dismissible for critical** (compliance) |

---

## Package 4: `app_foundation/`

App-level patterns and screen templates.

| Pattern | Description |
|---|---|
| `FinAppShell` | CupertinoTabScaffold with per-tab navigation stacks |
| `DataLoadingState<T>` | Sealed class: initial → loading → loaded/empty/error with `.when()` |
| `FinErrorHandler` | Routes errors to inline/dialog/toast by severity |
| `FinRetry` | Exponential backoff retry utility |
| `FinListPage` | List template: pull-to-refresh, search, skeleton, empty/error states |
| `FinResultPage` | Success/failure result screen |
| `FinEmptyPage` | No-data placeholder with icon + CTA |

---

## Package 5: `examples/`

Gallery app with 4 tabs, demonstrating every component with:
- **Interactive previews** — tap buttons, toggle switches, trigger dialogs
- **Code examples** — collapsible `CodeExampleCard` per component with copy-to-clipboard
- **Image assets** — avatar, credit card, empty wallet illustrations
- **Dark mode toggle** + **brand cycling** (Default → Bank A → Wallet B → Neo C)

Run: `cd examples && flutter run`

---

## Test Results (49 passing)

| Package | Tests | Status |
|---|---|---|
| `design_tokens` | 19 | ✅ |
| `finance_components` | 22 | ✅ |
| `app_foundation` | 8 | ✅ |

Run all: `cd <package> && flutter test`

---

## Design Principles

- **No hardcoded colors** — all from `FinSemanticColors` via `FinanceTheme.of(context)`
- **8px spacing grid** — all spacing from `FinSpacing` tokens
- **Elevation = 0** — minimal shadows, flat finance aesthetic
- **Cupertino-first** — all components use native Cupertino widgets
- **Secure defaults** — balance masked, OTP/PIN never in debug output
- **Multi-brand** — switch brands via `BrandConfig` without touching component code

---

## How to Add a New Brand

```dart
const myBrand = BrandConfig(
  name: 'MyBank',
  accentPrimary: Color(0xFF00A86B),
  accentDark: Color(0xFF34D399),
  fontFamily: 'Poppins',
);

// Use it
FinanceThemeDataExtension.light(brand: myBrand);
```

---

## How to Add a New Component

1. Create file in the appropriate package's `lib/src/<category>/` 
2. Import `design_tokens` and use `FinanceTheme.of(context)` for all styling
3. Export from the package's barrel file (`lib/<package>.dart`)
4. Add demo + code example in `examples/lib/pages/`

---

## Bugs Fixed During Development

- `FinSkeleton` infinite recursion — custom `AnimatedBuilder` class shadowed Flutter's built-in
- `FinOTPInput` Row overflow — fixed with `Expanded` cells instead of fixed 48px width
- Missing `cupertino_icons` package — icons not rendering (added to all 4 packages)
- Missing `foundation.dart` import in OTP/PIN — `IntProperty`/`FlagProperty` undefined
- Material `CircleAvatar` in Cupertino app — replaced with `ClipOval`

---

## Next Steps (Future Work)

- [ ] Widget tests for all components
- [ ] Integration tests for full user flows
- [ ] Accessibility audit (VoiceOver, Dynamic Type)
- [ ] Component API documentation (dartdoc)
- [ ] CI/CD pipeline setup
- [ ] Publish to private pub.dev or git-based dependency
