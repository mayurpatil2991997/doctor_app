import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Routes/app_routes.dart';
import 'diet_detail_screen.dart';

class DietController extends GetxController {
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  final days = <String>['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
  var selectedDayIndex = 0.obs;

  var weeklyPlan = <int, List<PlanMeal>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadWeeklyPlan();
  }

  void _loadWeeklyPlan() {
    isLoading.value = true;
    hasError.value = false;

    final sampleMeals = <PlanMeal>[
      PlanMeal(
        type: 'Breakfast',
        title: 'Oatmeal with Berries',
        calories: 350,
        protein: 15,
        carbs: 45,
        imageAsset: 'assets/images/intro_image1.png',
        ingredients: [
          Ingredient(name: 'Oats', amount: '1 cup'),
          Ingredient(name: 'Berries', amount: '1/2 cup'),
          Ingredient(name: 'Almond milk', amount: '1 cup'),
        ],
        steps: [
          'Cook oats with almond milk until soft.',
          'Top with assorted berries.',
          'Serve warm.',
        ],
      ),
      PlanMeal(
        type: 'Lunch',
        title: 'Grilled Chicken Salad',
        calories: 450,
        protein: 35,
        carbs: 20,
        imageAsset: 'assets/images/intro_image2.png',
        ingredients: [
          Ingredient(name: 'Chicken breast', amount: '150g'),
          Ingredient(name: 'Mixed greens', amount: '2 cups'),
          Ingredient(name: 'Olive oil & lemon', amount: '1 tbsp each'),
        ],
        steps: [
          'Grill chicken until cooked.',
          'Toss greens with dressing.',
          'Slice chicken and add on top.',
        ],
      ),
      PlanMeal(
        type: 'Dinner',
        title: 'Salmon with Asparagus',
        calories: 500,
        protein: 40,
        carbs: 25,
        imageAsset: 'assets/images/intro_image3.png',
        ingredients: [
          Ingredient(name: 'Salmon fillet', amount: '1 piece'),
          Ingredient(name: 'Asparagus', amount: '8-10 spears'),
          Ingredient(name: 'Olive oil', amount: '1 tbsp'),
        ],
        steps: [
          'Season and bake salmon.',
          'Roast asparagus with olive oil.',
          'Plate and serve.',
        ],
      ),
      PlanMeal(
        type: 'Snack',
        title: 'Greek Yogurt with Nuts',
        calories: 200,
        protein: 12,
        carbs: 15,
        imageAsset: 'assets/images/intro_image4.png',
        ingredients: [
          Ingredient(name: 'Greek yogurt', amount: '1 cup'),
          Ingredient(name: 'Mixed nuts', amount: '2 tbsp'),
        ],
        steps: [
          'Spoon yogurt into bowl.',
          'Top with chopped nuts and serve.',
        ],
      ),
    ];

    for (int i = 0; i < 7; i++) {
      weeklyPlan[i] = List<PlanMeal>.from(sampleMeals);
    }

    isLoading.value = false;
  }

  List<PlanMeal> get mealsForSelectedDay => weeklyPlan[selectedDayIndex.value] ?? [];

  void selectDay(int index) {
    selectedDayIndex.value = index;
  }

  void openMealDetail(PlanMeal meal) {
    try {
      Get.toNamed(AppRoutes.dietDetail, arguments: meal.toMap());
    } catch (e) {
      Get.to(() => DietDetailScreen(), arguments: meal.toMap());
    }
  }

  void addToShoppingList() {
    Get.snackbar('Shopping List', 'Added ingredients to shopping list');
  }

  void markAsEaten() {
    Get.snackbar('Meal', 'Marked as eaten');
  }
}

class PlanMeal {
  final String type;
  final String title;
  final int calories;
  final int protein;
  final int carbs;
  final String imageAsset;
  final List<Ingredient> ingredients;
  final List<String> steps;

  PlanMeal({
    required this.type,
    required this.title,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.imageAsset,
    required this.ingredients,
    required this.steps,
  });

  Map<String, dynamic> toMap() => {
    'type': type,
    'title': title,
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'imageAsset': imageAsset,
    'ingredients': ingredients.map((e) => e.toMap()).toList(),
    'steps': steps,
  };
}

class Ingredient {
  final String name;
  final String amount;

  Ingredient({required this.name, required this.amount});

  Map<String, String> toMap() => {'name': name, 'amount': amount};
}


