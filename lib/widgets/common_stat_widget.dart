import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Themes/app_colors_theme.dart';
import '../Themes/app_text_theme.dart';

class CommonStatWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const CommonStatWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget statContent = Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 4.w,
          ),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: AppTextStyle.boldText.copyWith(
              fontSize: 14,
              color: color,
            ),
          ),
          Text(
            title,
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 10,
              color: AppColor.greyColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: statContent,
      );
    }

    return statContent;
  }
}

class CompactStatWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const CompactStatWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget statContent = Container(
      padding: EdgeInsets.all(1.5.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 3.w,
          ),
          SizedBox(height: 0.3.h),
          Text(
            value,
            style: AppTextStyle.boldText.copyWith(
              fontSize: 12,
              color: color,
            ),
          ),
          Text(
            title,
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 9,
              color: AppColor.greyColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: statContent,
      );
    }

    return statContent;
  }
}

class ProgressSummaryWidget extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const ProgressSummaryWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyle.boldText.copyWith(
            fontSize: 12,
            color: color,
          ),
        ),
        Text(
          title,
          style: AppTextStyle.mediumText.copyWith(
            fontSize: 9,
            color: AppColor.greyColor,
          ),
        ),
      ],
    );
  }
}
