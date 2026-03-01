import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:design_tokens/design_tokens.dart';

/// A collapsible card showing Dart source code for a component.
///
/// Tap to expand/collapse. Tap the copy button to copy code to clipboard.
class CodeExampleCard extends StatefulWidget {
  const CodeExampleCard({
    super.key,
    required this.title,
    required this.code,
    this.initiallyExpanded = false,
  });

  final String title;
  final String code;
  final bool initiallyExpanded;

  @override
  State<CodeExampleCard> createState() => _CodeExampleCardState();
}

class _CodeExampleCardState extends State<CodeExampleCard>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final typo = theme.typography;

    return Container(
      margin: const EdgeInsets.only(
        top: FinSpacing.space8,
        bottom: FinSpacing.space16,
      ),
      decoration: BoxDecoration(
        color: colors.bgTertiary,
        borderRadius: BorderRadius.circular(FinRadius.radiusSM),
        border: Border.all(color: colors.borderSubtle, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header — tap to toggle
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: FinSpacing.space12,
                vertical: FinSpacing.space8,
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.chevron_left_slash_chevron_right,
                    size: FinIconSize.xs,
                    color: colors.accentPrimary,
                  ),
                  const SizedBox(width: FinSpacing.space8),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: typo.labelSmall.copyWith(
                        color: colors.accentPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (_isExpanded)
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.code));
                      },
                      child: Icon(
                        CupertinoIcons.doc_on_clipboard,
                        size: FinIconSize.xs,
                        color: colors.textTertiary,
                      ),
                    ),
                  const SizedBox(width: FinSpacing.space8),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.25 : 0,
                    duration: FinMotion.durationFast,
                    child: Icon(
                      CupertinoIcons.chevron_right,
                      size: 12,
                      color: colors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Code block — collapsible
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                FinSpacing.space12,
                0,
                FinSpacing.space12,
                FinSpacing.space12,
              ),
              child: Text(
                widget.code,
                style: typo.monoSmall.copyWith(
                  color: colors.textSecondary,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: FinMotion.durationFast,
          ),
        ],
      ),
    );
  }
}
