import 'dart:convert';

FamilyMemberModel familyMemberModelFromJson(String str) => FamilyMemberModel.fromJson(json.decode(str));
String familyMemberModelToJson(FamilyMemberModel data) => json.encode(data.toJson());

class FamilyMemberModel {
  int? memberId;
  String? name;
  String? relationship;
  String? dateOfBirth;
  String? gender;
  String? bloodGroup;
  String? profileImage;
  String? phoneNumber;
  String? email;
  String? address;
  String? emergencyContact;
  String? medicalHistory;
  String? allergies;
  String? currentMedications;
  bool? isActive;
  String? createdDate;
  String? updatedDate;

  FamilyMemberModel({
    this.memberId,
    this.name,
    this.relationship,
    this.dateOfBirth,
    this.gender,
    this.bloodGroup,
    this.profileImage,
    this.phoneNumber,
    this.email,
    this.address,
    this.emergencyContact,
    this.medicalHistory,
    this.allergies,
    this.currentMedications,
    this.isActive,
    this.createdDate,
    this.updatedDate,
  });

  FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    name = json['name'];
    relationship = json['relationship'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    bloodGroup = json['bloodGroup'];
    profileImage = json['profileImage'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    emergencyContact = json['emergencyContact'];
    medicalHistory = json['medicalHistory'];
    allergies = json['allergies'];
    currentMedications = json['currentMedications'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['memberId'] = memberId;
    data['name'] = name;
    data['relationship'] = relationship;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['bloodGroup'] = bloodGroup;
    data['profileImage'] = profileImage;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['emergencyContact'] = emergencyContact;
    data['medicalHistory'] = medicalHistory;
    data['allergies'] = allergies;
    data['currentMedications'] = currentMedications;
    data['isActive'] = isActive;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
