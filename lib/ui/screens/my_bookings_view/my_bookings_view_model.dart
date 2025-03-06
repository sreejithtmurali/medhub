
// my_bookings_view_model.dart
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/allbookings/GetAllBookings.dart';


class MyBookingsViewModel extends BaseViewModel {
  List<GetAllBookings>?mybookings=[];

  Future<void> initialize() async {
    setBusy(true);
    try {
     mybookings= await apiService.getallAppointment();
     notifyListeners();

    } catch (e) {
      // Handle error - could show dialog or set error state
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }






  // Cancel a booking
  Future<bool?> cancelBooking(GetAllBookings bookingId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    bool? status=await apiService.deletebooking(bookingId.id!);
    if(status==true){
      mybookings?.remove(bookingId);
    }

  }
}
