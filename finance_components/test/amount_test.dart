import 'package:flutter_test/flutter_test.dart';
import 'package:finance_components/finance_components.dart';

void main() {
  group('FinAmountFormatter', () {
    const formatter = FinAmountFormatter();

    test('formats simple amount with 2 decimals', () {
      expect(formatter.format(1000), '1,000.00');
    });

    test('formats large amount with thousands grouping', () {
      expect(formatter.format(1234567.89), '1,234,567.89');
    });

    test('formats zero', () {
      expect(formatter.format(0), '0.00');
    });

    test('formats negative amount', () {
      expect(formatter.format(-500.50), '-500.50');
    });

    test('formats with custom separators', () {
      const dotFormatter = FinAmountFormatter(
        thousandSeparator: '.',
        decimalSeparator: ',',
      );
      expect(dotFormatter.format(1234567.89), '1.234.567,89');
    });

    test('formats with currency symbol before', () {
      const symFormatter = FinAmountFormatter(
        currencySymbol: '\$',
        symbolBefore: true,
      );
      expect(symFormatter.format(1000), '\$1,000.00');
    });

    test('formats with currency symbol after', () {
      const symFormatter = FinAmountFormatter(
        currencySymbol: '₫',
        symbolBefore: false,
        decimalDigits: 0,
      );
      expect(symFormatter.format(1000000), '1,000,000 ₫');
    });

    test('parses formatted string back to double', () {
      expect(formatter.parse('1,000.00'), 1000.0);
      expect(formatter.parse('1,234,567.89'), 1234567.89);
    });

    test('parse returns null for empty string', () {
      expect(formatter.parse(''), null);
    });

    test('parse returns null for invalid input', () {
      expect(formatter.parse('abc'), null);
    });

    test('parse handles currency symbol', () {
      const symFormatter = FinAmountFormatter(currencySymbol: '\$');
      expect(symFormatter.parse('\$1,000.00'), 1000.0);
    });
  });

  group('FinAmountValidator', () {
    test('required validator fails on null', () {
      const v = FinAmountValidator(required: true);
      expect(v.validate(null), isNotNull);
    });

    test('required validator fails on zero', () {
      const v = FinAmountValidator(required: true);
      expect(v.validate(0), isNotNull);
    });

    test('optional validator allows null', () {
      const v = FinAmountValidator(required: false);
      expect(v.validate(null), null);
    });

    test('optional validator allows zero', () {
      const v = FinAmountValidator(required: false);
      expect(v.validate(0), null);
    });

    test('rejects negative values', () {
      const v = FinAmountValidator();
      expect(v.validate(-1), isNotNull);
    });

    test('respects min amount', () {
      const v = FinAmountValidator(minAmount: 100);
      expect(v.validate(50), isNotNull);
      expect(v.validate(100), null);
      expect(v.validate(200), null);
    });

    test('respects max amount', () {
      const v = FinAmountValidator(maxAmount: 1000);
      expect(v.validate(500), null);
      expect(v.validate(1000), null);
      expect(v.validate(1001), isNotNull);
    });

    test('custom validator runs after built-in checks', () {
      final v = FinAmountValidator(
        customValidator: (value) =>
            value % 100 != 0 ? 'Must be multiple of 100' : null,
      );
      expect(v.validate(150), 'Must be multiple of 100');
      expect(v.validate(200), null);
    });

    test('validateText parses and validates', () {
      const v = FinAmountValidator(minAmount: 100);
      expect(v.validateText('50'), isNotNull);
      expect(v.validateText('200'), null);
      expect(v.validateText('1,000'), null);
    });

    test('validateText handles empty', () {
      const v = FinAmountValidator(required: true);
      expect(v.validateText(''), isNotNull);
      expect(v.validateText(null), isNotNull);
    });

    test('transfer preset has correct limits', () {
      expect(FinAmountValidators.transfer.validate(0.5), isNotNull); // below min
      expect(FinAmountValidators.transfer.validate(1), null);
      expect(FinAmountValidators.transfer.validate(999999999), null);
      expect(FinAmountValidators.transfer.validate(1000000000), isNotNull); // above max
    });
  });
}
