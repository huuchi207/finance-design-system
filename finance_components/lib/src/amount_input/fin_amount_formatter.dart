import 'package:flutter/services.dart';

/// Formats currency amounts with thousands grouping and decimal precision.
///
/// - Groups thousands with configurable separator (default: ',')
/// - Forces fixed decimal places (default: 2)
/// - Strips non-numeric input for safety
///
/// ```dart
/// final formatter = FinAmountFormatter(decimalDigits: 2);
/// formatter.format(1234567.89); // '1,234,567.89'
/// formatter.format(1000);       // '1,000.00'
/// ```
class FinAmountFormatter {
  const FinAmountFormatter({
    this.decimalDigits = 2,
    this.thousandSeparator = ',',
    this.decimalSeparator = '.',
    this.currencySymbol = '',
    this.symbolBefore = true,
  });

  /// Number of decimal places to display.
  final int decimalDigits;

  /// Character used to separate thousands groups.
  final String thousandSeparator;

  /// Character used as decimal point.
  final String decimalSeparator;

  /// Currency symbol (e.g., '\$', '₫', '€').
  final String currencySymbol;

  /// Whether symbol appears before (true) or after (false) the amount.
  final bool symbolBefore;

  /// Format a numeric value to display string.
  String format(double value) {
    final parts = value.toStringAsFixed(decimalDigits).split('.');
    final intPart = parts[0];
    final decPart = parts.length > 1 ? parts[1] : '';

    // Add thousands separators
    final buffer = StringBuffer();
    final digits = intPart.replaceAll('-', '');
    final isNegative = value < 0;

    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(thousandSeparator);
      }
      buffer.write(digits[i]);
    }

    String result = buffer.toString();
    if (decimalDigits > 0) {
      result = '$result$decimalSeparator$decPart';
    }
    if (isNegative) {
      result = '-$result';
    }

    if (currencySymbol.isNotEmpty) {
      result = symbolBefore
          ? '$currencySymbol$result'
          : '$result $currencySymbol';
    }

    return result;
  }

  /// Parse a formatted string back to double.
  /// Returns null if parsing fails (safe for finance — never guess).
  double? parse(String text) {
    try {
      final cleaned = text
          .replaceAll(currencySymbol, '')
          .replaceAll(thousandSeparator, '')
          .replaceAll(decimalSeparator, '.')
          .trim();
      if (cleaned.isEmpty) return null;
      return double.tryParse(cleaned);
    } catch (_) {
      return null;
    }
  }
}

/// A [TextInputFormatter] that enforces amount input rules.
///
/// - Allows only digits and one decimal point
/// - Limits decimal places
/// - Adds thousands grouping as user types
class FinAmountTextInputFormatter extends TextInputFormatter {
  FinAmountTextInputFormatter({
    this.decimalDigits = 2,
    this.thousandSeparator = ',',
    this.decimalSeparator = '.',
    this.maxValue,
  });

  final int decimalDigits;
  final String thousandSeparator;
  final String decimalSeparator;
  final double? maxValue;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    // Strip non-numeric except decimal point
    String text = newValue.text.replaceAll(thousandSeparator, '');
    final dotCount = decimalSeparator.allMatches(text).length;
    if (dotCount > 1) return oldValue;

    // Only allow digits and one decimal point
    final validChars = RegExp(r'^[0-9]*\.?[0-9]*$');
    if (!validChars.hasMatch(text)) return oldValue;

    // Limit decimal digits
    if (text.contains(decimalSeparator)) {
      final parts = text.split(decimalSeparator);
      if (parts.length == 2 && parts[1].length > decimalDigits) {
        return oldValue;
      }
    }

    // Check max value
    if (maxValue != null) {
      final value = double.tryParse(text);
      if (value != null && value > maxValue!) return oldValue;
    }

    // Add thousands separator to integer part
    if (text.isNotEmpty) {
      final parts = text.split(decimalSeparator);
      final intPart = parts[0];
      final decPart = parts.length > 1 ? parts[1] : null;

      if (intPart.isNotEmpty) {
        final buffer = StringBuffer();
        final digits = intPart;
        for (int i = 0; i < digits.length; i++) {
          if (i > 0 && (digits.length - i) % 3 == 0) {
            buffer.write(thousandSeparator);
          }
          buffer.write(digits[i]);
        }
        text = decPart != null
            ? '$buffer$decimalSeparator$decPart'
            : buffer.toString();
      }
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
