import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'package:pretty_dio_logger/pretty_dio_logger.dart'; // For PrettyDioLogger
import 'api_status.dart'; // Import your API status definitions

enum ParamType { raw, formData, none }

class APIServices {
  static final APIServices instance = APIServices._internal();

  factory APIServices() {
    return instance;
  }

  APIServices._internal() {
    dioInstance.interceptors.addAll(
      kDebugMode
          ? [
        PrettyDioLogger(
          requestHeader: true,
          request: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          logPrint: (object) {
            debugPrint(object.toString());
          },
          maxWidth: 90,
        ),
      ]
          : [],
    );

    // SSL/TLS settings for self-signed certificates (for development purposes)
    if (kDebugMode) {
      print("Debug mode: $kDebugMode");

      dioInstance.httpClientAdapter = DefaultHttpClientAdapter()
        ..onHttpClientCreate = (HttpClient client) {
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
          return client;
        };
    }
  }

  final dio.Dio dioInstance = dio.Dio(
    dio.BaseOptions(
      connectTimeout: const Duration(seconds: 180),
      receiveTimeout: const Duration(seconds: 30),
      responseType: dio.ResponseType.json,
    ),
  );

  Future<APIStatus> postImageAPICall({
    required dio.FormData param,
    required Map<String, String> headers,
    required String url,
  }) async {
    try {
      final response = await dioInstance.post(
        url,
        data: param,
        options: dio.Options(headers: headers),
      );
      return Success(response: response, code: response.statusCode);
    } catch (e) {
      return Failure(errorResponse: e.toString(), code: 500); // Handle exceptions as needed
    }
  }


  Future<dynamic> postAPICall({
    required Map<String, dynamic> param,
    required String url,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dioInstance.post(
        url,
        options: dio.Options(headers: headers),
        data: param,
      );
      return Success(code: response.statusCode, response: response);
    } on dio.DioError catch (e) {
      if (e.response != null) {
        var errorData = e.response?.data;
        String errorMessage = '';
        if (errorData is Map<String, dynamic>) {
          errorMessage = errorData['message'] ?? '';
        } else if (errorData is String) {
          errorMessage = errorData;
        } else {
          errorMessage = e.response?.statusMessage ?? 'An unknown error occurred';
        }
        return Failure(
          code: e.response?.statusCode ?? 0,
          errorResponse: errorMessage,
        );
      } else {
        return Failure(
          code: 0,
          errorResponse: e.message,
        );
      }
    }
  }

  // Future<APIStatus> postAPICallProfile({
  //   required Object param,
  //   required String url,
  //   Map<String, dynamic>? headers,
  //   bool isMultipart = false,
  // }) async {
  //   try {
  //     // Set default headers if not provided
  //     headers ??= {
  //       'Accept': 'application/json',
  //     };
  //
  //     if (!isMultipart) {
  //       headers['Content-Type'] = 'application/json';
  //     }
  //
  //     final response = await dioInstance.post(
  //       url,
  //       data: isMultipart ? param : jsonEncode(param),
  //       options: dio.Options(headers: headers),
  //     );
  //
  //     return Success(code: response.statusCode, response: response.data);
  //   } on dio.DioError catch (e) {
  //     String errorMessage = 'An unknown error occurred';
  //     if (e.response != null) {
  //       final errorData = e.response!.data;
  //       if (errorData is Map<String, dynamic>) {
  //         errorMessage = errorData['message'] ?? jsonEncode(errorData);
  //       } else if (errorData is String) {
  //         errorMessage = errorData;
  //       } else {
  //         errorMessage = e.response!.statusMessage ?? errorMessage;
  //       }
  //     } else {
  //       errorMessage = e.message ?? errorMessage;
  //     }
  //
  //     return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
  //   }
  // }



  Future<dynamic> getAPICall({
    required String url,
    Map<String, dynamic>? param,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dioInstance.get(
        url,
        queryParameters: param,
        options: dio.Options(headers: headers),
      );
      return Success(code: response.statusCode, response: response);
    } on dio.DioError catch (e) {
      if (e.response != null) {
        var errorData = e.response?.data;
        String errorMessage = '';
        if (errorData is Map<String, dynamic>) {
          errorMessage = errorData['message'] ?? '';
        } else if (errorData is String) {
          errorMessage = errorData;
        } else {
          errorMessage = e.response?.statusMessage ?? 'An unknown error occurred';
        }
        return Failure(
          code: e.response?.statusCode ?? 0,
          errorResponse: errorMessage,
        );
      } else {
        return Failure(
          code: 0,
          errorResponse: e.message,
        );
      }
    }
  }

  Future<dynamic> deleteAPICall({
    required Map<String, dynamic> param,
    required String url,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dioInstance.delete(
        url,
        options: dio.Options(headers: headers),
        data: param,
      );
      return Success(code: response.statusCode, response: response);
    } on dio.DioError catch (e) {
      if (e.response != null) {
        var errorData = e.response?.data;
        String errorMessage = '';
        if (errorData is Map<String, dynamic>) {
          errorMessage = errorData['message'] ?? '';
        } else if (errorData is String) {
          errorMessage = errorData;
        } else {
          errorMessage = e.response?.statusMessage ?? 'An unknown error occurred';
        }
        return Failure(
          code: e.response?.statusCode ?? 0,
          errorResponse: errorMessage,
        );
      } else {
        return Failure(
          code: 0,
          errorResponse: e.message,
        );
      }
    }
  }

  Future<dynamic> patchAPICall({
    required Map<String, dynamic> param,
    required String url,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dioInstance.patch(
        url,
        options: dio.Options(headers: headers),
        data: param,
      );
      return Success(code: response.statusCode, response: response);
    } on dio.DioError catch (e) {
      if (e.response != null) {
        var errorData = e.response?.data;
        String errorMessage = '';
        if (errorData is Map<String, dynamic>) {
          errorMessage = errorData['message'] ?? '';
        } else if (errorData is String) {
          errorMessage = errorData;
        } else {
          errorMessage = e.response?.statusMessage ?? 'An unknown error occurred';
        }
        return Failure(
          code: e.response?.statusCode ?? 0,
          errorResponse: errorMessage,
        );
      } else {
        return Failure(
          code: 0,
          errorResponse: e.message,
        );
      }
    }
  }

  Future<dynamic> patchDeleteAccountAPICall({
    required String url,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dioInstance.patch(
        url,
        options: dio.Options(headers: headers),
      );
      return Success(code: response.statusCode, response: response);
    } on dio.DioError catch (e) {
      if (e.response != null) {
        var errorData = e.response?.data;
        String errorMessage = '';
        if (errorData is Map<String, dynamic>) {
          errorMessage = errorData['message'] ?? '';
        } else if (errorData is String) {
          errorMessage = errorData;
        } else {
          errorMessage = e.response?.statusMessage ?? 'An unknown error occurred';
        }
        return Failure(
          code: e.response?.statusCode ?? 0,
          errorResponse: errorMessage,
        );
      } else {
        return Failure(
          code: 0,
          errorResponse: e.message,
        );
      }
    }
  }

  Future<APIStatus> patchImageAPICall({
    required dio.FormData param,
    required Map<String, String> headers,
    required String url,
  }) async {
    try {
      final response = await dioInstance.patch(
        url,
        data: param,
        options: dio.Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return Success(code: response.statusCode, response: response.data);
      } else {
        return Failure(code: response.statusCode, errorResponse: response.statusMessage);
      }
    } on dio.DioError catch (e) {
      String errorMessage = '';
      if (e.response != null) {
        var errorData = e.response?.data;
        if (errorData is Map<String, dynamic>) {
          errorMessage = errorData['message'] ?? '';
        } else if (errorData is String) {
          errorMessage = errorData;
        } else {
          errorMessage = e.response?.statusMessage ?? 'An unknown error occurred';
        }
      } else {
        errorMessage = e.message.toString();
      }
      return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
    } catch (error) {
      // Handle other exceptions
      return Failure(errorResponse: error.toString());
    }
  }


}
