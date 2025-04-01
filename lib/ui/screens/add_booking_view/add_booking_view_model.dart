import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../my_bookings_view/my_bookings_view_model.dart';


class AddBookingViewModel extends BaseViewModel {
  final NavigationService navigationService = locator<NavigationService>();
  final BookingService _bookingService = BookingService();
  final SnackbarService _snackbarService = SnackbarService();

  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final categoryController = TextEditingController();

  // Doctor selection
  final List<String> doctors = ['Sarah Johnson', 'Michael Chen', 'Emily Rodriguez', 'David Kim'];
  String? selectedDoctor;

  // Category mapping
  final Map<String, String> doctorCategories = {
    'Sarah Johnson': 'Cardiology',
    'Michael Chen': 'Dermatology',
    'Emily Rodriguez': 'Pediatrics',
    'David Kim': 'Orthopedics',
  };

  // Time selection
  final List<String> availableTimes = [
    '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM',
    '1:00 PM', '1:30 PM', '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM',
  ];
  String? selectedTime;

  // Date selection
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));

  @override
  void dispose() {
    dateController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  void updateCategory() {
    if (selectedDoctor != null) {
      categoryController.text = doctorCategories[selectedDoctor] ?? '';
    }
  }

  Future<void> selectDate(BuildContext context) async {
    // Restrict past dates
    final DateTime firstDate = DateTime.now();
    final DateTime lastDate = DateTime.now().add(const Duration(days: 60)); // 2 months ahead

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = DateFormat('EEE, MMM d, yyyy').format(selectedDate);
      notifyListeners();
    }
  }

  Future<void> submitBooking() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setBusy(true);

    try {
      // Generate a unique booking ID
      final bookingId = 'BK-${1000 + DateTime.now().millisecondsSinceEpoch % 9000}';

      // Create booking object
      final newBooking = Booking(
        bookingId: bookingId,
        bookingDate: selectedDate,
        time: selectedTime!,
        doctorName: selectedDoctor!,
        category: categoryController.text,
      );

      // Save booking
      await _bookingService.addBooking(newBooking);

      // Show success message and navigate back
      _snackbarService.showSnackbar(
        message: 'Appointment booked successfully',
        duration: const Duration(seconds: 2),
      );

      navigationService.back();
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Failed to book appointment: ${e.toString()}',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }
}