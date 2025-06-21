
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? verified;
  String? message;

  LoginModel({this.verified, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['message'] = this.message;
    return data;
  }
}
