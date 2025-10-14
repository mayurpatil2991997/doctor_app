import 'package:flutter/material.dart';

class DoctorHomeModel {
  String? doctorName;
  String? doctorType;
  String? hospitalName;
  String? hospitalAddress;
  String? patientName;
  String? patientSpecialization;
  String? patientImage;
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

  DoctorHomeModel({
    this.doctorName,
    this.doctorType,
    this.hospitalName,
    this.hospitalAddress,
    this.patientName,
    this.patientSpecialization,
    this.patientImage,
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

  factory DoctorHomeModel.fromJson(Map<String, dynamic> json) {
    return DoctorHomeModel(
      doctorName: json['doctorName'],
      doctorType: json['doctorType'],
      hospitalName: json['hospitalName'],
      hospitalAddress: json['hospitalAddress'],
      patientName: json['patientName'],
      patientSpecialization: json['patientSpecialization'],
      patientImage: json['patientImage'],
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
      'doctorName': doctorName,
      'doctorType': doctorType,
      'hospitalName': hospitalName,
      'hospitalAddress': hospitalAddress,
      'patientName': patientName,
      'patientSpecialization': patientSpecialization,
      'patientImage': patientImage,
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
