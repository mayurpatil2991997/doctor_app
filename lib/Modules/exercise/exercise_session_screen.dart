import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import 'exercise_session_controller.dart';

class ExerciseSessionScreen extends StatefulWidget {
  final String exerciseName;
  final String nextExercise;
  final int totalSets;
  final int currentSet;
  final int duration;

  const ExerciseSessionScreen({
    Key? key,
    required this.exerciseName,
    required this.nextExercise,
    required this.totalSets,
    required this.currentSet,
    required this.duration,
  }) : super(key: key);

  @override
  State<ExerciseSessionScreen> createState() => _ExerciseSessionScreenState();
}

class _CircularTimerPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color trackColor;
  final List<Color> gradientColors;

  _CircularTimerPainter({
    required this.progress,
    required this.strokeWidth,
    required this.trackColor,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: gradientColors,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth / 2;

    // Draw track
    canvas.drawCircle(center, radius, trackPaint);

    // Draw progress arc
    final double sweep = 2 * math.pi * progress;
    final Rect arcRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      arcRect,
      -math.pi / 2,
      sweep,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularTimerPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.gradientColors != gradientColors;
  }
}

class _ExerciseSessionScreenState extends State<ExerciseSessionScreen>
    with TickerProviderStateMixin {
  final ExerciseSessionController controller = Get.put(ExerciseSessionController());
  late AnimationController _timerController;
  late AnimationController _progressController;
  late final bool _isPlayAll;

  @override
  void initState() {
    super.initState();
    _isPlayAll = (Get.arguments != null && Get.arguments['isPlayAll'] != null)
        ? (Get.arguments['isPlayAll'] as bool)
        : false;
    _timerController = AnimationController(
      duration: Duration(seconds: widget.duration),
      vsync: this,
    );
    _progressController = AnimationController(
      duration: Duration(seconds: widget.duration),
      vsync: this,
    );
    
    controller.initializeSession(
      widget.duration,
      widget.currentSet,
      widget.totalSets,
    );
    
    _startTimer();
  }

  void _startTimer() {
    _timerController.forward();
    _progressController.forward();
  }

  @override
  void dispose() {
    _timerController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _confirmExit();
      },
      child: Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Light gray background
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                // Header with progress and close button
                _buildHeader(),
                
                // Exercise video/image section
                _buildExerciseVideo(),
                
                // Exercise name and next exercise
                _buildExerciseInfo(),
              
              // Doctor note card
              _buildDoctorNoteCard(),
                
                // Circular timer
                _buildCircularTimer(),
                
                // Removed overall progress bar to avoid duplicate progress indicators
                
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          // Compact set progress bars
          Row(
            children: [Expanded(child: _buildSetIndicator())],
          ),
          SizedBox(height: 1.2.h),
          
          // Info pill with set and time + inline close
          _buildSetInfoPill(),
          SizedBox(height: 1.2.h),
          
          // Progress bar with all exercises (only when playing all)
          if (_isPlayAll) _buildExerciseProgressBar(),
          SizedBox(height: 1.h),
          
          // Removed separate set/time row in favor of pill above
        ],
      ),
    );
  }

  Widget _buildSetInfoPill() {
    return Obx(() {
      final minutesLeft = ((controller.remainingSeconds.value + 59) ~/ 60);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              "Set ${widget.currentSet} of ${widget.totalSets}",
              style: AppTextStyle.boldText.copyWith(
                fontSize: 14,
                color: AppColor.blackColor,
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              "•",
              style: AppTextStyle.boldText.copyWith(
                fontSize: 14,
                color: AppColor.greyColor,
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              "Est. ${minutesLeft} min left",
              style: AppTextStyle.mediumText.copyWith(
                fontSize: 14,
                color: AppColor.greyColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () async { if (await _confirmExit()) Get.back(); },
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.close, color: AppColor.blackColor, size: 5.w),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildSetIndicator() {
    return Row(
      children: List.generate(widget.totalSets, (index) {
        final isDone = index < (widget.currentSet - 1);
        final isCurrent = index == (widget.currentSet - 1);
        return Container(
          width: 14.w,
          height: 1.2.h,
          margin: EdgeInsets.only(right: index == widget.totalSets - 1 ? 0 : 2.w),
          decoration: BoxDecoration(
            color: isDone || isCurrent ? AppColor.primaryColor : Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }

  Widget _buildExerciseProgressBar() {
    // Get current exercise index based on exercise name
    final allExercises = [
      {"name": "Warm Up", "icon": Icons.self_improvement},
      {"name": "Knee Extension", "icon": Icons.accessibility_new},
      {"name": "Shoulder Mobility", "icon": Icons.self_improvement},
      {"name": "Back Flexibility", "icon": Icons.self_improvement},
      {"name": "Cool Down", "icon": Icons.directions_walk},
    ];
    
    final currentExerciseIndex = allExercises.indexWhere(
      (exercise) => exercise["name"] == widget.exerciseName
    );
    
    final exercises = allExercises.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> exercise = entry.value;
      return {
        ...exercise,
        "completed": index < currentExerciseIndex,
        "current": index == currentExerciseIndex,
      };
    }).toList();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: exercises.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> exercise = entry.value;
          bool isCompleted = exercise["completed"] ?? false;
          bool isCurrent = exercise["current"] ?? false;
          bool isLast = index == exercises.length - 1;

          return Row(
            children: [
                // Exercise step circle
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: isCompleted 
                        ? AppColor.primaryColor 
                        : isCurrent 
                            ? Colors.white 
                            : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCompleted 
                          ? AppColor.primaryColor 
                          : isCurrent 
                              ? AppColor.primaryColor 
                              : Colors.grey.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: isCurrent ? [
                      BoxShadow(
                        color: AppColor.primaryColor.withOpacity(0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ] : null,
                  ),
                  child: Icon(
                    exercise["icon"] as IconData,
                    color: isCompleted 
                        ? Colors.white 
                        : isCurrent 
                            ? AppColor.primaryColor 
                            : Colors.grey.withOpacity(0.5),
                    size: 3.5.w,
                  ),
                ),
                
                // Connecting line (except for last item)
                if (!isLast)
                  Container(
                    width: 10.w,
                    height: 0.2.h,
                    margin: EdgeInsets.symmetric(horizontal: 1.w),
                    decoration: BoxDecoration(
                      color: isCompleted 
                          ? AppColor.primaryColor 
                          : Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
            ],
          );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildExerciseVideo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      height: 28.h, // Reduced from 35.h to 28.h
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.grey[100],
          child: Stack(
            children: [
              // Placeholder for exercise video/image
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      color: AppColor.primaryColor.withOpacity(0.6),
                      size: 12.w, // Reduced from 15.w to 12.w
                    ),
                    SizedBox(height: 1.h), // Reduced from 2.h to 1.h
                    Text(
                      "Exercise Video",
                      style: AppTextStyle.mediumText.copyWith(
                        fontSize: 14, // Reduced from 16 to 14
                        color: AppColor.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          Text(
            widget.exerciseName,
            style: AppTextStyle.boldText.copyWith(
              fontSize: 26,
              color: AppColor.blackColor,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            "Next: ${widget.nextExercise}",
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 15,
              color: AppColor.greyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorNoteCard() {
    final note = (Get.arguments != null && Get.arguments['doctorNote'] != null)
        ? (Get.arguments['doctorNote'] as String)
        : "Perform movements slowly. Keep your back straight and avoid locking the knee. Breathe steadily and stop if you feel pain.";
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
      padding: EdgeInsets.all(3.5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.sticky_note_2_rounded, color: AppColor.primaryColor, size: 6.w),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Doctor's Note",
                  style: AppTextStyle.boldText.copyWith(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                ),
                SizedBox(height: 0.6.h),
                Text(
                  note,
                  style: AppTextStyle.mediumText.copyWith(
                    fontSize: 12,
                    color: AppColor.greyColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularTimer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.5.h),
      child: Obx(() {
        final progress = controller.progressValue.value.clamp(0.0, 1.0);
        final double diameter = 50.w;
        final double stroke = 10;
        final double radius = diameter / 2;
        final double angle = -math.pi / 2 + 2 * math.pi * progress;
        final Offset center = Offset(radius, radius);
        final Offset thumbOffset = Offset(
          center.dx + (radius - stroke / 2) * math.cos(angle),
          center.dy + (radius - stroke / 2) * math.sin(angle),
        );

        return GestureDetector(
          onTap: controller.togglePlayPause,
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Custom gradient ring
                CustomPaint(
                  size: Size(diameter, diameter),
                  painter: _CircularTimerPainter(
                    progress: progress,
                    strokeWidth: stroke,
                    trackColor: Colors.grey.withOpacity(0.18),
                    gradientColors: [
                      AppColor.primaryColor,
                      AppColor.primaryColor.withOpacity(0.85),
                    ],
                  ),
                ),
                // Moving thumb
                Positioned(
                  left: thumbOffset.dx - 1.6.w,
                  top: thumbOffset.dy - 1.6.w,
                  child: Container(
                    width: 3.2.w,
                    height: 3.2.w,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primaryColor.withOpacity(0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                // Center labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatTime(controller.remainingSeconds.value),
                      style: AppTextStyle.boldText.copyWith(
                        fontSize: 34,
                        color: AppColor.blackColor,
                      ),
                    ),
                    SizedBox(height: 0.4.h),
                    Text(
                      "SECONDS",
                      style: AppTextStyle.mediumText.copyWith(
                        fontSize: 11,
                        color: AppColor.greyColor,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildControlButtons() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Skip button
          _buildControlButton(
            icon: Icons.skip_next,
            color: AppColor.blackColor,
            backgroundColor: Colors.white,
            onTap: controller.skipExercise,
          ),
          
          // Pause/Play button
          _buildControlButton(
            icon: Icons.pause,
            color: Colors.white,
            backgroundColor: AppColor.primaryColor,
            onTap: controller.togglePlayPause,
            isLarge: true,
          ),
          
          // Complete button
          _buildControlButton(
            icon: Icons.check,
            color: Colors.white,
            backgroundColor: Colors.green,
            onTap: controller.completeExercise,
          ),
        ],
      ),
    );
  }

  Widget _buildOverallProgress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Obx(() {
        final percent = (controller.progressValue.value * 100).toInt();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Session Progress",
                  style: AppTextStyle.boldText.copyWith(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                ),
                Text(
                  "$percent%",
                  style: AppTextStyle.boldText.copyWith(
                    fontSize: 14,
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                minHeight: 1.2.h,
                value: controller.progressValue.value,
                backgroundColor: Colors.grey.withOpacity(0.15),
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 1.2.h, bottom: 2.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildRoundBottomButton(
            tooltip: "Skip",
            icon: Icons.skip_next,
            background: Colors.white,
            iconColor: AppColor.blackColor,
            onTap: controller.skipExercise,
          ),
          Obx(() => _buildRoundBottomButton(
            tooltip: controller.isPlaying.value ? "Pause" : "Resume",
            icon: controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
            background: AppColor.primaryColor,
            iconColor: Colors.white,
            onTap: controller.togglePlayPause,
            isLarge: true,
          )),
          _buildRoundBottomButton(
            tooltip: "Complete",
            icon: Icons.check,
            background: Colors.green,
            iconColor: Colors.white,
            onTap: controller.completeExercise,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required Color background,
    required Color foreground,
    bool outlined = false,
  }) {
    return Tooltip(
      message: label,
      preferBelow: true,
      child: InkWell(
        onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.6.h),
        decoration: BoxDecoration(
          color: outlined ? Colors.white : background,
          borderRadius: BorderRadius.circular(12),
          border: outlined ? Border.all(color: Colors.grey.withOpacity(0.3)) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: outlined ? foreground : foreground, size: 5.w),
            SizedBox(width: 2.w),
            Text(
              label,
              style: AppTextStyle.boldText.copyWith(
                fontSize: 12,
                color: outlined ? foreground : Colors.white,
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildRoundBottomButton({
    required String tooltip,
    required IconData icon,
    required Color background,
    required Color iconColor,
    required VoidCallback onTap,
    bool isLarge = false,
  }) {
    final double size = isLarge ? 16.w : 13.w;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        customBorder: CircleBorder(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Icon(icon, color: iconColor, size: isLarge ? 7.w : 6.w),
        ),
      ),
    );
  }

  Future<bool> _confirmExit() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Exit Session?", style: AppTextStyle.boldText.copyWith(color: AppColor.blackColor)),
          content: Text(
            "Your current progress will be lost. Are you sure you want to exit?",
            style: AppTextStyle.mediumText.copyWith(color: AppColor.greyColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text("Cancel", style: TextStyle(color: AppColor.primaryColor)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor),
              child: Text("Exit", style: TextStyle(color: Colors.white)),
            )
          ],
        );
      },
    );
    return shouldExit == true;
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    required VoidCallback onTap,
    bool isLarge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isLarge ? 15.w : 12.w,
        height: isLarge ? 15.w : 12.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: isLarge ? 8.w : 6.w,
        ),
      ),
    );
  }
}
