import 'dart:convert';

AppSettingsMessageModel appSettingsMessageModelFromJson(String str) => AppSettingsMessageModel.fromJson(json.decode(str));
String appSettingsMessageModelToJson(AppSettingsMessageModel data) => json.encode(data.toJson());

class AppSettingsMessageModel {
  bool? status;
  String? message;

  AppSettingsMessageModel({this.status, this.message});

  AppSettingsMessageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
