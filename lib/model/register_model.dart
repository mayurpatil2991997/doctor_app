
import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));
String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  int? patientId;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? gender;
  String? contact;
  String? email;
  String? address;
  String? bloodGroup;
  String? createdDate;
  String? updatedDate;
  String? keycloakId;
  bool? isDeleted;

  RegisterModel(
      {this.patientId,
        this.firstName,
        this.lastName,
        this.dateOfBirth,
        this.gender,
        this.contact,
        this.email,
        this.address,
        this.bloodGroup,
        this.createdDate,
        this.updatedDate,
        this.keycloakId,
        this.isDeleted});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    contact = json['contact'];
    email = json['email'];
    address = json['address'];
    bloodGroup = json['bloodGroup'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    keycloakId = json['keycloakId'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['address'] = this.address;
    data['bloodGroup'] = this.bloodGroup;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['keycloakId'] = this.keycloakId;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}
