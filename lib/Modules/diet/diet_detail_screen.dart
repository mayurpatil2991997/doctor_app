import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Themes/app_text_theme.dart';
import '../../Themes/app_colors_theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DietDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map args = Get.arguments ?? {};
    final String title = args['title'] ?? 'Meal';
    final String imageAsset = args['imageAsset'] ?? '';
    final int calories = args['calories'] ?? 0;
    final int protein = args['protein'] ?? 0;
    final int carbs = args['carbs'] ?? 0;
    final List ingredients = args['ingredients'] ?? [];
    final List steps = args['steps'] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    imageAsset,
                    width: double.infinity,
                    height: 28.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 3.w,
                    top: 2.h,
                    child: _circleIcon(Icons.arrow_back, () => Get.back()),
                  ),
                  Positioned(
                    right: 3.w,
                    top: 2.h,
                    child: _circleIcon(Icons.favorite_border, () {}),
                  ),
                  Positioned(
                    left: 3.w,
                    bottom: 2.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        title,
                        style: AppTextStyle.boldText.copyWith(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2.h),
              _macrosRow(calories: calories, protein: protein, carbs: carbs),
              SizedBox(height: 2.h),

              _sectionTitle('Ingredients'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: ingredients.map<Widget>((ing) {
                    return _ingredientRow(ing['name'] ?? '', ing['amount'] ?? '');
                  }).toList(),
                ),
              ),

              SizedBox(height: 2.h),
              _sectionTitle('Recipe Steps'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: steps.asMap().entries.map<Widget>((e) {
                    final idx = e.key + 1;
                    final text = e.value.toString();
                    return _stepRow(idx, text);
                  }).toList(),
                ),
              ),

              SizedBox(height: 2.h),
              _sectionTitle('Multimedia'),
              _multimediaRow(imageAsset),

              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }

  Widget _macrosRow({required int calories, required int protein, required int carbs}) {
    Widget pill(String label, String value) {
      return Container(
        width: 28.w,
        padding: EdgeInsets.symmetric(vertical: 1.4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(label, style: AppTextStyle.mediumText.copyWith(color: Colors.grey[700], fontSize: 12)),
            SizedBox(height: 0.4.h),
            Text(value, style: AppTextStyle.boldText.copyWith(color: Colors.black, fontSize: 15)),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          pill('Calories', '$calories'),
          pill('Protein', '${protein}g'),
          pill('Carbs', '${carbs}g'),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Text(
        text,
        style: AppTextStyle.boldText.copyWith(color: Colors.black, fontSize: 16),
      ),
    );
  }

  Widget _ingredientRow(String name, String amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.2.h),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.eco, color: AppColor.primaryColor, size: 16),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyle.mediumText.copyWith(color: Colors.black)),
                SizedBox(height: 0.2.h),
                Text(amount, style: AppTextStyle.mediumText.copyWith(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepRow(int index, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text('$index', style: AppTextStyle.boldText.copyWith(color: Colors.white, fontSize: 12)),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.mediumText.copyWith(color: Colors.black.withOpacity(0.7), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _multimediaRow(String imageAsset) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Embedded YouTube player on mobile only; on web, show an opener tile
          if (!kIsWeb)
            Container(
              height: 22.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: WebViewWidget(
                controller: _buildYoutubeWebViewController(
                  'https://www.youtube.com/embed/dXl2NdlmeIE',
                ),
              ),
            )
          else
            GestureDetector(
              onTap: _openVideo,
              child: _videoTile(),
            ),
          SizedBox(height: 1.5.h),
          GestureDetector(
            onTap: _openPDF,
            child: _pdfTile(),
          ),
        ],
      ),
    );
  }

  WebViewController _buildYoutubeWebViewController(String embedUrl) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(embedUrl));
    return controller;
  }

  Widget _pdfTile() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.picture_as_pdf, color: Colors.red),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dietary Guidelines PDF',
                  style: AppTextStyle.boldText.copyWith(color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: 0.3.h),
                Text(
                  'Open the official Dietary Guidelines for Indians (NIN)',
                  style: AppTextStyle.mediumText.copyWith(color: Colors.grey[700], fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16),
        ],
      ),
    );
  }

  Widget _videoTile() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_circle_filled, color: Colors.red),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Video Tutorial',
                  style: AppTextStyle.boldText.copyWith(color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: 0.3.h),
                Text(
                  'Open on YouTube',
                  style: AppTextStyle.mediumText.copyWith(color: Colors.grey[700], fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16),
        ],
      ),
    );
  }

  Widget _mediaCard(String image, String caption, IconData icon, Color iconColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: 60.w,
                  height: 16.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(icon, color: iconColor, size: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 0.8.h),
          Text(
            caption,
            style: AppTextStyle.mediumText.copyWith(
              color: Colors.black, 
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _openVideo() {
    // YouTube URL for recipe tutorial
    const String youtubeUrl = 'https://youtu.be/dXl2NdlmeIE?si=daoGe71ACUOdB7Z7';
    
    Get.snackbar(
      'Opening YouTube',
      'Redirecting to video tutorial...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
    
    launchUrl(Uri.parse(youtubeUrl), mode: LaunchMode.externalApplication);
  }

  void _openPDF() {
    // PDF URL for Dietary Guidelines for Indians
    const String pdfUrl = 'https://www.nin.res.in/downloads/DietaryGuidelinesforNINwebsite.pdf';
    
    Get.snackbar(
      'Opening PDF',
      'Loading dietary guidelines...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
    
    launchUrl(Uri.parse(pdfUrl), mode: LaunchMode.externalApplication);
  }

  void _openNutritionGuide() {
    Get.snackbar(
      'Nutrition Guide',
      'Opening nutrition guide...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

}


