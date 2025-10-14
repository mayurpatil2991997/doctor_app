import 'dart:convert';

ReportModel reportModelFromJson(String str) => ReportModel.fromJson(json.decode(str));
String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  List<ReportItem>? reports;

  ReportModel({this.reports});

  ReportModel.fromJson(Map<String, dynamic> json) {
    if (json['reports'] != null) {
      reports = <ReportItem>[];
      json['reports'].forEach((v) {
        reports!.add(ReportItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reports != null) {
      data['reports'] = reports!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportItem {
  String? id;
  String? title;
  String? type;
  String? thumbnailUrl;
  String? status;
  String? visibility;
  String? uploadedBy;
  String? uploadDate;
  String? description;
  List<String>? tags;
  bool? isShared;
  String? sharedWith;

  ReportItem({
    this.id,
    this.title,
    this.type,
    this.thumbnailUrl,
    this.status,
    this.visibility,
    this.uploadedBy,
    this.uploadDate,
    this.description,
    this.tags,
    this.isShared,
    this.sharedWith,
  });

  ReportItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    thumbnailUrl = json['thumbnailUrl'];
    status = json['status'];
    visibility = json['visibility'];
    uploadedBy = json['uploadedBy'];
    uploadDate = json['uploadDate'];
    description = json['description'];
    tags = json['tags']?.cast<String>();
    isShared = json['isShared'];
    sharedWith = json['sharedWith'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['thumbnailUrl'] = thumbnailUrl;
    data['status'] = status;
    data['visibility'] = visibility;
    data['uploadedBy'] = uploadedBy;
    data['uploadDate'] = uploadDate;
    data['description'] = description;
    data['tags'] = tags;
    data['isShared'] = isShared;
    data['sharedWith'] = sharedWith;
    return data;
  }

  ReportItem copyWith({
    String? id,
    String? title,
    String? type,
    String? thumbnailUrl,
    String? status,
    String? visibility,
    String? uploadedBy,
    String? uploadDate,
    String? description,
    List<String>? tags,
    bool? isShared,
    String? sharedWith,
  }) {
    return ReportItem(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      status: status ?? this.status,
      visibility: visibility ?? this.visibility,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      uploadDate: uploadDate ?? this.uploadDate,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      isShared: isShared ?? this.isShared,
      sharedWith: sharedWith ?? this.sharedWith,
    );
  }
}

// Enum for report types
enum ReportType {
  bloodTest,
  xRay,
  mri,
  ctScan,
  dischargeSummary,
  prescription,
  labResults,
  other,
}

// Enum for report status
enum ReportStatus {
  pending,
  reviewed,
  approved,
  rejected,
}

// Enum for visibility
enum ReportVisibility {
  private,
  visibleToPatient,
  visibleToDoctor,
  shared,
}

// Extension methods for enums
extension ReportTypeExtension on ReportType {
  String get displayName {
    switch (this) {
      case ReportType.bloodTest:
        return 'Blood Test';
      case ReportType.xRay:
        return 'X-Ray';
      case ReportType.mri:
        return 'MRI';
      case ReportType.ctScan:
        return 'CT Scan';
      case ReportType.dischargeSummary:
        return 'Discharge Summary';
      case ReportType.prescription:
        return 'Prescription';
      case ReportType.labResults:
        return 'Lab Results';
      case ReportType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case ReportType.bloodTest:
        return '🩸';
      case ReportType.xRay:
        return '📷';
      case ReportType.mri:
        return '🧠';
      case ReportType.ctScan:
        return '🫁';
      case ReportType.dischargeSummary:
        return '📄';
      case ReportType.prescription:
        return '💊';
      case ReportType.labResults:
        return '🧪';
      case ReportType.other:
        return '📋';
    }
  }
}

extension ReportStatusExtension on ReportStatus {
  String get displayName {
    switch (this) {
      case ReportStatus.pending:
        return 'Pending Review';
      case ReportStatus.reviewed:
        return 'Reviewed';
      case ReportStatus.approved:
        return 'Approved';
      case ReportStatus.rejected:
        return 'Rejected';
    }
  }

  String get color {
    switch (this) {
      case ReportStatus.pending:
        return '#F59E0B'; // Amber
      case ReportStatus.reviewed:
        return '#10B981'; // Green
      case ReportStatus.approved:
        return '#059669'; // Emerald
      case ReportStatus.rejected:
        return '#EF4444'; // Red
    }
  }
}

extension ReportVisibilityExtension on ReportVisibility {
  String get displayName {
    switch (this) {
      case ReportVisibility.private:
        return 'Private';
      case ReportVisibility.visibleToPatient:
        return 'Visible to Patient';
      case ReportVisibility.visibleToDoctor:
        return 'Visible to Doctor';
      case ReportVisibility.shared:
        return 'Shared';
    }
  }

  String get color {
    switch (this) {
      case ReportVisibility.private:
        return '#6B7280'; // Gray
      case ReportVisibility.visibleToPatient:
        return '#3B82F6'; // Blue
      case ReportVisibility.visibleToDoctor:
        return '#10B981'; // Green
      case ReportVisibility.shared:
        return '#8B5CF6'; // Purple
    }
  }
}
