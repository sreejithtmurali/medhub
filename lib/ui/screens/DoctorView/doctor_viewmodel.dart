import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/getalldoctors/Data.dart';
import '../../../services/api_service.dart';

class DoctorViewModel extends BaseViewModel {
  final Doctor? doctor;


  DoctorViewModel({required this.doctor});

  static const environment = ApiEnvironment.dev;
  String baseUrl = environment.baseUrl;

  String? selectedTimeSlot;
  DateTime? selectedDate;
  bool isFavorite = false;
  bool isBooking = false;

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void setSelectedTimeSlot(String time) {
    if (doctor?.timeslots?.any((slot) => slot.slot == time) ?? false) {
      selectedTimeSlot = time;
      notifyListeners();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      notifyListeners();
    }
  }
  Future<void> bookNow(BuildContext context) async {
    if (selectedDate == null || selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both date and time slot'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    isBooking = true;
    notifyListeners();

    try {
      // Convert DateTime to formatted string (YYYY-MM-DD)
      final formattedDate = "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";

      // Call the mybooking API
      final status = await apiService.mybooking(
        doctor: doctor?.id,  // Pass doctor ID
        selected_date: selectedDate!,  // Pass the DateTime object
        selected_time: selectedTimeSlot!,  // Pass the selected time slot string
      );

      isBooking = false;
      notifyListeners();

      if (status == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Appointment booked for ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} at $selectedTimeSlot'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to book appointment'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      isBooking = false;
      notifyListeners();
      debugPrint('Booking error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Future<void> bookNow(BuildContext context) async {
  //   if (selectedDate == null || selectedTimeSlot == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please select both date and time slot'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   isBooking = true;
  //   notifyListeners();
  //
  //   try {
  //     // Convert DateTime to formatted string (YYYY-MM-DD)
  //     final formattedDate = "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
  //
  //     final status = await apiService.bookAppointment(
  //       doctorId: doctor?.id,
  //       date: formattedDate,  // Pass the formatted string
  //       time: selectedTimeSlot!,
  //     );
  //
  //     isBooking = false;
  //     notifyListeners();
  //
  //     if (status == true) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Appointment booked for ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} at $selectedTimeSlot'),
  //           backgroundColor: Colors.green,
  //         ),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Failed to book appointment'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     isBooking = false;
  //     notifyListeners();
  //     debugPrint('Booking error: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error: ${e.toString()}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  void navigateLogin() {
    Timer(const Duration(seconds: 4), () {
      navigationService.navigateTo(Routes.loginView);
    });
  }

  String? get doctorImageUrl {
    return doctor?.image != null ? '$baseUrl${doctor!.image}' : null;
  }

  String getDoctorName() => doctor?.name ?? 'Unknown Doctor';
  String getDoctorDepartment() => doctor?.department ?? 'No Department';
  num getDoctorExperience() => doctor?.experience ?? 0;
  num getDoctorRating() => doctor?.rating ?? 0;
  String getDoctorAbout() => doctor?.about ?? 'No description available.';
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import '../../../app/app.router.dart';
// import '../../../app/utils.dart';
// import '../../../models/getalldoctors/Data.dart';
// import '../../../services/api_service.dart';
//
// class DoctorViewModel extends BaseViewModel {
//   final Doctor? doctor;
//
//   DoctorViewModel({required this.doctor});
//
//   static const environment = ApiEnvironment.dev;
//   String baseUrl = environment.baseUrl;
//
//   String? selectedTimeSlot;
//   bool isFavorite = false;
//
//   void toggleFavorite() {
//     isFavorite = !isFavorite;
//     notifyListeners();
//   }
//
//   void setSelectedTimeSlot(String time) {
//     // Validate that the time is from the doctor's actual time slots
//     if (doctor?.timeslots?.any((slot) => slot.slot == time) ?? false) {
//       selectedTimeSlot = time;
//       notifyListeners();
//     }
//   }
//
//   void navigateLogin() {
//     Timer(const Duration(seconds: 4), () {
//       navigationService.navigateTo(Routes.loginView);
//     });
//   }
//
//   // Helper method to safely get the doctor's image URL
//   String? get doctorImageUrl {
//     return doctor?.image != null ? '$baseUrl${doctor!.image}' : null;
//   }
//
//   // Helper method to safely get doctor details with fallback
//   String getDoctorName() => doctor?.name ?? 'Unknown Doctor';
//   String getDoctorDepartment() => doctor?.department ?? 'No Department';
//   num getDoctorExperience() => doctor?.experience ?? 0;
//   num getDoctorRating() => doctor?.rating ?? 0;
//   String getDoctorAbout() => doctor?.about ?? 'No description available.';
// }