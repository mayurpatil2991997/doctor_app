import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import 'fitness_assessment_controller.dart';
import '../../model/fitness_assessment_model.dart';

class FitnessAssessmentScreen extends StatefulWidget {
  @override
  State<FitnessAssessmentScreen> createState() => _FitnessAssessmentScreenState();
}

class _FitnessAssessmentScreenState extends State<FitnessAssessmentScreen> {
  final FitnessAssessmentController controller = Get.put(FitnessAssessmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.primaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Fitness Assessment',
          style: AppTextStyle.boldText.copyWith(
            color: Color(0xFF1E293B),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator
          _buildProgressIndicator(),
          
          // Form Content
          Expanded(
            child: PageView(
              controller: controller.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildPersonalInfoPage(),
                _buildHealthInfoPage(),
                _buildDietaryHabitsPage(),
                _buildGoalEvaluationPage(),
                _buildBodyMeasurementsPage(),
                _buildFitnessTestingPage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildNavigationButtons(),
    );
  }

  Widget _buildProgressIndicator() {
    return Obx(() => Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${controller.currentPage.value + 1} of 6',
                style: AppTextStyle.mediumText.copyWith(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(controller.progressPercentage * 100).toInt()}% Complete',
                style: AppTextStyle.mediumText.copyWith(
                  fontSize: 14,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          // Modern Animated Progress Bar
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color(0xFFE5E7EB),
            ),
            child: Stack(
              children: [
                // Background
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFFE5E7EB),
                  ),
                ),
                // Progress fill with gradient
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: MediaQuery.of(context).size.width * controller.progressPercentage,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: [
                        AppColor.primaryColor,
                        AppColor.primaryColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                // Step indicators on top
                Row(
                  children: List.generate(6, (index) {
                    bool isCompleted = index < controller.currentPage.value;
                    bool isCurrent = index == controller.currentPage.value;
                    
                    return Expanded(
                      child: Container(
                        height: 8,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Step dot
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: isCompleted || isCurrent ? 24 : 16,
                              height: isCompleted || isCurrent ? 24 : 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted 
                                  ? AppColor.primaryColor
                                  : isCurrent 
                                    ? AppColor.primaryColor
                                    : Color(0xFFD1D5DB),
                                border: Border.all(
                                  color: isCompleted || isCurrent 
                                    ? AppColor.primaryColor 
                                    : Color(0xFFD1D5DB),
                                  width: isCompleted || isCurrent ? 4 : 2,
                                ),
                                boxShadow: isCompleted || isCurrent ? [
                                  BoxShadow(
                                    color: AppColor.primaryColor.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ] : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: isCurrent
                                ? Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildPersonalInfoPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModernSectionTitle('Personal Information', Icons.person_outline),
          SizedBox(height: 3.h),
          
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildModernTextField(
                  controller: controller.fullNameController,
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  icon: Icons.person,
                ),
                SizedBox(height: 3.h),
                
                _buildModernTextField(
                  controller: controller.mobileNumberController,
                  label: 'Mobile Number',
                  hint: 'Enter your mobile number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 3.h),
                
                _buildModernTextField(
                  controller: controller.emailController,
                  label: 'Email Address',
                  hint: 'Enter your email address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 3.h),
                
                _buildModernLabel('Select Gender'),
                SizedBox(height: 1.h),
                _buildModernGenderSelector(),
                SizedBox(height: 3.h),
                
                _buildModernDatePicker(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthInfoPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModernSectionTitle('Health Information', Icons.health_and_safety_outlined),
          SizedBox(height: 3.h),
          
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildModernYesNoQuestion(
                  'Any major fluctuations in weight in the past 12 months?',
                  controller.assessmentData.value.weightFluctuations,
                  controller.setWeightFluctuations,
                ),
                SizedBox(height: 3.h),
                
                _buildModernYesNoQuestion(
                  'Did your physician recommend that you lose weight or start an exercise program?',
                  controller.assessmentData.value.physicianRecommendation,
                  controller.setPhysicianRecommendation,
                ),
                SizedBox(height: 3.h),
                
                _buildModernYesNoQuestion(
                  'Any Addictions?',
                  controller.assessmentData.value.hasAddictions,
                  controller.setHasAddictions,
                ),
                SizedBox(height: 3.h),
                
                _buildModernLabel('Are you currently, or during past 2 years seeing a chiropractor, physiotherapist, occupation therapist, or any other health therapist?'),
                SizedBox(height: 1.h),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFE5E7EB)),
                  ),
                  child: TextField(
                    controller: controller.healthTherapistController,
                    style: AppTextStyle.mediumText.copyWith(
                      fontSize: 16,
                      color: Color(0xFF374151),
                    ),
                    decoration: InputDecoration(
                      hintText: 'If yes, please explain',
                      hintStyle: AppTextStyle.mediumText.copyWith(
                        fontSize: 16,
                        color: Color(0xFF9CA3AF),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildModernLabel('Do you now, or have you had in the past?'),
                SizedBox(height: 2.h),
                _buildModernHealthConditionsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDietaryHabitsPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModernSectionTitle('Dietary Habits', Icons.restaurant_outlined),
          SizedBox(height: 3.h),
          
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildModernTextField(
                  controller: controller.mealsPerDayController,
                  label: 'How many meals (including snacks) do you eat in a typical day?',
                  hint: 'Enter number of meals',
                  icon: Icons.restaurant,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 3.h),
                
                _buildModernTextField(
                  controller: controller.waterGlassesController,
                  label: 'How many glasses of water do you drink in a typical day?',
                  hint: 'Enter number of glasses',
                  icon: Icons.water_drop,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalEvaluationPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModernSectionTitle('Goal Evaluation', Icons.flag_outlined),
          SizedBox(height: 3.h),
          
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rank your goals in starting an exercise program. Use the following scale to rate each goal:',
                  style: AppTextStyle.mediumText.copyWith(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 3.h),
                
                ...FitnessAssessmentModel.fitnessGoals.map((goal) => 
                  _buildModernGoalRatingItem(goal)
                ).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyMeasurementsPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModernSectionTitle('Body Measurements', Icons.straighten),
          SizedBox(height: 3.h),
          
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildModernTextField(
                  controller: controller.ageController,
                  label: 'Age',
                  hint: 'Enter your age',
                  icon: Icons.cake,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 3.h),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildModernTextField(
                        controller: controller.heightController,
                        label: 'Height (cm)',
                        hint: 'Enter height',
                        icon: Icons.height,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: _buildModernTextField(
                        controller: controller.weightController,
                        label: 'Weight (kg)',
                        hint: 'Enter weight',
                        icon: Icons.monitor_weight,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildModernLabel('Girth Measurements'),
                SizedBox(height: 2.h),
                
                // Body diagram with person image
                Container(
                  height: 30.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFE5E7EB)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/person.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                            strokeWidth: 2,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print('Image load error: $error');
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 48,
                                color: Color(0xFF9CA3AF),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                'Body Measurement Diagram\n(Neck, Chest, Bicep, Forearm, Waist, Hip, Thigh, Calf)',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.mediumText.copyWith(
                                  fontSize: 12,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                
                // Girth measurement inputs
                _buildModernGirthMeasurements(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFitnessTestingPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModernSectionTitle('Fitness Testing', Icons.fitness_center),
          SizedBox(height: 3.h),
          
          _buildModernFitnessTestCard(
            '2 Min Step Test',
            'Record the number of steps you can take in 2 minutes.',
            'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/2minstep.png',
            [
              _buildModernTextField(
                controller: controller.stepTestStepsController,
                label: 'No. of steps',
                hint: 'Enter number of steps',
                icon: Icons.directions_run,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 2.h),
              _buildModernTextField(
                controller: controller.stepTestHeartRateController,
                label: 'Heart Rate (BPM)',
                hint: 'Enter heart rate',
                icon: Icons.favorite,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          SizedBox(height: 3.h),
          
          _buildModernFitnessTestCard(
            'Sit and Reach Test',
            'Measure distance reached from black line.',
            'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/sitandreach.png',
            [
              _buildModernTextField(
                controller: controller.sitReach1Controller,
                label: 'Measurement 1st (cm)',
                hint: 'Enter first measurement',
                icon: Icons.straighten,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 2.h),
              _buildModernTextField(
                controller: controller.sitReach2Controller,
                label: 'Measurement 2nd (cm)',
                hint: 'Enter second measurement',
                icon: Icons.straighten,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 2.h),
              _buildModernTextField(
                controller: controller.sitReach3Controller,
                label: 'Measurement 3rd (cm)',
                hint: 'Enter third measurement',
                icon: Icons.straighten,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          
          _buildModernFitnessTestCard(
            'Knee Push Up',
            'Record the number of knee push ups you can do.',
            'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/kneepushupa.jpg',
            [
              _buildModernTextField(
                controller: controller.kneePushUpsController,
                label: 'No. of knee push ups',
                hint: 'Enter number of push ups',
                icon: Icons.fitness_center,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          SizedBox(height: 3.h),
          
          _buildModernFitnessTestCard(
            'Plank',
            'Record how many seconds you can hold this position.',
            'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/planka.jpg',
            [
              _buildModernTextField(
                controller: controller.plankSecondsController,
                label: 'No. of seconds',
                hint: 'Enter duration in seconds',
                icon: Icons.timer,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          SizedBox(height: 3.h),
          
          _buildModernFitnessTestCard(
            'Wall Sit',
            'Record how many seconds you can hold this position.',
            'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/wallsita.jpg',
            [
              _buildModernTextField(
                controller: controller.wallSitSecondsController,
                label: 'No. of seconds',
                hint: 'Enter duration in seconds',
                icon: Icons.timer,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          SizedBox(height: 3.h),
          
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: _buildModernTextField(
              controller: controller.mainGoalController,
              label: 'What is your main fitness goal?',
              hint: 'Describe your main fitness goal',
              icon: Icons.flag,
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.boldText.copyWith(
        fontSize: 18,
        color: AppColor.blackColor,
      ),
    );
  }

  Widget _buildModernSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColor.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColor.primaryColor,
            size: 24,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.boldText.copyWith(
              fontSize: 20,
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernLabel(String label) {
    return Text(
      label,
      style: AppTextStyle.mediumText.copyWith(
        fontSize: 16,
        color: Color(0xFF374151),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildModernLabel(label),
        SizedBox(height: 1.h),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE5E7EB)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 16,
              color: Color(0xFF374151),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyle.mediumText.copyWith(
                fontSize: 16,
                color: Color(0xFF9CA3AF),
              ),
              prefixIcon: Icon(
                icon,
                color: AppColor.primaryColor,
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? label,
    String? hint,
    TextInputType? keyboardType,
    bool isCompact = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label,
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 14,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(height: 1.h),
        ],
        Container(
          height: isCompact ? 5.h : 6.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppTextStyle.mediumText.copyWith(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyle.mediumText.copyWith(
                fontSize: 14,
                color: AppColor.greyColor,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Obx(() => Row(
      children: [
        Expanded(
          child: _buildPillButton(
            'Male',
            controller.assessmentData.value.gender == 'Male',
            () => controller.setGender('Male'),
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: _buildPillButton(
            'Female',
            controller.assessmentData.value.gender == 'Female',
            () => controller.setGender('Female'),
          ),
        ),
      ],
    ));
  }

  Widget _buildModernGenderSelector() {
    return Obx(() => Row(
      children: [
        Expanded(
          child: _buildModernPillButton(
            'Male',
            Icons.male,
            controller.assessmentData.value.gender == 'Male',
            () => controller.setGender('Male'),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _buildModernPillButton(
            'Female',
            Icons.female,
            controller.assessmentData.value.gender == 'Female',
            () => controller.setGender('Female'),
          ),
        ),
      ],
    ));
  }

  Widget _buildDatePicker() {
    return Obx(() => GestureDetector(
      onTap: controller.selectDateOfBirth,
      child: Container(
        height: 6.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            SizedBox(width: 3.w),
            Icon(Icons.calendar_today, color: AppColor.greyColor, size: 20),
            SizedBox(width: 2.w),
            Text(
              controller.formattedDateOfBirth.isEmpty 
                ? 'Select Date of Birth' 
                : controller.formattedDateOfBirth,
              style: AppTextStyle.mediumText.copyWith(
                fontSize: 14,
                color: controller.formattedDateOfBirth.isEmpty 
                  ? AppColor.greyColor 
                  : AppColor.blackColor,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildModernDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildModernLabel('Date of Birth'),
        SizedBox(height: 1.h),
        Obx(() => GestureDetector(
          onTap: controller.selectDateOfBirth,
          child: Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                SizedBox(width: 4.w),
                Icon(Icons.calendar_today, color: AppColor.primaryColor, size: 20),
                SizedBox(width: 3.w),
                Text(
                  controller.formattedDateOfBirth.isEmpty 
                    ? 'Select Date of Birth' 
                    : controller.formattedDateOfBirth,
                  style: AppTextStyle.mediumText.copyWith(
                    fontSize: 16,
                    color: controller.formattedDateOfBirth.isEmpty 
                      ? Color(0xFF9CA3AF)
                      : Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildYesNoQuestion(String question, bool? value, Function(bool) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: AppTextStyle.mediumText.copyWith(
            fontSize: 14,
            color: AppColor.blackColor,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Expanded(
              child: _buildYesNoButton(
                'Yes',
                value == true,
                () => onChanged(true),
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: _buildYesNoButton(
                'No',
                value == false,
                () => onChanged(false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildYesNoButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected 
                ? (text == 'Yes' ? Icons.check : Icons.close)
                : (text == 'Yes' ? Icons.add : Icons.remove),
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 16,
            ),
            SizedBox(width: 1.w),
            Text(
              text,
              style: AppTextStyle.mediumText.copyWith(
                fontSize: 14,
                color: isSelected ? Colors.white : AppColor.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPillButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : Colors.grey[300]!,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 14,
              color: isSelected ? Colors.white : AppColor.blackColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernPillButton(String text, IconData icon, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 6.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : Color(0xFFE5E7EB),
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColor.primaryColor.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ] : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColor.primaryColor,
              size: 20,
            ),
            SizedBox(width: 2.w),
            Text(
              text,
              style: AppTextStyle.mediumText.copyWith(
                fontSize: 16,
                color: isSelected ? Colors.white : Color(0xFF374151),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthConditionsList() {
    return Obx(() => Column(
      children: FitnessAssessmentModel.healthConditionsList.map((condition) =>
        _buildHealthConditionItem(condition)
      ).toList(),
    ));
  }

  Widget _buildHealthConditionItem(String condition) {
    bool isSelected = controller.assessmentData.value.healthConditions.contains(condition);
    
    return GestureDetector(
      onTap: () => controller.toggleHealthCondition(condition),
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected ? AppColor.primaryColor : Colors.grey[400]!,
                ),
              ),
              child: isSelected
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : null,
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                condition,
                style: AppTextStyle.mediumText.copyWith(
                  fontSize: 12,
                  color: AppColor.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalRatingItem(String goal) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            goal,
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 14,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(height: 1.h),
          _buildStarRating(goal),
        ],
      ),
    );
  }

  Widget _buildModernGoalRatingItem(String goal) {
    return Obx(() {
      int rating = controller.getGoalRating(goal);
      return Container(
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: rating > 0 ? AppColor.primaryColor.withOpacity(0.05) : Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: rating > 0 ? AppColor.primaryColor.withOpacity(0.3) : Color(0xFFE5E7EB),
            width: rating > 0 ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    goal,
                    style: AppTextStyle.mediumText.copyWith(
                      fontSize: 16,
                      color: Color(0xFF374151),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (rating > 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$rating/5',
                      style: AppTextStyle.mediumText.copyWith(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 1.5.h),
            _buildModernStarRating(goal),
          ],
        ),
      );
    });
  }

  Widget _buildModernYesNoQuestion(String question, bool? value, Function(bool) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: AppTextStyle.mediumText.copyWith(
            fontSize: 16,
            color: Color(0xFF374151),
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Expanded(
              child: _buildModernYesNoButton(
                'Yes',
                value == true,
                () => onChanged(true),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: _buildModernYesNoButton(
                'No',
                value == false,
                () => onChanged(false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModernYesNoButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 6.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : Color(0xFFE5E7EB),
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColor.primaryColor.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ] : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected 
                ? (text == 'Yes' ? Icons.check_circle : Icons.cancel)
                : (text == 'Yes' ? Icons.add_circle_outline : Icons.remove_circle_outline),
              color: isSelected ? Colors.white : AppColor.primaryColor,
              size: 20,
            ),
            SizedBox(width: 2.w),
            Text(
              text,
              style: AppTextStyle.mediumText.copyWith(
                fontSize: 16,
                color: isSelected ? Colors.white : Color(0xFF374151),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernStarRating(String goal) {
    return Obx(() => Row(
      children: List.generate(5, (index) {
        int rating = controller.getGoalRating(goal);
        bool isSelected = index < rating;
        
        return GestureDetector(
          onTap: () => controller.setGoalRating(goal, index + 1),
          child: Container(
            margin: EdgeInsets.only(right: 2.w),
            padding: EdgeInsets.all(1.w),
            child: Icon(
              isSelected ? Icons.star : Icons.star_border,
              color: isSelected ? Colors.amber[600] : Color(0xFFD1D5DB),
              size: 28,
            ),
          ),
        );
      }),
    ));
  }

  Widget _buildModernHealthConditionsList() {
    return Obx(() => Column(
      children: FitnessAssessmentModel.healthConditionsList.map((condition) =>
        _buildModernHealthConditionItem(condition)
      ).toList(),
    ));
  }

  Widget _buildModernHealthConditionItem(String condition) {
    bool isSelected = controller.assessmentData.value.healthConditions.contains(condition);
    
    return GestureDetector(
      onTap: () => controller.toggleHealthCondition(condition),
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? AppColor.primaryColor : Color(0xFFD1D5DB),
                ),
              ),
              child: isSelected
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : null,
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                condition,
                style: AppTextStyle.mediumText.copyWith(
                  fontSize: 14,
                  color: isSelected ? AppColor.primaryColor : Color(0xFF374151),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating(String goal) {
    return Obx(() => Row(
      children: List.generate(5, (index) {
        int rating = controller.getGoalRating(goal);
        return GestureDetector(
          onTap: () => controller.setGoalRating(goal, index + 1),
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: AppColor.primaryColor,
            size: 20,
          ),
        );
      }),
    ));
  }

  Widget _buildGirthMeasurements() {
    return Column(
      children: [
        _buildTextField(
          controller: controller.neckController,
          label: 'Neck (cm)',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildTextField(
          controller: controller.chestController,
          label: 'Chest (cm)',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildTextField(
          controller: controller.bicepController,
          label: 'Bicep (cm)',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildTextField(
          controller: controller.forearmController,
          label: 'Forearm (cm)',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildTextField(
          controller: controller.waistController,
          label: 'Waist (cm)',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildTextField(
          controller: controller.hipController,
          label: 'Hip (cm)',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildTextField(
          controller: controller.thighController,
          label: 'Thigh (cm)',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildTextField(
          controller: controller.calfController,
          label: 'Calf (cm)',
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
      ],
    );
  }

  Widget _buildModernGirthMeasurements() {
    return Column(
      children: [
        _buildModernTextField(
          controller: controller.neckController,
          label: 'Neck (cm)',
          hint: 'Enter neck measurement',
          icon: Icons.straighten,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildModernTextField(
          controller: controller.chestController,
          label: 'Chest (cm)',
          hint: 'Enter chest measurement',
          icon: Icons.straighten,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildModernTextField(
          controller: controller.bicepController,
          label: 'Bicep (cm)',
          hint: 'Enter bicep measurement',
          icon: Icons.straighten,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildModernTextField(
          controller: controller.forearmController,
          label: 'Forearm (cm)',
          hint: 'Enter forearm measurement',
          icon: Icons.straighten,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildModernTextField(
          controller: controller.waistController,
          label: 'Waist (cm)',
          hint: 'Enter waist measurement',
          icon: Icons.straighten,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildModernTextField(
          controller: controller.hipController,
          label: 'Hip (cm)',
          hint: 'Enter hip measurement',
          icon: Icons.straighten,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildModernTextField(
          controller: controller.thighController,
          label: 'Thigh (cm)',
          hint: 'Enter thigh measurement',
          icon: Icons.straighten,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 2.h),
        _buildModernTextField(
          controller: controller.calfController,
          label: 'Calf (cm)',
          hint: 'Enter calf measurement',
          icon: Icons.straighten,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
      ],
    );
  }

  Widget _buildFitnessTestCard(String title, String instruction, IconData icon, List<Widget> inputFields) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColor.primaryColor, size: 24),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.boldText.copyWith(
                    fontSize: 16,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            instruction,
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 12,
              color: AppColor.greyColor,
            ),
          ),
          SizedBox(height: 2.h),
          ...inputFields.map((field) => Column(
            children: [
              field,
              SizedBox(height: 1.h),
            ],
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildModernFitnessTestCard(String title, String instruction, String imageUrl, List<Widget> inputFields) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Container(
            height: 25.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Color(0xFFF9FAFB),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  print('Fitness test image load error: $error');
                  return Container(
                    color: Color(0xFFF9FAFB),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: Color(0xFF9CA3AF),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Image not available',
                            style: AppTextStyle.mediumText.copyWith(
                              fontSize: 12,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Content section
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.boldText.copyWith(
                    fontSize: 18,
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  instruction,
                  style: AppTextStyle.mediumText.copyWith(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 3.h),
                ...inputFields,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Obx(() => Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              if (controller.currentPage.value > 0) ...[
                Expanded(
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color(0xFFE5E7EB)),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: controller.previousPage,
                        borderRadius: BorderRadius.circular(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xFF374151),
                              size: 18,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              'Previous',
                              style: AppTextStyle.mediumText.copyWith(
                                fontSize: 16,
                                color: Color(0xFF374151),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
              ],
              Expanded(
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    gradient: controller.canGoNext || controller.currentPage.value == 5
                      ? LinearGradient(
                          colors: [AppColor.primaryColor, AppColor.primaryColor.withOpacity(0.8)],
                        )
                      : null,
                    color: controller.canGoNext || controller.currentPage.value == 5
                      ? null
                      : Color(0xFF9CA3AF),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: controller.canGoNext || controller.currentPage.value == 5
                      ? [
                          BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.3),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ]
                      : null,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: controller.currentPage.value == 5 
                        ? controller.submitForm 
                        : (controller.canGoNext ? controller.nextPage : null),
                      borderRadius: BorderRadius.circular(16),
                      child: Obx(() => controller.isSubmitting.value
                        ? Center(
                            child: SizedBox(
                              height: 2.5.h,
                              width: 2.5.h,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.currentPage.value == 5 ? 'Submit Assessment' : 'Next Step',
                                style: AppTextStyle.mediumText.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (controller.currentPage.value != 5) ...[
                                SizedBox(width: 1.w),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ],
                          ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
