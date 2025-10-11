import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Themes/app_colors_theme.dart';
import '../Themes/app_text_theme.dart';

class CommonTabWidget extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;
  final bool isScrollable;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? indicatorColor;

  const CommonTabWidget({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.isScrollable = false,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selColor = selectedColor ?? AppColor.primaryColor;
    final unselColor = unselectedColor ?? AppColor.greyColor;
    final indColor = indicatorColor ?? AppColor.primaryColor;

    if (isScrollable) {
      return Container(
        height: 5.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tabs.length,
          itemBuilder: (context, index) {
            return _buildTabItem(
              tabs[index],
              index,
              selColor,
              unselColor,
              indColor,
            );
          },
        ),
      );
    }

    return Row(
      children: tabs.asMap().entries.map((entry) {
        int index = entry.key;
        String tab = entry.value;
        return Expanded(
          child: _buildTabItem(
            tab,
            index,
            selColor,
            unselColor,
            indColor,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTabItem(
    String tab,
    int index,
    Color selectedColor,
    Color unselectedColor,
    Color indicatorColor,
  ) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Column(
          children: [
            Text(
              tab,
              style: AppTextStyle.mediumText.copyWith(
                color: isSelected ? selectedColor : unselectedColor,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            SizedBox(height: 0.8.h),
            Container(
              width: 8.w,
              height: 3,
              decoration: BoxDecoration(
                color: isSelected ? indicatorColor : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChipTabWidget extends StatelessWidget {
  final List<String> chips;
  final String selectedChip;
  final Function(String) onChipSelected;
  final bool isScrollable;
  final Color? selectedColor;
  final Color? unselectedColor;

  const ChipTabWidget({
    Key? key,
    required this.chips,
    required this.selectedChip,
    required this.onChipSelected,
    this.isScrollable = true,
    this.selectedColor,
    this.unselectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selColor = selectedColor ?? AppColor.primaryColor;
    final unselColor = unselectedColor ?? AppColor.companyUpdateColor1;

    if (isScrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: chips.map((chip) {
            return Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: _buildChip(chip, selColor, unselColor),
            );
          }).toList(),
        ),
      );
    }

    return Row(
      children: chips.map((chip) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: _buildChip(chip, selColor, unselColor),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChip(String chip, Color selectedColor, Color unselectedColor) {
    bool isSelected = selectedChip == chip;

    return GestureDetector(
      onTap: () => onChipSelected(chip),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? selectedColor : AppColor.greyColor.withOpacity(0.3),
          ),
        ),
        child: Text(
          chip,
          style: AppTextStyle.mediumText.copyWith(
            color: isSelected ? AppColor.whiteColor : AppColor.blackColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class WeekTabWidget extends StatelessWidget {
  final List<String> days;
  final int selectedDayIndex;
  final Function(int) onDaySelected;

  const WeekTabWidget({
    Key? key,
    required this.days,
    required this.selectedDayIndex,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: days.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          final isSelected = selectedDayIndex == index;

          return GestureDetector(
            onTap: () => onDaySelected(index),
            child: Column(
              children: [
                Text(
                  label,
                  style: AppTextStyle.mediumText.copyWith(
                    color: isSelected ? AppColor.primaryColor : Colors.grey,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 0.8.h),
                Container(
                  width: 8.w,
                  height: 3,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
