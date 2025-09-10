import 'dart:convert';

MedicineModel medicineModelFromJson(String str) => MedicineModel.fromJson(json.decode(str));
String medicineModelToJson(MedicineModel data) => json.encode(data.toJson());

class MedicineModel {
  int? prescriptionId;
  String? doctorName;
  String? prescriptionDate;
  String? medicineName;
  String? dosage;
  String? duration;
  String? frequency;
  String? timing;
  String? instructions;
  bool? isActive;
  String? status;

  MedicineModel({
    this.prescriptionId,
    this.doctorName,
    this.prescriptionDate,
    this.medicineName,
    this.dosage,
    this.duration,
    this.frequency,
    this.timing,
    this.instructions,
    this.isActive,
    this.status,
  });

  MedicineModel.fromJson(Map<String, dynamic> json) {
    prescriptionId = json['prescriptionId'];
    doctorName = json['doctorName'];
    prescriptionDate = json['prescriptionDate'];
    medicineName = json['medicineName'];
    dosage = json['dosage'];
    duration = json['duration'];
    frequency = json['frequency'];
    timing = json['timing'];
    instructions = json['instructions'];
    isActive = json['isActive'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['prescriptionId'] = prescriptionId;
    data['doctorName'] = doctorName;
    data['prescriptionDate'] = prescriptionDate;
    data['medicineName'] = medicineName;
    data['dosage'] = dosage;
    data['duration'] = duration;
    data['frequency'] = frequency;
    data['timing'] = timing;
    data['instructions'] = instructions;
    data['isActive'] = isActive;
    data['status'] = status;
    return data;
  }
}
