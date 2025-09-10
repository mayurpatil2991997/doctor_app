import 'dart:convert';

PersonalDetailsModel personalDetailsModelFromJson(String str) => PersonalDetailsModel.fromJson(json.decode(str));
String personalDetailsModelToJson(PersonalDetailsModel data) => json.encode(data.toJson());

class PersonalDetailsModel {
  String? name;
  String? dateOfBirth;
  String? email;
  String? phoneNumber;
  String? address;
  String? medicalLicenseNumber;
  String? specialization;
  String? yearsOfExperience;

  PersonalDetailsModel({
    this.name,
    this.dateOfBirth,
    this.email,
    this.phoneNumber,
    this.address,
    this.medicalLicenseNumber,
    this.specialization,
    this.yearsOfExperience,
  });

  PersonalDetailsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    medicalLicenseNumber = json['medicalLicenseNumber'];
    specialization = json['specialization'];
    yearsOfExperience = json['yearsOfExperience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['dateOfBirth'] = dateOfBirth;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['medicalLicenseNumber'] = medicalLicenseNumber;
    data['specialization'] = specialization;
    data['yearsOfExperience'] = yearsOfExperience;
    return data;
  }
}
