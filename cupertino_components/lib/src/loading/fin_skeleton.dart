import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Skeleton placeholder shape type.
enum FinSkeletonType {
  /// Rectangular block (default)
  rectangle,

  /// Circular shape (avatars, icons)
  circle,

  /// Text line (thin rectangle with rounded ends)
  text,
}

/// Configurable skeleton placeholder for loading states.
///
/// ```dart
/// // Text skeleton
/// FinSkeleton(type: FinSkeletonType.text, width: 200, height: 16)
///
/// // Circle avatar skeleton
/// FinSkeleton(type: FinSkeletonType.circle, width: 40, height: 40)
///
/// // Card skeleton
/// FinSkeleton(width: double.infinity, height: 120)
/// ```
class FinSkeleton extends StatefulWidget {
  const FinSkeleton({
    super.key,
    this.type = FinSkeletonType.rectangle,
    this.width,
    this.height,
    this.borderRadius,
  });

  final FinSkeletonType type;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  State<FinSkeleton> createState() => _FinSkeletonState();
}

class _FinSkeletonState extends State<FinSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: FinMotion.shimmerDuration,
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;

    final resolvedRadius = widget.borderRadius ?? _defaultRadius();
    final resolvedWidth = widget.width ?? _defaultWidth();
    final resolvedHeight = widget.height ?? _defaultHeight();

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: resolvedWidth,
          height: resolvedHeight,
          decoration: BoxDecoration(
            color: colors.bgTertiary.withOpacity(_animation.value),
            borderRadius: widget.type == FinSkeletonType.circle
                ? null
                : BorderRadius.circular(resolvedRadius),
            shape: widget.type == FinSkeletonType.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
          ),
        );
      },
    );
  }

  double _defaultRadius() {
    switch (widget.type) {
      case FinSkeletonType.rectangle:
        return FinRadius.radiusSM;
      case FinSkeletonType.circle:
        return 0;
      case FinSkeletonType.text:
        return FinRadius.radiusXS;
    }
  }

  double _defaultWidth() {
    switch (widget.type) {
      case FinSkeletonType.text:
        return 120;
      case FinSkeletonType.circle:
        return 40;
      case FinSkeletonType.rectangle:
        return double.infinity;
    }
  }

  double _defaultHeight() {
    switch (widget.type) {
      case FinSkeletonType.text:
        return 14;
      case FinSkeletonType.circle:
        return 40;
      case FinSkeletonType.rectangle:
        return 48;
    }
  }
}

/// Pre-composed skeleton layouts for common finance UI patterns.
class FinSkeletonLayouts {
  FinSkeletonLayouts._();

  /// Skeleton for a transaction list item
  static Widget transactionItem() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: FinSpacing.space16,
        vertical: FinSpacing.space12,
      ),
      child: Row(
        children: [
          FinSkeleton(type: FinSkeletonType.circle, width: 40, height: 40),
          SizedBox(width: FinSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FinSkeleton(type: FinSkeletonType.text, width: 140, height: 14),
                SizedBox(height: FinSpacing.space8),
                FinSkeleton(type: FinSkeletonType.text, width: 90, height: 12),
              ],
            ),
          ),
          FinSkeleton(type: FinSkeletonType.text, width: 60, height: 14),
        ],
      ),
    );
  }

  /// Skeleton for a balance card
  static Widget balanceCard() {
    return const Padding(
      padding: EdgeInsets.all(FinSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FinSkeleton(type: FinSkeletonType.text, width: 80, height: 12),
          SizedBox(height: FinSpacing.space12),
          FinSkeleton(type: FinSkeletonType.text, width: 180, height: 28),
          SizedBox(height: FinSpacing.space16),
          Row(
            children: [
              Expanded(child: FinSkeleton(height: 44)),
              SizedBox(width: FinSpacing.space12),
              Expanded(child: FinSkeleton(height: 44)),
            ],
          ),
        ],
      ),
    );
  }
}
