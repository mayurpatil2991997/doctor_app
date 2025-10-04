import 'package:flutter/material.dart';

class ExerciseModel {
  String? title;
  String? subtitle;
  String? duration;
  String? type;
  String? status;
  String? icon;
  Color? statusColor;
  bool? isCompleted;

  ExerciseModel({
    this.title,
    this.subtitle,
    this.duration,
    this.type,
    this.status,
    this.icon,
    this.statusColor,
    this.isCompleted,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      title: json['title'],
      subtitle: json['subtitle'],
      duration: json['duration'],
      type: json['type'],
      status: json['status'],
      icon: json['icon'],
      statusColor: json['statusColor'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'duration': duration,
      'type': type,
      'status': status,
      'icon': icon,
      'statusColor': statusColor,
      'isCompleted': isCompleted,
    };
  }
}

class ProgressDashboardModel {
  String? nextSessionTitle;
  String? nextSessionTime;
  String? nextSessionDate;

  ProgressDashboardModel({
    this.nextSessionTitle,
    this.nextSessionTime,
    this.nextSessionDate,
  });
}

class AdaptiveInsightModel {
  String? message;
  String? icon;
  Color? iconColor;

  AdaptiveInsightModel({
    this.message,
    this.icon,
    this.iconColor,
  });
}
