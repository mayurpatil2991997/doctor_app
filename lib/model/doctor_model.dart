import 'dart:convert';

DoctorModel doctorModelFromJson(String str) => DoctorModel.fromJson(json.decode(str));
String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  int? doctorId;
  String? name;
  String? specialization;
  String? experience;
  String? image;
  double? rating;
  int? consultationFee;
  bool? isAvailable;
  String? availabilityStatus;
  bool? isVideoConsult;

  DoctorModel({
    this.doctorId,
    this.name,
    this.specialization,
    this.experience,
    this.image,
    this.rating,
    this.consultationFee,
    this.isAvailable,
    this.availabilityStatus,
    this.isVideoConsult,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    name = json['name'];
    specialization = json['specialization'];
    experience = json['experience'];
    image = json['image'];
    rating = json['rating']?.toDouble();
    consultationFee = json['consultationFee'];
    isAvailable = json['isAvailable'];
    availabilityStatus = json['availabilityStatus'];
    isVideoConsult = json['isVideoConsult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['doctorId'] = doctorId;
    data['name'] = name;
    data['specialization'] = specialization;
    data['experience'] = experience;
    data['image'] = image;
    data['rating'] = rating;
    data['consultationFee'] = consultationFee;
    data['isAvailable'] = isAvailable;
    data['availabilityStatus'] = availabilityStatus;
    data['isVideoConsult'] = isVideoConsult;
    return data;
  }
}
