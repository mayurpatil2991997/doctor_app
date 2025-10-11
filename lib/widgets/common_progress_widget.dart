import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Themes/app_colors_theme.dart';
import '../Themes/app_text_theme.dart';
import 'common_stat_widget.dart';

class CommonProgressBarWidget extends StatelessWidget {
  final double progress;
  final double height;
  final Color? backgroundColor;
  final Color? progressColor;
  final BorderRadius? borderRadius;
  final String? label;
  final String? value;

  const CommonProgressBarWidget({
    Key? key,
    required this.progress,
    this.height = 8.0,
    this.backgroundColor,
    this.progressColor,
    this.borderRadius,
    this.label,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Colors.grey.withOpacity(0.3);
    final progColor = progressColor ?? AppColor.primaryColor;
    final borderRad = borderRadius ?? BorderRadius.circular(4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || value != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: AppTextStyle.mediumText.copyWith(
                    fontSize: 12,
                    color: AppColor.greyColor,
                  ),
                ),
              if (value != null)
                Text(
                  value!,
                  style: AppTextStyle.boldText.copyWith(
                    fontSize: 12,
                    color: AppColor.blackColor,
                  ),
                ),
            ],
          ),
          SizedBox(height: 0.5.h),
        ],
        Container(
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: borderRad,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: progColor,
                borderRadius: borderRad,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EnhancedDayBarWidget extends StatelessWidget {
  final String day;
  final double height;
  final Color color;
  final String duration;
  final Function(String day, String duration, Color color)? onTap;

  const EnhancedDayBarWidget({
    Key? key,
    required this.day,
    required this.height,
    required this.color,
    required this.duration,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget dayBarContent = Column(
      children: [
        // Day label
        Text(
          day,
          style: AppTextStyle.mediumText.copyWith(
            fontSize: 10,
            color: AppColor.greyColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 0.5.h),
        // Progress bar with gradient
        Container(
          width: 5.w,
          height: 5.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: height > 0 
                ? LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  )
                : null,
            color: height > 0 ? null : Colors.grey.withOpacity(0.3),
          ),
          child: height > 0 
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.7)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                )
              : null,
        ),
        SizedBox(height: 0.5.h),
        // Duration
        Text(
          duration,
          style: AppTextStyle.mediumText.copyWith(
            fontSize: 8,
            color: height > 0 ? color : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Completion indicator
        SizedBox(height: 0.3.h),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: height > 0.5 ? Colors.green : height > 0 ? Colors.orange : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: () => onTap!(day, duration, color),
        child: dayBarContent,
      );
    }

    return dayBarContent;
  }
}

class WeeklyProgressChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> weekData;
  final Function(String day, String duration, Color color)? onDayTap;

  const WeeklyProgressChartWidget({
    Key? key,
    required this.weekData,
    this.onDayTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor.withOpacity(0.05),
            AppColor.primaryColor.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.primaryColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Weekly Progress",
                style: AppTextStyle.boldText.copyWith(
                  fontSize: 13,
                  color: AppColor.blackColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "5/7 days",
                  style: AppTextStyle.mediumText.copyWith(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekData.map((dayData) {
              return EnhancedDayBarWidget(
                day: dayData['day'],
                height: dayData['height'],
                color: dayData['color'],
                duration: dayData['duration'],
                onTap: onDayTap,
              );
            }).toList(),
          ),
          SizedBox(height: 1.h),
          // Progress summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProgressSummaryWidget(
                title: "Total Time",
                value: "2h 32m",
                color: Colors.blue,
              ),
              ProgressSummaryWidget(
                title: "Avg/Day",
                value: "22 min",
                color: Colors.green,
              ),
              ProgressSummaryWidget(
                title: "Streak",
                value: "3 days",
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
