import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../APIHelper/api_status.dart';
import '../../APIHelper/repository.dart';
import '../../Utils/helper_method.dart';
import '../../model/doctor_model.dart';

class DoctorsController extends GetxController {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var filteredDoctorsList = <DoctorDetails>[].obs;
  var selectedSpecialization = 'General Physician'.obs;
  var searchQuery = ''.obs;

  var doctorsList = <DoctorDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Add a small delay to ensure UI is ready
    Future.delayed(Duration(milliseconds: 100), () {
      doctors(); // Call API when controller initializes
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  Future<void> doctors() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    
    var response = await Repository.instance.doctorsApi();
    isLoading.value = false;
    
    if (response is Success) {
      try {
        // Access the data from the Dio response
        var responseData = response.response?.data;
        print('API Response type: ${responseData.runtimeType}');
        print('API Response data: $responseData');
        
        if (responseData != null) {
          // Check if responseData is already a Map (from Dio)
          if (responseData is Map<String, dynamic>) {
            print('Response is already a Map, parsing directly');
            var result = DoctorModel.fromJson(responseData);
            if (result.doctorDetails != null && result.doctorDetails!.isNotEmpty) {
              doctorsList.value = result.doctorDetails!;
              hasError.value = false;
              _filterDoctors(); // Apply current filters
              print('Successfully parsed Map response with ${result.doctorDetails!.length} doctors');
            } else {
              throw Exception('No doctor details found in Map response');
            }
          } else {
            // If it's a string, try to parse it as JSON
            try {
              print('Attempting to parse as JSON string');
              var result = doctorModelFromJson(responseData.toString());
              if (result.doctorDetails != null && result.doctorDetails!.isNotEmpty) {
                doctorsList.value = result.doctorDetails!;
                hasError.value = false;
                _filterDoctors(); // Apply current filters
                print('Successfully parsed JSON string with ${result.doctorDetails!.length} doctors');
              } else {
                throw Exception('No doctor details found in JSON string response');
              }
            } catch (jsonError) {
              // If JSON parsing fails, try to handle the malformed JSON
              print('JSON parsing failed, trying to fix malformed JSON: $jsonError');
              String jsonString = responseData.toString();
              
              // Try to fix the specific format we're seeing
              // The API seems to return {doctorDetails: [...]} instead of {"doctorDetails": [...]}
              
              // More targeted approach for the specific format
              // Based on the error: {doctorDetails: [{registrationNumber: DOC001, firstName: Swapnil, lastName:...
              
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
              
              print('Fixed JSON string: $jsonString');
              
              try {
                var result = doctorModelFromJson(jsonString);
                if (result.doctorDetails != null && result.doctorDetails!.isNotEmpty) {
                  doctorsList.value = result.doctorDetails!;
                  hasError.value = false;
                  _filterDoctors(); // Apply current filters
                  print('Successfully parsed fixed JSON with ${result.doctorDetails!.length} doctors');
                } else {
                  throw Exception('No doctor details found in response');
                }
              } catch (secondError) {
                print('Second parsing attempt failed: $secondError');
                print('Original response: $responseData');
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
        print('Error parsing doctors data: $e');
        print('Response data: ${response.response?.data}');
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

  void searchDoctors(String query) {
    searchQuery.value = query;
    _filterDoctors();
  }

  void _filterDoctors() {
    List<DoctorDetails> filtered = List.from(doctorsList);
    
    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase().trim();
      filtered = filtered.where((doctor) {
        final firstName = doctor.firstName?.toLowerCase() ?? '';
        final lastName = doctor.lastName?.toLowerCase() ?? '';
        final specialization = doctor.specialization?.toLowerCase() ?? '';
        final qualifications = doctor.qualifications?.toLowerCase() ?? '';
        
        return firstName.contains(query) ||
               lastName.contains(query) ||
               specialization.contains(query) ||
               qualifications.contains(query) ||
               '${firstName} ${lastName}'.contains(query);
      }).toList();
    }
    
    // Filter by specialization
    if (selectedSpecialization.value != 'General Physician') {
      filtered = filtered.where((doctor) {
        return doctor.specialization?.toLowerCase() == selectedSpecialization.value.toLowerCase();
      }).toList();
    }
    
    filteredDoctorsList.value = filtered;
  }
  void bookAppointment(DoctorDetails doctor) {
    // Handle appointment booking
    Get.snackbar(
      "Appointment",
      "Booking appointment with Dr. ${doctor.firstName} ${doctor.lastName}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.primaryColor,
      colorText: Colors.white,
    );
  }

  String getDoctorsFoundText() {
    return "${filteredDoctorsList.length} Doctors found in";
  }

  void retryLoading() {
    doctors();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    selectedSpecialization.value = 'General Physician';
    _filterDoctors();
  }

  void selectSpecialization(String specialization) {
    selectedSpecialization.value = specialization;
    _filterDoctors();
  }

  void _createMockData() {
    // If API fails completely, show empty state instead of hardcoded data
    doctorsList.value = [];
    filteredDoctorsList.value = [];
    hasError.value = true;
    errorMessage.value = 'Unable to load doctors data. Please check your internet connection and try again.';
    print('API failed, showing empty state instead of hardcoded data');
  }
}
