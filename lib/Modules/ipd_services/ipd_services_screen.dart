import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../model/ipd_services_model.dart';
import 'ipd_services_controller.dart';

class IpdServicesScreen extends StatefulWidget {
  @override
  State<IpdServicesScreen> createState() => _IpdServicesScreenState();
}

class _IpdServicesScreenState extends State<IpdServicesScreen> {
  final IpdServicesController controller = Get.put(IpdServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'IPD Services',
          style: AppTextStyle.boldText.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (controller.ipdData.value == null) {
          return Center(child: CircularProgressIndicator());
        }
        
        return SingleChildScrollView(
          child: Column(
            children: [
              // Navigation Tabs
              navigationTabs(),
              
              // Patient Information Card
              patientInfoCard(),
              
              // Today's Schedule Card
              todayScheduleCard(),
              
              // Vital Statistics Card
              vitalStatisticsCard(),
              
              // Recent Documents Card
              recentDocumentsCard(),
              
              // Insurance Coverage Card
              insuranceCoverageCard(),
              
              SizedBox(height: 2.h),
            ],
          ),
        );
      }),
      bottomNavigationBar: bottomActionButtons(),
    );
  }

  Widget navigationTabs() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: controller.tabs.asMap().entries.map((entry) {
          int index = entry.key;
          String tab = entry.value;
          bool isSelected = controller.selectedTab.value == index;
          
          return GestureDetector(
            onTap: () => controller.selectTab(index),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected 
                        ? Color(0xFF4DB6AC) // Teal color
                        : Color(0xFFE0F2F1), // Light teal
                  ),
                  child: Icon(
                    _getTabIcon(tab),
                    color: isSelected ? Colors.white : Color(0xFF4DB6AC),
                    size: 24,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  tab,
                  style: AppTextStyle.mediumText.copyWith(
                    color: isSelected ? Color(0xFF4DB6AC) : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getTabIcon(String tab) {
    switch (tab) {
      case 'Admission':
        return Icons.add_circle_outline;
      case 'Bed Status':
        return Icons.bed;
      case 'Treatment':
        return Icons.healing;
      case 'Discharge':
        return Icons.exit_to_app;
      default:
        return Icons.circle;
    }
  }

  Widget patientInfoCard() {
    final data = controller.ipdData.value!;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Color(0xFFE0F2F1), // Light teal background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Patient Name and Room
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.patientName ?? "",
                      style: AppTextStyle.boldText.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "${data.roomNumber} - ${data.wardType}",
                      style: AppTextStyle.mediumText.copyWith(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data.status ?? "",
                  style: AppTextStyle.mediumText.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 2.h),
          
          // Treatment Progress
          Text(
            "Treatment Progress",
            style: AppTextStyle.mediumText.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: data.treatmentProgress ?? 0.0,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2196F3)),
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                "${((data.treatmentProgress ?? 0.0) * 100).toInt()}%",
                style: AppTextStyle.boldText.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 1.h),
          
          // Admission Date
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: Colors.black.withOpacity(0.6),
                size: 16,
              ),
              SizedBox(width: 1.w),
              Text(
                "Since: ${data.admissionDate}",
                style: AppTextStyle.mediumText.copyWith(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget todayScheduleCard() {
    final data = controller.ipdData.value!;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Schedule",
            style: AppTextStyle.boldText.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 2.h),
          
          // Schedule Items
          ...data.todaySchedule!.asMap().entries.map((entry) {
            int index = entry.key;
            ScheduleItem item = entry.value;
            bool isLast = index == data.todaySchedule!.length - 1;
            
            return scheduleItem(item, isLast);
          }).toList(),
        ],
      ),
    );
  }

  Widget scheduleItem(ScheduleItem item, bool isLast) {
    return Row(
      children: [
        // Timeline dot and line
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.getDotColor(item.dotColor ?? "grey"),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: Colors.grey.withOpacity(0.3),
              ),
          ],
        ),
        
        SizedBox(width: 3.w),
        
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title ?? "",
                style: AppTextStyle.boldText.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                item.time ?? "",
                style: AppTextStyle.mediumText.copyWith(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        
        // Status
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: controller.getStatusColor(item.status ?? "").withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            item.status ?? "",
            style: AppTextStyle.mediumText.copyWith(
              color: controller.getStatusColor(item.status ?? ""),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget vitalStatisticsCard() {
    final data = controller.ipdData.value!;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vital Statistics",
            style: AppTextStyle.boldText.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 2.h),
          
          // Vital signs grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 2.w,
              mainAxisSpacing: 2.h,
            ),
            itemCount: data.vitalSigns!.length,
            itemBuilder: (context, index) {
              VitalSign vital = data.vitalSigns![index];
              return vitalSignItem(vital);
            },
          ),
        ],
      ),
    );
  }

  Widget vitalSignItem(VitalSign vital) {
    return Row(
      children: [
        Icon(
          controller.getVitalIcon(vital.icon ?? ""),
          color: Color(0xFF2196F3),
          size: 20,
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                vital.name ?? "",
                style: AppTextStyle.mediumText.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              Text(
                "${vital.value}${vital.unit}",
                style: AppTextStyle.boldText.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Text(
          vital.status ?? "",
          style: AppTextStyle.mediumText.copyWith(
            color: controller.getStatusColor(vital.status ?? ""),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget recentDocumentsCard() {
    final data = controller.ipdData.value!;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Documents",
            style: AppTextStyle.boldText.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 2.h),
          
          // Documents list
          ...data.recentDocuments!.map((document) => documentItem(document)).toList(),
        ],
      ),
    );
  }

  Widget documentItem(Document document) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF2196F3).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.description,
              color: Color(0xFF2196F3),
              size: 20,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.title ?? "",
                  style: AppTextStyle.boldText.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  document.date ?? "",
                  style: AppTextStyle.mediumText.copyWith(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.downloadDocument(document),
            icon: Icon(
              Icons.download,
              color: Color(0xFF2196F3),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget insuranceCoverageCard() {
    final data = controller.ipdData.value!;
    final insurance = data.insuranceInfo!;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Insurance Coverage",
            style: AppTextStyle.boldText.copyWith(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 2.h),
          
          // Provider and Policy
          Text(
            "Provider: ${insurance.provider}",
            style: AppTextStyle.mediumText.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "Policy: ${insurance.policyNumber}",
            style: AppTextStyle.mediumText.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 2.h),
          
          // Claim Status
          Text(
            "Claim Status",
            style: AppTextStyle.mediumText.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: insurance.claimProgress ?? 0.0,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2196F3)),
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                insurance.claimStatus ?? "",
                style: AppTextStyle.boldText.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomActionButtons() {
    return Container(
      padding: EdgeInsets.all(4.w),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: controller.callEmergency,
              icon: Icon(Icons.phone, color: Colors.white),
              label: Text(
                'Emergency',
                style: AppTextStyle.mediumText.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4DB6AC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 3.h),
                elevation: 0,
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: controller.callNurse,
              icon: Icon(Icons.person, color: Colors.white),
              label: Text(
                'Call Nurse',
                style: AppTextStyle.mediumText.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4DB6AC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 3.h),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
