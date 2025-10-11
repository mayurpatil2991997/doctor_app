
import 'dart:convert';

DoctorSlotModel doctorSlotModelFromJson(String str) => DoctorSlotModel.fromJson(json.decode(str));
String doctorSlotToJson(DoctorSlotModel data) => json.encode(data.toJson());

class DoctorSlotModel {
  String? doctorId;
  String? dayOfWeek;
  List<Slots>? slots;
  int? totalSlots;
  String? date;
  int? bookedSlots;
  int? availableSlots;
  String? doctorName;

  DoctorSlotModel(
      {this.doctorId,
        this.dayOfWeek,
        this.slots,
        this.totalSlots,
        this.date,
        this.bookedSlots,
        this.availableSlots,
        this.doctorName});

  DoctorSlotModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    dayOfWeek = json['dayOfWeek'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
    totalSlots = json['totalSlots'];
    date = json['date'];
    bookedSlots = json['bookedSlots'];
    availableSlots = json['availableSlots'];
    doctorName = json['doctorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorId'] = this.doctorId;
    data['dayOfWeek'] = this.dayOfWeek;
    if (this.slots != null) {
      data['slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
    data['totalSlots'] = this.totalSlots;
    data['date'] = this.date;
    data['bookedSlots'] = this.bookedSlots;
    data['availableSlots'] = this.availableSlots;
    data['doctorName'] = this.doctorName;
    return data;
  }
}

class Slots {
  Null? id;
  String? startTime;
  String? endTime;
  bool? available;
  bool? booked;

  Slots({this.id, this.startTime, this.endTime, this.available, this.booked});

  Slots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    available = json['available'];
    booked = json['booked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['available'] = this.available;
    data['booked'] = this.booked;
    return data;
  }
}
