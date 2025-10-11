import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../widgets/common_card_widget.dart';
import '../../widgets/common_stat_widget.dart';
import '../../widgets/common_progress_widget.dart';
import '../../widgets/common_avatar_widget.dart';
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
    return CommonCardWidget(
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
                child: CommonStatWidget(
                  title: "Completion",
                  value: "85%",
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: CommonStatWidget(
                  title: "Streak",
                  value: "7 Days",
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: CommonStatWidget(
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


  Widget _buildCompactWeeklyChart() {
    final weekData = [
      {'day': 'Mon', 'height': 0.8, 'color': Colors.green, 'duration': '32 min'},
      {'day': 'Tue', 'height': 0.6, 'color': Colors.orange, 'duration': '24 min'},
      {'day': 'Wed', 'height': 0.9, 'color': Colors.green, 'duration': '36 min'},
      {'day': 'Thu', 'height': 0.7, 'color': Colors.blue, 'duration': '28 min'},
      {'day': 'Fri', 'height': 0.5, 'color': Colors.orange, 'duration': '20 min'},
      {'day': 'Sat', 'height': 0.3, 'color': Colors.red, 'duration': '12 min'},
      {'day': 'Sun', 'height': 0.0, 'color': Colors.grey, 'duration': '0 min'},
    ];

    return WeeklyProgressChartWidget(
      weekData: weekData,
      onDayTap: (day, duration, color) => _showDayDetails(day, duration, color),
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
    return CompactCardWidget(
      onTap: () => controller.startExercise(exercise),
      child: Row(
        children: [
          CircularIconWidget(
            icon: _getExerciseIcon(exercise.title!),
            backgroundColor: _getExerciseBackgroundColor(exercise.title!),
            iconColor: exercise.statusColor,
            size: 8.w,
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
    return CommonCardWidget(
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
