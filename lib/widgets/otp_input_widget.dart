import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Themes/app_colors_theme.dart';
import '../Themes/app_text_theme.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final int index;
  final int otpLength;
  final bool showLine;

  const OtpInput({
    Key? key,
    required this.controller,
    required this.index,
    required this.otpLength,
    this.showLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              autofocus: index == 0,
              maxLength: 1,
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              cursorColor: AppColor.primaryColor,
              style: AppTextStyle.normalText.copyWith(fontSize: 18.0),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  isDense: true,
                  filled: true,
                  fillColor: AppColor.greyColor.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                        color: AppColor.greyColor,
                        strokeAlign: 1
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColor.greyColor,
                        strokeAlign: 1
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColor.greyColor,
                        strokeAlign: 1
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.redColor,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  counterText: ''),
              onChanged: (value) {
                if (value.length == 1) {
                  if (index == 5) {
                    FocusScope.of(context).unfocus();
                  } else {
                    FocusScope.of(context).nextFocus();
                  }
                } else {
                  if (index != 0) {
                    FocusScope.of(context).previousFocus();
                  }
                }
              },
            ),
          ),
          if (showLine)
            Container(
              width: 0.w,
              height: 0.h,
              color: AppColor.blackColor.withOpacity(0.5),
            ),
        ],
      ),
    );
  }
}
