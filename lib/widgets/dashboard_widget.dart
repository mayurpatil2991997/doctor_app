import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Themes/app_colors_theme.dart';
import '../Themes/app_text_theme.dart';

class DashboardWidget extends StatefulWidget {
  final VoidCallback onTap;
  final String count;
  final String title;
  final IconData icon;
  final Color color;

  const DashboardWidget(
      {super.key,
      required this.onTap,
      required this.count,
      required this.title,
      required this.icon,
      required this.color});

  @override
  State<DashboardWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.all(3),
        height: MediaQuery.sizeOf(context).height * 0.13,
        width: MediaQuery.sizeOf(context).width * 0.45,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icon(widget.icon, color: white, size: 30),
            Text(widget.count,
                style: AppTextStyle.semiBoldText
                    .copyWith(fontSize: 18, color: AppColor.whiteColor)),
            Expanded(
              child: Text(
                  widget.title,
                  style: AppTextStyle.semiBoldText
                      .copyWith(fontSize: 15, color: AppColor.whiteColor)),
            ),
          ],
        ),
      ),
    );
  }
}
