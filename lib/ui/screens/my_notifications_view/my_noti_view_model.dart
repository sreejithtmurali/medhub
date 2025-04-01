
// my_bookings_view_model.dart
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/allbookings/GetAllBookings.dart';
import '../../../models/allnoti/Data.dart';


class NotifictionsViewModel extends BaseViewModel {
  List<Notification2>?notifications=[];

  Future<void> initialize() async {
    setBusy(true);
    try {
      notifications=await apiService.getNotifications();
     notifyListeners();

    } catch (e) {
      // Handle error - could show dialog or set error state
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }







}
