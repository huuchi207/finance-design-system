/// Validation rules for financial amount inputs.
///
/// Returns null on valid input, or an error message string on invalid input.
/// Designed for safe-by-default finance: conservative validation, clear errors.
///
/// ```dart
/// final validator = FinAmountValidator(
///   minAmount: 1.0,
///   maxAmount: 50000,
///   required: true,
/// );
/// final error = validator.validate(inputValue);
/// if (error != null) showError(error);
/// ```
class FinAmountValidator {
  const FinAmountValidator({
    this.required = true,
    this.minAmount,
    this.maxAmount,
    this.minAmountMessage,
    this.maxAmountMessage,
    this.requiredMessage = 'Amount is required',
    this.invalidMessage = 'Invalid amount',
    this.customValidator,
  });

  /// Whether a non-zero value is required.
  final bool required;

  /// Minimum allowed amount (inclusive).
  final double? minAmount;

  /// Maximum allowed amount (inclusive).
  final double? maxAmount;

  /// Custom error message for min amount violation.
  final String? minAmountMessage;

  /// Custom error message for max amount violation.
  final String? maxAmountMessage;

  /// Error message when field is empty but required.
  final String requiredMessage;

  /// Error message for unparseable input.
  final String invalidMessage;

  /// Additional custom validation rule.
  final String? Function(double value)? customValidator;

  /// Validate a raw amount value.
  /// Returns null if valid, or an error message string if invalid.
  String? validate(double? value) {
    if (value == null || value == 0) {
      return required ? requiredMessage : null;
    }

    if (value < 0) {
      return invalidMessage;
    }

    if (minAmount != null && value < minAmount!) {
      return minAmountMessage ?? 'Minimum amount is $minAmount';
    }

    if (maxAmount != null && value > maxAmount!) {
      return maxAmountMessage ?? 'Maximum amount is $maxAmount';
    }

    if (customValidator != null) {
      return customValidator!(value);
    }

    return null;
  }

  /// Validate from a text string (parses first).
  String? validateText(String? text) {
    if (text == null || text.trim().isEmpty) {
      return required ? requiredMessage : null;
    }

    // Strip formatting characters
    final cleaned = text.replaceAll(RegExp(r'[,\s]'), '');
    final value = double.tryParse(cleaned);

    if (value == null) {
      return invalidMessage;
    }

    return validate(value);
  }
}

/// Predefined validators for common finance scenarios.
class FinAmountValidators {
  FinAmountValidators._();

  /// Standard transfer validator (1 – 999,999,999)
  static const FinAmountValidator transfer = FinAmountValidator(
    required: true,
    minAmount: 1,
    maxAmount: 999999999,
    minAmountMessage: 'Minimum transfer amount is 1',
    maxAmountMessage: 'Amount exceeds transfer limit',
  );

  /// Top-up validator (10,000 – 50,000,000)
  static const FinAmountValidator topUp = FinAmountValidator(
    required: true,
    minAmount: 10000,
    maxAmount: 50000000,
    minAmountMessage: 'Minimum top-up is 10,000',
    maxAmountMessage: 'Maximum top-up is 50,000,000',
  );

  /// Optional amount (can be zero)
  static const FinAmountValidator optional = FinAmountValidator(
    required: false,
  );
}
