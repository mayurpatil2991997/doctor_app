import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../APIHelper/api_constant.dart';
import '../../model/doctor_details_model.dart';
import '../../model/doctor_slot_model.dart';
import '../../APIHelper/repository.dart';
import '../../APIHelper/api_status.dart';

class DoctorProfileController extends GetxController {
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var doctorProfile = Rxn<DoctorDetailsModel>();
  var doctorDetails = Rxn<DoctorDetailsModel>();
  var doctorSlots = Rxn<DoctorSlotModel>();
  var selectedDate = DateTime.now().obs;
  var selectedTimeSlot = Rxn<TimeSlot>();
  var availableTimeSlots = <TimeSlot>[].obs;
  var selectedMonth = DateTime.now().obs;
  var isLoadingSlots = false.obs;
  
  // Calendar related
  var calendarDates = <DateTime>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    generateCalendarDates();
    loadDoctorProfile();
  }

  void loadDoctorProfile() async {
    print('🔄 Starting loadDoctorProfile...');
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    // Get registration number from arguments
    final args = Get.arguments;
    String registrationNumber = 'DOC001'; // Default fallback
    
    print('📋 Arguments received: $args');
    
    if (args != null && args['doctor'] != null) {
      registrationNumber = args['doctor'].registrationNumber ?? 'DOC001';
      print('👨‍⚕️ Doctor registration number: $registrationNumber');
    } else {
      print('⚠️ No doctor arguments found, using default: $registrationNumber');
    }

    print('🌐 Making API call to: ${APIConstant.doctorDetails}/$registrationNumber/complete');

    try {
      var response = await Repository.instance.doctorDetailsApi(
        registrationNumber: registrationNumber,
      );
      
      print('📡 API Response received: ${response.runtimeType}');

      if (response is Success) {
        var responseData = response.response?.data;
        print('✅ Doctor Details API Response: $responseData');

        if (responseData != null) {
          // Parse the response data
          if (responseData is Map<String, dynamic>) {
            print('📊 Parsing Map response...');
            doctorDetails.value = DoctorDetailsModel.fromJson(responseData);
            _createDoctorProfileFromDetails();
            print('✅ Successfully loaded data from API');
          } else {
            // If it's a string, try to parse it as JSON
            try {
              print('📊 Parsing JSON string response...');
              doctorDetails.value = doctorDetailsModelFromJson(responseData.toString());
              _createDoctorProfileFromDetails();
              print('✅ Successfully loaded data from JSON string');
            } catch (e) {
              print('❌ Error parsing doctor details: $e');
              print('🔄 Loading mock data as fallback...');
              _loadMockData();
            }
          }
        } else {
          print('⚠️ No response data received, loading mock data...');
          _loadMockData();
        }
      } else if (response is Failure) {
        print('❌ API call failed: ${response.errorResponse}');
        hasError.value = true;
        errorMessage.value = response.errorResponse.toString();
        print('🔄 Loading mock data as fallback...');
        _loadMockData();
      }
    } catch (e) {
      print('Error loading doctor profile: $e');
      hasError.value = true;
      errorMessage.value = 'Error loading doctor details: ${e.toString()}';
      _loadMockData();
    }

    isLoading.value = false;
    loadTimeSlotsForDate(selectedDate.value);
  }

  void _createDoctorProfileFromDetails() {
    if (doctorDetails.value == null) return;

    final details = doctorDetails.value!;
    print('📊 Setting doctorProfile directly from DoctorDetailsModel: ${details.firstName} ${details.lastName}');
    
    // Directly use DoctorDetailsModel
    doctorProfile.value = details;
    print('✅ DoctorDetailsModel set directly to doctorProfile');
  }

  void _loadMockData() {
    // Fallback mock data using DoctorDetailsModel
    print('🔄 Loading mock DoctorDetailsModel data...');
    doctorProfile.value = DoctorDetailsModel(
      registrationNumber: "DOC001",
      firstName: "Kiran",
      lastName: "Doke",
      email: "kiran.doke@example.com",
      contactNumber: "+91 9876543210",
      specialization: "Pediatrician",
      doctorStatus: "Active",
      profileImageUrl: "assets/images/doctor1.jpg",
      professionalBio: "Experienced pediatrician with expertise in child healthcare.",
      qualifications: ["MBBS", "DCH(Pediatrics)", "DNB (Pediatrics)"],
      certifications: ["Pediatric Advanced Life Support"],
      experienceYears: "5",
      dateOfBirth: "1985-01-15",
      gender: "Male",
      additionalSpecializations: "Child Development, Vaccination",
      hospitalAssociations: [
        HospitalAssociations(
          id: 1,
          hospitalName: "City Hospital",
          status: "Active",
        ),
      ],
      consultationFees: [
        ConsultationFee(
          type: "General Consultation",
          amount: 600.0,
          currency: "INR",
        ),
      ],
      doctorRating: DoctorRating(
        averageRating: 4.9,
      totalReviews: 5,
        fiveStarCount: 4,
        fourStarCount: 1,
        threeStarCount: 0,
        twoStarCount: 0,
        oneStarCount: 0,
      ),
      reviews: [
        Reviews(
          reviewId: 1,
          patientName: "Chhaya Deshmukh",
          rating: 5,
          comments: "I was so worried about my baby's health, especially about his development. Visiting Dr. Kiran was truly a wise decision as he helped with all my concerns.",
          reviewDate: "Nov 03, 2023",
          verified: true,
        ),
        Reviews(
          reviewId: 2,
          patientName: "Nikita Indalkar",
          rating: 4,
          comments: "Excellent doctor with great expertise in pediatrics.",
          reviewDate: "Apr 04, 2023",
          verified: true,
        ),
      ],
      workingDays: [
        WorkingDays(
          id: 1,
          dayOfWeek: "Monday",
          startTime: "09:00",
          endTime: "17:00",
          working: true,
        ),
        WorkingDays(
          id: 2,
          dayOfWeek: "Tuesday",
          startTime: "09:00",
          endTime: "17:00",
          working: true,
        ),
        WorkingDays(
          id: 3,
          dayOfWeek: "Wednesday",
          startTime: "09:00",
          endTime: "17:00",
          working: true,
        ),
        WorkingDays(
          id: 4,
          dayOfWeek: "Thursday",
          startTime: "09:00",
          endTime: "17:00",
          working: true,
        ),
        WorkingDays(
          id: 5,
          dayOfWeek: "Friday",
          startTime: "09:00",
          endTime: "17:00",
          working: true,
        ),
        WorkingDays(
          id: 6,
          dayOfWeek: "Saturday",
          startTime: "09:00",
          endTime: "13:00",
          working: true,
        ),
        WorkingDays(
          id: 7,
          dayOfWeek: "Sunday",
          startTime: "00:00",
          endTime: "00:00",
          working: false,
        ),
      ],
    );
    print('✅ Mock DoctorDetailsModel data loaded');
  }

  void generateCalendarDates() {
    calendarDates.clear();
    DateTime startDate = DateTime(selectedMonth.value.year, selectedMonth.value.month, 1);
    DateTime endDate = DateTime(selectedMonth.value.year, selectedMonth.value.month + 1, 0);
    
    for (int i = 0; i <= endDate.day - startDate.day; i++) {
      calendarDates.add(startDate.add(Duration(days: i)));
    }
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    loadTimeSlotsForDate(date);
  }

  void loadTimeSlotsForDate(DateTime date) async {
    print('🕐 Loading time slots for date: ${DateFormat('yyyy-MM-dd').format(date)}');
    isLoadingSlots.value = true;
    
    // Get registration number from doctor profile or arguments
    String registrationNumber = 'DOC001'; // Default fallback
    
    // First try to get from current doctor profile
    if (doctorProfile.value?.registrationNumber != null && doctorProfile.value!.registrationNumber!.isNotEmpty) {
      registrationNumber = doctorProfile.value!.registrationNumber!;
      print('📋 Using registration number from doctor profile: $registrationNumber');
    } else {
      // Fallback to arguments
      final args = Get.arguments;
      if (args != null && args['doctor'] != null) {
        registrationNumber = args['doctor'].registrationNumber ?? 'DOC001';
        print('📋 Using registration number from arguments: $registrationNumber');
      } else {
        print('⚠️ No registration number found, using default: $registrationNumber');
      }
    }
    
    String dateString = DateFormat('yyyy-MM-dd').format(date);
    print('🔗 Fetching slots for doctor: $registrationNumber, date: $dateString');

    try {
      var response = await Repository.instance.doctorTimeSlotsApi(
        registrationNumber: registrationNumber,
        date: dateString,
      );

      if (response is Success) {
        var responseData = response.response?.data;
        print('✅ Time slots API response: $responseData');

        if (responseData != null) {
          if (responseData is Map<String, dynamic>) {
            doctorSlots.value = DoctorSlotModel.fromJson(responseData);
            _convertSlotsToTimeSlots();
            print('✅ Successfully loaded time slots from API');
          } else {
            try {
              doctorSlots.value = doctorSlotModelFromJson(responseData.toString());
              _convertSlotsToTimeSlots();
              print('✅ Successfully loaded time slots from JSON string');
            } catch (e) {
              print('❌ Error parsing time slots: $e');
              _loadMockTimeSlots(date);
            }
          }
        } else {
          print('⚠️ No time slots data received, loading mock data...');
          _loadMockTimeSlots(date);
        }
      } else if (response is Failure) {
        print('❌ Time slots API call failed: ${response.errorResponse}');
        print('🔄 Falling back to mock data...');
        _loadMockTimeSlots(date);
        
        // Show user-friendly message
        Get.snackbar(
          "Time Slots",
          "Using sample time slots (API unavailable)",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      print('❌ Error loading time slots: $e');
      print('🔄 Falling back to mock data...');
      _loadMockTimeSlots(date);
      
      // Show user-friendly message
      Get.snackbar(
        "Time Slots",
        "Using sample time slots (Connection error)",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }

    isLoadingSlots.value = false;
  }

  void _convertSlotsToTimeSlots() {
    if (doctorSlots.value?.slots == null || doctorSlots.value!.slots!.isEmpty) {
      print('⚠️ No slots data available');
      return;
    }

    availableTimeSlots.clear();
    
    for (var slot in doctorSlots.value!.slots!) {
      // Parse time and determine AM/PM
      String time = slot.startTime ?? "10:00";
      String period = "AM";
      
      if (time.contains(":")) {
        try {
          int hour = int.parse(time.split(":")[0]);
          if (hour >= 12) {
            period = "PM";
            if (hour > 12) {
              hour -= 12;
            }
          }
          if (hour == 0) hour = 12; // Handle midnight
          time = "${hour.toString().padLeft(2, '0')}:${time.split(":")[1]}";
        } catch (e) {
          print('⚠️ Error parsing time: $time, using default');
          time = "10:00";
          period = "AM";
        }
      }

      // Check if slot is available (not booked)
      bool isAvailable = slot.available ?? true;
      bool isBooked = slot.booked ?? false;
      
      // If available is true and booked is false, then slot is selectable
      bool isSelectable = isAvailable && !isBooked;

      availableTimeSlots.add(TimeSlot(
        time: time,
        period: period,
        isBooked: !isSelectable, // If not selectable, then it's booked
        isSelected: false,
        date: doctorSlots.value?.date ?? DateFormat('yyyy-MM-dd').format(selectedDate.value),
      ));
      
      print('🕐 Slot: $time $period - Available: $isAvailable, Booked: $isBooked, Selectable: $isSelectable');
    }
    
    print('🕐 Converted ${availableTimeSlots.length} time slots from API');
    print('✅ Available slots: ${availableTimeSlots.where((slot) => !slot.isBooked!).length}');
    print('❌ Booked slots: ${availableTimeSlots.where((slot) => slot.isBooked!).length}');
  }

  void _loadMockTimeSlots(DateTime date) {
    print('🔄 Loading mock time slots for ${DateFormat('yyyy-MM-dd').format(date)}...');
    
    // Generate realistic mock slots based on date and doctor
    List<TimeSlot> mockSlots = [];
    
    // Morning slots (9 AM - 12 PM)
    for (int hour = 9; hour < 12; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        String time = "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
        String period = hour >= 12 ? "PM" : "AM";
        String displayTime = hour > 12 ? "${hour - 12}" : hour == 0 ? "12" : hour.toString();
        displayTime = "${displayTime.padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
        
        // Randomly make some slots booked (30% chance)
        bool isBooked = (DateTime.now().millisecondsSinceEpoch + hour * 1000 + minute) % 3 == 0;
        
        mockSlots.add(TimeSlot(
          time: displayTime,
          period: period,
          isBooked: isBooked,
          isSelected: false,
          date: DateFormat('yyyy-MM-dd').format(date),
        ));
      }
    }
    
    // Afternoon slots (2 PM - 5 PM)
    for (int hour = 14; hour < 17; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        String time = "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
        String period = "PM";
        String displayTime = "${(hour - 12).toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
        
        // Randomly make some slots booked (25% chance)
        bool isBooked = (DateTime.now().millisecondsSinceEpoch + hour * 1000 + minute) % 4 == 0;
        
        mockSlots.add(TimeSlot(
          time: displayTime,
          period: period,
          isBooked: isBooked,
          isSelected: false,
          date: DateFormat('yyyy-MM-dd').format(date),
        ));
      }
    }
    
    availableTimeSlots.value = mockSlots;
    
    int available = mockSlots.where((slot) => !slot.isBooked!).length;
    int booked = mockSlots.where((slot) => slot.isBooked!).length;
    
    print('✅ Mock slots loaded: ${mockSlots.length} total, $available available, $booked booked');
  }

  void selectTimeSlot(TimeSlot timeSlot) {
    if (timeSlot.isBooked!) return;
    
    // Clear previous selection
    for (var slot in availableTimeSlots) {
      slot.isSelected = false;
    }
    
    // Select new slot
    timeSlot.isSelected = true;
    selectedTimeSlot.value = timeSlot;
    availableTimeSlots.refresh();
  }

  void previousMonth() {
    selectedMonth.value = DateTime(selectedMonth.value.year, selectedMonth.value.month - 1);
    generateCalendarDates();
  }

  void nextMonth() {
    selectedMonth.value = DateTime(selectedMonth.value.year, selectedMonth.value.month + 1);
    generateCalendarDates();
  }

  void viewAllAvailability() {
    // Navigate to full availability screen
    Get.snackbar(
      "Availability", 
      "Viewing all availability for ${DateFormat('MMMM yyyy').format(selectedDate.value)}",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void bookAppointment() {
    if (selectedTimeSlot.value == null) {
      Get.snackbar(
        "Error",
        "Please select a time slot",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      "Appointment Booked",
      "Appointment booked with Dr. ${doctorProfile.value?.firstName} ${doctorProfile.value?.lastName} on ${DateFormat('MMM dd, yyyy').format(selectedDate.value)} at ${selectedTimeSlot.value?.time} ${selectedTimeSlot.value?.period}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  String getMonthYear() {
    return DateFormat('MMMM yyyy').format(selectedMonth.value);
  }

  bool isToday(DateTime date) {
    DateTime today = DateTime.now();
    return date.year == today.year && date.month == today.month && date.day == today.day;
  }

  bool isSelected(DateTime date) {
    return date.year == selectedDate.value.year && 
           date.month == selectedDate.value.month && 
           date.day == selectedDate.value.day;
  }

  String getRatingText() {
    if (doctorProfile.value?.doctorRating != null) {
      return "${doctorProfile.value!.doctorRating!.averageRating} (${doctorProfile.value!.doctorRating!.totalReviews})";
    }
    return "4.9 (5)";
  }


  // Method to show raw DoctorDetailsModel data
  void showRawDoctorDetails() {
    if (doctorDetails.value != null) {
      final details = doctorDetails.value!;
      print('🔍 Raw DoctorDetailsModel Data:');
      print('📋 Registration Number: ${details.registrationNumber}');
      print('👤 Name: ${details.firstName} ${details.lastName}');
      print('📧 Email: ${details.email}');
      print('📞 Contact: ${details.contactNumber}');
      print('🩺 Specialization: ${details.specialization}');
      print('🏥 Status: ${details.doctorStatus}');
      print('🖼️ Profile Image: ${details.profileImageUrl}');
      print('📝 Bio: ${details.professionalBio}');
      print('🎓 Qualifications: ${details.qualifications}');
      print('🏆 Certifications: ${details.certifications}');
      print('💼 Experience: ${details.experienceYears}');
      print('📅 DOB: ${details.dateOfBirth}');
      print('⚧ Gender: ${details.gender}');
      print('🏥 Hospital Associations: ${details.hospitalAssociations?.length ?? 0}');
      print('🏥 Hospital Addresses: ${details.hospitalAddresses?.length ?? 0}');
      print('🤝 Affiliations: ${details.affiliations?.length ?? 0}');
      print('💰 Consultation Fees: ${details.consultationFees?.length ?? 0}');
      print('⭐ Doctor Rating: ${details.doctorRating?.averageRating} (${details.doctorRating?.totalReviews} reviews)');
      print('📝 Reviews: ${details.reviews?.length ?? 0}');
      print('📅 Working Days: ${details.workingDays?.length ?? 0}');
      print('📰 Blogs: ${details.blogs?.length ?? 0}');
    } else {
      print('❌ No DoctorDetailsModel data available');
    }
  }

  // Method to show raw DoctorSlotModel data
  void showRawTimeSlots() {
    if (doctorSlots.value != null) {
      final slots = doctorSlots.value!;
      print('🕐 Raw DoctorSlotModel Data:');
      print('👨‍⚕️ Doctor ID: ${slots.doctorId}');
      print('📅 Date: ${slots.date}');
      print('📆 Day of Week: ${slots.dayOfWeek}');
      print('👤 Doctor Name: ${slots.doctorName}');
      print('📊 Total Slots: ${slots.totalSlots}');
      print('✅ Available Slots: ${slots.availableSlots}');
      print('❌ Booked Slots: ${slots.bookedSlots}');
      print('🕐 Time Slots: ${slots.slots?.length ?? 0}');
      
      if (slots.slots != null) {
        for (int i = 0; i < slots.slots!.length; i++) {
          final slot = slots.slots![i];
          print('  Slot $i: ${slot.startTime} - ${slot.endTime} (Available: ${slot.available}, Booked: ${slot.booked})');
        }
      }
    } else {
      print('❌ No DoctorSlotModel data available');
    }
  }

  // Test method to load time slots with different registration numbers
  void testTimeSlotsWithDifferentDoctors() {
    print('🧪 Testing time slots with different doctors...');
    
    // Test with different registration numbers
    List<String> testDoctors = ['DOC001', 'DOC002', 'DOC003'];
    String testDate = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1)));
    
    for (String doctorId in testDoctors) {
      print('🔗 Testing with doctor: $doctorId, date: $testDate');
      // You can call loadTimeSlotsForDate with different doctors here
    }
  }

  // Method to get reviews count
  int getReviewsCount() {
    return doctorProfile.value?.reviews?.length ?? 0;
  }

  // Method to get available slots count
  int getAvailableSlotsCount() {
    return availableTimeSlots.where((slot) => !slot.isBooked!).length;
  }

  // Method to get total slots count
  int getTotalSlotsCount() {
    return availableTimeSlots.length;
  }

  // Method to show slots summary
  void showSlotsSummary() {
    int total = getTotalSlotsCount();
    int available = getAvailableSlotsCount();
    int booked = total - available;
    
    print('📊 Slots Summary:');
    print('📅 Date: ${DateFormat('yyyy-MM-dd').format(selectedDate.value)}');
    print('👨‍⚕️ Doctor: ${doctorProfile.value?.registrationNumber ?? "Unknown"}');
    print('📊 Total Slots: $total');
    print('✅ Available: $available');
    print('❌ Booked: $booked');
    
    if (doctorSlots.value != null) {
      print('🔗 API Data:');
      print('📊 Total Slots (API): ${doctorSlots.value!.totalSlots}');
      print('✅ Available Slots (API): ${doctorSlots.value!.availableSlots}');
      print('❌ Booked Slots (API): ${doctorSlots.value!.bookedSlots}');
    } else {
      print('📝 Using Mock Data (API not available)');
    }
  }

  // Method to test different dates with mock data
  void testDifferentDates() {
    print('🧪 Testing different dates with mock data...');
    
    List<DateTime> testDates = [
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
      DateTime.now().add(Duration(days: 2)),
      DateTime.now().add(Duration(days: 7)),
    ];
    
    for (DateTime date in testDates) {
      print('📅 Testing date: ${DateFormat('yyyy-MM-dd').format(date)}');
      _loadMockTimeSlots(date);
      
      int total = getTotalSlotsCount();
      int available = getAvailableSlotsCount();
      print('   📊 Total: $total, Available: $available');
    }
    
    // Reset to current selected date
    _loadMockTimeSlots(selectedDate.value);
  }

  // Method to force refresh slots for current date
  void refreshSlots() {
    print('🔄 Refreshing slots for current date...');
    loadTimeSlotsForDate(selectedDate.value);
  }

}
