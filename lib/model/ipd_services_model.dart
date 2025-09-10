import 'dart:convert';

IpdServicesModel ipdServicesModelFromJson(String str) => IpdServicesModel.fromJson(json.decode(str));
String ipdServicesModelToJson(IpdServicesModel data) => json.encode(data.toJson());

class IpdServicesModel {
  String? patientName;
  String? roomNumber;
  String? wardType;
  String? status;
  double? treatmentProgress;
  String? admissionDate;
  List<ScheduleItem>? todaySchedule;
  List<VitalSign>? vitalSigns;
  List<Document>? recentDocuments;
  InsuranceInfo? insuranceInfo;

  IpdServicesModel({
    this.patientName,
    this.roomNumber,
    this.wardType,
    this.status,
    this.treatmentProgress,
    this.admissionDate,
    this.todaySchedule,
    this.vitalSigns,
    this.recentDocuments,
    this.insuranceInfo,
  });

  IpdServicesModel.fromJson(Map<String, dynamic> json) {
    patientName = json['patientName'];
    roomNumber = json['roomNumber'];
    wardType = json['wardType'];
    status = json['status'];
    treatmentProgress = json['treatmentProgress']?.toDouble();
    admissionDate = json['admissionDate'];
    
    if (json['todaySchedule'] != null) {
      todaySchedule = <ScheduleItem>[];
      json['todaySchedule'].forEach((v) {
        todaySchedule!.add(ScheduleItem.fromJson(v));
      });
    }
    
    if (json['vitalSigns'] != null) {
      vitalSigns = <VitalSign>[];
      json['vitalSigns'].forEach((v) {
        vitalSigns!.add(VitalSign.fromJson(v));
      });
    }
    
    if (json['recentDocuments'] != null) {
      recentDocuments = <Document>[];
      json['recentDocuments'].forEach((v) {
        recentDocuments!.add(Document.fromJson(v));
      });
    }
    
    insuranceInfo = json['insuranceInfo'] != null 
        ? InsuranceInfo.fromJson(json['insuranceInfo']) 
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['patientName'] = patientName;
    data['roomNumber'] = roomNumber;
    data['wardType'] = wardType;
    data['status'] = status;
    data['treatmentProgress'] = treatmentProgress;
    data['admissionDate'] = admissionDate;
    
    if (todaySchedule != null) {
      data['todaySchedule'] = todaySchedule!.map((v) => v.toJson()).toList();
    }
    
    if (vitalSigns != null) {
      data['vitalSigns'] = vitalSigns!.map((v) => v.toJson()).toList();
    }
    
    if (recentDocuments != null) {
      data['recentDocuments'] = recentDocuments!.map((v) => v.toJson()).toList();
    }
    
    if (insuranceInfo != null) {
      data['insuranceInfo'] = insuranceInfo!.toJson();
    }
    
    return data;
  }
}

class ScheduleItem {
  String? title;
  String? time;
  String? status;
  String? dotColor;

  ScheduleItem({
    this.title,
    this.time,
    this.status,
    this.dotColor,
  });

  ScheduleItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    time = json['time'];
    status = json['status'];
    dotColor = json['dotColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['time'] = time;
    data['status'] = status;
    data['dotColor'] = dotColor;
    return data;
  }
}

class VitalSign {
  String? name;
  String? value;
  String? unit;
  String? status;
  String? icon;

  VitalSign({
    this.name,
    this.value,
    this.unit,
    this.status,
    this.icon,
  });

  VitalSign.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    unit = json['unit'];
    status = json['status'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['value'] = value;
    data['unit'] = unit;
    data['status'] = status;
    data['icon'] = icon;
    return data;
  }
}

class Document {
  String? title;
  String? date;
  String? type;

  Document({
    this.title,
    this.date,
    this.type,
  });

  Document.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['date'] = date;
    data['type'] = type;
    return data;
  }
}

class InsuranceInfo {
  String? provider;
  String? policyNumber;
  double? claimProgress;
  String? claimStatus;

  InsuranceInfo({
    this.provider,
    this.policyNumber,
    this.claimProgress,
    this.claimStatus,
  });

  InsuranceInfo.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    policyNumber = json['policyNumber'];
    claimProgress = json['claimProgress']?.toDouble();
    claimStatus = json['claimStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['provider'] = provider;
    data['policyNumber'] = policyNumber;
    data['claimProgress'] = claimProgress;
    data['claimStatus'] = claimStatus;
    return data;
  }
}
