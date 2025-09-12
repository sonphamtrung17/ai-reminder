import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

enum AppButtonType { text, icon, textIcon }

enum AppButtonWidth { wrapContent, matchParent }

/// filled: màu nền, không viền
/// outlined: viền, không màu nền
/// elevated: màu nền, không viền, có đổ bóng
enum AppButtonVariant { filled, outlined, elevated }

class AppButton extends StatelessWidget {
  final AppButtonType type;
  final AppButtonWidth buttonWidth;
  final AppButtonVariant variant;

  final String? text;
  final String? iconPath; // svg hoặc png
  final VoidCallback? onPressed;
  final double? width;
  final double? iconWidth;
  final double? height;
  final double? iconHeight;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? spacing;

  const AppButton._({
    required this.type,
    required this.variant,
    required this.buttonWidth,
    super.key,
    this.text,
    this.iconPath,
    this.onPressed,
    this.width,
    this.iconWidth,
    this.height,
    this.iconHeight,
    this.textStyle,
    this.textAlign,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.borderRadius,
    this.padding,
    this.spacing,
  });

  /// Text button
  factory AppButton.text({
    required String text,
    Key? key,
    VoidCallback? onPressed,
    double? height,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    AppButtonWidth buttonWidth = AppButtonWidth.wrapContent,
    AppButtonVariant variant = AppButtonVariant.filled,
    TextAlign textAlign = TextAlign.center,
  }) {
    return AppButton._(
      key: key,
      type: AppButtonType.text,
      variant: variant,
      buttonWidth: buttonWidth,
      text: text,
      onPressed: onPressed,
      height: height,
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      padding: padding,
      textAlign: textAlign,
    );
  }

  /// Icon button
  factory AppButton.icon({
    required String iconPath,
    Key? key,
    VoidCallback? onPressed,
    double? iconHeight,
    double? iconWidth,
    double? width,
    double? height,
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    AppButtonWidth buttonWidth = AppButtonWidth.wrapContent,
    AppButtonVariant variant = AppButtonVariant.filled,
  }) {
    return AppButton._(
      key: key,
      type: AppButtonType.icon,
      variant: variant,
      buttonWidth: buttonWidth,
      iconPath: iconPath,
      onPressed: onPressed,
      iconHeight: iconHeight,
      iconWidth: iconWidth,
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      iconColor: iconColor,
      borderRadius: borderRadius,
      padding: padding,
    );
  }

  /// Text + Icon button
  factory AppButton.textIcon({
    required String text,
    required String iconPath,
    Key? key,
    VoidCallback? onPressed,
    double? iconHeight,
    double? iconWidth,
    double? width,
    double? height,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double spacing = 8,
    AppButtonWidth buttonWidth = AppButtonWidth.wrapContent,
    AppButtonVariant variant = AppButtonVariant.filled,
  }) {
    return AppButton._(
      key: key,
      type: AppButtonType.textIcon,
      variant: variant,
      buttonWidth: buttonWidth,
      text: text,
      iconPath: iconPath,
      onPressed: onPressed,
      iconHeight: iconHeight,
      iconWidth: iconWidth,
      width: width,
      height: height,
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      iconColor: iconColor,
      borderRadius: borderRadius,
      padding: padding,
      spacing: spacing,
    );
  }

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(12);

    /// Xác định màu nền, border, content theo variant
    final (Color bg, Color border, List<BoxShadow> shadows) = switch (variant) {
      AppButtonVariant.filled => (
        backgroundColor ?? context.color.primary,
        Colors.transparent,
        <BoxShadow>[],
      ),
      AppButtonVariant.outlined => (
        Colors.transparent,
        borderColor ?? context.color.primary,
        <BoxShadow>[],
      ),
      AppButtonVariant.elevated => (
        backgroundColor ?? context.theme.colorScheme.surface,
        borderColor ?? context.color.primary,
        AppColors.buttonShadows,
      ),
    };

    return Container(
      width: _resolveWidth(),
      height: height,
      decoration: BoxDecoration(
        color: bg,
        border: variant == AppButtonVariant.outlined ? Border.all(color: border, width: 1) : null,
        borderRadius: br,
        boxShadow: shadows,
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: br,
        child: InkWell(
          borderRadius: br,
          onTap: onPressed,
          // màu ripple
          splashColor: context.color.black.withValues(alpha: 0.12),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: _buildChild(context),
          ),
        ),
      ),
    );
  }

  double? _resolveWidth() {
    if (buttonWidth == AppButtonWidth.matchParent) {
      return double.infinity;
    }
    return width;
  }

  Widget _buildChild(BuildContext context) {
    switch (type) {
      case AppButtonType.text:
        return Text(
          text ?? '',
          style: textStyle ?? context.textStyle.bodyMMedium,
          textAlign: textAlign,
        );

      case AppButtonType.icon:
        return _buildIcon();

      case AppButtonType.textIcon:
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            SizedBox(width: spacing ?? 8),
            Text(
              text ?? '',
              style: textStyle ?? context.textStyle.bodyMMedium,
            ),
          ],
        );
    }
  }

  Widget _buildIcon() {
    if (iconPath == null) {
      return const SizedBox();
    }
    if (iconPath!.endsWith('.svg')) {
      return SvgPicture.asset(
        iconPath!,
        width: iconWidth,
        height: iconHeight,
        colorFilter: iconColor != null ? ColorFilter.mode(iconColor!, BlendMode.srcIn) : null,
      );
    }
    return Image.asset(iconPath!, width: iconWidth, height: iconHeight, color: iconColor);
  }
}
