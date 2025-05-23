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

  Future<APIStatus> postAPICallProfile({
    required Object param,
    required String url,
    Map<String, dynamic>? headers,
    bool isMultipart = false,
  }) async {
    try {
      headers ??= {'Accept': 'application/json'};

      if (!isMultipart) {
        headers['Content-Type'] = 'application/json';
      }

      print('Calling API: $url');
      print('Headers: $headers');
      print('Is Multipart: $isMultipart');

      final response = await dio.Dio().post(
        url,
        data: isMultipart ? param : jsonEncode(param),
        options: dio.Options(headers: headers),
      );

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        return SuccessProfile(code: response.statusCode, response: response.data);
      } else {
        return Failure(code: response.statusCode, errorResponse: 'Error: ${response.statusCode}');
      }
    } on dio.DioError catch (e) {
      print('Dio Error occurred: ${e.message}');
      if (e.response != null) {
        print('Dio Response Error: ${e.response!.data}');
      }

      String errorMessage = 'Request failed';
      if (e.response?.data is Map && e.response!.data['message'] != null) {
        errorMessage = e.response!.data['message'];
      } else if (e.response?.data is String) {
        errorMessage = e.response!.data;
      }

      return Failure(
        code: e.response?.statusCode ?? 0,
        errorResponse: errorMessage,
      );
    } catch (e) {
      print('Unknown Error: $e');
      return Failure(code: 0, errorResponse: 'Unexpected error: $e');
    }
  }


  // Future<APIStatus> signInApi({
  //   required String email,
  //   required String password,
  // }) async {
  //   var params = {"email": email, "password": password};
  //   var response = await APIServices.instance.postAPICall(
  //     param: params,
  //     url: APIConstant.signIn,
  //   );
  //   return response;
  // }
  //
  // Future<APIStatus> companySettingsApi() async {
  //   var response = await APIServices.instance.getAPICall(
  //     url: APIConstant.companySettings,
  //   );
  //   return response;
  // }
  //

}
