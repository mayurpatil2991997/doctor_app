import 'package:flutter/material.dart';

class FitnessAssessmentModel {
  // Personal Information
  String? fullName;
  String? mobileNumber;
  String? emailAddress;
  String? gender;
  DateTime? dateOfBirth;

  // Health Information
  bool? weightFluctuations;
  bool? physicianRecommendation;
  bool? hasAddictions;
  String? healthTherapistInfo;
  List<String> healthConditions;

  // Dietary Habits
  int? mealsPerDay;
  int? waterGlassesPerDay;

  // Goal Evaluation (5-star ratings for each goal)
  Map<String, int> goalRatings;

  // Body Measurements
  int? age;
  double? height;
  double? weight;
  
  // Girth Measurements
  double? neckCircumference;
  double? chestCircumference;
  double? bicepCircumference;
  double? forearmCircumference;
  double? waistCircumference;
  double? hipCircumference;
  double? thighCircumference;
  double? calfCircumference;

  // Fitness Testing
  int? stepTestSteps;
  int? stepTestHeartRate;
  double? sitAndReachTest1;
  double? sitAndReachTest2;
  double? sitAndReachTest3;
  int? kneePushUps;
  int? plankSeconds;
  int? wallSitSeconds;

  // Final Goal
  String? mainFitnessGoal;

  FitnessAssessmentModel({
    this.fullName,
    this.mobileNumber,
    this.emailAddress,
    this.gender,
    this.dateOfBirth,
    this.weightFluctuations,
    this.physicianRecommendation,
    this.hasAddictions,
    this.healthTherapistInfo,
    List<String>? healthConditions,
    this.mealsPerDay,
    this.waterGlassesPerDay,
    this.goalRatings = const {},
    this.age,
    this.height,
    this.weight,
    this.neckCircumference,
    this.chestCircumference,
    this.bicepCircumference,
    this.forearmCircumference,
    this.waistCircumference,
    this.hipCircumference,
    this.thighCircumference,
    this.calfCircumference,
    this.stepTestSteps,
    this.stepTestHeartRate,
    this.sitAndReachTest1,
    this.sitAndReachTest2,
    this.sitAndReachTest3,
    this.kneePushUps,
    this.plankSeconds,
    this.wallSitSeconds,
    this.mainFitnessGoal,
  }) : healthConditions = healthConditions ?? [];

  // Static list of health conditions
  static const List<String> healthConditionsList = [
    "Increase blood pressure (Hypertension) or low blood pressure",
    "difficulty doing physical exercise",
    "Advice from physician not to exercise",
    "Recent surgery in past 2 years",
    "Pregnancy for past 12 months?",
    "Breast feeding (now or in the past 12 months)",
    "History of breathing issues (asthma, bronchitis, COPD, emphysema)",
    "Muscle, ligament, tendon, joint (shoulder, knee, ankle, back, neck, etc.) problems or injury",
    "Arthritis, Rheumatoid arthritis, Osteoporosis",
    "Diabetes Type 1 or 2, Thyroid condition",
    "Obesity (more than 20-25 lbs over weight)",
    "Hernias or any condition that may be aggravated by lifting weight",
    "Frequent headache (migraines, cluster, tension)",
  ];

  // Static list of fitness goals
  static const List<String> fitnessGoals = [
    "Body fat loss (weight loss)",
    "Improved cardiovascular fitness",
    "Reshape or tone body",
    "Build muscle",
    "Improve flexibility",
    "Improve performance for a specific sport",
    "Improve mood and ability to cope with stress",
    "Increase energy level",
    "Feel better, positive attitude",
    "Enjoy my workout for fun",
    "Exercise safely with proper form",
    "To maintain my workout consistency",
  ];

  factory FitnessAssessmentModel.fromJson(Map<String, dynamic> json) {
    return FitnessAssessmentModel(
      fullName: json['fullName'],
      mobileNumber: json['mobileNumber'],
      emailAddress: json['emailAddress'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      weightFluctuations: json['weightFluctuations'],
      physicianRecommendation: json['physicianRecommendation'],
      hasAddictions: json['hasAddictions'],
      healthTherapistInfo: json['healthTherapistInfo'],
      healthConditions: List<String>.from(json['healthConditions'] ?? []),
      mealsPerDay: json['mealsPerDay'],
      waterGlassesPerDay: json['waterGlassesPerDay'],
      goalRatings: Map<String, int>.from(json['goalRatings'] ?? {}),
      age: json['age'],
      height: json['height']?.toDouble(),
      weight: json['weight']?.toDouble(),
      neckCircumference: json['neckCircumference']?.toDouble(),
      chestCircumference: json['chestCircumference']?.toDouble(),
      bicepCircumference: json['bicepCircumference']?.toDouble(),
      forearmCircumference: json['forearmCircumference']?.toDouble(),
      waistCircumference: json['waistCircumference']?.toDouble(),
      hipCircumference: json['hipCircumference']?.toDouble(),
      thighCircumference: json['thighCircumference']?.toDouble(),
      calfCircumference: json['calfCircumference']?.toDouble(),
      stepTestSteps: json['stepTestSteps'],
      stepTestHeartRate: json['stepTestHeartRate'],
      sitAndReachTest1: json['sitAndReachTest1']?.toDouble(),
      sitAndReachTest2: json['sitAndReachTest2']?.toDouble(),
      sitAndReachTest3: json['sitAndReachTest3']?.toDouble(),
      kneePushUps: json['kneePushUps'],
      plankSeconds: json['plankSeconds'],
      wallSitSeconds: json['wallSitSeconds'],
      mainFitnessGoal: json['mainFitnessGoal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'emailAddress': emailAddress,
      'gender': gender,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'weightFluctuations': weightFluctuations,
      'physicianRecommendation': physicianRecommendation,
      'hasAddictions': hasAddictions,
      'healthTherapistInfo': healthTherapistInfo,
      'healthConditions': healthConditions,
      'mealsPerDay': mealsPerDay,
      'waterGlassesPerDay': waterGlassesPerDay,
      'goalRatings': goalRatings,
      'age': age,
      'height': height,
      'weight': weight,
      'neckCircumference': neckCircumference,
      'chestCircumference': chestCircumference,
      'bicepCircumference': bicepCircumference,
      'forearmCircumference': forearmCircumference,
      'waistCircumference': waistCircumference,
      'hipCircumference': hipCircumference,
      'thighCircumference': thighCircumference,
      'calfCircumference': calfCircumference,
      'stepTestSteps': stepTestSteps,
      'stepTestHeartRate': stepTestHeartRate,
      'sitAndReachTest1': sitAndReachTest1,
      'sitAndReachTest2': sitAndReachTest2,
      'sitAndReachTest3': sitAndReachTest3,
      'kneePushUps': kneePushUps,
      'plankSeconds': plankSeconds,
      'wallSitSeconds': wallSitSeconds,
      'mainFitnessGoal': mainFitnessGoal,
    };
  }

  FitnessAssessmentModel copyWith({
    String? fullName,
    String? mobileNumber,
    String? emailAddress,
    String? gender,
    DateTime? dateOfBirth,
    bool? weightFluctuations,
    bool? physicianRecommendation,
    bool? hasAddictions,
    String? healthTherapistInfo,
    List<String>? healthConditions,
    int? mealsPerDay,
    int? waterGlassesPerDay,
    Map<String, int>? goalRatings,
    int? age,
    double? height,
    double? weight,
    double? neckCircumference,
    double? chestCircumference,
    double? bicepCircumference,
    double? forearmCircumference,
    double? waistCircumference,
    double? hipCircumference,
    double? thighCircumference,
    double? calfCircumference,
    int? stepTestSteps,
    int? stepTestHeartRate,
    double? sitAndReachTest1,
    double? sitAndReachTest2,
    double? sitAndReachTest3,
    int? kneePushUps,
    int? plankSeconds,
    int? wallSitSeconds,
    String? mainFitnessGoal,
  }) {
    return FitnessAssessmentModel(
      fullName: fullName ?? this.fullName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      weightFluctuations: weightFluctuations ?? this.weightFluctuations,
      physicianRecommendation: physicianRecommendation ?? this.physicianRecommendation,
      hasAddictions: hasAddictions ?? this.hasAddictions,
      healthTherapistInfo: healthTherapistInfo ?? this.healthTherapistInfo,
      healthConditions: healthConditions ?? this.healthConditions,
      mealsPerDay: mealsPerDay ?? this.mealsPerDay,
      waterGlassesPerDay: waterGlassesPerDay ?? this.waterGlassesPerDay,
      goalRatings: goalRatings ?? this.goalRatings,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      neckCircumference: neckCircumference ?? this.neckCircumference,
      chestCircumference: chestCircumference ?? this.chestCircumference,
      bicepCircumference: bicepCircumference ?? this.bicepCircumference,
      forearmCircumference: forearmCircumference ?? this.forearmCircumference,
      waistCircumference: waistCircumference ?? this.waistCircumference,
      hipCircumference: hipCircumference ?? this.hipCircumference,
      thighCircumference: thighCircumference ?? this.thighCircumference,
      calfCircumference: calfCircumference ?? this.calfCircumference,
      stepTestSteps: stepTestSteps ?? this.stepTestSteps,
      stepTestHeartRate: stepTestHeartRate ?? this.stepTestHeartRate,
      sitAndReachTest1: sitAndReachTest1 ?? this.sitAndReachTest1,
      sitAndReachTest2: sitAndReachTest2 ?? this.sitAndReachTest2,
      sitAndReachTest3: sitAndReachTest3 ?? this.sitAndReachTest3,
      kneePushUps: kneePushUps ?? this.kneePushUps,
      plankSeconds: plankSeconds ?? this.plankSeconds,
      wallSitSeconds: wallSitSeconds ?? this.wallSitSeconds,
      mainFitnessGoal: mainFitnessGoal ?? this.mainFitnessGoal,
    );
  }
}
