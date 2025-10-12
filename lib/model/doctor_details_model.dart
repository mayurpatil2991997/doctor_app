
import 'dart:convert';

DoctorDetailsModel doctorDetailsModelFromJson(String str) => DoctorDetailsModel.fromJson(json.decode(str));
String doctorDetailsModelToJson(DoctorDetailsModel data) => json.encode(data.toJson());


class DoctorDetailsModel {
  String? registrationNumber;
  String? firstName;
  String? lastName;
  String? email;
  String? contactNumber;
  String? specialization;
  String? doctorStatus;
  String? profileImageUrl;
  String? createdAt;
  String? updatedAt;
  String? professionalBio;
  List<String>? qualifications;
  List<String>? certifications;
  String? experienceYears;
  String? dateOfBirth;
  String? gender;
  String? additionalSpecializations;
  List<CareerHistory>? careerHistories;
  List<HospitalAssociations>? hospitalAssociations;
  List<HospitalAddresses>? hospitalAddresses;
  List<Affiliations>? affiliations;
  List<ConsultationFee>? consultationFees;
  DoctorRating? doctorRating;
  List<Reviews>? reviews;
  List<WorkingDays>? workingDays;
  List<Blog>? blogs;

  DoctorDetailsModel(
      {this.registrationNumber,
        this.firstName,
        this.lastName,
        this.email,
        this.contactNumber,
        this.specialization,
        this.doctorStatus,
        this.profileImageUrl,
        this.createdAt,
        this.updatedAt,
        this.professionalBio,
        this.qualifications,
        this.certifications,
        this.experienceYears,
        this.dateOfBirth,
        this.gender,
        this.additionalSpecializations,
        this.careerHistories,
        this.hospitalAssociations,
        this.hospitalAddresses,
        this.affiliations,
        this.consultationFees,
        this.doctorRating,
        this.reviews,
        this.workingDays,
        this.blogs});

  DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    registrationNumber = json['registrationNumber'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    contactNumber = json['contactNumber'];
    specialization = json['specialization'];
    doctorStatus = json['doctorStatus'];
    profileImageUrl = json['profileImageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    professionalBio = json['professionalBio'];
    qualifications = json['qualifications'].cast<String>();
    certifications = json['certifications'].cast<String>();
    experienceYears = json['experienceYears'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    additionalSpecializations = json['additionalSpecializations'];
    if (json['careerHistories'] != null) {
      careerHistories = <CareerHistory>[];
      json['careerHistories'].forEach((v) {
        careerHistories!.add(new CareerHistory.fromJson(v));
      });
    }
    if (json['hospitalAssociations'] != null) {
      hospitalAssociations = <HospitalAssociations>[];
      json['hospitalAssociations'].forEach((v) {
        hospitalAssociations!.add(new HospitalAssociations.fromJson(v));
      });
    }
    if (json['hospitalAddresses'] != null) {
      hospitalAddresses = <HospitalAddresses>[];
      json['hospitalAddresses'].forEach((v) {
        hospitalAddresses!.add(new HospitalAddresses.fromJson(v));
      });
    }
    if (json['affiliations'] != null) {
      affiliations = <Affiliations>[];
      json['affiliations'].forEach((v) {
        affiliations!.add(new Affiliations.fromJson(v));
      });
    }
    if (json['consultationFees'] != null) {
      consultationFees = <ConsultationFee>[];
      json['consultationFees'].forEach((v) {
        consultationFees!.add(new ConsultationFee.fromJson(v));
      });
    }
    doctorRating = json['doctorRating'] != null
        ? new DoctorRating.fromJson(json['doctorRating'])
        : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    if (json['workingDays'] != null) {
      workingDays = <WorkingDays>[];
      json['workingDays'].forEach((v) {
        workingDays!.add(new WorkingDays.fromJson(v));
      });
    }
    if (json['blogs'] != null) {
      blogs = <Blog>[];
      json['blogs'].forEach((v) {
        blogs!.add(new Blog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registrationNumber'] = this.registrationNumber;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['contactNumber'] = this.contactNumber;
    data['specialization'] = this.specialization;
    data['doctorStatus'] = this.doctorStatus;
    data['profileImageUrl'] = this.profileImageUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['professionalBio'] = this.professionalBio;
    data['qualifications'] = this.qualifications;
    data['certifications'] = this.certifications;
    data['experienceYears'] = this.experienceYears;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['additionalSpecializations'] = this.additionalSpecializations;
    if (this.careerHistories != null) {
      data['careerHistories'] =
          this.careerHistories!.map((v) => v.toJson()).toList();
    }
    if (this.hospitalAssociations != null) {
      data['hospitalAssociations'] =
          this.hospitalAssociations!.map((v) => v.toJson()).toList();
    }
    if (this.hospitalAddresses != null) {
      data['hospitalAddresses'] =
          this.hospitalAddresses!.map((v) => v.toJson()).toList();
    }
    if (this.affiliations != null) {
      data['affiliations'] = this.affiliations!.map((v) => v.toJson()).toList();
    }
    if (this.consultationFees != null) {
      data['consultationFees'] =
          this.consultationFees!.map((v) => v.toJson()).toList();
    }
    if (this.doctorRating != null) {
      data['doctorRating'] = this.doctorRating!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    if (this.workingDays != null) {
      data['workingDays'] = this.workingDays!.map((v) => v.toJson()).toList();
    }
    if (this.blogs != null) {
      data['blogs'] = this.blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HospitalAssociations {
  int? id;
  String? hospitalId;
  String? hospitalName;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  Null? approvedBy;
  Null? rejectedBy;
  Null? rejectionReason;
  Null? notes;

  HospitalAssociations(
      {this.id,
        this.hospitalId,
        this.hospitalName,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.approvedBy,
        this.rejectedBy,
        this.rejectionReason,
        this.notes});

  HospitalAssociations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalId = json['hospitalId'];
    hospitalName = json['hospitalName'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    approvedBy = json['approvedBy'];
    rejectedBy = json['rejectedBy'];
    rejectionReason = json['rejectionReason'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hospitalId'] = this.hospitalId;
    data['hospitalName'] = this.hospitalName;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['approvedBy'] = this.approvedBy;
    data['rejectedBy'] = this.rejectedBy;
    data['rejectionReason'] = this.rejectionReason;
    data['notes'] = this.notes;
    return data;
  }
}

class HospitalAddresses {
  String? hospitalName;
  String? type;
  String? streetAddress;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? phone;
  String? email;

  HospitalAddresses(
      {this.hospitalName,
        this.type,
        this.streetAddress,
        this.city,
        this.state,
        this.postalCode,
        this.country,
        this.phone,
        this.email});

  HospitalAddresses.fromJson(Map<String, dynamic> json) {
    hospitalName = json['hospitalName'];
    type = json['type'];
    streetAddress = json['streetAddress'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospitalName'] = this.hospitalName;
    data['type'] = this.type;
    data['streetAddress'] = this.streetAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}

class Affiliations {
  String? institutionName;
  String? type;
  String? role;
  String? startDate;
  String? endDate;
  String? description;

  Affiliations(
      {this.institutionName,
        this.type,
        this.role,
        this.startDate,
        this.endDate,
        this.description});

  Affiliations.fromJson(Map<String, dynamic> json) {
    institutionName = json['institutionName'];
    type = json['type'];
    role = json['role'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['institutionName'] = this.institutionName;
    data['type'] = this.type;
    data['role'] = this.role;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    return data;
  }
}

class DoctorRating {
  double? averageRating;
  int? totalReviews;
  int? fiveStarCount;
  int? fourStarCount;
  int? threeStarCount;
  int? twoStarCount;
  int? oneStarCount;

  DoctorRating(
      {this.averageRating,
        this.totalReviews,
        this.fiveStarCount,
        this.fourStarCount,
        this.threeStarCount,
        this.twoStarCount,
        this.oneStarCount});

  DoctorRating.fromJson(Map<String, dynamic> json) {
    averageRating = json['averageRating'];
    totalReviews = json['totalReviews'];
    fiveStarCount = json['fiveStarCount'];
    fourStarCount = json['fourStarCount'];
    threeStarCount = json['threeStarCount'];
    twoStarCount = json['twoStarCount'];
    oneStarCount = json['oneStarCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['averageRating'] = this.averageRating;
    data['totalReviews'] = this.totalReviews;
    data['fiveStarCount'] = this.fiveStarCount;
    data['fourStarCount'] = this.fourStarCount;
    data['threeStarCount'] = this.threeStarCount;
    data['twoStarCount'] = this.twoStarCount;
    data['oneStarCount'] = this.oneStarCount;
    return data;
  }
}

class Reviews {
  int? reviewId;
  String? patientId;
  String? patientName;
  int? rating;
  String? comments;
  String? reviewDate;
  bool? verified;

  Reviews(
      {this.reviewId,
        this.patientId,
        this.patientName,
        this.rating,
        this.comments,
        this.reviewDate,
        this.verified});

  Reviews.fromJson(Map<String, dynamic> json) {
    reviewId = json['reviewId'];
    patientId = json['patientId'];
    patientName = json['patientName'];
    rating = json['rating'];
    comments = json['comments'];
    reviewDate = json['reviewDate'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewId'] = this.reviewId;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['rating'] = this.rating;
    data['comments'] = this.comments;
    data['reviewDate'] = this.reviewDate;
    data['verified'] = this.verified;
    return data;
  }
}

class WorkingDays {
  int? id;
  String? dayOfWeek;
  String? startTime;
  String? endTime;
  String? notes;
  bool? working;

  WorkingDays(
      {this.id,
        this.dayOfWeek,
        this.startTime,
        this.endTime,
        this.notes,
        this.working});

  WorkingDays.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayOfWeek = json['dayOfWeek'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    notes = json['notes'];
    working = json['working'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dayOfWeek'] = this.dayOfWeek;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['notes'] = this.notes;
    data['working'] = this.working;
    return data;
  }
}

class CareerHistory {
  String? position;
  String? organization;
  String? startDate;
  String? endDate;
  String? description;

  CareerHistory({
    this.position,
    this.organization,
    this.startDate,
    this.endDate,
    this.description,
  });

  CareerHistory.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    organization = json['organization'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this.position;
    data['organization'] = this.organization;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    return data;
  }
}

class ConsultationFee {
  String? type;
  double? amount;
  String? currency;

  ConsultationFee({
    this.type,
    this.amount,
    this.currency,
  });

  ConsultationFee.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount = json['amount']?.toDouble();
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    return data;
  }
}

class Blog {
  int? blogId;
  String? title;
  String? content;
  String? publishedDate;
  String? imageUrl;

  Blog({
    this.blogId,
    this.title,
    this.content,
    this.publishedDate,
    this.imageUrl,
  });

  Blog.fromJson(Map<String, dynamic> json) {
    blogId = json['blogId'];
    title = json['title'];
    content = json['content'];
    publishedDate = json['publishedDate'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blogId'] = this.blogId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['publishedDate'] = this.publishedDate;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class TimeSlot {
  String? time;
  String? period;
  bool? isBooked;
  bool? isSelected;
  String? date;
  String? slotId;

  TimeSlot({
    this.time,
    this.period,
    this.isBooked,
    this.isSelected,
    this.date,
    this.slotId,
  });

  TimeSlot.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    period = json['period'];
    isBooked = json['isBooked'];
    isSelected = json['isSelected'];
    date = json['date'];
    slotId = json['slotId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['period'] = this.period;
    data['isBooked'] = this.isBooked;
    data['isSelected'] = this.isSelected;
    data['date'] = this.date;
    data['slotId'] = this.slotId;
    return data;
  }
}
