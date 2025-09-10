import 'dart:convert';

DoctorProfileModel doctorProfileModelFromJson(String str) => DoctorProfileModel.fromJson(json.decode(str));
String doctorProfileModelToJson(DoctorProfileModel data) => json.encode(data.toJson());

class DoctorProfileModel {
  int? doctorId;
  String? name;
  String? specialization;
  String? degree;
  String? experience;
  String? image;
  double? rating;
  int? totalReviews;
  int? consultationFee;
  String? hospitalName;
  List<TimeSlot>? timeSlots;
  List<Review>? reviews;
  List<String>? availableDates;

  DoctorProfileModel({
    this.doctorId,
    this.name,
    this.specialization,
    this.degree,
    this.experience,
    this.image,
    this.rating,
    this.totalReviews,
    this.consultationFee,
    this.hospitalName,
    this.timeSlots,
    this.reviews,
    this.availableDates,
  });

  DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    name = json['name'];
    specialization = json['specialization'];
    degree = json['degree'];
    experience = json['experience'];
    image = json['image'];
    rating = json['rating']?.toDouble();
    totalReviews = json['totalReviews'];
    consultationFee = json['consultationFee'];
    hospitalName = json['hospitalName'];
    
    if (json['timeSlots'] != null) {
      timeSlots = <TimeSlot>[];
      json['timeSlots'].forEach((v) {
        timeSlots!.add(TimeSlot.fromJson(v));
      });
    }
    
    if (json['reviews'] != null) {
      reviews = <Review>[];
      json['reviews'].forEach((v) {
        reviews!.add(Review.fromJson(v));
      });
    }
    
    availableDates = json['availableDates']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['doctorId'] = doctorId;
    data['name'] = name;
    data['specialization'] = specialization;
    data['degree'] = degree;
    data['experience'] = experience;
    data['image'] = image;
    data['rating'] = rating;
    data['totalReviews'] = totalReviews;
    data['consultationFee'] = consultationFee;
    data['hospitalName'] = hospitalName;
    
    if (timeSlots != null) {
      data['timeSlots'] = timeSlots!.map((v) => v.toJson()).toList();
    }
    
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    
    data['availableDates'] = availableDates;
    return data;
  }
}

class TimeSlot {
  String? time;
  String? period; // AM/PM
  bool? isBooked;
  bool? isSelected;
  String? date;

  TimeSlot({
    this.time,
    this.period,
    this.isBooked,
    this.isSelected,
    this.date,
  });

  TimeSlot.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    period = json['period'];
    isBooked = json['isBooked'];
    isSelected = json['isSelected'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['time'] = time;
    data['period'] = period;
    data['isBooked'] = isBooked;
    data['isSelected'] = isSelected;
    data['date'] = date;
    return data;
  }
}

class Review {
  String? patientName;
  String? patientImage;
  double? rating;
  String? comment;
  String? date;

  Review({
    this.patientName,
    this.patientImage,
    this.rating,
    this.comment,
    this.date,
  });

  Review.fromJson(Map<String, dynamic> json) {
    patientName = json['patientName'];
    patientImage = json['patientImage'];
    rating = json['rating']?.toDouble();
    comment = json['comment'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['patientName'] = patientName;
    data['patientImage'] = patientImage;
    data['rating'] = rating;
    data['comment'] = comment;
    data['date'] = date;
    return data;
  }
}
