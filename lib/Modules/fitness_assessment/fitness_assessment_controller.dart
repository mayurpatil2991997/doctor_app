import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/fitness_assessment_model.dart';

class FitnessAssessmentController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();
  
  // Form data
  var assessmentData = FitnessAssessmentModel().obs;
  var currentPage = 0.obs;
  var isSubmitting = false.obs;
  
  // Text controllers
  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final healthTherapistController = TextEditingController();
  final mealsPerDayController = TextEditingController();
  final waterGlassesController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final neckController = TextEditingController();
  final chestController = TextEditingController();
  final bicepController = TextEditingController();
  final forearmController = TextEditingController();
  final waistController = TextEditingController();
  final hipController = TextEditingController();
  final thighController = TextEditingController();
  final calfController = TextEditingController();
  final stepTestStepsController = TextEditingController();
  final stepTestHeartRateController = TextEditingController();
  final sitReach1Controller = TextEditingController();
  final sitReach2Controller = TextEditingController();
  final sitReach3Controller = TextEditingController();
  final kneePushUpsController = TextEditingController();
  final plankSecondsController = TextEditingController();
  final wallSitSecondsController = TextEditingController();
  final mainGoalController = TextEditingController();

  // Date picker
  var selectedDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    _initializeGoalRatings();
    _addTextControllerListeners();
  }

  void _addTextControllerListeners() {
    // Add listeners to text controllers to trigger UI updates
    fullNameController.addListener(() => update());
    mobileNumberController.addListener(() => update());
    emailController.addListener(() => update());
    healthTherapistController.addListener(() => update());
    mealsPerDayController.addListener(() => update());
    waterGlassesController.addListener(() => update());
    ageController.addListener(() => update());
    heightController.addListener(() => update());
    weightController.addListener(() => update());
    neckController.addListener(() => update());
    chestController.addListener(() => update());
    bicepController.addListener(() => update());
    forearmController.addListener(() => update());
    waistController.addListener(() => update());
    hipController.addListener(() => update());
    thighController.addListener(() => update());
    calfController.addListener(() => update());
    stepTestStepsController.addListener(() => update());
    stepTestHeartRateController.addListener(() => update());
    sitReach1Controller.addListener(() => update());
    sitReach2Controller.addListener(() => update());
    sitReach3Controller.addListener(() => update());
    kneePushUpsController.addListener(() => update());
    plankSecondsController.addListener(() => update());
    wallSitSecondsController.addListener(() => update());
    mainGoalController.addListener(() => update());
  }

  @override
  void onClose() {
    fullNameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    healthTherapistController.dispose();
    mealsPerDayController.dispose();
    waterGlassesController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    neckController.dispose();
    chestController.dispose();
    bicepController.dispose();
    forearmController.dispose();
    waistController.dispose();
    hipController.dispose();
    thighController.dispose();
    calfController.dispose();
    stepTestStepsController.dispose();
    stepTestHeartRateController.dispose();
    sitReach1Controller.dispose();
    sitReach2Controller.dispose();
    sitReach3Controller.dispose();
    kneePushUpsController.dispose();
    plankSecondsController.dispose();
    wallSitSecondsController.dispose();
    mainGoalController.dispose();
    pageController.dispose();
    super.onClose();
  }

  void _initializeGoalRatings() {
    var goalRatings = <String, int>{};
    for (String goal in FitnessAssessmentModel.fitnessGoals) {
      goalRatings[goal] = 0;
    }
    assessmentData.value.goalRatings = goalRatings;
  }

  // Navigation methods
  void nextPage() {
    // Validate current page before proceeding
    bool isValid = false;
    switch (currentPage.value) {
      case 0:
        isValid = validatePersonalInfo();
        break;
      case 1:
        isValid = validateHealthInfo();
        break;
      case 2:
        isValid = validateDietaryHabits();
        break;
      case 3:
        isValid = true; // Goal evaluation - no validation needed
        break;
      case 4:
        isValid = validateBodyMeasurements();
        break;
      case 5:
        isValid = true; // Fitness testing is optional
        break;
    }
    
    if (isValid && currentPage.value < 5) {
      currentPage.value++;
      update(); // Force UI update
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      update(); // Force UI update
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPage(int page) {
    currentPage.value = page;
    update(); // Force UI update
    pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Personal Information methods
  void setGender(String gender) {
    assessmentData.value.gender = gender;
    assessmentData.refresh();
    update(); // Trigger UI update for button state
  }

  void selectDateOfBirth() async {
    final DateTime? picked = await Get.dialog<DateTime>(
      DatePickerDialog(
        initialDate: selectedDate.value ?? DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      ),
    );
    
    if (picked != null) {
      selectedDate.value = picked;
      assessmentData.value.dateOfBirth = picked;
      assessmentData.refresh();
      update(); // Trigger UI update for button state
    }
  }

  // Health Information methods
  void setWeightFluctuations(bool value) {
    assessmentData.value.weightFluctuations = value;
    assessmentData.refresh();
    update(); // Trigger UI update for button state
  }

  void setPhysicianRecommendation(bool value) {
    assessmentData.value.physicianRecommendation = value;
    assessmentData.refresh();
    update(); // Trigger UI update for button state
  }

  void setHasAddictions(bool value) {
    assessmentData.value.hasAddictions = value;
    assessmentData.refresh();
    update(); // Trigger UI update for button state
  }

  void toggleHealthCondition(String condition) {
    var conditions = List<String>.from(assessmentData.value.healthConditions);
    if (conditions.contains(condition)) {
      conditions.remove(condition);
    } else {
      conditions.add(condition);
    }
    assessmentData.value = assessmentData.value.copyWith(healthConditions: conditions);
    assessmentData.refresh();
    update(); // Trigger UI update for button state
  }

  // Goal rating methods
  void setGoalRating(String goal, int rating) {
    assessmentData.value.goalRatings[goal] = rating;
    assessmentData.refresh();
  }

  int getGoalRating(String goal) {
    return assessmentData.value.goalRatings[goal] ?? 0;
  }

  // Form validation
  bool validatePersonalInfo() {
    if (fullNameController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your full name");
      return false;
    }
    if (mobileNumberController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your mobile number");
      return false;
    }
    if (emailController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your email address");
      return false;
    }
    if (assessmentData.value.gender == null) {
      Get.snackbar("Error", "Please select your gender");
      return false;
    }
    if (selectedDate.value == null) {
      Get.snackbar("Error", "Please select your date of birth");
      return false;
    }
    return true;
  }

  bool validateHealthInfo() {
    if (assessmentData.value.weightFluctuations == null) {
      Get.snackbar("Error", "Please answer about weight fluctuations");
      return false;
    }
    if (assessmentData.value.physicianRecommendation == null) {
      Get.snackbar("Error", "Please answer about physician recommendation");
      return false;
    }
    if (assessmentData.value.hasAddictions == null) {
      Get.snackbar("Error", "Please answer about addictions");
      return false;
    }
    return true;
  }

  bool validateDietaryHabits() {
    if (mealsPerDayController.text.isEmpty) {
      Get.snackbar("Error", "Please enter number of meals per day");
      return false;
    }
    if (waterGlassesController.text.isEmpty) {
      Get.snackbar("Error", "Please enter number of water glasses per day");
      return false;
    }
    return true;
  }

  bool validateBodyMeasurements() {
    if (ageController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your age");
      return false;
    }
    if (heightController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your height");
      return false;
    }
    if (weightController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your weight");
      return false;
    }
    return true;
  }

  bool validateFitnessTesting() {
    // Fitness testing is optional, so we don't require validation
    return true;
  }

  // Submit form
  Future<void> submitForm() async {
    isSubmitting.value = true;
    
    try {
      // Update assessment data with form values
      _updateAssessmentData();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      Get.snackbar(
        "Success",
        "Fitness assessment submitted successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Navigate back or to next screen
      Get.back();
      
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to submit assessment: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void _updateAssessmentData() {
    assessmentData.value = assessmentData.value.copyWith(
      fullName: fullNameController.text,
      mobileNumber: mobileNumberController.text,
      emailAddress: emailController.text,
      healthTherapistInfo: healthTherapistController.text,
      mealsPerDay: int.tryParse(mealsPerDayController.text),
      waterGlassesPerDay: int.tryParse(waterGlassesController.text),
      age: int.tryParse(ageController.text),
      height: double.tryParse(heightController.text),
      weight: double.tryParse(weightController.text),
      neckCircumference: double.tryParse(neckController.text),
      chestCircumference: double.tryParse(chestController.text),
      bicepCircumference: double.tryParse(bicepController.text),
      forearmCircumference: double.tryParse(forearmController.text),
      waistCircumference: double.tryParse(waistController.text),
      hipCircumference: double.tryParse(hipController.text),
      thighCircumference: double.tryParse(thighController.text),
      calfCircumference: double.tryParse(calfController.text),
      stepTestSteps: int.tryParse(stepTestStepsController.text),
      stepTestHeartRate: int.tryParse(stepTestHeartRateController.text),
      sitAndReachTest1: double.tryParse(sitReach1Controller.text),
      sitAndReachTest2: double.tryParse(sitReach2Controller.text),
      sitAndReachTest3: double.tryParse(sitReach3Controller.text),
      kneePushUps: int.tryParse(kneePushUpsController.text),
      plankSeconds: int.tryParse(plankSecondsController.text),
      wallSitSeconds: int.tryParse(wallSitSecondsController.text),
      mainFitnessGoal: mainGoalController.text,
    );
  }

  // Utility methods
  String get formattedDateOfBirth {
    if (selectedDate.value == null) return "";
    return "${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}";
  }

  double get progressPercentage {
    return (currentPage.value + 1) / 6.0; // 6 total pages
  }

  bool get canGoNext {
    bool result = false;
    switch (currentPage.value) {
      case 0:
        result = _validatePersonalInfoSilent();
        break;
      case 1:
        result = _validateHealthInfoSilent();
        break;
      case 2:
        result = _validateDietaryHabitsSilent();
        break;
      case 3:
        result = true; // Goal evaluation - no validation needed
        break;
      case 4:
        result = _validateBodyMeasurementsSilent();
        break;
      case 5:
        result = true; // Fitness testing is optional
        break;
      default:
        result = false;
    }
    return result;
  }

  // Silent validation methods (without snackbar) for UI updates
  bool _validatePersonalInfoSilent() {
    return fullNameController.text.isNotEmpty &&
           mobileNumberController.text.isNotEmpty &&
           emailController.text.isNotEmpty &&
           assessmentData.value.gender != null &&
           selectedDate.value != null;
  }

  bool _validateHealthInfoSilent() {
    return assessmentData.value.weightFluctuations != null &&
           assessmentData.value.physicianRecommendation != null &&
           assessmentData.value.hasAddictions != null;
  }

  bool _validateDietaryHabitsSilent() {
    return mealsPerDayController.text.isNotEmpty &&
           waterGlassesController.text.isNotEmpty;
  }

  bool _validateBodyMeasurementsSilent() {
    return ageController.text.isNotEmpty &&
           heightController.text.isNotEmpty &&
           weightController.text.isNotEmpty;
  }
}
