import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Themes/app_colors_theme.dart';

class ExerciseSessionController extends GetxController {
  var isPlaying = false.obs;
  var remainingSeconds = 0.obs;
  var progressValue = 0.0.obs;
  var currentSet = 1.obs;
  var totalSets = 3.obs;
  var totalDuration = 0.obs;
  
  Timer? _timer;

  void initializeSession(int duration, int set, int sets) {
    totalDuration.value = duration;
    remainingSeconds.value = duration;
    currentSet.value = set;
    totalSets.value = sets;
    progressValue.value = 0.0;
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      _pauseTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    isPlaying.value = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        progressValue.value = (totalDuration.value - remainingSeconds.value) / totalDuration.value;
      } else {
        _completeExercise();
      }
    });
  }

  void _pauseTimer() {
    isPlaying.value = false;
    _timer?.cancel();
  }

  void skipExercise() {
    _pauseTimer();
    Get.snackbar(
      "Exercise Skipped",
      "Moving to next exercise...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
    // Navigate to next exercise or back to exercise list
    Get.back();
  }

  void completeExercise() {
    _pauseTimer();
    Get.snackbar(
      "Exercise Completed!",
      "Great job! Moving to next exercise...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    // Navigate to next exercise or back to exercise list
    Get.back();
  }

  void _completeExercise() {
    _pauseTimer();
    Get.snackbar(
      "Time's Up!",
      "Exercise completed. Moving to next...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.primaryColor,
      colorText: Colors.white,
    );
    // Auto-advance to next exercise
    Get.back();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
