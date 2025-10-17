import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import 'rehab_controller.dart';

class RehabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RehabController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: _buildAppBar(),
          body: Column(
            children: [
              _buildTabBar(controller),
              _buildHeader(controller),
              _buildContent(controller),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.06),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Rehab',
        style: AppTextStyle.boldText.copyWith(
          fontSize: 20,
          color: Colors.black87,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildTabBar(RehabController controller) {
    return Obx(() => Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Container(
        height: 5.5.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: [
            _buildTabItem('My Sessions', 0, controller),
            _buildTabItem('Progress', 1, controller),
          ],
        ),
      ),
    ));
  }

  Widget _buildTabItem(String title, int index, RehabController controller) {
    final isSelected = controller.selectedTabIndex.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColor.primaryColor.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Text(
            title,
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 14,
              color: isSelected ? AppColor.primaryColor : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(RehabController controller) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildSearchBar(controller)),
              SizedBox(width: 3.w),
              _buildFilterButton(controller),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(RehabController controller) {
    return Container(
      height: 5.2.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF64748B), size: 18),
          SizedBox(width: 2.w),
          Expanded(
            child: TextField(
              onChanged: controller.search,
              decoration: InputDecoration(
                hintText: 'Search programs or sessions...',
                hintStyle: AppTextStyle.mediumText.copyWith(
                  fontSize: 13,
                  color: const Color(0xFF94A3B8),
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

  Widget _buildFilterButton(RehabController controller) {
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
            const Icon(Icons.tune, size: 16, color: Color(0xFF475569)),
            SizedBox(width: 1.w),
            Obx(() => Text(
              controller.selectedFilter.value,
              style: AppTextStyle.mediumText.copyWith(
                fontSize: 14,
                color: const Color(0xFF475569),
                fontWeight: FontWeight.w600,
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(RehabController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
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
              const SizedBox(height: 16),
              Text('Filter Programs', style: AppTextStyle.boldText.copyWith(fontSize: 16)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.filters.map((f) {
                  final isSelected = controller.selectedFilter.value == f;
                  return GestureDetector(
                    onTap: () { controller.selectFilter(f); Get.back(); },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColor.primaryColor.withOpacity(0.1) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? AppColor.primaryColor : const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        f,
                        style: AppTextStyle.mediumText.copyWith(
                          fontSize: 13,
                          color: isSelected ? AppColor.primaryColor : const Color(0xFF475569),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(RehabController controller) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: AppColor.primaryColor));
        }

        if (controller.selectedTabIndex.value == 0) {
          return _buildSessions(controller);
        } else {
          return _buildProgressOnly(controller);
        }
      }),
    );
  }


  Widget _buildSessions(RehabController controller) {
    final upcomingSessions = controller.sessions.where((s) => s.status == 'Upcoming').toList();
    final completedSessions = controller.sessions.where((s) => s.status == 'Completed').toList();
    final missedSessions = controller.sessions.where((s) => s.status == 'Missed').toList();

    if (controller.sessions.isEmpty) return _empty('No sessions yet');

    return RefreshIndicator(
      onRefresh: () async => controller.refreshRehab(),
      color: AppColor.primaryColor,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upcoming Visits Section
            if (upcomingSessions.isNotEmpty) ...[
              _buildSectionHeader('Upcoming Visits', upcomingSessions.length, Colors.blue),
              SizedBox(height: 1.5.h),
              ...upcomingSessions.map((session) => _buildSessionCard(session, controller)),
              SizedBox(height: 3.h),
            ],

            // Completed Visits Section
            if (completedSessions.isNotEmpty) ...[
              _buildSectionHeader('Completed Visits', completedSessions.length, Colors.green),
              SizedBox(height: 1.5.h),
              ...completedSessions.take(5).map((session) => _buildSessionCard(session, controller)),
              if (completedSessions.length > 5) ...[
                SizedBox(height: 1.h),
                _buildViewAllButton('View All ${completedSessions.length} Completed', () {
                  // Handle view all completed
                }),
              ],
              SizedBox(height: 3.h),
            ],

            // Missed Visits Section
            if (missedSessions.isNotEmpty) ...[
              _buildSectionHeader('Missed Visits', missedSessions.length, Colors.red),
              SizedBox(height: 1.5.h),
              ...missedSessions.map((session) => _buildSessionCard(session, controller)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          title,
          style: AppTextStyle.boldText.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        SizedBox(width: 2.w),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count.toString(),
            style: AppTextStyle.mediumText.copyWith(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSessionCard(RehabSession session, RehabController controller) {
    final isUpcoming = session.status == 'Upcoming';
    final isCompleted = session.status == 'Completed';
    final isMissed = session.status == 'Missed';

    Color statusColor;
    IconData statusIcon;
    String statusText;

    if (isUpcoming) {
      statusColor = Colors.blue;
      statusIcon = Icons.schedule;
      statusText = _getTimeUntilSession(session.dateTime);
    } else if (isCompleted) {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
      statusText = 'Completed';
    } else {
      statusColor = Colors.red;
      statusIcon = Icons.cancel;
      statusText = 'Missed';
    }

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: statusColor.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(statusIcon, color: statusColor, size: 20),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.title,
                      style: AppTextStyle.boldText.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      '${session.estimatedMinutes} minutes',
                      style: AppTextStyle.mediumText.copyWith(
                        fontSize: 13,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    statusText,
                    style: AppTextStyle.mediumText.copyWith(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    _formatDateTime(session.dateTime),
                    style: AppTextStyle.mediumText.copyWith(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (isUpcoming) ...[
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle start session
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Start Session',
                      style: AppTextStyle.mediumText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                OutlinedButton(
                  onPressed: () {
                    // Handle reschedule
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF64748B),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Reschedule',
                    style: AppTextStyle.mediumText.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildViewAllButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTextStyle.mediumText.copyWith(
                fontSize: 14,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 1.w),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColor.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeUntilSession(DateTime sessionTime) {
    final now = DateTime.now();
    final difference = sessionTime.difference(now);

    if (difference.inDays > 0) {
      return 'In ${difference.inDays} day${difference.inDays == 1 ? '' : 's'}';
    } else if (difference.inHours > 0) {
      return 'In ${difference.inHours} hour${difference.inHours == 1 ? '' : 's'}';
    } else if (difference.inMinutes > 0) {
      return 'In ${difference.inMinutes} min';
    } else {
      return 'Now';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final sessionDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (sessionDate == today) {
      return 'Today, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (sessionDate == today.add(const Duration(days: 1))) {
      return 'Tomorrow, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  Widget _buildProgressOnly(RehabController controller) {
    return RefreshIndicator(
      onRefresh: () async => controller.refreshRehab(),
      color: AppColor.primaryColor,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressSummary(controller),
            SizedBox(height: 3.h),
            _buildPainTrend(controller),
            SizedBox(height: 3.h),
            _buildMobilityImprovement(controller),
            SizedBox(height: 3.h),
            _buildGoalProgress(controller),
            SizedBox(height: 3.h),
            _buildPhaseTimeline(controller),
            SizedBox(height: 3.h),
            _buildUpcomingVisits(controller),
            SizedBox(height: 3.h),
            _buildDoctorLogs(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildProgress(RehabController controller) {
    return RefreshIndicator(
      onRefresh: () async => controller.refreshRehab(),
      color: AppColor.primaryColor,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressSummary(controller),
            SizedBox(height: 3.h),
            _buildPainTrend(controller),
            SizedBox(height: 3.h),
            _buildMobilityImprovement(controller),
            SizedBox(height: 3.h),
            _buildGoalProgress(controller),
            SizedBox(height: 3.h),
            _buildPhaseTimeline(controller),
            SizedBox(height: 3.h),
            _buildUpcomingVisits(controller),
            SizedBox(height: 3.h),
            _buildDoctorLogs(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSummary(RehabController controller) {
    final currentPain = controller.painLogs.isNotEmpty ? controller.painLogs.first : null;
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Progress Summary', style: AppTextStyle.boldText.copyWith(fontSize: 18, fontWeight: FontWeight.w700)),
          SizedBox(height: 2.h),
          Row(
            children: [
              Container(
                width: 16.w,
                height: 16.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.sentiment_satisfied_alt, color: Color(0xFF2196F3), size: 32),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Pain Level',
                      style: AppTextStyle.mediumText.copyWith(fontSize: 14, color: const Color(0xFF64748B)),
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        Text(
                          currentPain?.level.toString() ?? '2',
                          style: AppTextStyle.boldText.copyWith(fontSize: 24, color: const Color(0xFF2196F3)),
                        ),
                        Text('/10', style: AppTextStyle.mediumText.copyWith(fontSize: 16, color: const Color(0xFF64748B))),
                        SizedBox(width: 2.w),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '(-${currentPain?.changeFromLast.abs() ?? 1} from last log)',
                            style: AppTextStyle.mediumText.copyWith(fontSize: 11, color: Colors.green, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      currentPain?.note ?? 'Feeling much better today.',
                      style: AppTextStyle.mediumText.copyWith(fontSize: 13, color: const Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPainTrend(RehabController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 16.w,
                height: 16.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.show_chart, color: Color(0xFF2196F3), size: 32),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pain Trend Analysis',
                      style: AppTextStyle.boldText.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Last 7 days overview',
                      style: AppTextStyle.mediumText.copyWith(fontSize: 13, color: const Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Container(
            height: 25.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildPainChart(controller),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPainChart(RehabController controller) {
    final logs = controller.painLogs.take(7).toList().reversed.toList();
    if (logs.isEmpty) {
      return Center(child: Text('No pain data available', style: AppTextStyle.mediumText.copyWith(color: const Color(0xFF64748B))));
    }

    return CustomPaint(
      painter: PainChartPainter(logs),
      child: Container(),
    );
  }

  Widget _buildMobilityImprovement(RehabController controller) {
    final improvement = controller.mobilityImprovements.isNotEmpty ? controller.mobilityImprovements.first : null;
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.trending_up, color: Colors.green, size: 32),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobility Improvement',
                  style: AppTextStyle.mediumText.copyWith(fontSize: 14, color: const Color(0xFF64748B)),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '+${improvement?.improvementPercent.toInt() ?? 15}% ${improvement?.metric ?? 'Knee Flexion'}',
                  style: AppTextStyle.boldText.copyWith(fontSize: 18, color: Colors.green),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  improvement?.note ?? 'Significant gains this week.',
                  style: AppTextStyle.mediumText.copyWith(fontSize: 13, color: const Color(0xFF64748B)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalProgress(RehabController controller) {
    final currentPhase = controller.phases.firstWhere((p) => p.status == 'In Progress', orElse: () => controller.phases.first);
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.flag, color: Color(0xFF2196F3), size: 32),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Goal Progress',
                  style: AppTextStyle.mediumText.copyWith(fontSize: 14, color: const Color(0xFF64748B)),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '${currentPhase.progressPercent}% to ${currentPhase.name}',
                  style: AppTextStyle.boldText.copyWith(fontSize: 18, color: const Color(0xFF2196F3)),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'On track to return to activity.',
                  style: AppTextStyle.mediumText.copyWith(fontSize: 13, color: const Color(0xFF64748B)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseTimeline(RehabController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Phase Timeline', style: AppTextStyle.boldText.copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
          SizedBox(height: 2.h),
          ...controller.phases.map((phase) => _buildPhaseItem(phase)),
        ],
      ),
    );
  }

  Widget _buildPhaseItem(RehabPhase phase) {
    IconData icon;
    Color color;
    
    switch (phase.status) {
      case 'Completed':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'In Progress':
        icon = Icons.access_time;
        color = Colors.orange;
        break;
      default:
        icon = Icons.schedule;
        color = Colors.grey;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(phase.name, style: AppTextStyle.boldText.copyWith(fontSize: 14, fontWeight: FontWeight.w700)),
                Text(phase.status, style: AppTextStyle.mediumText.copyWith(fontSize: 12, color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingVisits(RehabController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming Visits', style: AppTextStyle.boldText.copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text('2', style: AppTextStyle.boldText.copyWith(fontSize: 24, color: const Color(0xFF2196F3))),
                      Text('Days until next visit', style: AppTextStyle.mediumText.copyWith(fontSize: 12, color: const Color(0xFF64748B))),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text('5', style: AppTextStyle.boldText.copyWith(fontSize: 24, color: Colors.green)),
                      Text('Visits remaining', style: AppTextStyle.mediumText.copyWith(fontSize: 12, color: const Color(0xFF64748B))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorLogs(RehabController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Doctor's Daily Log", style: AppTextStyle.boldText.copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
          SizedBox(height: 2.h),
          ...controller.doctorLogs.take(3).map((log) => _buildDoctorLogItem(log)),
        ],
      ),
    );
  }

  Widget _buildDoctorLogItem(DoctorLog log) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.calendar_today, color: Colors.green, size: 20),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${log.date.day}/${log.date.month}/${log.date.year}',
                  style: AppTextStyle.boldText.copyWith(fontSize: 12, color: Colors.green),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  log.note,
                  style: AppTextStyle.mediumText.copyWith(fontSize: 13, color: const Color(0xFF64748B)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _empty(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.folder_open, size: 64, color: Color(0xFFCBD5E1)),
          SizedBox(height: 1.h),
          Text(text, style: AppTextStyle.mediumText.copyWith(color: const Color(0xFF64748B))),
        ],
      ),
    );
  }

  Widget _levelChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.primaryColor.withOpacity(0.3)),
      ),
      child: Text(text, style: AppTextStyle.mediumText.copyWith(fontSize: 11, color: AppColor.primaryColor, fontWeight: FontWeight.w700)),
    );
  }

  Widget _tagChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(text, style: AppTextStyle.mediumText.copyWith(fontSize: 11, color: const Color(0xFF475569), fontWeight: FontWeight.w600)),
    );
  }

  Widget _statusDot(String status) {
    Color c;
    switch (status.toLowerCase()) {
      case 'completed':
        c = Colors.green; break;
      case 'missed':
        c = Colors.red; break;
      default:
        c = Colors.orange;
    }
    return Container(width: 12, height: 12, decoration: BoxDecoration(color: c, shape: BoxShape.circle));
  }

  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';
}

class PainChartPainter extends CustomPainter {
  final List<PainLog> painLogs;

  PainChartPainter(this.painLogs);

  @override
  void paint(Canvas canvas, Size size) {
    if (painLogs.isEmpty) return;

    // Enhanced styling
    final linePaint = Paint()
      ..color = const Color(0xFF2196F3)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF2196F3).withOpacity(0.3),
          const Color(0xFF2196F3).withOpacity(0.05),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final pointBorderPaint = Paint()
      ..color = const Color(0xFF2196F3)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Calculate chart dimensions with better padding
    final chartWidth = size.width - 60;
    final chartHeight = size.height - 80;
    final startX = 40.0;
    final startY = 30.0;

    // Draw background gradient
    final backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final backgroundPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFF8FAFC),
          Colors.white,
        ],
      ).createShader(backgroundRect);
    canvas.drawRect(backgroundRect, backgroundPaint);

    // Draw Y-axis labels with enhanced styling
    for (int i = 0; i <= 10; i += 2) {
      final y = startY + (chartHeight * (10 - i) / 10);
      
      // Draw horizontal grid lines
      final gridPaint = Paint()
        ..color = i == 10 ? const Color(0xFFE2E8F0) : const Color(0xFFF1F5F9)
        ..strokeWidth = i == 10 ? 1.5 : 1.0;
      canvas.drawLine(Offset(startX, y), Offset(startX + chartWidth, y), gridPaint);
      
      // Draw Y-axis labels
      textPainter.text = TextSpan(
        text: i.toString(),
        style: TextStyle(
          color: i == 10 ? const Color(0xFF475569) : const Color(0xFF94A3B8),
          fontSize: i == 10 ? 13 : 11,
          fontWeight: i == 10 ? FontWeight.w600 : FontWeight.w500,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(15, y - 8));
    }

    // Draw X-axis labels with enhanced styling
    final dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (int i = 0; i < painLogs.length && i < 7; i++) {
      final x = startX + (chartWidth * i / 6);
      
      // Draw vertical grid lines
      final gridPaint = Paint()
        ..color = const Color(0xFFF1F5F9)
        ..strokeWidth = 1.0;
      canvas.drawLine(Offset(x, startY), Offset(x, startY + chartHeight), gridPaint);
      
      // Draw day labels
      textPainter.text = TextSpan(
        text: dayLabels[i],
        style: const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - 12, chartHeight + 45));
    }

    // Draw pain level line with enhanced curve
    final path = Path();
    final fillPath = Path();
    final points = <Offset>[];

    for (int i = 0; i < painLogs.length && i < 7; i++) {
      final log = painLogs[i];
      final x = startX + (chartWidth * i / 6);
      final y = startY + (chartHeight * (10 - log.level) / 10);
      points.add(Offset(x, y));

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, startY + chartHeight);
        fillPath.lineTo(x, y);
      } else {
        // Create smooth curves between points
        final prevPoint = points[i - 1];
        final controlPoint1 = Offset(prevPoint.dx + (x - prevPoint.dx) * 0.5, prevPoint.dy);
        final controlPoint2 = Offset(x - (x - prevPoint.dx) * 0.5, y);
        path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, x, y);
        fillPath.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, x, y);
      }
    }

    // Close fill path
    fillPath.lineTo(startX + chartWidth, startY + chartHeight);
    fillPath.lineTo(startX, startY + chartHeight);
    fillPath.close();

    // Draw filled area with gradient
    canvas.drawPath(fillPath, gradientPaint);
    
    // Draw main line
    canvas.drawPath(path, linePaint);

    // Draw enhanced points
    for (int i = 0; i < points.length; i++) {
      final point = points[i];
      final log = painLogs[i];
      
      // Draw point border
      canvas.drawCircle(point, 6, pointBorderPaint);
      
      // Draw point fill
      canvas.drawCircle(point, 4, pointPaint);
      
      // Add subtle shadow effect
      final shadowPaint = Paint()
        ..color = const Color(0xFF2196F3).withOpacity(0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
      canvas.drawCircle(point, 5, shadowPaint);
    }

    // Draw chart title
    textPainter.text = const TextSpan(
      text: 'Pain Level Trend',
      style: TextStyle(
        color: Color(0xFF1E293B),
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(startX, 10));

    // Draw current pain level indicator
    if (painLogs.isNotEmpty) {
      final currentPain = painLogs.first.level;
      textPainter.text = TextSpan(
        text: 'Current: $currentPain/10',
        style: const TextStyle(
          color: Color(0xFF2196F3),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(startX + chartWidth - 80, 10));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


