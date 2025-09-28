import 'dart:convert';

DoctorModel doctorModelFromJson(String str) => DoctorModel.fromJson(json.decode(str));
String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  List<DoctorDetails>? doctorDetails;

  DoctorModel({this.doctorDetails});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    if (json['doctorDetails'] != null) {
      doctorDetails = <DoctorDetails>[];
      json['doctorDetails'].forEach((v) {
        doctorDetails!.add(new DoctorDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctorDetails != null) {
      data['doctorDetails'] =
          this.doctorDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorDetails {
  String? registrationNumber;
  String? firstName;
  String? lastName;
  String? specialization;
  String? contactNumber;
  String? email;
  String? password;
  String? qualifications;
  List<String>? certifications;
  String? profileImageUrl;
  String? doctorStatus;
  String? createdAt;
  String? updatedAt;
  String? createdByHospitalId;

  DoctorDetails(
      {this.registrationNumber,
        this.firstName,
        this.lastName,
        this.specialization,
        this.contactNumber,
        this.email,
        this.password,
        this.qualifications,
        this.certifications,
        this.profileImageUrl,
        this.doctorStatus,
        this.createdAt,
        this.updatedAt,
        this.createdByHospitalId});

  DoctorDetails.fromJson(Map<String, dynamic> json) {
    registrationNumber = json['registrationNumber'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    specialization = json['specialization'];
    contactNumber = json['contactNumber'];
    email = json['email'];
    password = json['password'];
    qualifications = json['qualifications'];
    certifications = json['certifications'].cast<String>();
    profileImageUrl = json['profileImageUrl'];
    doctorStatus = json['doctorStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdByHospitalId = json['createdByHospitalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registrationNumber'] = this.registrationNumber;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['specialization'] = this.specialization;
    data['contactNumber'] = this.contactNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['qualifications'] = this.qualifications;
    data['certifications'] = this.certifications;
    data['profileImageUrl'] = this.profileImageUrl;
    data['doctorStatus'] = this.doctorStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdByHospitalId'] = this.createdByHospitalId;
    return data;
  }
}

