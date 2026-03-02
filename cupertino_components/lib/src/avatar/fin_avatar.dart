import 'package:flutter/cupertino.dart';
import 'package:design_tokens/design_tokens.dart';

/// Avatar sizes.
enum FinAvatarSize {
  /// 28×28
  small(28),

  /// 40×40
  medium(40),

  /// 56×56
  large(56);

  const FinAvatarSize(this.dimension);
  final double dimension;
}

/// Optional status indicator for the avatar.
enum FinAvatarStatus {
  /// Green dot — user is online.
  online,

  /// Gray dot — user is offline.
  offline,

  /// Red dot — do not disturb.
  busy,
}

/// A token-driven avatar widget for the Finance Design System.
///
/// Supports image URLs, initials fallback, and an optional
/// status indicator (online/offline/busy).
///
/// ```dart
/// FinAvatar(
///   initials: 'JD',
///   size: FinAvatarSize.medium,
///   status: FinAvatarStatus.online,
/// )
///
/// FinAvatar(
///   imageUrl: 'https://example.com/photo.jpg',
///   size: FinAvatarSize.large,
/// )
/// ```
class FinAvatar extends StatelessWidget {
  const FinAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = FinAvatarSize.medium,
    this.status,
    this.backgroundColor,
    this.onTap,
    this.semanticsLabel,
  });

  /// URL for the avatar image. Takes priority over [initials].
  final String? imageUrl;

  /// Initials to display when no image is provided (1-2 characters).
  final String? initials;

  /// Size of the avatar.
  final FinAvatarSize size;

  /// Optional status indicator dot.
  final FinAvatarStatus? status;

  /// Override background color. Defaults to brand accent.
  final Color? backgroundColor;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Accessibility label.
  final String? semanticsLabel;

  double get _fontSize {
    switch (size) {
      case FinAvatarSize.small:
        return 11;
      case FinAvatarSize.medium:
        return 15;
      case FinAvatarSize.large:
        return 21;
    }
  }

  double get _statusDotSize {
    switch (size) {
      case FinAvatarSize.small:
        return 8;
      case FinAvatarSize.medium:
        return 10;
      case FinAvatarSize.large:
        return 14;
    }
  }

  Color _statusColor(FinSemanticColors colors) {
    switch (status!) {
      case FinAvatarStatus.online:
        return colors.success;
      case FinAvatarStatus.offline:
        return colors.textTertiary;
      case FinAvatarStatus.busy:
        return colors.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FinanceTheme.of(context);
    final colors = theme.colors;
    final dim = size.dimension;
    final bgColor = backgroundColor ?? colors.accentPrimary;

    Widget avatar = Container(
      width: dim,
      height: dim,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        border: Border.all(
          color: colors.borderSubtle,
          width: 0.5,
        ),
      ),
      child: _buildContent(colors),
    );

    if (status != null) {
      final dotSize = _statusDotSize;
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _statusColor(colors),
                border: Border.all(
                  color: colors.bgPrimary,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    return Semantics(
      label: semanticsLabel ?? initials,
      image: imageUrl != null,
      button: onTap != null,
      child: avatar,
    );
  }

  Widget _buildContent(FinSemanticColors colors) {
    if (imageUrl != null) {
      return ClipOval(
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          width: size.dimension,
          height: size.dimension,
          errorBuilder: (_, __, ___) => _buildInitials(colors),
        ),
      );
    }
    return _buildInitials(colors);
  }

  Widget _buildInitials(FinSemanticColors colors) {
    final text = (initials ?? '?').toUpperCase();
    return Center(
      child: Text(
        text.length > 2 ? text.substring(0, 2) : text,
        style: TextStyle(
          color: colors.textOnAccent,
          fontSize: _fontSize,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
