import 'package:flutter/material.dart';

class PatientHomeModel {
  String? patientName;
  String? patientType;
  String? hospitalName;
  String? hospitalAddress;
  String? doctorName;
  String? doctorSpecialization;
  String? doctorImage;
  String? roomNumber;
  String? wing;
  String? appointmentTitle;
  String? appointmentDate;
  String? appointmentTime;
  String? exerciseTitle;
  String? exerciseStartDate;
  double? bmi;
  String? bmiStatus;
  String? bloodPressure;
  String? bloodPressureUnit;

  PatientHomeModel({
    this.patientName,
    this.patientType,
    this.hospitalName,
    this.hospitalAddress,
    this.doctorName,
    this.doctorSpecialization,
    this.doctorImage,
    this.roomNumber,
    this.wing,
    this.appointmentTitle,
    this.appointmentDate,
    this.appointmentTime,
    this.exerciseTitle,
    this.exerciseStartDate,
    this.bmi,
    this.bmiStatus,
    this.bloodPressure,
    this.bloodPressureUnit,
  });

  factory PatientHomeModel.fromJson(Map<String, dynamic> json) {
    return PatientHomeModel(
      patientName: json['patientName'],
      patientType: json['patientType'],
      hospitalName: json['hospitalName'],
      hospitalAddress: json['hospitalAddress'],
      doctorName: json['doctorName'],
      doctorSpecialization: json['doctorSpecialization'],
      doctorImage: json['doctorImage'],
      roomNumber: json['roomNumber'],
      wing: json['wing'],
      appointmentTitle: json['appointmentTitle'],
      appointmentDate: json['appointmentDate'],
      appointmentTime: json['appointmentTime'],
      exerciseTitle: json['exerciseTitle'],
      exerciseStartDate: json['exerciseStartDate'],
      bmi: json['bmi']?.toDouble(),
      bmiStatus: json['bmiStatus'],
      bloodPressure: json['bloodPressure'],
      bloodPressureUnit: json['bloodPressureUnit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'patientType': patientType,
      'hospitalName': hospitalName,
      'hospitalAddress': hospitalAddress,
      'doctorName': doctorName,
      'doctorSpecialization': doctorSpecialization,
      'doctorImage': doctorImage,
      'roomNumber': roomNumber,
      'wing': wing,
      'appointmentTitle': appointmentTitle,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'exerciseTitle': exerciseTitle,
      'exerciseStartDate': exerciseStartDate,
      'bmi': bmi,
      'bmiStatus': bmiStatus,
      'bloodPressure': bloodPressure,
      'bloodPressureUnit': bloodPressureUnit,
    };
  }
}

class FeatureService {
  String? title;
  IconData? icon;
  Color? color;

  FeatureService({
    this.title,
    this.icon,
    this.color,
  });
}
