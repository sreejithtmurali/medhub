
// my_bookings_view_model.dart
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';


class MyBookingsViewModel extends BaseViewModel {
  final BookingService _bookingService = BookingService();

  List<Booking> _bookings = [];
  List<Booking> get bookings => _bookings;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _bookings = await _bookingService.getBookings();
    } catch (e) {
      // Handle error - could show dialog or set error state
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void navigateToAddBooking() {
    navigationService.navigateTo(Routes.addBookingView);
  }
}

// booking_model.dart
class Booking {
  final String bookingId;
  final DateTime bookingDate;
  final String time;
  final String doctorName;
  final String category;

  Booking({
    required this.bookingId,
    required this.bookingDate,
    required this.time,
    required this.doctorName,
    required this.category,
  });

  // Factory constructor for creating a Booking from a Map
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      bookingId: map['bookingId'],
      bookingDate: DateTime.parse(map['bookingDate']),
      time: map['time'],
      doctorName: map['doctorName'],
      category: map['category'],
    );
  }

  // Convert Booking to a Map
  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'bookingDate': bookingDate.toIso8601String(),
      'time': time,
      'doctorName': doctorName,
      'category': category,
    };
  }
}

// booking_service.dart
class BookingService {
  // Mock data for demonstration
  final List<Booking> _bookings = [
    Booking(
      bookingId: 'BK-1001',
      bookingDate: DateTime.now().add(const Duration(days: 3)),
      time: '10:30 AM',
      doctorName: 'Sarah Johnson',
      category: 'Cardiology',
    ),
    Booking(
      bookingId: 'BK-1002',
      bookingDate: DateTime.now().add(const Duration(days: 5)),
      time: '2:15 PM',
      doctorName: 'Michael Chen',
      category: 'Dermatology',
    ),
  ];

  // Get all bookings
  Future<List<Booking>> getBookings() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _bookings;
  }

  // Add a new booking
  Future<void> addBooking(Booking booking) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _bookings.add(booking);
  }

  // Cancel a booking
  Future<bool> cancelBooking(String bookingId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final previousLength = _bookings.length;
    _bookings.removeWhere((booking) => booking.bookingId == bookingId);
    return previousLength != _bookings.length;
  }
}
