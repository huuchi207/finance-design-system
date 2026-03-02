import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';
import 'package:cupertino_components/cupertino_components.dart';
import '../widgets/code_example_card.dart';

/// Core components gallery page with code examples.
class CoreComponentsPage extends StatefulWidget {
  const CoreComponentsPage({super.key});

  @override
  State<CoreComponentsPage> createState() => _CoreComponentsPageState();
}

class _CoreComponentsPageState extends State<CoreComponentsPage> {
  bool _switchValue = false;
  bool _checkboxValue = false;
  String _radioValue = 'option1';
  int _segmentValue = 0;
  int _tabBarIndex = 0;
  String _navBarTitle = 'Transactions';
  String? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Core Components'),
        backgroundColor: colors.bgPrimary.withOpacity(0.94),
      ),
      backgroundColor: colors.bgSecondary,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(FinSpacing.space16),
          children: [
            // ═══════════════════════════════════════
            // BUTTONS
            // ═══════════════════════════════════════
            _section('Buttons', [
              FinButton(
                label: 'Primary Button',
                variant: FinButtonVariant.primary,
                expand: true,
                onPressed: () {},
              ),
              const SizedBox(height: FinSpacing.space12),
              FinButton(
                label: 'Secondary Button',
                variant: FinButtonVariant.secondary,
                expand: true,
                onPressed: () {},
              ),
              const SizedBox(height: FinSpacing.space12),
              Row(
                children: [
                  FinButton(
                    label: 'Tertiary',
                    variant: FinButtonVariant.tertiary,
                    onPressed: () {},
                  ),
                  const SizedBox(width: FinSpacing.space12),
                  FinButton(
                    label: 'Destructive',
                    variant: FinButtonVariant.destructive,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: FinSpacing.space12),
              Row(
                children: [
                  FinButton(
                    label: 'Small',
                    size: FinButtonSize.small,
                    onPressed: () {},
                  ),
                  const SizedBox(width: FinSpacing.space8),
                  FinButton(
                    label: 'Medium',
                    size: FinButtonSize.medium,
                    onPressed: () {},
                  ),
                  const SizedBox(width: FinSpacing.space8),
                  FinButton(
                    label: 'Large',
                    size: FinButtonSize.large,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: FinSpacing.space12),
              const FinButton(
                label: 'Loading...',
                variant: FinButtonVariant.primary,
                isLoading: true,
                expand: true,
              ),
              const SizedBox(height: FinSpacing.space12),
              const FinButton(
                label: 'Disabled',
                isDisabled: true,
                expand: true,
              ),
            ]),
            const CodeExampleCard(
              title: 'FinButton Code',
              code: '''FinButton(
  label: 'Transfer Now',
  variant: FinButtonVariant.primary,
  size: FinButtonSize.large,
  expand: true,
  isLoading: isProcessing,
  onPressed: () => handleTransfer(),
);

// Variants: primary, secondary,
//           tertiary, destructive
// Sizes:    small, medium, large''',
            ),

            // ═══════════════════════════════════════
            // TEXT FIELDS
            // ═══════════════════════════════════════
            _section('Text Fields', [
              FinTextField(
                label: 'Full Name',
                placeholder: 'Enter your name...',
                onChanged: (_) {},
              ),
              const SizedBox(height: FinSpacing.space16),
              FinTextField(
                label: 'Password',
                variant: FinTextFieldVariant.password,
                placeholder: 'Enter password',
                onChanged: (_) {},
              ),
              const SizedBox(height: FinSpacing.space16),
              FinTextField(
                variant: FinTextFieldVariant.search,
                placeholder: 'Search transactions...',
                onChanged: (_) {},
              ),
              const SizedBox(height: FinSpacing.space16),
              const FinTextField(
                label: 'Email',
                placeholder: 'Enter email',
                errorText: 'Invalid email address',
                helperText: 'We\'ll send a verification code',
              ),
            ]),
            const CodeExampleCard(
              title: 'FinTextField Code',
              code: '''FinTextField(
  label: 'Email',
  placeholder: 'name@example.com',
  variant: FinTextFieldVariant.normal,
  helperText: 'Used for account recovery',
  errorText: hasError ? 'Invalid email' : null,
  onChanged: (value) => updateEmail(value),
);

// Variants: normal, amount,
//           password, search''',
            ),

            // ═══════════════════════════════════════
            // LIST CELLS
            // ═══════════════════════════════════════
            _section('List Cells', [
              FinListCell(
                title: 'Account Settings',
                subtitle: 'Manage your account preferences',
                leading: _iconContainer(CupertinoIcons.gear, colors),
                showDisclosure: true,
                showSeparator: true,
                backgroundColor: colors.bgPrimary,
                onTap: () {},
              ),
              FinListCell(
                title: 'Notifications',
                subtitle: 'Push, email, and SMS alerts',
                leading: _iconContainer(CupertinoIcons.bell, colors),
                showDisclosure: true,
                showSeparator: true,
                backgroundColor: colors.bgPrimary,
                onTap: () {},
              ),
              FinListCell(
                title: 'Privacy & Security',
                leading: _iconContainer(CupertinoIcons.lock, colors),
                showDisclosure: true,
                showSeparator: false,
                backgroundColor: colors.bgPrimary,
                onTap: () {},
              ),
            ]),
            const CodeExampleCard(
              title: 'FinListCell Code',
              code: '''FinListCell(
  title: 'Account Settings',
  subtitle: 'Manage preferences',
  leading: Icon(CupertinoIcons.gear),
  trailing: Text('Pro'),
  showDisclosure: true,
  showSeparator: true,
  onTap: () => navigateTo(settings),
);

// FinSettingsRow — convenience wrapper:
FinSettingsRow(
  title: 'Biometrics',
  icon: CupertinoIcons.lock,
  iconBgColor: colors.success,
  trailing: FinSwitch(value: on, ...),
);''',
            ),

            // ═══════════════════════════════════════
            // SELECTION CONTROLS
            // ═══════════════════════════════════════
            _section('Selection Controls', [
              Row(
                children: [
                  Expanded(
                    child: Text('Biometric Login',
                        style: theme.typography.bodyMedium),
                  ),
                  FinSwitch(
                    value: _switchValue,
                    onChanged: (v) => setState(() => _switchValue = v),
                  ),
                ],
              ),
              const SizedBox(height: FinSpacing.space16),
              FinCheckbox(
                value: _checkboxValue,
                onChanged: (v) => setState(() => _checkboxValue = v),
                label: 'I agree to the Terms of Service',
              ),
              const SizedBox(height: FinSpacing.space12),
              FinRadio<String>(
                value: 'option1',
                groupValue: _radioValue,
                onChanged: (v) => setState(() => _radioValue = v),
                label: 'Bank Transfer',
              ),
              const SizedBox(height: FinSpacing.space8),
              FinRadio<String>(
                value: 'option2',
                groupValue: _radioValue,
                onChanged: (v) => setState(() => _radioValue = v),
                label: 'Credit Card',
              ),
              const SizedBox(height: FinSpacing.space8),
              FinRadio<String>(
                value: 'option3',
                groupValue: _radioValue,
                onChanged: (v) => setState(() => _radioValue = v),
                label: 'E-Wallet',
              ),
            ]),
            const CodeExampleCard(
              title: 'Selection Controls Code',
              code: '''FinSwitch(
  value: isBiometricOn,
  onChanged: (v) => toggle(v),
);

FinCheckbox(
  value: agreed,
  onChanged: (v) => setAgreed(v),
  label: 'I agree to Terms',
);

FinRadio<PaymentMethod>(
  value: PaymentMethod.bankTransfer,
  groupValue: selected,
  onChanged: (v) => setMethod(v),
  label: 'Bank Transfer',
);''',
            ),

            // ═══════════════════════════════════════
            // SEGMENTED CONTROL
            // ═══════════════════════════════════════
            _section('Segmented Control', [
              FinSegmentedControl<int>(
                segments: const {0: 'All', 1: 'Income', 2: 'Expense'},
                groupValue: _segmentValue,
                onValueChanged: (v) => setState(() => _segmentValue = v),
              ),
            ]),
            const CodeExampleCard(
              title: 'FinSegmentedControl Code',
              code: '''FinSegmentedControl<int>(
  segments: const {
    0: 'All',
    1: 'Income',
    2: 'Expense',
  },
  groupValue: selectedIndex,
  onValueChanged: (v) => setFilter(v),
);''',
            ),

            // ═══════════════════════════════════════
            // FEEDBACK
            // ═══════════════════════════════════════
            _section('Feedback — Toasts', [
              FinButton(
                label: '✅ Success Toast',
                variant: FinButtonVariant.secondary,
                expand: true,
                onPressed: () => FinToast.show(
                  context: context,
                  message: 'Transfer completed successfully!',
                  variant: FinToastVariant.success,
                ),
              ),
              const SizedBox(height: FinSpacing.space8),
              FinButton(
                label: '❌ Error Toast with Retry',
                variant: FinButtonVariant.secondary,
                expand: true,
                onPressed: () => FinToast.show(
                  context: context,
                  message: 'Transaction failed. Please try again.',
                  variant: FinToastVariant.error,
                  actionLabel: 'Retry',
                  onAction: () {},
                ),
              ),
              const SizedBox(height: FinSpacing.space8),
              FinButton(
                label: 'ℹ️ Info Toast',
                variant: FinButtonVariant.secondary,
                expand: true,
                onPressed: () => FinToast.show(
                  context: context,
                  message: 'New feature: Instant transfers now available.',
                  variant: FinToastVariant.info,
                ),
              ),
            ]),
            const CodeExampleCard(
              title: 'FinToast Code',
              code: '''FinToast.show(
  context: context,
  message: 'Transfer completed!',
  variant: FinToastVariant.success,
  actionLabel: 'View',     // optional
  onAction: () => goToReceipt(),
  duration: Duration(seconds: 3),
);

// Variants: success, error, warning, info''',
            ),

            _section('Feedback — Banner & Inline', [
              const FinBanner(
                message: 'System maintenance tonight at 11 PM.',
                variant: FinBannerVariant.info,
              ),
              const SizedBox(height: FinSpacing.space12),
              const FinBanner(
                message: 'Your session will expire in 5 minutes.',
                variant: FinBannerVariant.warning,
                actionLabel: 'Extend',
              ),
              const SizedBox(height: FinSpacing.space16),
              const FinInlineMessage(
                title: 'Daily Limit',
                message: 'Your daily transfer limit is \$50,000.',
                variant: FinInlineMessageVariant.info,
              ),
              const SizedBox(height: FinSpacing.space12),
              const FinInlineMessage(
                message: 'Amount exceeds your available balance.',
                variant: FinInlineMessageVariant.warning,
              ),
            ]),
            const CodeExampleCard(
              title: 'Banner & Inline Code',
              code: '''FinBanner(
  message: 'Scheduled maintenance tonight.',
  variant: FinBannerVariant.info,
  actionLabel: 'Learn More',
  onAction: () => showDetails(),
  onDismiss: () => hideBanner(),
);

FinInlineMessage(
  title: 'Transfer Limit',
  message: 'Max \$50,000 per day.',
  variant: FinInlineMessageVariant.warning,
  actionLabel: 'Increase',
  onAction: () => requestHigherLimit(),
);''',
            ),

            // ═══════════════════════════════════════
            // DIALOGS
            // ═══════════════════════════════════════
            _section('Dialogs & Sheets', [
              FinButton(
                label: 'Alert Dialog',
                variant: FinButtonVariant.secondary,
                expand: true,
                onPressed: () => FinDialog.show(
                  context: context,
                  title: 'Confirm Transfer',
                  message: 'Send \$1,000 to John Doe?',
                  primaryAction: const FinDialogAction(label: 'Transfer'),
                  secondaryAction: const FinDialogAction(label: 'Cancel'),
                ),
              ),
              const SizedBox(height: FinSpacing.space12),
              FinButton(
                label: 'Confirmation Dialog',
                variant: FinButtonVariant.secondary,
                expand: true,
                onPressed: () async {
                  final confirmed = await FinDialog.confirm(
                    context: context,
                    title: 'Delete Account?',
                    message: 'This action cannot be undone.',
                    confirmLabel: 'Delete',
                    isDestructive: true,
                  );
                  if (confirmed == true && context.mounted) {
                    FinToast.show(
                      context: context,
                      message: 'Demo: Would delete account',
                      variant: FinToastVariant.info,
                    );
                  }
                },
              ),
              const SizedBox(height: FinSpacing.space12),
              FinButton(
                label: 'Bottom Sheet',
                variant: FinButtonVariant.secondary,
                expand: true,
                onPressed: () => FinBottomSheet.show(
                  context: context,
                  child: Padding(
                    padding: const EdgeInsets.all(FinSpacing.space24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Transfer Details',
                            style: theme.typography.titleMedium),
                        const SizedBox(height: FinSpacing.space16),
                        Text('\$1,000.00',
                            style: theme.typography.monoLarge),
                        const SizedBox(height: FinSpacing.space24),
                        FinButton(
                          label: 'Confirm Transfer',
                          expand: true,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: FinSpacing.space12),
              FinButton(
                label: 'Action Sheet',
                variant: FinButtonVariant.secondary,
                expand: true,
                onPressed: () => FinActionSheet.show(
                  context: context,
                  title: 'Transaction Options',
                  actions: [
                    FinActionSheetItem(label: 'Copy Reference', onPressed: () {}),
                    FinActionSheetItem(label: 'Share Receipt', onPressed: () {}),
                    FinActionSheetItem(
                      label: 'Report Issue',
                      isDestructive: true,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ]),
            const CodeExampleCard(
              title: 'Dialog & Sheet Code',
              code: '''// Alert dialog
await FinDialog.show(
  context: context,
  title: 'Confirm Transfer',
  message: 'Send \$1,000 to John?',
  primaryAction: FinDialogAction(label: 'Send'),
  secondaryAction: FinDialogAction(label: 'Cancel'),
);

// Confirmation (returns bool)
final ok = await FinDialog.confirm(
  context: context,
  title: 'Delete?',
  isDestructive: true,
);

// Bottom sheet
FinBottomSheet.show(
  context: context,
  child: MyContent(),
);

// Action sheet
FinActionSheet.show(
  context: context,
  title: 'Options',
  actions: [
    FinActionSheetItem(
      label: 'Share', onPressed: () {},
    ),
  ],
);''',
            ),

            // ═══════════════════════════════════════
            // LOADING
            // ═══════════════════════════════════════
            _section('Loading States', [
              FinSkeletonLayouts.transactionItem(),
              FinSkeletonLayouts.transactionItem(),
              const SizedBox(height: FinSpacing.space16),
              FinSkeletonLayouts.balanceCard(),
            ]),
            const CodeExampleCard(
              title: 'FinSkeleton Code',
              code: '''// Individual shapes
FinSkeleton(
  type: FinSkeletonType.text,
  width: 200, height: 16,
);
FinSkeleton(
  type: FinSkeletonType.circle,
  width: 40, height: 40,
);

// Pre-composed layouts
FinSkeletonLayouts.transactionItem();
FinSkeletonLayouts.balanceCard();''',
            ),

            // ═══════════════════════════════════════
            // NAVIGATION BAR
            // ═══════════════════════════════════════
            _section('Navigation Bar', [
              // Compact nav bar preview
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(FinRadius.radiusSM),
                  border: Border.all(color: colors.borderSubtle, width: 0.5),
                ),
                child: Column(
                  children: [
                    FinNavigationBar(
                      title: _navBarTitle,
                      leading: GestureDetector(
                        onTap: () {
                          setState(() {
                            _navBarTitle = _navBarTitle == 'Transactions'
                                ? 'Home'
                                : 'Transactions';
                          });
                          FinToast.show(
                            context: context,
                            message: 'Navigated back to $_navBarTitle',
                            variant: FinToastVariant.info,
                          );
                        },
                        child: Icon(CupertinoIcons.back,
                            color: colors.accentPrimary, size: FinIconSize.md),
                      ),
                      trailing: GestureDetector(
                        onTap: () => FinToast.show(
                          context: context,
                          message: 'Notifications tapped',
                          variant: FinToastVariant.info,
                        ),
                        child: Icon(CupertinoIcons.bell,
                            color: colors.accentPrimary, size: FinIconSize.md),
                      ),
                    ),
                    Container(
                      height: 60,
                      color: colors.bgSecondary,
                      child: Center(
                        child: Text('$_navBarTitle Content',
                            style: theme.typography.caption
                                .copyWith(color: colors.textTertiary)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: FinSpacing.space16),
              // Nav bar with search
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(FinRadius.radiusSM),
                  border: Border.all(color: colors.borderSubtle, width: 0.5),
                ),
                child: Column(
                  children: [
                    FinNavigationBar(
                      title: 'Home',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => FinToast.show(
                              context: context,
                              message: 'Search tapped',
                              variant: FinToastVariant.info,
                            ),
                            child: Icon(CupertinoIcons.search,
                                color: colors.accentPrimary, size: FinIconSize.sm),
                          ),
                          const SizedBox(width: FinSpacing.space16),
                          GestureDetector(
                            onTap: () => FinToast.show(
                              context: context,
                              message: 'More options tapped',
                              variant: FinToastVariant.info,
                            ),
                            child: Icon(CupertinoIcons.ellipsis_circle,
                                color: colors.accentPrimary, size: FinIconSize.sm),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      color: colors.bgSecondary,
                      child: Center(
                        child: Text('Page Content',
                            style: theme.typography.caption
                                .copyWith(color: colors.textTertiary)),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            const CodeExampleCard(
              title: 'FinNavigationBar Code',
              code: '''// Compact navigation bar
CupertinoPageScaffold(
  navigationBar: FinNavigationBar(
    title: 'Transactions',
    leading: Icon(CupertinoIcons.back),
    trailing: Icon(CupertinoIcons.bell),
    previousPageTitle: 'Home',
  ),
  child: content,
);

// Large-title (sliver-based)
CustomScrollView(
  slivers: [
    FinSliverNavigationBar(
      largeTitle: 'Home',
      trailing: Icon(CupertinoIcons.bell),
    ),
    SliverList(...),
  ],
);''',
            ),

            // ═══════════════════════════════════════
            // BOTTOM TAB BAR
            // ═══════════════════════════════════════
            _section('Bottom Tab Bar', [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(FinRadius.radiusSM),
                  border: Border.all(color: colors.borderSubtle, width: 0.5),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      color: colors.bgSecondary,
                      child: Center(
                        child: Text(
                            const ['Home', 'Transactions', 'Reports', 'Profile'][_tabBarIndex],
                            style: theme.typography.bodyLarge
                                .copyWith(color: colors.textSecondary)),
                      ),
                    ),
                    FinBottomTabBar(
                      items: const [
                        FinTabBarItem(
                          icon: CupertinoIcons.house,
                          activeIcon: CupertinoIcons.house_fill,
                          label: 'Home',
                        ),
                        FinTabBarItem(
                          icon: CupertinoIcons.arrow_right_arrow_left,
                          label: 'Transactions',
                        ),
                        FinTabBarItem(
                          icon: CupertinoIcons.chart_bar,
                          activeIcon: CupertinoIcons.chart_bar_fill,
                          label: 'Reports',
                        ),
                        FinTabBarItem(
                          icon: CupertinoIcons.person,
                          activeIcon: CupertinoIcons.person_fill,
                          label: 'Profile',
                        ),
                      ],
                      currentIndex: _tabBarIndex,
                      onTap: (i) => setState(() => _tabBarIndex = i),
                    ),
                  ],
                ),
              ),
            ]),
            const CodeExampleCard(
              title: 'FinBottomTabBar Code',
              code: '''FinBottomTabBar(
  items: [
    FinTabBarItem(
      icon: CupertinoIcons.house,
      activeIcon: CupertinoIcons.house_fill,
      label: 'Home',
    ),
    FinTabBarItem(
      icon: CupertinoIcons.arrow_right_arrow_left,
      label: 'Transactions',
    ),
    FinTabBarItem(
      icon: CupertinoIcons.person,
      activeIcon: CupertinoIcons.person_fill,
      label: 'Profile',
    ),
  ],
  currentIndex: selectedTab,
  onTap: (index) => setTab(index),
);''',
            ),

            // ═══════════════════════════════════════
            // DROPDOWN
            // ═══════════════════════════════════════
            _section('Dropdown', [
              FinDropdown<String>(
                label: 'Account Type',
                placeholder: 'Select account...',
                items: const [
                  FinDropdownItem(value: 'savings', label: 'Savings Account', icon: CupertinoIcons.money_dollar),
                  FinDropdownItem(value: 'checking', label: 'Checking Account', icon: CupertinoIcons.creditcard),
                  FinDropdownItem(value: 'investment', label: 'Investment Account', icon: CupertinoIcons.chart_bar),
                  FinDropdownItem(value: 'crypto', label: 'Crypto Wallet', icon: CupertinoIcons.bitcoin_circle),
                ],
                selectedValue: _dropdownValue,
                onChanged: (v) => setState(() => _dropdownValue = v),
              ),
              const SizedBox(height: FinSpacing.space16),
              const FinDropdown<String>(
                label: 'Disabled Dropdown',
                placeholder: 'Not available',
                items: [],
                selectedValue: null,
                onChanged: null,
                isDisabled: true,
              ),
            ]),
            const CodeExampleCard(
              title: 'FinDropdown Code',
              code: '''FinDropdown<String>(
  label: 'Account Type',
  placeholder: 'Select account...',
  items: [
    FinDropdownItem(
      value: 'savings',
      label: 'Savings Account',
      icon: CupertinoIcons.money_dollar,
    ),
    FinDropdownItem(
      value: 'checking',
      label: 'Checking Account',
    ),
  ],
  selectedValue: selected,
  onChanged: (v) => setAccount(v),
);''',
            ),

            // ═══════════════════════════════════════
            // AVATAR
            // ═══════════════════════════════════════
            _section('Avatar', [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const FinAvatar(
                        initials: 'JD',
                        size: FinAvatarSize.small,
                      ),
                      const SizedBox(height: FinSpacing.space4),
                      Text('Small', style: theme.typography.caption.copyWith(color: colors.textTertiary)),
                    ],
                  ),
                  Column(
                    children: [
                      const FinAvatar(
                        initials: 'AB',
                        size: FinAvatarSize.medium,
                        status: FinAvatarStatus.online,
                      ),
                      const SizedBox(height: FinSpacing.space4),
                      Text('Medium', style: theme.typography.caption.copyWith(color: colors.textTertiary)),
                    ],
                  ),
                  Column(
                    children: [
                      const FinAvatar(
                        initials: 'VT',
                        size: FinAvatarSize.large,
                        status: FinAvatarStatus.busy,
                      ),
                      const SizedBox(height: FinSpacing.space4),
                      Text('Large', style: theme.typography.caption.copyWith(color: colors.textTertiary)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: FinSpacing.space16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      FinAvatar(
                        imageUrl: 'https://i.pravatar.cc/150?img=1',
                        size: FinAvatarSize.medium,
                        status: FinAvatarStatus.online,
                        onTap: () => FinToast.show(
                          context: context,
                          message: 'Avatar tapped!',
                          variant: FinToastVariant.info,
                        ),
                      ),
                      const SizedBox(height: FinSpacing.space4),
                      Text('Image', style: theme.typography.caption.copyWith(color: colors.textTertiary)),
                    ],
                  ),
                  Column(
                    children: [
                      const FinAvatar(
                        initials: 'VN',
                        size: FinAvatarSize.medium,
                        status: FinAvatarStatus.offline,
                      ),
                      const SizedBox(height: FinSpacing.space4),
                      Text('Offline', style: theme.typography.caption.copyWith(color: colors.textTertiary)),
                    ],
                  ),
                  Column(
                    children: [
                      const FinAvatar(
                        size: FinAvatarSize.medium,
                      ),
                      const SizedBox(height: FinSpacing.space4),
                      Text('Fallback', style: theme.typography.caption.copyWith(color: colors.textTertiary)),
                    ],
                  ),
                ],
              ),
            ]),
            const CodeExampleCard(
              title: 'FinAvatar Code',
              code: '''// Initials avatar
FinAvatar(
  initials: 'JD',
  size: FinAvatarSize.medium,
  status: FinAvatarStatus.online,
);

// Image avatar
FinAvatar(
  imageUrl: 'https://example.com/photo.jpg',
  size: FinAvatarSize.large,
  onTap: () => viewProfile(),
);

// Sizes: small (28), medium (40), large (56)
// Status: online, offline, busy''',
            ),

            const SizedBox(height: FinSpacing.space48),
          ],
        ),
      ),
    );
  }

  Widget _iconContainer(IconData icon, FinSemanticColors colors) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: colors.accentPrimary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: FinIconSize.sm, color: colors.accentPrimary),
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
