import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../widgets/common_card_widget.dart';
import '../../widgets/common_tab_widget.dart';
import 'diet_controller.dart';

class DietScreen extends StatefulWidget {
  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final DietController controller = Get.put(DietController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Diet Plan',
          style: AppTextStyle.boldText.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  'This Week',
                  style: AppTextStyle.boldText.copyWith(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              _buildWeekTabs(),
              SizedBox(height: 2.h),
              _buildMealsList(),
              SizedBox(height: 4.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildWeekTabs() {
    return WeekTabWidget(
      days: controller.days,
      selectedDayIndex: controller.selectedDayIndex.value,
      onDaySelected: controller.selectDay,
    );
  }

  Widget _buildMealsList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: controller.mealsForSelectedDay.map((meal) => _planMealCard(meal)).toList(),
      ),
    );
  }

  Widget _planMealCard(PlanMeal meal) {
    return CommonCardWidget(
      onTap: () => controller.openMealDetail(meal),
      margin: EdgeInsets.only(bottom: 1.5.h),
      padding: EdgeInsets.all(4.w),
      borderRadius: 14,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.type,
                  style: AppTextStyle.mediumText.copyWith(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  meal.title,
                  style: AppTextStyle.boldText.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 0.3.h),
                Text(
                  '${meal.calories} calories',
                  style: AppTextStyle.mediumText.copyWith(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              meal.imageAsset,
              width: 22.w,
              height: 22.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 2.w),
          Icon(Icons.chevron_right, color: Colors.grey[600]),
        ],
      ),
    );
  }
}


