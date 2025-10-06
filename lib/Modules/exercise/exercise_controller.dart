import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Routes/app_routes.dart';
import 'exercise_model.dart';

class ExerciseController extends GetxController {
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var exercisesList = <ExerciseModel>[].obs;
  var progressDashboard = Rxn<ProgressDashboardModel>();
  var adaptiveInsight = Rxn<AdaptiveInsightModel>();

  @override
  void onInit() {
    super.onInit();
    loadExerciseData();
  }

  void loadExerciseData() {
    isLoading.value = true;
    hasError.value = false;
    
    // Mock data based on the image design
    progressDashboard.value = ProgressDashboardModel(
      nextSessionTitle: "Next Session",
      nextSessionTime: "Today, 5:00 PM",
      nextSessionDate: "Today",
    );

    exercisesList.value = [
      ExerciseModel(
        title: "Knee Extension",
        subtitle: "STRENGTH • 30 min",
        duration: "30 min",
        type: "STRENGTH",
        status: "NEXT UP",
        icon: "knee",
        statusColor: Colors.orange,
        isCompleted: false,
      ),
      ExerciseModel(
        title: "Shoulder Mobility",
        subtitle: "MOBILITY • 20 min",
        duration: "20 min",
        type: "MOBILITY",
        status: "Completed",
        icon: "shoulder",
        statusColor: Colors.green,
        isCompleted: true,
      ),
      ExerciseModel(
        title: "Back Flexibility",
        subtitle: "FLEXIBILITY • 15 min",
        duration: "15 min",
        type: "FLEXIBILITY",
        status: "Pending",
        icon: "back",
        statusColor: Colors.orange,
        isCompleted: false,
      ),
      ExerciseModel(
        title: "Hip Flexor Stretch",
        subtitle: "FLEXIBILITY • 10 min",
        duration: "10 min",
        type: "FLEXIBILITY",
        status: "Pending",
        icon: "hip",
        statusColor: Colors.blue,
        isCompleted: false,
      ),
      ExerciseModel(
        title: "Core Strengthening",
        subtitle: "STRENGTH • 25 min",
        duration: "25 min",
        type: "STRENGTH",
        status: "Pending",
        icon: "core",
        statusColor: Colors.purple,
        isCompleted: false,
      ),
    ];

    adaptiveInsight.value = AdaptiveInsightModel(
      message: "Great job on your consistency! We've noticed you complete your sessions in the evening. Try adding a 5-minute warm-up to boost your performance.",
      icon: "location",
      iconColor: Colors.blue,
    );
    
    isLoading.value = false;
  }

  void startExercise(ExerciseModel exercise) {
    try {
      Get.toNamed(AppRoutes.exerciseSession, arguments: {
        'exerciseName': exercise.title,
        'nextExercise': 'Rest',
        'totalSets': 3,
        'currentSet': 1,
        'duration': 30, // 30 seconds for demo
        'isPlayAll': false,
      });
    } catch (e) {
      print('Navigation error: $e');
      Get.snackbar(
        "Starting Exercise",
        "Starting ${exercise.title}...",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void playAllExercises() {
    try {
      Get.toNamed(AppRoutes.exerciseSession, arguments: {
        'exerciseName': 'Knee Extension',
        'nextExercise': 'Shoulder Mobility',
        'totalSets': 5,
        'currentSet': 1,
        'duration': 30, // 30 seconds for demo
        'isPlayAll': true,
        'exerciseList': exercisesList.value,
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to start exercise session: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void rescheduleSession() {
    Get.snackbar(
      "Reschedule",
      "Opening session reschedule...",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void viewProgressDashboard() {
    Get.snackbar(
      "Progress Dashboard",
      "Opening detailed progress view...",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleExerciseStatus(ExerciseModel exercise) {
    exercise.isCompleted = !exercise.isCompleted!;
    if (exercise.isCompleted!) {
      exercise.status = "Completed";
      exercise.statusColor = Colors.green;
    } else {
      exercise.status = "Pending";
      exercise.statusColor = Colors.orange;
    }
    exercisesList.refresh();
  }
}
