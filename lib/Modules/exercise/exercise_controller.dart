import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: "Shoulder Mobility",
        subtitle: "Est. 30 min",
        duration: "30 min",
        type: "MOBILITY",
        status: "NEXT UP",
        icon: "shoulder",
        statusColor: Colors.orange,
        isCompleted: false,
      ),
      ExerciseModel(
        title: "Knee Strengthening",
        subtitle: "STRENGTH • 20 min",
        duration: "20 min",
        type: "STRENGTH",
        status: "Completed",
        icon: "knee",
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
    ];

    adaptiveInsight.value = AdaptiveInsightModel(
      message: "Great job on your consistency! We've noticed you complete your sessions in the evening. Try adding a 5-minute warm-up to boost your performance.",
      icon: "location",
      iconColor: Colors.blue,
    );
    
    isLoading.value = false;
  }

  void startExercise(ExerciseModel exercise) {
    Get.snackbar(
      "Starting Exercise",
      "Starting ${exercise.title}...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void playAllExercises() {
    Get.snackbar(
      "Play All",
      "Starting all exercises in sequence...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
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
