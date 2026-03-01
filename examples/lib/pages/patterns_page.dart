import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:cupertino_components/cupertino_components.dart';
import 'package:app_foundation/app_foundation.dart';
import '../widgets/code_example_card.dart';

/// Patterns & Templates gallery page with code examples.
class PatternsPage extends StatelessWidget {
  const PatternsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Patterns'),
        backgroundColor: colors.bgPrimary.withOpacity(0.94),
      ),
      backgroundColor: colors.bgSecondary,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(FinSpacing.space16),
          children: [
            // ═══════════════════════════════════════
            // SCREEN TEMPLATES
            // ═══════════════════════════════════════
            _section('Screen Templates', [
              FinListCell(
                title: 'Result — Success',
                subtitle: 'Transfer completed screen',
                leading: Icon(CupertinoIcons.checkmark_circle_fill,
                    color: colors.success, size: FinIconSize.md),
                showDisclosure: true,
                showSeparator: true,
                backgroundColor: colors.bgPrimary,
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => FinanceTheme(
                      data: theme,
                      child: FinResultPage(
                        type: FinResultType.success,
                        title: 'Transfer Successful',
                        message: '\$1,000.00 has been sent to John Doe.',
                        primaryAction: FinResultAction(
                          label: 'Done',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        secondaryAction: FinResultAction(
                          label: 'View Receipt',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FinListCell(
                title: 'Result — Failure',
                subtitle: 'Transfer failed screen',
                leading: Icon(CupertinoIcons.xmark_circle_fill,
                    color: colors.danger, size: FinIconSize.md),
                showDisclosure: true,
                showSeparator: true,
                backgroundColor: colors.bgPrimary,
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => FinanceTheme(
                      data: theme,
                      child: FinResultPage(
                        type: FinResultType.failure,
                        title: 'Transfer Failed',
                        message: 'Insufficient balance. Please try again.',
                        primaryAction: FinResultAction(
                          label: 'Try Again',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FinListCell(
                title: 'Empty Page',
                subtitle: 'No data / offline state',
                leading: Icon(CupertinoIcons.tray,
                    color: colors.textTertiary, size: FinIconSize.md),
                showDisclosure: true,
                showSeparator: false,
                backgroundColor: colors.bgPrimary,
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => FinanceTheme(
                      data: theme,
                      child: CupertinoPageScaffold(
                        navigationBar: const CupertinoNavigationBar(
                          middle: Text('Empty State'),
                        ),
                        child: FinEmptyPage(
                          iconWidget: Padding(
                            padding: const EdgeInsets.only(bottom: FinSpacing.space8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(FinRadius.radiusMD),
                              child: Image.asset(
                                'assets/images/empty_wallet.png',
                                width: 120,
                                height: 120,
                              ),
                            ),
                          ),
                          title: 'No Transactions',
                          message: 'Your transaction history will appear here once you make your first transfer.',
                          actionLabel: 'Make a Transfer',
                          onAction: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            const CodeExampleCard(
              title: 'FinResultPage Code',
              code: '''FinResultPage(
  type: FinResultType.success,
  title: 'Transfer Successful',
  message: '\$1,000 sent to John Doe.',
  primaryAction: FinResultAction(
    label: 'Done',
    onPressed: () => pop(),
  ),
  secondaryAction: FinResultAction(
    label: 'View Receipt',
    onPressed: () => goReceipt(),
  ),
);''',
            ),
            const CodeExampleCard(
              title: 'FinEmptyPage Code',
              code: '''FinEmptyPage(
  icon: CupertinoIcons.doc_text,
  title: 'No Transactions',
  message: 'History appears after your'
           ' first transfer.',
  actionLabel: 'Make a Transfer',
  onAction: () => goTransfer(),
  // Or use custom illustration:
  iconWidget: Image.asset('assets/empty.png'),
);''',
            ),

            // ═══════════════════════════════════════
            // DATA LOADING STATE
            // ═══════════════════════════════════════
            _section('DataLoadingState<T>', [
              Text(
                'Sealed class for type-safe async state management:',
                style: typo.bodySmall.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: FinSpacing.space12),
              // Visual state diagram
              _stateChip('Initial', colors.bgTertiary, colors.textTertiary),
              _stateArrow(colors),
              _stateChip('Loading', colors.infoBg, colors.info),
              _stateArrow(colors),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _stateChip('Loaded', colors.successBg, colors.success),
                  const SizedBox(width: FinSpacing.space8),
                  _stateChip('Empty', colors.warningBg, colors.warning),
                  const SizedBox(width: FinSpacing.space8),
                  _stateChip('Error', colors.dangerBg, colors.danger),
                ],
              ),
            ]),
            const CodeExampleCard(
              title: 'DataLoadingState Code',
              code: '''// Define state
var state = DataLoadingState<List<Txn>>.initial();

// Lifecycle
state = DataLoadingState.loading();
try {
  final data = await fetchTxns();
  state = data.isEmpty
    ? DataLoadingState.empty()
    : DataLoadingState.loaded(data);
} catch (e) {
  state = DataLoadingState.error(e.toString());
}

// Pattern matching in build():
state.when(
  initial: () => SizedBox.shrink(),
  loading: () => FinSkeletonLayouts.transactionItem(),
  loaded: (txns) => TransactionList(txns),
  empty: () => FinEmptyPage(title: 'No txns'),
  error: (msg) => ErrorView(msg, onRetry: load),
);

// Convenience getters:
state.isLoading  // bool
state.isLoaded   // bool
state.isError    // bool''',
            ),

            // ═══════════════════════════════════════
            // ERROR HANDLING
            // ═══════════════════════════════════════
            _section('Error Handling', [
              FinButton(
                label: '🔌 Network Error (Dialog)',
                variant: FinButtonVariant.secondary,
                expand: true,
                onPressed: () => FinErrorHandler.handle(
                  context: context,
                  error: 'Unable to connect. Check your internet.',
                  mode: FinErrorDisplayMode.dialog,
                  title: 'Connection Error',
                  onRetry: () {},
                ),
              ),
              const SizedBox(height: FinSpacing.space12),
              FinButton(
                label: '⏰ Session Expired (Toast)',
                variant: FinButtonVariant.secondary,
                expand: true,
                onPressed: () => FinErrorHandler.handle(
                  context: context,
                  error: 'Session expired. Please login again.',
                  mode: FinErrorDisplayMode.toast,
                ),
              ),
            ]),
            const CodeExampleCard(
              title: 'FinErrorHandler Code',
              code: '''try {
  await transferMoney();
} catch (e) {
  FinErrorHandler.handle(
    context: context,
    error: e.toString(),
    mode: FinErrorDisplayMode.dialog,
    title: 'Transfer Failed',
    onRetry: () => transferMoney(),
  );
}

// Auto-suggest display mode:
final mode = FinErrorHandler.suggestMode(
  isNetworkError: true,  // → dialog
  isValidationError: true, // → inline
  isBlocking: false,       // → toast
);

// Retry with exponential backoff:
final result = await FinRetry.execute(
  operation: () => fetchData(),
  maxAttempts: 3,
  initialDelay: Duration(seconds: 1),
);''',
            ),

            // ═══════════════════════════════════════
            // APP SHELL
            // ═══════════════════════════════════════
            _section('App Shell', [
              Text(
                'CupertinoTabScaffold with per-tab navigation:',
                style: typo.bodySmall.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: FinSpacing.space12),
              Container(
                padding: const EdgeInsets.all(FinSpacing.space16),
                decoration: BoxDecoration(
                  color: colors.bgTertiary,
                  borderRadius: BorderRadius.circular(FinRadius.radiusSM),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _tabIcon(CupertinoIcons.house_fill, 'Home', true, colors),
                    _tabIcon(CupertinoIcons.arrow_right_arrow_left, 'Txns', false, colors),
                    _tabIcon(CupertinoIcons.chart_bar, 'Reports', false, colors),
                    _tabIcon(CupertinoIcons.person, 'Profile', false, colors),
                  ],
                ),
              ),
            ]),
            const CodeExampleCard(
              title: 'FinAppShell Code',
              code: '''FinAppShell(
  tabs: [
    FinTabItem(
      title: 'Home',
      icon: CupertinoIcons.house,
      activeIcon: CupertinoIcons.house_fill,
      builder: (_) => HomePage(),
    ),
    FinTabItem(
      title: 'Transactions',
      icon: CupertinoIcons.arrow_right_arrow_left,
      builder: (_) => TransactionsPage(),
    ),
  ],
  onTabChanged: (index) => analytics.log(index),
);

// Each tab has its own CupertinoTabView
// with independent navigation stack.''',
            ),

            // ═══════════════════════════════════════
            // LIST PAGE TEMPLATE
            // ═══════════════════════════════════════
            _section('FinListPage Template', [
              Text(
                'Ready-made list screen with pull-to-refresh, search, '
                'skeleton loading, and empty/error states built in.',
                style: typo.bodySmall.copyWith(color: colors.textSecondary),
              ),
            ]),
            const CodeExampleCard(
              title: 'FinListPage Code',
              code: '''FinListPage<Transaction>(
  title: 'Transactions',
  items: transactions,
  isLoading: isLoading,
  isEmpty: transactions.isEmpty,
  errorMessage: errorMsg,
  searchable: true,
  onSearch: (q) => search(q),
  onRefresh: () => loadMore(),
  onRetry: () => reload(),
  emptyTitle: 'No Transactions',
  emptyIcon: CupertinoIcons.tray,
  itemBuilder: (ctx, txn) =>
    FinTransactionSummary(
      title: txn.title,
      amount: txn.amount,
      // ...
    ),
);''',
            ),

            const SizedBox(height: FinSpacing.space48),
          ],
        ),
      ),
    );
  }

  Widget _stateChip(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: FinSpacing.space12,
        vertical: FinSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(FinRadius.radiusSM),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }

  Widget _stateArrow(FinSemanticColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FinSpacing.space4),
      child: Icon(CupertinoIcons.arrow_down, size: 16, color: colors.textTertiary),
    );
  }

  Widget _tabIcon(IconData icon, String label, bool active, FinSemanticColors colors) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: FinIconSize.md,
          color: active ? colors.accentPrimary : colors.textTertiary),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: active ? colors.accentPrimary : colors.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Builder(builder: (context) {
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
    });
  }
}
