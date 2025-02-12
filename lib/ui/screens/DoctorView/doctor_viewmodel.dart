import 'dart:async';
import 'package:stacked/stacked.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';

class DoctorViewModel extends BaseViewModel {
  String? selectedTimeSlot;

  void setSelectedTimeSlot(String time) {
    selectedTimeSlot = time;
    notifyListeners(); // Notify UI to rebuild
  }

  navigatelogin() {
    Timer(Duration(seconds: 4), () {
      navigationService.navigateTo(Routes.loginView);
    });
  }
}
