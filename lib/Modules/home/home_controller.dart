import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Routes/app_routes.dart';
import '../../APIHelper/api_status.dart';
import '../../APIHelper/repository.dart';
import '../../Utils/helper_method.dart';
import '../../model/doctor_model.dart';

class HomeController extends GetxController {
  final phoneController = TextEditingController();
  
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var doctorsList = <DoctorDetails>[].obs;
  var top3Doctors = <DoctorDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Add a small delay to ensure UI is ready
    Future.delayed(Duration(milliseconds: 100), () {
      loadDoctors(); // Call API when controller initializes
    });
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  Future<void> loadDoctors() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    
    var response = await Repository.instance.doctorsApi();
    isLoading.value = false;
    
    if (response is Success) {
      try {
        // Access the data from the Dio response
        var responseData = response.response?.data;
        print('Home API Response type: ${responseData.runtimeType}');
        print('Home API Response data: $responseData');
        
        if (responseData != null) {
          // Check if responseData is already a Map (from Dio)
          if (responseData is Map<String, dynamic>) {
            print('Home Response is already a Map, parsing directly');
            var result = DoctorModel.fromJson(responseData);
            doctorsList.value = result.doctorDetails ?? [];
            _setTop3Doctors();
            hasError.value = false;
          } else {
            // If it's a string, try to parse it as JSON
            try {
              print('Home Attempting to parse as JSON string');
              var result = doctorModelFromJson(responseData.toString());
              doctorsList.value = result.doctorDetails ?? [];
              _setTop3Doctors();
              hasError.value = false;
            } catch (jsonError) {
              // If JSON parsing fails, try to handle the malformed JSON
              print('Home JSON parsing failed, trying to fix malformed JSON: $jsonError');
              String jsonString = responseData.toString();
              
              // Try to fix the specific format we're seeing
              // The API seems to return {doctorDetails: [...]} instead of {"doctorDetails": [...]}
              
              // First, fix the main structure: {doctorDetails: [...]} to {"doctorDetails": [...]}
              jsonString = jsonString.replaceAllMapped(
                RegExp(r'(\w+):\s*(\[|\{)'),
                (match) => '"${match.group(1)}": ${match.group(2)}'
              );
              
              // Fix object properties inside arrays: {key: value} to {"key": "value"}
              jsonString = jsonString.replaceAllMapped(
                RegExp(r'(\w+):\s*([^,}\]]+?)(?=[,}\]])'),
                (match) {
                  String key = match.group(1)!;
                  String value = match.group(2)!.trim();
                  
                  // Don't quote numeric values, booleans, or null
                  if (RegExp(r'^\d+$').hasMatch(value) || 
                      value == 'true' || value == 'false' || 
                      value == 'null') {
                    return '"$key": $value';
                  } else {
                    return '"$key": "$value"';
                  }
                }
              );
              
              // Handle array elements that might have trailing commas or other issues
              jsonString = jsonString.replaceAll(RegExp(r',\s*\]'), ']');
              jsonString = jsonString.replaceAll(RegExp(r',\s*\}'), '}');
              
              // Additional cleanup for common JSON issues
              jsonString = jsonString.replaceAll(RegExp(r'\s+'), ' '); // Remove extra spaces
              jsonString = jsonString.trim();
              
              print('Home Fixed JSON string: $jsonString');
              
              try {
                var result = doctorModelFromJson(jsonString);
                if (result.doctorDetails != null && result.doctorDetails!.isNotEmpty) {
                  doctorsList.value = result.doctorDetails!;
                  hasError.value = false;
                  _setTop3Doctors();
                  print('Home Successfully parsed fixed JSON with ${result.doctorDetails!.length} doctors');
                } else {
                  throw Exception('No doctor details found in response');
                }
              } catch (secondError) {
                print('Home Second parsing attempt failed: $secondError');
                print('Home Original response: $responseData');
                // If all else fails, show error instead of mock data
                hasError.value = true;
                errorMessage.value = 'Unable to parse doctor data from server. Please try again or contact support.';
                showSnackBarError(message: 'Unable to parse doctor data from server');
              }
            }
          }
        } else {
          hasError.value = true;
          errorMessage.value = 'No data received from server. Please check your internet connection and try again.';
          showSnackBarError(message: 'No data received from server');
        }
      } catch (e) {
        print('Home Error parsing doctors data: $e');
        print('Home Response data: ${response.response?.data}');
        hasError.value = true;
        errorMessage.value = 'Error loading doctors data: ${e.toString()}';
        showSnackBarError(message: 'Error loading doctors data');
      }
    } else if (response is Failure) {
      hasError.value = true;
      errorMessage.value = response.errorResponse.toString();
      showSnackBarError(message: response.errorResponse.toString());
    }
  }

  void _setTop3Doctors() {
    // Get top 3 doctors from the list
    if (doctorsList.isNotEmpty) {
      top3Doctors.value = doctorsList.take(3).toList();
    } else {
      top3Doctors.value = [];
    }
  }

  void retryLoading() {
    loadDoctors();
  }
}
