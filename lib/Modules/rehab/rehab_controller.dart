import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RehabProgram {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String level; // Beginner, Intermediate, Advanced
  final int durationWeeks;
  final int sessionsPerWeek;
  final List<String> tags;

  const RehabProgram({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.level,
    required this.durationWeeks,
    required this.sessionsPerWeek,
    required this.tags,
  });
}

class RehabSession {
  final String id;
  final String programId;
  final String title;
  final String status; // Upcoming, Completed, Missed
  final DateTime dateTime;
  final int estimatedMinutes;

  const RehabSession({
    required this.id,
    required this.programId,
    required this.title,
    required this.status,
    required this.dateTime,
    required this.estimatedMinutes,
  });
}

class PainLog {
  final String id;
  final int level; // 1-10
  final String note;
  final DateTime dateTime;
  final int changeFromLast; // -1, 0, +1

  const PainLog({
    required this.id,
    required this.level,
    required this.note,
    required this.dateTime,
    required this.changeFromLast,
  });
}

class MobilityImprovement {
  final String id;
  final String metric;
  final double improvementPercent;
  final String note;
  final DateTime dateTime;

  const MobilityImprovement({
    required this.id,
    required this.metric,
    required this.improvementPercent,
    required this.note,
    required this.dateTime,
  });
}

class RehabPhase {
  final String id;
  final String name;
  final String status; // Completed, In Progress, Upcoming
  final int progressPercent;
  final String description;

  const RehabPhase({
    required this.id,
    required this.name,
    required this.status,
    required this.progressPercent,
    required this.description,
  });
}

class DoctorLog {
  final String id;
  final DateTime date;
  final String note;

  const DoctorLog({
    required this.id,
    required this.date,
    required this.note,
  });
}

class RehabController extends GetxController {
  var isLoading = false.obs;
  var selectedTabIndex = 0.obs; // 0: My Sessions, 1: Progress
  var selectedFilter = 'All'.obs;
  var searchQuery = ''.obs;

  final List<String> filters = const [
    'All', 'Upcoming', 'Completed', 'Missed', 'Today', 'This Week'
  ];

  var programs = <RehabProgram>[].obs;
  var sessions = <RehabSession>[].obs;
  var painLogs = <PainLog>[].obs;
  var mobilityImprovements = <MobilityImprovement>[].obs;
  var phases = <RehabPhase>[].obs;
  var doctorLogs = <DoctorLog>[].obs;

  var filteredPrograms = <RehabProgram>[].obs;
  var filteredSessions = <RehabSession>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  void selectTab(int idx) {
    selectedTabIndex.value = idx;
    applyFilters();
  }

  void selectFilter(String value) {
    selectedFilter.value = value;
    applyFilters();
  }

  void applyFilters() {
    final q = searchQuery.value.trim().toLowerCase();

    filteredPrograms.value = programs.where((p) {
      final byLevel = selectedFilter.value == 'All' || p.level.toLowerCase() == selectedFilter.value.toLowerCase();
      final byQuery = q.isEmpty || p.title.toLowerCase().contains(q) || p.subtitle.toLowerCase().contains(q) || p.tags.any((t) => t.toLowerCase().contains(q));
      return byLevel && byQuery;
    }).toList();

    filteredSessions.value = sessions.where((s) {
      final byQuery = q.isEmpty || s.title.toLowerCase().contains(q);
      return byQuery;
    }).toList();
  }

  void search(String q) {
    searchQuery.value = q;
    applyFilters();
  }

  Future<void> refreshRehab() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    loadMockData();
  }

  void loadMockData() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      programs.value = const [
        RehabProgram(
          id: 'p1',
          title: 'Lower Back Pain Relief',
          subtitle: 'Core stabilization and mobility sequence',
          imageUrl: 'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/planka.jpg',
          level: 'Beginner',
          durationWeeks: 4,
          sessionsPerWeek: 3,
          tags: ['Pain Relief', 'Mobility'],
        ),
        RehabProgram(
          id: 'p2',
          title: 'Knee Rehab (Post-Op)',
          subtitle: 'ROM restoration and quadriceps activation',
          imageUrl: 'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/kneepushupa.jpg',
          level: 'Intermediate',
          durationWeeks: 6,
          sessionsPerWeek: 4,
          tags: ['Post-Op', 'Strength'],
        ),
        RehabProgram(
          id: 'p3',
          title: 'Shoulder Mobility',
          subtitle: 'Scapular control and overhead mobility',
          imageUrl: 'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/sitandreach.png',
          level: 'Beginner',
          durationWeeks: 3,
          sessionsPerWeek: 3,
          tags: ['Mobility'],
        ),
      ];

      sessions.value = [
        RehabSession(
          id: 's1', programId: 'p1', title: 'Core Bracing + Cat-Cow', status: 'Upcoming', dateTime: DateTime.now().add(const Duration(hours: 2)), estimatedMinutes: 25,
        ),
        RehabSession(
          id: 's2', programId: 'p2', title: 'Heel Slides + Quad Sets', status: 'Upcoming', dateTime: DateTime.now().add(const Duration(days: 1)), estimatedMinutes: 20,
        ),
        RehabSession(
          id: 's3', programId: 'p3', title: 'Wall Angels + Band Rows', status: 'Upcoming', dateTime: DateTime.now().add(const Duration(days: 2)), estimatedMinutes: 30,
        ),
        RehabSession(
          id: 's4', programId: 'p4', title: 'Lower Back Stretches', status: 'Completed', dateTime: DateTime.now().subtract(const Duration(hours: 3)), estimatedMinutes: 15,
        ),
        RehabSession(
          id: 's5', programId: 'p5', title: 'Hip Flexor Release', status: 'Completed', dateTime: DateTime.now().subtract(const Duration(days: 1)), estimatedMinutes: 20,
        ),
        RehabSession(
          id: 's6', programId: 'p6', title: 'Shoulder Mobility', status: 'Completed', dateTime: DateTime.now().subtract(const Duration(days: 2)), estimatedMinutes: 25,
        ),
        RehabSession(
          id: 's7', programId: 'p7', title: 'Knee Strengthening', status: 'Completed', dateTime: DateTime.now().subtract(const Duration(days: 3)), estimatedMinutes: 30,
        ),
        RehabSession(
          id: 's8', programId: 'p8', title: 'Balance Training', status: 'Missed', dateTime: DateTime.now().subtract(const Duration(days: 4)), estimatedMinutes: 20,
        ),
        RehabSession(
          id: 's9', programId: 'p9', title: 'Flexibility Routine', status: 'Missed', dateTime: DateTime.now().subtract(const Duration(days: 5)), estimatedMinutes: 15,
        ),
      ];

      // Mock progress data
      painLogs.value = [
        PainLog(id: 'pl1', level: 2, note: 'Feeling much better today.', dateTime: DateTime.now(), changeFromLast: -1),
        PainLog(id: 'pl2', level: 3, note: 'Slight discomfort after exercise.', dateTime: DateTime.now().subtract(const Duration(days: 1)), changeFromLast: 0),
        PainLog(id: 'pl3', level: 4, note: 'Better than yesterday.', dateTime: DateTime.now().subtract(const Duration(days: 2)), changeFromLast: -1),
        PainLog(id: 'pl4', level: 5, note: 'Manageable pain level.', dateTime: DateTime.now().subtract(const Duration(days: 3)), changeFromLast: 0),
        PainLog(id: 'pl5', level: 6, note: 'Had a good session.', dateTime: DateTime.now().subtract(const Duration(days: 4)), changeFromLast: 1),
        PainLog(id: 'pl6', level: 5, note: 'Feeling optimistic.', dateTime: DateTime.now().subtract(const Duration(days: 5)), changeFromLast: -1),
        PainLog(id: 'pl7', level: 6, note: 'First day back to exercises.', dateTime: DateTime.now().subtract(const Duration(days: 6)), changeFromLast: 0),
      ];

      mobilityImprovements.value = [
        MobilityImprovement(id: 'mi1', metric: 'Knee Flexion', improvementPercent: 15.0, note: 'Significant gains this week.', dateTime: DateTime.now()),
        MobilityImprovement(id: 'mi2', metric: 'Shoulder ROM', improvementPercent: 8.0, note: 'Steady progress.', dateTime: DateTime.now().subtract(const Duration(days: 3))),
      ];

      phases.value = [
        RehabPhase(id: 'rp1', name: 'Initial Recovery', status: 'Completed', progressPercent: 100, description: 'Basic mobility restoration'),
        RehabPhase(id: 'rp2', name: 'Strengthening', status: 'In Progress', progressPercent: 75, description: 'Building strength and endurance'),
        RehabPhase(id: 'rp3', name: 'Return to Activity', status: 'Upcoming', progressPercent: 0, description: 'Preparing for normal activities'),
      ];

      doctorLogs.value = [
        DoctorLog(
          id: 'dl1',
          date: DateTime(2024, 10, 25),
          note: 'Patient reports reduced swelling. Range of motion exercises completed with minimal pain. Continue current plan.',
        ),
        DoctorLog(
          id: 'dl2',
          date: DateTime(2024, 10, 24),
          note: 'Introduced light resistance bands. Patient tolerated well. Pain level reported as 3/10 post-session.',
        ),
        DoctorLog(
          id: 'dl3',
          date: DateTime(2024, 10, 22),
          note: 'Excellent progress on mobility exercises. Patient showing good form and dedication.',
        ),
      ];

      applyFilters();
      isLoading.value = false;
    });
  }
}


