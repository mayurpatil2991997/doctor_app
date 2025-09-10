import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/doctor_profile_model.dart';

class DoctorProfileController extends GetxController {
  var isLoading = false.obs;
  var doctorProfile = Rxn<DoctorProfileModel>();
  var selectedDate = DateTime.now().obs;
  var selectedTimeSlot = Rxn<TimeSlot>();
  var availableTimeSlots = <TimeSlot>[].obs;
  var selectedMonth = DateTime.now().obs;
  
  // Calendar related
  var calendarDates = <DateTime>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    generateCalendarDates();
    loadDoctorProfile();
  }

  void loadDoctorProfile() {
    // Mock data matching screenshot
    doctorProfile.value = DoctorProfileModel(
      doctorId: 1,
      name: "Dr. Kiran Doke",
      specialization: "Pediatrician",
      degree: "MBBS, DCH(Pediatrics), DNB (Pediatrics)",
      experience: "05+ Years",
      image: "assets/images/doctor1.jpg",
      rating: 4.9,
      totalReviews: 5,
      consultationFee: 600,
      hospitalName: "City Hospital",
      reviews: [
        Review(
          patientName: "Chhaya Deshmukh",
          patientImage: "assets/images/patient1.jpg",
          rating: 4.5,
          comment: "I was so worried about my baby's health, especially about his development. Visiting Dr. Kiran was truly a wise decision as he helped with all my concerns. During my pregnancy, but Dr. Kiran ensured I was feeling very comfortable and gave guidance on every concern, ensuring both my baby and I were in good hands.",
          date: "Nov 03, 2023",
        ),
        Review(
          patientName: "Nikita Indalkar",
          patientImage: "assets/images/patient2.jpg", 
          rating: 4.5,
          comment: "Excellent doctor with great expertise in pediatrics.",
          date: "Apr 04, 2023",
        ),
      ],
    );
    
    loadTimeSlotsForDate(selectedDate.value);
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

  void loadTimeSlotsForDate(DateTime date) {
    // Mock time slots for the selected date
    availableTimeSlots.value = [
      TimeSlot(time: "10:00", period: "AM", isBooked: false, isSelected: false, date: DateFormat('yyyy-MM-dd').format(date)),
      TimeSlot(time: "10:30", period: "AM", isBooked: true, isSelected: false, date: DateFormat('yyyy-MM-dd').format(date)),
      TimeSlot(time: "11:00", period: "AM", isBooked: false, isSelected: false, date: DateFormat('yyyy-MM-dd').format(date)),
      TimeSlot(time: "11:30", period: "AM", isBooked: false, isSelected: false, date: DateFormat('yyyy-MM-dd').format(date)),
      TimeSlot(time: "02:00", period: "PM", isBooked: false, isSelected: false, date: DateFormat('yyyy-MM-dd').format(date)),
      TimeSlot(time: "02:30", period: "PM", isBooked: true, isSelected: false, date: DateFormat('yyyy-MM-dd').format(date)),
      TimeSlot(time: "03:00", period: "PM", isBooked: false, isSelected: false, date: DateFormat('yyyy-MM-dd').format(date)),
      TimeSlot(time: "03:30", period: "PM", isBooked: false, isSelected: false, date: DateFormat('yyyy-MM-dd').format(date)),
    ];
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
      "Appointment booked with ${doctorProfile.value?.name} on ${DateFormat('MMM dd, yyyy').format(selectedDate.value)} at ${selectedTimeSlot.value?.time} ${selectedTimeSlot.value?.period}",
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
    return "${doctorProfile.value?.rating} (${doctorProfile.value?.totalReviews})";
  }
}
