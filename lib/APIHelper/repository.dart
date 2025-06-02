import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'api_constant.dart';
import 'api_services.dart';
import 'api_status.dart';

class Repository {
  static final Repository _instance = Repository._internal();

  factory Repository() {
    return _instance;
  }

  Repository._internal();

  static Repository get instance => _instance;
  final dio.Dio dioInstance = dio.Dio(
    dio.BaseOptions(
      connectTimeout: const Duration(seconds: 180),
      receiveTimeout: const Duration(seconds: 30),
      responseType: dio.ResponseType.json,
    ),
  );


  Future<APIStatus> registerApi({
    required String fName,
    required String lName,
    required String email,
    required String dateOfBirth,
    required String gender,
    required String contact,
  }) async {
    var params = {
      "firstName": fName,
      "lastName": lName,
      "email": email,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "contact": contact,
    };
    var response = await APIServices.instance.postAPICall(
      param: params,
      url: APIConstant.register,
    );
    print("hbdsfbdfb $params");
    return response;
  }

  Future<APIStatus> sendOtpApi({
    required String number,
  }) async {
    var params = {
      "mobileNumber": number
    };
    var response = await APIServices.instance.postAPICall(
      param: params,
      url: "${APIConstant.sendOtp}?mobileNumber=$number",
    );
    return response;
  }

// Future<APIStatus> companySettingsApi() async {
//   var response = await APIServices.instance.getAPICall(
//     url: APIConstant.companySettings,
//   );
//   return response;
// }
//

}
