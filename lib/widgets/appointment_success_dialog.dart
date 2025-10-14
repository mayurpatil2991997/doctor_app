import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Themes/app_colors_theme.dart';
import '../Themes/app_text_theme.dart';

class AppointmentSuccessDialog extends StatelessWidget {
  final String doctorName;
  final String appointmentDate;
  final String appointmentTime;
  final VoidCallback? onClose;

  const AppointmentSuccessDialog({
    Key? key,
    required this.doctorName,
    required this.appointmentDate,
    required this.appointmentTime,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.1),
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 12.w,
              ),
            ),
            
            SizedBox(height: 3.h),
            
            // Success Title
            Text(
              'Appointment Booked!',
              style: AppTextStyle.boldText.copyWith(
                color: AppColor.blackColor,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 2.h),
            
            // Appointment Details
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    icon: Icons.person,
                    label: 'Doctor',
                    value: doctorName,
                  ),
                  SizedBox(height: 1.h),
                  _buildDetailRow(
                    icon: Icons.calendar_today,
                    label: 'Date',
                    value: appointmentDate,
                  ),
                  SizedBox(height: 1.h),
                  _buildDetailRow(
                    icon: Icons.access_time,
                    label: 'Time',
                    value: appointmentTime,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 3.h),
            
            // Success Message
            Text(
              'Your appointment has been successfully booked. You will receive a confirmation shortly.',
              style: AppTextStyle.mediumText.copyWith(
                color: AppColor.greyColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 3.h),
            
            // Close Button
            Container(
              width: double.infinity,
              height: 6.h,
              child: ElevatedButton(
                onPressed: () {
                  Get.back(); // Close dialog
                  if (onClose != null) {
                    onClose!();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Done',
                  style: AppTextStyle.boldText.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColor.primaryColor,
          size: 5.w,
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyle.mediumText.copyWith(
                  color: AppColor.greyColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                value,
                style: AppTextStyle.boldText.copyWith(
                  color: AppColor.blackColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Static method to show dialog
  static void show({
    required String doctorName,
    required String appointmentDate,
    required String appointmentTime,
    VoidCallback? onClose,
  }) {
    Get.dialog(
      AppointmentSuccessDialog(
        doctorName: doctorName,
        appointmentDate: appointmentDate,
        appointmentTime: appointmentTime,
        onClose: onClose,
      ),
      barrierDismissible: false,
    );
  }
}
