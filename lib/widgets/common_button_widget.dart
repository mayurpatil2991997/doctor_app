import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Themes/app_colors_theme.dart';
import '../Themes/app_text_theme.dart';

class CommonButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final IconData? icon;
  final bool isLoading;
  final bool isOutlined;
  final EdgeInsetsGeometry? padding;

  const CommonButtonWidget({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.borderRadius,
    this.icon,
    this.isLoading = false,
    this.isOutlined = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColor.primaryColor;
    final txtColor = textColor ?? AppColor.whiteColor;
    final btnHeight = height ?? 45.0;
    final btnWidth = width ?? double.infinity;
    final borderRad = borderRadius ?? 8.0;

    Widget buttonContent = Container(
      height: btnHeight,
      width: btnWidth,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRad),
            side: isOutlined 
                ? BorderSide(color: bgColor, width: 1.5)
                : BorderSide.none,
          ),
          elevation: 0,
          padding: padding,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(txtColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: isOutlined ? bgColor : txtColor,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: AppTextStyle.mediumText.copyWith(
                      color: isOutlined ? bgColor : txtColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
      ),
    );

    return buttonContent;
  }
}

class CompactButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final IconData? icon;
  final bool isLoading;

  const CompactButtonWidget({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.borderRadius,
    this.icon,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColor.primaryColor;
    final txtColor = textColor ?? AppColor.whiteColor;
    final btnHeight = height ?? 35.0;
    final btnWidth = width ?? double.infinity;
    final borderRad = borderRadius ?? 6.0;

    Widget buttonContent = Container(
      height: btnHeight,
      width: btnWidth,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRad),
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        ),
        child: isLoading
            ? SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(txtColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: txtColor,
                      size: 16,
                    ),
                    SizedBox(width: 6),
                  ],
                  Text(
                    text,
                    style: AppTextStyle.mediumText.copyWith(
                      color: txtColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
      ),
    );

    return buttonContent;
  }
}

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;
  final double? borderRadius;
  final bool isCircular;

  const IconButtonWidget({
    Key? key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.borderRadius,
    this.isCircular = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColor.primaryColor;
    final icColor = iconColor ?? AppColor.whiteColor;
    final btnSize = size ?? 36.0;
    final borderRad = borderRadius ?? (isCircular ? btnSize / 2 : 8.0);

    return Container(
      width: btnSize,
      height: btnSize,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: isCircular
              ? CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRad),
                ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Icon(
          icon,
          color: icColor,
          size: btnSize * 0.5,
        ),
      ),
    );
  }
}

class FloatingActionButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? tooltip;

  const FloatingActionButtonWidget({
    Key? key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColor.primaryColor;
    final icColor = iconColor ?? AppColor.whiteColor;

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: bgColor,
      tooltip: tooltip,
      child: Icon(
        icon,
        color: icColor,
      ),
    );
  }
}
