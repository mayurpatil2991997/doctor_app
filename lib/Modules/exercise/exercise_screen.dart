import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import 'exercise_controller.dart';

class ExerciseScreen extends StatefulWidget {
  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final ExerciseController controller = Get.put(ExerciseController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Light gray background
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.person_outline,
              color: AppColor.blackColor,
              size: 24,
            ),
            Text(
              'Home',
              style: AppTextStyle.boldText.copyWith(
                color: AppColor.blackColor,
                fontSize: 20,
              ),
            ),
            Icon(
              Icons.notifications_outlined,
              color: AppColor.blackColor,
              size: 24,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 2.h),
              
              // Progress Dashboard Section
              _buildProgressDashboard(),
              SizedBox(height: 2.h),
              
              // Next Up Session Card
              _buildNextUpCard(),
              SizedBox(height: 2.h),
              
              // Your Full Plan Section
              _buildFullPlanSection(),
              SizedBox(height: 2.h),
              
              // Adaptive Insights Card
              _buildAdaptiveInsightsCard(),
              SizedBox(height: 4.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProgressDashboard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Progress Dashboard",
            style: AppTextStyle.boldText.copyWith(
              fontSize: 18,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(height: 2.h),
          
          // Empty space for progress chart (placeholder)
          Container(
            height: 15.h,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Progress Chart Placeholder",
                style: AppTextStyle.mediumText.copyWith(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          
          SizedBox(height: 2.h),
          
          // Next Session Card
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD), // Light blue
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Next Session",
                      style: AppTextStyle.mediumText.copyWith(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "Today, 5:00 PM",
                      style: AppTextStyle.boldText.copyWith(
                        fontSize: 16,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: controller.rescheduleSession,
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextUpCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5DC), // Light beige
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.fitness_center,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                "NEXT UP",
                style: AppTextStyle.mediumText.copyWith(
                  fontSize: 12,
                  color: Color(0xFF2196F3), // Light blue
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            "Shoulder Mobility",
            style: AppTextStyle.boldText.copyWith(
              fontSize: 20,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            "Est. 30 min",
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton.icon(
              onPressed: () => controller.startExercise(controller.exercisesList[0]),
              icon: Icon(Icons.play_arrow, color: Colors.white, size: 20),
              label: Text("Start Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2196F3), // Light blue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullPlanSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Full Plan",
                style: AppTextStyle.boldText.copyWith(
                  fontSize: 18,
                  color: AppColor.blackColor,
                ),
              ),
              GestureDetector(
                onTap: controller.playAllExercises,
                child: Row(
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      color: Color(0xFF2196F3),
                      size: 20,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      "Play All",
                      style: AppTextStyle.mediumText.copyWith(
                        fontSize: 14,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          
          // Exercise Items
          ...controller.exercisesList.skip(1).map((exercise) => _buildExerciseItem(exercise)).toList(),
        ],
      ),
    );
  }

  Widget _buildExerciseItem(exercise) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: exercise.title == "Knee Strengthening" 
                  ? Color(0xFFF5F5DC) // Light beige for knee
                  : Color(0xFFE8F5E8), // Light green for back
              shape: BoxShape.circle,
            ),
            child: Icon(
              exercise.title == "Knee Strengthening" 
                  ? Icons.accessibility_new
                  : Icons.self_improvement,
              color: exercise.title == "Knee Strengthening" 
                  ? Colors.orange
                  : Colors.green,
              size: 20,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.title,
                  style: AppTextStyle.boldText.copyWith(
                    fontSize: 16,
                    color: AppColor.blackColor,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  exercise.subtitle,
                  style: AppTextStyle.mediumText.copyWith(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: exercise.isCompleted! ? Colors.green : Colors.orange,
              shape: BoxShape.circle,
            ),
            child: Icon(
              exercise.isCompleted! ? Icons.check : Icons.schedule,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdaptiveInsightsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Adaptive Insights",
            style: AppTextStyle.boldText.copyWith(
              fontSize: 18,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: Color(0xFF2196F3),
                size: 20,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Great job on your consistency! ",
                        style: AppTextStyle.boldText.copyWith(
                          fontSize: 14,
                          color: AppColor.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: "We've noticed you complete your sessions in the evening. Try adding a 5-minute warm-up to boost your performance.",
                        style: AppTextStyle.mediumText.copyWith(
                          fontSize: 14,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
