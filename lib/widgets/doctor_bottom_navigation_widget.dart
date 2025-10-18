import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Themes/app_colors_theme.dart';
import '../Themes/app_text_theme.dart';
import '../Modules/doctor_home/doctor_home_controller.dart';

class DoctorBottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const DoctorBottomNavigationWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: AppTextStyle.mediumText.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyle.mediumText.copyWith(
          fontSize: 12,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 0 
                ? Icons.home 
                : Icons.home_outlined,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 1 
                ? Icons.medication 
                : Icons.medication_outlined,
              size: 24,
            ),
            label: 'Prescription',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 2 
                ? Icons.connect_without_contact 
                : Icons.connect_without_contact_outlined,
              size: 24,
            ),
            label: 'Connect',
          ),
        ],
      ),
    );
  }
}
