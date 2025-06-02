import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_status.dart';

class APIServices {
  static final APIServices instance = APIServices._internal();

  factory APIServices() => instance;

  late dio.Dio dioInstance;

  APIServices._internal() {
    final options = dio.BaseOptions(
      connectTimeout: const Duration(seconds: 180),
      receiveTimeout: const Duration(seconds: 30),
      responseType: dio.ResponseType.json,
    );

    dioInstance = dio.Dio(options);

    if (kDebugMode) {
      // Bypass SSL verification (ONLY for development)
      (dioInstance.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };

      // Add logging
      dioInstance.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          request: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  /// Common Error Handling Method
  Failure _handleError(dio.DioException e) {
    String message = e.message ?? 'Unknown error';
    int code = e.response?.statusCode ?? 0;

    if (e.type == dio.DioExceptionType.connectionError || e.type == dio.DioExceptionType.unknown) {
      message = 'Connection failed. Check your internet or server URL.';
    } else if (e.response != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic>) {
        message = data['message'] ?? e.message!;
      } else if (data is String) {
        message = data;
      }
    }

    return Failure(code: code, errorResponse: message);
  }

  Future<dynamic> postAPICall({
    required Map<String, dynamic> param,
    required String url,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dioInstance.post(
        url,
        data: param,
        options: dio.Options(headers: headers),
      );
      return Success(code: response.statusCode, response: response);
    } on dio.DioException catch (e) {
      return _handleError(e);
    }
  }

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
    } on dio.DioException catch (e) {
      return _handleError(e);
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
        data: param,
        options: dio.Options(headers: headers),
      );
      return Success(code: response.statusCode, response: response);
    } on dio.DioException catch (e) {
      return _handleError(e);
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
        data: param,
        options: dio.Options(headers: headers),
      );
      return Success(code: response.statusCode, response: response);
    } on dio.DioException catch (e) {
      return _handleError(e);
    }
  }

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
      return Success(code: response.statusCode, response: response);
    } on dio.DioException catch (e) {
      return _handleError(e);
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
      return Success(code: response.statusCode, response: response.data);
    } on dio.DioException catch (e) {
      return _handleError(e);
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
    } on dio.DioException catch (e) {
      return _handleError(e);
    }
  }
}
