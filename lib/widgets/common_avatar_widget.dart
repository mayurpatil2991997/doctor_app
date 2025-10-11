import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Themes/app_colors_theme.dart';
import '../Themes/app_text_theme.dart';

class CommonAvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? size;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showStatusDot;
  final Color? statusColor;
  final VoidCallback? onTap;

  const CommonAvatarWidget({
    Key? key,
    this.imageUrl,
    this.name,
    this.size,
    this.backgroundColor,
    this.textColor,
    this.showStatusDot = false,
    this.statusColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? 60.0;
    final bgColor = backgroundColor ?? AppColor.primaryColor;
    final txtColor = textColor ?? AppColor.whiteColor;

    Widget avatarContent = Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor.withOpacity(0.1),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildTextAvatar(name ?? "A", bgColor, txtColor);
                },
              )
            : _buildTextAvatar(name ?? "A", bgColor, txtColor),
      ),
    );

    if (showStatusDot && statusColor != null) {
      avatarContent = Stack(
        children: [
          avatarContent,
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: avatarContent,
      );
    }

    return avatarContent;
  }

  Widget _buildTextAvatar(String name, Color bgColor, Color txtColor) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            bgColor,
            bgColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : "A",
          style: AppTextStyle.boldText.copyWith(
            color: txtColor,
            fontSize: size != null ? (size! * 0.3) : 20,
          ),
        ),
      ),
    );
  }
}

class SmallAvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? size;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;

  const SmallAvatarWidget({
    Key? key,
    this.imageUrl,
    this.name,
    this.size,
    this.backgroundColor,
    this.textColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? 40.0;
    final bgColor = backgroundColor ?? AppColor.primaryColor;
    final txtColor = textColor ?? AppColor.whiteColor;

    Widget avatarContent = Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor.withOpacity(0.1),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildTextAvatar(name ?? "A", bgColor, txtColor);
                },
              )
            : _buildTextAvatar(name ?? "A", bgColor, txtColor),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: avatarContent,
      );
    }

    return avatarContent;
  }

  Widget _buildTextAvatar(String name, Color bgColor, Color txtColor) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            bgColor,
            bgColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : "A",
          style: AppTextStyle.boldText.copyWith(
            color: txtColor,
            fontSize: size != null ? (size! * 0.3) : 16,
          ),
        ),
      ),
    );
  }
}

class CircularIconWidget extends StatelessWidget {
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;
  final VoidCallback? onTap;

  const CircularIconWidget({
    Key? key,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? 8.w;
    final bgColor = backgroundColor ?? AppColor.primaryColor.withOpacity(0.1);
    final icColor = iconColor ?? AppColor.primaryColor;

    Widget iconContent = Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: icColor,
        size: iconSize * 0.5,
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: iconContent,
      );
    }

    return iconContent;
  }
}
