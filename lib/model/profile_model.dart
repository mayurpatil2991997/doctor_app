import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));
String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String? name;
  String? specialization;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? address;
  String? dateOfBirth;
  String? gender;
  String? bloodGroup;
  String? emergencyContact;

  ProfileModel({
    this.name,
    this.specialization,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.address,
    this.dateOfBirth,
    this.gender,
    this.bloodGroup,
    this.emergencyContact,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    specialization = json['specialization'];
    email = json['email'];
    profileImage = json['profileImage'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    bloodGroup = json['bloodGroup'];
    emergencyContact = json['emergencyContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['specialization'] = specialization;
    data['email'] = email;
    data['profileImage'] = profileImage;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['bloodGroup'] = bloodGroup;
    data['emergencyContact'] = emergencyContact;
    return data;
  }
}
