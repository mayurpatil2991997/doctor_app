import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../widgets/common_card_widget.dart';
import '../../widgets/common_button_widget.dart';
import 'connect_controller.dart';

class ConnectScreen extends StatefulWidget {
  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> with TickerProviderStateMixin {
  final ConnectController controller = Get.put(ConnectController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      controller.onTabChanged(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(12.h),
        child: _buildHeader(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            
            // Patient Information Card (moved from doctor home)
            _buildPatientCard(),
            SizedBox(height: 2.h),
            
            // Connect Options Section
            _buildConnectOptionsSection(),
            SizedBox(height: 2.h),
            
            // Quick Actions Section
            _buildQuickActionsSection(),
            SizedBox(height: 2.h),
            
            // Recent Activity Section
            _buildRecentActivitySection(),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.primaryColor,
            AppColor.primaryColor.withOpacity(0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColor.whiteColor,
                        size: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  
                  // Title
                  Expanded(
                    child: Center(
                      child: Text(
                        "Connect",
                        style: AppTextStyle.boldText.copyWith(
                          fontSize: 20.sp,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  
                  // Settings Icon
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.settings,
                      color: AppColor.whiteColor,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientCard() {
    return CommonCardWidget(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "YOUR PATIENT",
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 12,
              color: AppColor.primaryColor,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. Amelia Harper",
                      style: AppTextStyle.boldText.copyWith(
                        fontSize: 18,
                        color: AppColor.blackColor,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "Physiotherapist",
                      style: AppTextStyle.mediumText.copyWith(
                        fontSize: 14,
                        color: AppColor.greyColor,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColor.greyColor,
                          size: 16,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          "Room 302, West Wing",
                          style: AppTextStyle.mediumText.copyWith(
                            fontSize: 12,
                            color: AppColor.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 4.h,
                backgroundImage: AssetImage("assets/images/doctor.png"),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: CommonButtonWidget(
                  onPressed: controller.onCallPatient,
                  text: "Call",
                  backgroundColor: AppColor.primaryColor,
                  textColor: Colors.white,
                  icon: Icons.phone,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: CommonButtonWidget(
                  onPressed: controller.onMessagePatient,
                  text: "Message",
                  backgroundColor: Colors.grey[300]!,
                  textColor: AppColor.blackColor,
                  icon: Icons.message,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConnectOptionsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Connect Options",
            style: AppTextStyle.boldText.copyWith(
              fontSize: 18,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(height: 1.h),
          Obx(() => Column(
            children: controller.connectOptions.map((option) {
              return Container(
                margin: EdgeInsets.only(bottom: 1.h),
                child: CommonCardWidget(
                  onTap: option.onTap,
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          color: option.color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          option.icon,
                          color: option.color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.title,
                              style: AppTextStyle.boldText.copyWith(
                                fontSize: 16,
                                color: AppColor.blackColor,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              option.subtitle,
                              style: AppTextStyle.mediumText.copyWith(
                                fontSize: 14,
                                color: AppColor.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.greyColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: AppTextStyle.boldText.copyWith(
              fontSize: 18,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  title: "Share Files",
                  icon: Icons.share,
                  color: Colors.blue,
                  onTap: () => Get.snackbar("Share Files", "Opening file sharing..."),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildQuickActionCard(
                  title: "Schedule",
                  icon: Icons.schedule,
                  color: Colors.green,
                  onTap: () => Get.snackbar("Schedule", "Opening scheduler..."),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildQuickActionCard(
                  title: "Notes",
                  icon: Icons.note_add,
                  color: Colors.orange,
                  onTap: () => Get.snackbar("Notes", "Opening notes..."),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              title,
              style: AppTextStyle.mediumText.copyWith(
                fontSize: 12,
                color: AppColor.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Activity",
            style: AppTextStyle.boldText.copyWith(
              fontSize: 18,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(height: 1.h),
          CommonCardWidget(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                _buildActivityItem(
                  icon: Icons.chat,
                  title: "Chat Message",
                  subtitle: "Received message from Dr. Amelia Harper",
                  time: "2 minutes ago",
                  color: Colors.blue,
                ),
                Divider(),
                _buildActivityItem(
                  icon: Icons.videocam,
                  title: "Video Call",
                  subtitle: "Completed video consultation",
                  time: "1 hour ago",
                  color: Colors.green,
                ),
                Divider(),
                _buildActivityItem(
                  icon: Icons.file_upload,
                  title: "File Shared",
                  subtitle: "Shared medical report",
                  time: "3 hours ago",
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 18,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.boldText.copyWith(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                ),
                SizedBox(height: 0.2.h),
                Text(
                  subtitle,
                  style: AppTextStyle.mediumText.copyWith(
                    fontSize: 12,
                    color: AppColor.greyColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 10,
              color: AppColor.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
