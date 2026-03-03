import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:cupertino_components/cupertino_components.dart';

void main() {
  // ═══════════════════════════════════════════════════════════════════
  // FIN DROPDOWN ITEM
  // ═══════════════════════════════════════════════════════════════════
  group('FinDropdownItem', () {
    test('stores value and label', () {
      const item = FinDropdownItem<String>(
        value: 'usd',
        label: 'US Dollar',
      );
      expect(item.value, 'usd');
      expect(item.label, 'US Dollar');
      expect(item.icon, isNull);
    });

    test('stores optional icon', () {
      const item = FinDropdownItem<int>(
        value: 1,
        label: 'Option',
        icon: CupertinoIcons.money_dollar,
      );
      expect(item.icon, CupertinoIcons.money_dollar);
    });

    test('works with various generic types', () {
      const intItem = FinDropdownItem<int>(value: 42, label: 'Forty-two');
      expect(intItem.value, 42);

      const boolItem = FinDropdownItem<bool>(value: true, label: 'Yes');
      expect(boolItem.value, true);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // FIN AVATAR — SIZE, STATUS ENUMS
  // ═══════════════════════════════════════════════════════════════════
  group('FinAvatarSize', () {
    test('small dimension is 28', () {
      expect(FinAvatarSize.small.dimension, 28);
    });

    test('medium dimension is 40', () {
      expect(FinAvatarSize.medium.dimension, 40);
    });

    test('large dimension is 56', () {
      expect(FinAvatarSize.large.dimension, 56);
    });

    test('enum has exactly 3 values', () {
      expect(FinAvatarSize.values.length, 3);
    });
  });

  group('FinAvatarStatus', () {
    test('has 3 status values', () {
      expect(FinAvatarStatus.values.length, 3);
      expect(FinAvatarStatus.values, containsAll([
        FinAvatarStatus.online,
        FinAvatarStatus.offline,
        FinAvatarStatus.busy,
      ]));
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // FIN AVATAR — WIDGET TESTS
  // ═══════════════════════════════════════════════════════════════════
  group('FinAvatar widget', () {
    Widget wrapWithTheme(Widget child) {
      return FinanceTheme(
        data: FinanceThemeDataExtension.light(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(),
            child: child,
          ),
        ),
      );
    }

    testWidgets('renders initials capped at 2 chars', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinAvatar(initials: 'ABC', size: FinAvatarSize.medium),
      ));
      expect(find.text('AB'), findsOneWidget);
    });

    testWidgets('renders initials uppercase', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinAvatar(initials: 'jd', size: FinAvatarSize.small),
      ));
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('renders fallback "?" when no initials or image',
        (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinAvatar(size: FinAvatarSize.medium),
      ));
      expect(find.text('?'), findsOneWidget);
    });

    testWidgets('single-char initials render as-is', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinAvatar(initials: 'X', size: FinAvatarSize.large),
      ));
      expect(find.text('X'), findsOneWidget);
    });

    testWidgets('onTap callback triggers', (tester) async {
      var tapped = false;
      await tester.pumpWidget(wrapWithTheme(
        FinAvatar(
          initials: 'JD',
          size: FinAvatarSize.medium,
          onTap: () => tapped = true,
        ),
      ));
      await tester.tap(find.byType(GestureDetector).first);
      expect(tapped, true);
    });

    testWidgets('status dot renders with online status', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinAvatar(
          initials: 'AB',
          size: FinAvatarSize.large,
          status: FinAvatarStatus.online,
        ),
      ));
      expect(find.byType(Stack), findsOneWidget);
    });

    testWidgets('no status dot when status is null', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinAvatar(initials: 'AB', size: FinAvatarSize.medium),
      ));
      expect(find.byType(Stack), findsNothing);
    });

    testWidgets('busy status renders stack', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinAvatar(
          initials: 'X',
          size: FinAvatarSize.small,
          status: FinAvatarStatus.busy,
        ),
      ));
      expect(find.byType(Stack), findsOneWidget);
    });

    testWidgets('offline status renders stack', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinAvatar(
          initials: 'X',
          size: FinAvatarSize.medium,
          status: FinAvatarStatus.offline,
        ),
      ));
      expect(find.byType(Stack), findsOneWidget);
    });

    testWidgets('semantics label is applied', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinAvatar(
          initials: 'JD',
          size: FinAvatarSize.medium,
          semanticsLabel: 'John Doe avatar',
        ),
      ));
      final semantics = tester.widget<Semantics>(find.byType(Semantics));
      expect(semantics.properties.label, 'John Doe avatar');
    });

    testWidgets('custom backgroundColor is applied', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinAvatar(
          initials: 'C',
          size: FinAvatarSize.medium,
          backgroundColor: Color(0xFFFF0000),
        ),
      ));

      // Find the circular container that is the avatar body
      bool found = false;
      tester.allWidgets.whereType<Container>().forEach((c) {
        final dec = c.decoration;
        if (dec is BoxDecoration &&
            dec.shape == BoxShape.circle &&
            dec.color == const Color(0xFFFF0000)) {
          found = true;
        }
      });
      expect(found, true);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // FIN DROPDOWN — WIDGET TESTS
  // ═══════════════════════════════════════════════════════════════════
  group('FinDropdown widget', () {
    Widget wrapWithTheme(Widget child) {
      return FinanceTheme(
        data: FinanceThemeDataExtension.light(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(),
            child: child,
          ),
        ),
      );
    }

    testWidgets('shows placeholder when no value selected', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinDropdown<String>(
          items: [FinDropdownItem(value: 'a', label: 'Option A')],
          selectedValue: null,
          onChanged: null,
          placeholder: 'Pick one',
        ),
      ));
      expect(find.text('Pick one'), findsOneWidget);
    });

    testWidgets('shows selected label when value matches', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        FinDropdown<String>(
          items: const [
            FinDropdownItem(value: 'a', label: 'Option A'),
            FinDropdownItem(value: 'b', label: 'Option B'),
          ],
          selectedValue: 'b',
          onChanged: (_) {},
        ),
      ));
      expect(find.text('Option B'), findsOneWidget);
    });

    testWidgets('shows placeholder when value does not match any item',
        (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        FinDropdown<String>(
          items: const [
            FinDropdownItem(value: 'a', label: 'Option A'),
          ],
          selectedValue: 'zzz',
          onChanged: (_) {},
          placeholder: 'Select...',
        ),
      ));
      expect(find.text('Select...'), findsOneWidget);
    });

    testWidgets('renders label text when provided', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        FinDropdown<String>(
          label: 'Currency',
          items: const [],
          selectedValue: null,
          onChanged: (_) {},
        ),
      ));
      expect(find.text('Currency'), findsOneWidget);
    });

    testWidgets('no label text when label is null', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        FinDropdown<String>(
          items: const [],
          selectedValue: null,
          onChanged: (_) {},
        ),
      ));
      // Default placeholder should appear, but no label
      expect(find.text('Select...'), findsOneWidget);
    });

    testWidgets('disabled state shows reduced opacity', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        const FinDropdown<String>(
          items: [],
          selectedValue: null,
          onChanged: null,
          isDisabled: true,
        ),
      ));
      final opacity = tester.widget<AnimatedOpacity>(
        find.byType(AnimatedOpacity),
      );
      expect(opacity.opacity, FinStateOpacity.disabled);
    });

    testWidgets('enabled state shows full opacity', (tester) async {
      await tester.pumpWidget(wrapWithTheme(
        FinDropdown<String>(
          items: const [],
          selectedValue: null,
          onChanged: (_) {},
        ),
      ));
      final opacity = tester.widget<AnimatedOpacity>(
        find.byType(AnimatedOpacity),
      );
      expect(opacity.opacity, 1.0);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // FIN TAB BAR ITEM
  // ═══════════════════════════════════════════════════════════════════
  group('FinTabBarItem', () {
    test('constructs with required fields', () {
      final item = FinTabBarItem(
        icon: CupertinoIcons.home,
        label: 'Home',
      );
      expect(item.label, 'Home');
      expect(item.activeIcon, isNull);
    });

    test('constructs with activeIcon', () {
      final item = FinTabBarItem(
        icon: CupertinoIcons.home,
        activeIcon: CupertinoIcons.house_fill,
        label: 'Home',
      );
      expect(item.activeIcon, isNotNull);
    });
  });
}
