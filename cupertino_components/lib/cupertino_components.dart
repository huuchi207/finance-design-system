/// Cupertino-first component library for the Finance Design System.
///
/// All components read visual properties from [FinanceTheme] tokens —
/// no hard-coded colors or sizes. Every interactive component supports
/// disabled, loading, and error states.
///
/// Usage:
/// ```dart
/// import 'package:cupertino_components/cupertino_components.dart';
///
/// FinButton(
///   label: 'Transfer',
///   variant: FinButtonVariant.primary,
///   onPressed: () => doTransfer(),
/// )
/// ```
library cupertino_components;

export 'src/buttons/fin_button.dart';
export 'src/text_fields/fin_text_field.dart';
export 'src/list_cells/fin_list_cell.dart';
export 'src/selection/fin_switch.dart';
export 'src/navigation/fin_segmented_control.dart';
export 'src/navigation/fin_navigation_bar.dart';
export 'src/navigation/fin_bottom_tab_bar.dart';
export 'src/dialogs/fin_dialog.dart';
export 'src/dialogs/fin_bottom_sheet.dart';
export 'src/dialogs/fin_action_sheet.dart';
export 'src/feedback/fin_toast.dart';
export 'src/feedback/fin_banner.dart';
export 'src/feedback/fin_inline_message.dart';
export 'src/loading/fin_skeleton.dart';
