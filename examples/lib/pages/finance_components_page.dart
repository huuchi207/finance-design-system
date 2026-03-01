import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:cupertino_components/cupertino_components.dart';
import 'package:finance_components/finance_components.dart';
import '../widgets/code_example_card.dart';

/// Finance-specific components gallery page with code examples.
class FinanceComponentsPage extends StatefulWidget {
  const FinanceComponentsPage({super.key});

  @override
  State<FinanceComponentsPage> createState() => _FinanceComponentsPageState();
}

class _FinanceComponentsPageState extends State<FinanceComponentsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Finance Components'),
        backgroundColor: colors.bgPrimary.withOpacity(0.94),
      ),
      backgroundColor: colors.bgSecondary,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(FinSpacing.space16),
          children: [
            // ═══════════════════════════════════════
            // BALANCE DISPLAY
            // ═══════════════════════════════════════
            _section('Balance Display', [
              // Card illustration
              ClipRRect(
                borderRadius: BorderRadius.circular(FinRadius.radiusMD),
                child: Image.asset(
                  'assets/images/card.png',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: FinSpacing.space16),
              const FinBalanceDisplay(
                amount: 12345678.90,
                currencySymbol: '\$',
                label: 'Available Balance',
                initiallyMasked: true,
                showChange: true,
                changeAmount: 2500.00,
              ),
            ]),
            const CodeExampleCard(
              title: 'FinBalanceDisplay Code',
              code: '''FinBalanceDisplay(
  amount: 12345678.90,
  currencySymbol: '\$',
  label: 'Available Balance',
  initiallyMasked: true,  // 🔒 Secure default
  showChange: true,
  changeAmount: 2500.00,  // + green indicator
  // changeAmount: -500.0  // - red indicator
);

// Tap 👁 icon to mask/unmask.
// Masked shows: \$•••••••
// Uses monospace typography for alignment.''',
            ),

            // ═══════════════════════════════════════
            // AMOUNT INPUT
            // ═══════════════════════════════════════
            _section('Amount Input', [
              FinAmountInput(
                label: 'Transfer Amount',
                currencySymbol: '\$',
                validator: FinAmountValidators.transfer,
                helperText: 'Min \$1 — Max \$999,999,999',
                onAmountChanged: (_) {},
              ),
            ]),
            const CodeExampleCard(
              title: 'FinAmountInput Code',
              code: '''FinAmountInput(
  label: 'Transfer Amount',
  currencySymbol: '\$',
  validator: FinAmountValidators.transfer,
  helperText: 'Min \$1 — Max \$999M',
  onAmountChanged: (amount) {
    print('Parsed: \$amount');
  },
);

// Preset validators:
FinAmountValidators.transfer  // min:1 max:999M
FinAmountValidators.topUp     // min:10 max:10M
FinAmountValidators.payment   // min:0.01 max:100M

// Custom validator:
FinAmountValidator(
  required: true,
  minAmount: 100,
  maxAmount: 5000,
  customValidator: (v) =>
    v % 50 != 0 ? 'Must be x50' : null,
);''',
            ),

            // ═══════════════════════════════════════
            // TRANSACTION STATUS CHIPS
            // ═══════════════════════════════════════
            _section('Transaction Status Chips', [
              const Wrap(
                spacing: FinSpacing.space8,
                runSpacing: FinSpacing.space8,
                children: [
                  FinTransactionChip(status: FinTransactionStatus.pending),
                  FinTransactionChip(status: FinTransactionStatus.processing),
                  FinTransactionChip(status: FinTransactionStatus.success),
                  FinTransactionChip(status: FinTransactionStatus.failed),
                  FinTransactionChip(status: FinTransactionStatus.cancelled),
                ],
              ),
            ]),
            const CodeExampleCard(
              title: 'FinTransactionChip Code',
              code: '''FinTransactionChip(
  status: FinTransactionStatus.success,
);

// Statuses: pending, processing,
//           success, failed, cancelled
// Each has its own color + icon.''',
            ),

            // ═══════════════════════════════════════
            // TRANSACTION LIST
            // ═══════════════════════════════════════
            _section('Transaction List', [
              FinTransactionSummary(
                title: 'Transfer to John Doe',
                subtitle: 'Today, 14:30',
                amount: -500000,
                currencySymbol: '\$',
                status: FinTransactionStatus.success,
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/avatar.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              FinTransactionSummary(
                title: 'Salary Deposit',
                subtitle: 'Yesterday, 09:00',
                amount: 3500000,
                currencySymbol: '\$',
                status: FinTransactionStatus.success,
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.successBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(CupertinoIcons.arrow_down_left,
                      size: FinIconSize.sm, color: colors.success),
                ),
              ),
              FinTransactionSummary(
                title: 'Payment to Merchant',
                subtitle: 'Feb 28, 16:45',
                amount: -125000,
                currencySymbol: '\$',
                status: FinTransactionStatus.pending,
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.warningBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(CupertinoIcons.cart,
                      size: FinIconSize.sm, color: colors.warning),
                ),
                showSeparator: false,
              ),
            ]),
            const CodeExampleCard(
              title: 'FinTransactionSummary Code',
              code: '''FinTransactionSummary(
  title: 'Transfer to John',
  subtitle: 'Today, 14:30',
  amount: -500000,  // negative = outgoing
  currencySymbol: '\$',
  status: FinTransactionStatus.success,
  leading: CircleAvatar(
    backgroundImage: NetworkImage(url),
  ),
  showSeparator: true,
  onTap: () => viewDetail(txn),
);

// Positive amounts show in green,
// negative in default text color.''',
            ),

            // ═══════════════════════════════════════
            // OTP INPUT
            // ═══════════════════════════════════════
            _section('OTP Input', [
              const FinOTPInput(
                length: 6,
                autofocus: false,
              ),
              const SizedBox(height: FinSpacing.space12),
              const FinOTPInput(
                length: 4,
                autofocus: false,
                errorText: 'Invalid OTP code',
              ),
            ]),
            const CodeExampleCard(
              title: 'FinOTPInput Code',
              code: '''FinOTPInput(
  length: 6,
  autofocus: true,
  errorText: hasError ? 'Invalid code' : null,
  onCompleted: (code) async {
    final ok = await verifyOTP(code);
    if (!ok) setError('Invalid code');
    // auto-clears on error
  },
  onChanged: (partial) => clearError(),
);

// Security:
// ✓ No value in debug output
// ✓ Auto-clear on error
// ✓ Paste support for SMS codes''',
            ),

            // ═══════════════════════════════════════
            // PIN INPUT
            // ═══════════════════════════════════════
            _section('PIN Input', [
              const FinPINInput(
                length: 4,
                autofocus: false,
              ),
              const SizedBox(height: FinSpacing.space12),
              const FinPINInput(
                length: 6,
                autofocus: false,
                errorText: 'Wrong PIN',
              ),
            ]),
            const CodeExampleCard(
              title: 'FinPINInput Code',
              code: '''FinPINInput(
  length: 4,
  onCompleted: (pin) async {
    final ok = await verifyPIN(pin);
    if (!ok) setError('Wrong PIN');
    // auto-clears + haptic on error
  },
  errorText: pinError,
);

// Security:
// ✓ Dots display (no digits shown)
// ✓ Haptic feedback (error + complete)
// ✓ PIN never in debug properties
// ✓ Auto-clear on new error''',
            ),

            // ═══════════════════════════════════════
            // RECEIPT CARD
            // ═══════════════════════════════════════
            _section('Receipt Card', [
              FinReceiptCard(
                status: FinTransactionStatus.success,
                title: 'Transfer Successful',
                referenceId: 'TXN-20240301-001',
                children: const [
                  FinTransactionSummaryRow(label: 'From', value: 'Main Account'),
                  FinTransactionSummaryRow(label: 'To', value: 'John Doe'),
                  FinTransactionSummaryRow(
                    label: 'Amount',
                    value: '\$1,000.00',
                    isHighlighted: true,
                    isMono: true,
                  ),
                  FinTransactionSummaryRow(label: 'Fee', value: '\$0.00', isMono: true),
                  FinTransactionSummaryRow(label: 'Date', value: 'Mar 1, 2024'),
                ],
              ),
            ]),
            const CodeExampleCard(
              title: 'FinReceiptCard Code',
              code: '''FinReceiptCard(
  status: FinTransactionStatus.success,
  title: 'Transfer Successful',
  referenceId: 'TXN-20240301-001',
  children: [
    FinTransactionSummaryRow(
      label: 'Amount',
      value: '\$1,000.00',
      isHighlighted: true,
      isMono: true,
    ),
    FinTransactionSummaryRow(
      label: 'Fee', value: '\$0.00',
    ),
  ],
  bottomWidget: FinButton(
    label: 'Share Receipt',
    onPressed: () => share(),
  ),
);''',
            ),

            // ═══════════════════════════════════════
            // RISK WARNING
            // ═══════════════════════════════════════
            _section('Risk Warning Banners', [
              const FinRiskWarningBanner(
                level: FinRiskLevel.info,
                title: 'Terms Updated',
                message: 'Our terms of service have been updated.',
                actionLabel: 'Review',
              ),
              const SizedBox(height: FinSpacing.space12),
              const FinRiskWarningBanner(
                level: FinRiskLevel.warning,
                title: 'Verify Identity',
                message: 'Complete KYC to unlock full features.',
                actionLabel: 'Verify Now',
              ),
              const SizedBox(height: FinSpacing.space12),
              const FinRiskWarningBanner(
                level: FinRiskLevel.critical,
                title: 'Account Restricted',
                message: 'Suspicious activity detected.',
                actionLabel: 'Contact Support',
              ),
            ]),
            const CodeExampleCard(
              title: 'FinRiskWarningBanner Code',
              code: '''FinRiskWarningBanner(
  level: FinRiskLevel.critical,
  title: 'Account Restricted',
  message: 'Suspicious activity detected.',
  actionLabel: 'Contact Support',
  onAction: () => openSupport(),
  onDismiss: () => dismiss(), // null for critical
);

// Levels: info, warning, critical
// critical = non-dismissible (compliance)''',
            ),

            const SizedBox(height: FinSpacing.space48),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return Padding(
      padding: const EdgeInsets.only(bottom: FinSpacing.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: typo.titleSmall.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: FinSpacing.space8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(FinSpacing.space16),
            decoration: BoxDecoration(
              color: colors.bgPrimary,
              borderRadius: FinRadius.borderRadiusMD,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
