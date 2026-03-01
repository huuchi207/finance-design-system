/// Finance-specific components for the Finance Design System.
///
/// Includes purpose-built components for financial applications:
/// amount inputs, balance displays, OTP/PIN entry, transaction status,
/// receipt cards, and compliance warning banners.
///
/// All components enforce secure defaults: masked sensitive data,
/// validated inputs, and clear UX patterns.
library finance_components;

export 'src/amount_input/fin_amount_input.dart';
export 'src/amount_input/fin_amount_formatter.dart';
export 'src/amount_input/fin_amount_validator.dart';
export 'src/balance_display/fin_balance_display.dart';
export 'src/transaction_status/fin_transaction_chip.dart';
export 'src/otp_pin/fin_otp_input.dart';
export 'src/otp_pin/fin_pin_input.dart';
export 'src/receipt/fin_receipt_card.dart';
export 'src/receipt/fin_transaction_summary.dart';
export 'src/warnings/fin_risk_warning_banner.dart';
