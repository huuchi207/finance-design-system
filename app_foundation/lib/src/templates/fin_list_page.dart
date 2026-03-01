import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:cupertino_components/cupertino_components.dart';

/// A list page template with pull-to-refresh, search, and loading states.
///
/// ```dart
/// FinListPage<Transaction>(
///   title: 'Transactions',
///   items: transactions,
///   onRefresh: () => loadTransactions(),
///   itemBuilder: (ctx, tx) => TransactionRow(tx),
///   searchable: true,
///   onSearch: (query) => searchTransactions(query),
/// )
/// ```
class FinListPage<T> extends StatelessWidget {
  const FinListPage({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.onRefresh,
    this.isLoading = false,
    this.isEmpty = false,
    this.errorMessage,
    this.onRetry,
    this.searchable = false,
    this.onSearch,
    this.emptyTitle,
    this.emptyMessage,
    this.emptyIcon,
    this.skeletonBuilder,
    this.skeletonCount = 5,
    this.trailing,
  });

  final String title;
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Future<void> Function()? onRefresh;
  final bool isLoading;
  final bool isEmpty;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final bool searchable;
  final ValueChanged<String>? onSearch;
  final String? emptyTitle;
  final String? emptyMessage;
  final IconData? emptyIcon;
  final Widget Function()? skeletonBuilder;
  final int skeletonCount;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
        trailing: trailing,
        backgroundColor: colors.bgPrimary.withOpacity(0.94),
        border: Border(
          bottom: BorderSide(
            color: colors.borderSubtle,
            width: 0.5,
          ),
        ),
      ),
      backgroundColor: colors.bgSecondary,
      child: SafeArea(
        child: _buildContent(context, colors, typo),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    FinSemanticColors colors,
    FinTypography typo,
  ) {
    // Error state
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(FinSpacing.space24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.exclamationmark_circle,
                size: FinIconSize.xxl,
                color: colors.danger,
              ),
              const SizedBox(height: FinSpacing.space16),
              Text(
                errorMessage!,
                style: typo.bodyMedium.copyWith(color: colors.textSecondary),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: FinSpacing.space16),
                FinButton(
                  label: 'Retry',
                  variant: FinButtonVariant.secondary,
                  onPressed: onRetry,
                ),
              ],
            ],
          ),
        ),
      );
    }

    // Loading state
    if (isLoading && items.isEmpty) {
      return ListView.builder(
        itemCount: skeletonCount,
        itemBuilder: (ctx, _) =>
            skeletonBuilder?.call() ?? FinSkeletonLayouts.transactionItem(),
      );
    }

    // Empty state
    if (isEmpty || (!isLoading && items.isEmpty)) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(FinSpacing.space24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                emptyIcon ?? CupertinoIcons.tray,
                size: FinIconSize.xxl,
                color: colors.textTertiary,
              ),
              const SizedBox(height: FinSpacing.space16),
              Text(
                emptyTitle ?? 'No items yet',
                style: typo.titleMedium.copyWith(color: colors.textPrimary),
              ),
              if (emptyMessage != null) ...[
                const SizedBox(height: FinSpacing.space8),
                Text(
                  emptyMessage!,
                  style: typo.bodySmall.copyWith(color: colors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      );
    }

    // Content
    return CustomScrollView(
      slivers: [
        if (searchable)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(FinSpacing.space16),
              child: FinTextField(
                variant: FinTextFieldVariant.search,
                placeholder: 'Search',
                onChanged: onSearch,
              ),
            ),
          ),
        CupertinoSliverRefreshControl(
          onRefresh: onRefresh,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, index) => itemBuilder(ctx, items[index]),
            childCount: items.length,
          ),
        ),
      ],
    );
  }
}
