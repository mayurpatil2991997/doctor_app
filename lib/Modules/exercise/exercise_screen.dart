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
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.trending_up,
                    color: AppColor.primaryColor,
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    "Progress Dashboard",
                    style: AppTextStyle.boldText.copyWith(
                      fontSize: 16,
                      color: AppColor.blackColor,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: controller.viewProgressDashboard,
                child: Text(
                  "View All",
                  style: AppTextStyle.mediumText.copyWith(
                    fontSize: 12,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          
          // Compact Stats Row
          Row(
            children: [
              Expanded(
                child: _buildCompactStat(
                  title: "Completion",
                  value: "85%",
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildCompactStat(
                  title: "Streak",
                  value: "7 Days",
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildCompactStat(
                  title: "Time",
                  value: "12h 30m",
                  icon: Icons.timer,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          
          // Weekly Progress Chart (Compact)
          _buildCompactWeeklyChart(),
          SizedBox(height: 1.5.h),
          
          // Next Session (Compact)
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.primaryColor.withOpacity(0.1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: AppColor.primaryColor,
                  size: 4.w,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next Session",
                        style: AppTextStyle.mediumText.copyWith(
                          fontSize: 11,
                          color: AppColor.greyColor,
                        ),
                      ),
                      Text(
                        "Today, 5:00 PM",
                        style: AppTextStyle.boldText.copyWith(
                          fontSize: 14,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: controller.rescheduleSession,
                  child: Icon(
                    Icons.calendar_today,
                    color: AppColor.primaryColor,
                    size: 4.w,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStat({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
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
  }

  Widget _buildCompactWeeklyChart() {
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
            children: [
              _buildEnhancedDayBar("Mon", 0.8, Colors.green, "32 min"),
              _buildEnhancedDayBar("Tue", 0.6, Colors.orange, "24 min"),
              _buildEnhancedDayBar("Wed", 0.9, Colors.green, "36 min"),
              _buildEnhancedDayBar("Thu", 0.7, Colors.blue, "28 min"),
              _buildEnhancedDayBar("Fri", 0.5, Colors.orange, "20 min"),
              _buildEnhancedDayBar("Sat", 0.3, Colors.red, "12 min"),
              _buildEnhancedDayBar("Sun", 0.0, Colors.grey, "0 min"),
            ],
          ),
          SizedBox(height: 1.h),
          // Progress summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProgressSummary("Total Time", "2h 32m", Colors.blue),
              _buildProgressSummary("Avg/Day", "22 min", Colors.green),
              _buildProgressSummary("Streak", "3 days", Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedDayBar(String day, double height, Color color, String duration) {
    return GestureDetector(
      onTap: () => _showDayDetails(day, duration, color),
      child: Column(
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
      ),
    );
  }

  Widget _buildProgressSummary(String title, String value, Color color) {
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

  void _showDayDetails(String day, String duration, Color color) {
    Get.snackbar(
      "$day Details",
      "Duration: $duration\nTap to view full details",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color.withOpacity(0.1),
      colorText: color,
      duration: Duration(seconds: 2),
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
    return GestureDetector(
      onTap: () => controller.startExercise(exercise),
      child: Container(
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
              color: _getExerciseBackgroundColor(exercise.title!),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getExerciseIcon(exercise.title!),
              color: exercise.statusColor,
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

  IconData _getExerciseIcon(String exerciseTitle) {
    switch (exerciseTitle) {
      case "Knee Extension":
        return Icons.accessibility_new;
      case "Shoulder Mobility":
        return Icons.self_improvement;
      case "Back Flexibility":
        return Icons.self_improvement;
      case "Hip Flexor Stretch":
        return Icons.directions_run;
      case "Core Strengthening":
        return Icons.fitness_center;
      default:
        return Icons.fitness_center;
    }
  }

  Color _getExerciseBackgroundColor(String exerciseTitle) {
    switch (exerciseTitle) {
      case "Knee Extension":
        return Color(0xFFF5F5DC); // Light beige
      case "Shoulder Mobility":
        return Color(0xFFE8F5E8); // Light green
      case "Back Flexibility":
        return Color(0xFFE3F2FD); // Light blue
      case "Hip Flexor Stretch":
        return Color(0xFFF3E5F5); // Light purple
      case "Core Strengthening":
        return Color(0xFFFFF3E0); // Light orange
      default:
        return Color(0xFFE8F5E8); // Light green
    }
  }
}
