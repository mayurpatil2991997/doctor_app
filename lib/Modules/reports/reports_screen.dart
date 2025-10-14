import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import 'reports_controller.dart';
import '../../model/report_model.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportsController>(
      builder: (controller) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(controller),
          _buildHeader(controller),
          _buildReportsList(controller),
        ],
      ),
      bottomNavigationBar: _buildUploadButton(controller),
    );
      },
    );
  }

  void _showFilterSheet(ReportsController controller) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Filter Reports',
                style: AppTextStyle.boldText.copyWith(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.filterOptions.map((opt) {
                  final isSelected = controller.selectedFilter.value == opt;
                  return GestureDetector(
                    onTap: () {
                      controller.selectFilter(opt);
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColor.primaryColor.withOpacity(0.1) : Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColor.primaryColor : Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Text(
                        opt,
                        style: AppTextStyle.mediumText.copyWith(
                          fontSize: 13,
                          color: isSelected ? AppColor.primaryColor : Color(0xFF475569),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.1),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 16,
          ),
        ),
      ),
      title: Text(
        'Reports',
        style: AppTextStyle.boldText.copyWith(
          fontSize: 20,
          color: Colors.black87,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildTabBar(ReportsController controller) {
    return Obx(() => Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Container(
        height: 5.5.h,
        decoration: BoxDecoration(
          color: Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildTabItem(
                'My Reports',
                0,
                controller.selectedTabIndex.value == 0,
                controller,
              ),
            ),
            Expanded(
              child: _buildTabItem(
                'Shared with Me',
                1,
                controller.selectedTabIndex.value == 1,
                controller,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildTabItem(String title, int index, bool isSelected, ReportsController controller) {
    return GestureDetector(
      onTap: () => controller.selectTab(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColor.primaryColor.withOpacity(0.12),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.mediumText.copyWith(
            fontSize: 14,
            color: isSelected ? AppColor.primaryColor : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ReportsController controller) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  controller.selectedTabIndex.value == 0 ? 'My Reports' : 'Shared with Me',
                  style: AppTextStyle.boldText.copyWith(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _buildFilterButton(controller),
            ],
          ),
          SizedBox(height: 1.5.h),
          _buildSearchBar(controller),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ReportsController controller) {
    return Container(
      height: 5.2.h,
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Row(
        children: [
          Icon(Icons.search, color: Color(0xFF64748B), size: 18),
          SizedBox(width: 2.w),
          Expanded(
            child: TextField(
              onChanged: controller.searchReports,
              decoration: InputDecoration(
                hintText: 'Search reports, tags or doctor...',
                hintStyle: AppTextStyle.mediumText.copyWith(
                  fontSize: 13,
                  color: Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(ReportsController controller) {
    return GestureDetector(
      onTap: () => _showFilterSheet(controller),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.filter_list,
              size: 16,
              color: Colors.grey[600],
            ),
            SizedBox(width: 1.w),
            Obx(() => Text(
              controller.selectedFilter.value == 'All' ? 'Filter' : controller.selectedFilter.value,
              style: AppTextStyle.mediumText.copyWith(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsList(ReportsController controller) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        }

        if (controller.filteredReportsList.isEmpty) {
          return _buildEmptyState(controller);
        }

        return RefreshIndicator(
          onRefresh: () async => controller.refreshReports(),
          color: AppColor.primaryColor,
          child: ListView.builder(
            padding: EdgeInsets.all(4.w),
            itemCount: controller.filteredReportsList.length,
            itemBuilder: (context, index) {
              final report = controller.filteredReportsList[index];
              return _buildReportCard(report, controller);
            },
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState(ReportsController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 2.h),
          Text(
            'No Reports Found',
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            controller.selectedTabIndex.value == 0 
              ? 'Upload your first report to get started'
              : 'No reports have been shared with you yet',
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          ElevatedButton.icon(
            onPressed: controller.uploadReport,
            icon: Icon(Icons.upload, color: Colors.white),
            label: Text(
              'Upload Report',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(ReportItem report, ReportsController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
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
          // Thumbnail and content
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: report.thumbnailUrl != null
                      ? Image.network(
                          report.thumbnailUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildDefaultThumbnail(report.type);
                          },
                        )
                      : _buildDefaultThumbnail(report.type),
                  ),
                ),
                SizedBox(width: 3.w),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        report.title ?? 'Untitled Report',
                        style: AppTextStyle.boldText.copyWith(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      
                      // Status and visibility
                      Wrap(
                        spacing: 2.w,
                        runSpacing: 1.h,
                        children: [
                          _buildStatusChip(report.visibility, report.visibilityColor),
                          _buildStatusChip(report.status, report.statusColor),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      
                      // Details
                      Text(
                        'Uploaded by ${report.uploadedBy} · ${report.uploadDate}',
                        style: AppTextStyle.mediumText.copyWith(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Actions
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    'View',
                    Icons.visibility,
                    AppColor.primaryColor,
                    () => controller.viewReport(report),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildActionButton(
                    'Share',
                    Icons.share,
                    Colors.grey[700]!,
                    () => controller.shareReport(report),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultThumbnail(String? type) {
    IconData icon;
    Color color;
    
    switch (type?.toLowerCase()) {
      case 'blood test':
        icon = Icons.bloodtype;
        color = Colors.red[400]!;
        break;
      case 'x-ray':
        icon = Icons.camera_alt;
        color = Colors.blue[400]!;
        break;
      case 'discharge summary':
        icon = Icons.description;
        color = Colors.teal[400]!;
        break;
      default:
        icon = Icons.assignment;
        color = Colors.grey[400]!;
    }
    
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: color,
        size: 24,
      ),
    );
  }

  Widget _buildStatusChip(String? text, String? color) {
    if (text == null) return SizedBox.shrink();
    
    Color chipColor = _getColorFromString(color);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: AppTextStyle.mediumText.copyWith(
          fontSize: 10,
          color: chipColor,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: color,
            ),
            SizedBox(width: 1.w),
            Text(
              text,
              style: AppTextStyle.mediumText.copyWith(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton(ReportsController controller) {
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
        child: Container(
          width: double.infinity,
          height: 6.h,
          child: ElevatedButton.icon(
            onPressed: controller.isUploading.value ? null : controller.uploadReport,
            icon: controller.isUploading.value
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Icon(Icons.add, color: Colors.white),
            label: Text(
              controller.isUploading.value ? 'Uploading...' : 'Upload New Report',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
          ),
        ),
      ),
    ));
  }

  Color _getColorFromString(String? colorString) {
    if (colorString == null) return Colors.grey;
    
    switch (colorString.toLowerCase()) {
      case 'visible to doctor':
        return Colors.green;
      case 'visible to patient':
        return Colors.blue;
      case 'private':
        return Colors.grey;
      case 'shared':
        return Colors.purple;
      case 'pending review':
        return Colors.orange;
      case 'reviewed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

// Extension for ReportItem to get colors
extension ReportItemExtension on ReportItem {
  String? get visibilityColor {
    switch (visibility?.toLowerCase()) {
      case 'visible to doctor':
        return '#10B981'; // Green
      case 'visible to patient':
        return '#3B82F6'; // Blue
      case 'private':
        return '#6B7280'; // Gray
      case 'shared':
        return '#8B5CF6'; // Purple
      default:
        return '#6B7280';
    }
  }

  String? get statusColor {
    switch (status?.toLowerCase()) {
      case 'pending review':
        return '#F59E0B'; // Amber
      case 'reviewed':
        return '#10B981'; // Green
      case 'approved':
        return '#059669'; // Emerald
      case 'rejected':
        return '#EF4444'; // Red
      default:
        return '#6B7280';
    }
  }
}
