import 'package:flutter/material.dart';

import '../Themes/app_colors_theme.dart';
import '../Themes/app_text_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final List<Widget> actions;

  CustomAppBar({
    required this.title,
    this.leading,
    this.automaticallyImplyLeading = false,
    required this.actions,
    required this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: AppColor.primaryColor,
      ),
      title: Text(
          title,
         style: AppTextStyle.boldText.copyWith(
           fontSize: 20,
           color: AppColor.primaryColor
         ),
      ),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: AppColor.whiteColor,
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
