import 'dart:core';

enum Environment {
  development,
  uat,
  production,
}

enum UserGroup {
  genz,
  millennials,
  outliers,
}


class APIConstant {
  static final APIConstant _instance = APIConstant._internal();

  factory APIConstant() {
    return _instance;
  }

  APIConstant._internal();

  static APIConstant get instance => _instance;


  static Environment environment = Environment.development;

  static String get buyer {
    switch (environment) {
      case Environment.development:
        return 'http://localhost:8080/api/user';
      case Environment.uat:
        return 'https://uatcentral.cause-i.ai';
      case Environment.production:
        return 'https://auth.cause-i.ai';
    }
  }

  static String get seller {
    switch (environment) {
      case Environment.development:
        return 'http://localhost:8080/api/user';
      case Environment.uat:
        return 'https://uat-api.cause-i.ai';
      case Environment.production:
        return 'https://surveyback.cause-i.ai';
    }
  }

  static String baseUrl = "http://www.doctech.solutions/api";
  static String register = "$baseUrl/register/patient";
  static String sendOtp = "$baseUrl/auth/otp/initiate";
  static String login = "$baseUrl/auth/login";
  static String doctors = "$baseUrl/doctors";
}
