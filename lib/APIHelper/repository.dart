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
      headers: {
        'Content-Type': 'application/json',
      },
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

  Future<APIStatus> loginApi({
    required String number,
    required String otp,
  }) async {
    var params = {
      "mobileNumber": number,
      "otp": otp,
    };
    var response = await APIServices.instance.postAPICall(
      param: params,
      url: APIConstant.login,
    );
    return response;
  }

  Future<APIStatus> doctorsApi() async {
    var response = await APIServices.instance.getAPICall(
      url: APIConstant.doctors,
    );
    return response;
  }

  Future<APIStatus> doctorDetailsApi({
    required String registrationNumber,
  }) async {
    String url = "${APIConstant.doctorDetails}/$registrationNumber/complete";
    print('🔗 Repository: Making GET request to: $url');
    
    var response = await APIServices.instance.getAPICall(
      url: url,
    );
    
    print('📊 Repository: Response type: ${response.runtimeType}');
    if (response is Success) {
      print('✅ Repository: Success response received');
      print('📄 Repository: Response data: ${response.response?.data}');
    } else if (response is Failure) {
      print('❌ Repository: Failure response received');
      print('🚨 Repository: Error: ${response.errorResponse}');
    }
    
    return response;
  }

  Future<APIStatus> doctorTimeSlotsApi({
    required String registrationNumber,
    required String date,
  }) async {
    String url = "${APIConstant.doctorTimeSlots}/$registrationNumber/slots/date/$date?slotMinutes=30";
    print('🔗 Repository: Making GET request to: $url');
    
    var response = await APIServices.instance.getAPICall(
      url: url,
    );
    
    print('📊 Repository: TimeSlots Response type: ${response.runtimeType}');
    if (response is Success) {
      print('✅ Repository: TimeSlots Success response received');
      print('📄 Repository: TimeSlots Response data: ${response.response?.data}');
    } else if (response is Failure) {
      print('❌ Repository: TimeSlots Failure response received');
      print('🚨 Repository: TimeSlots Error: ${response.errorResponse}');
    }
    
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
