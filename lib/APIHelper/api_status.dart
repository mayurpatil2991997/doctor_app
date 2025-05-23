import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;

abstract class APIStatus {}

class Success implements APIStatus {
  int? code;
  Response? response;

  Success({this.code, this.response});
}

class SuccessProfile implements APIStatus {
  final int? code;
  final dynamic response;

  SuccessProfile({this.code, this.response});
}

class Failure implements APIStatus {
  int? code;
  Object? errorResponse;

  Failure({this.code, this.errorResponse});
}
