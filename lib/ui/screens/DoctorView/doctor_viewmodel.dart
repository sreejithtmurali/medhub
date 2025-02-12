import 'dart:async';
import 'package:medhub/ui/screens/doctorslisting/doctorslist_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/doctor.dart';

class DoctorViewModel extends BaseViewModel {
  String? selectedTimeSlot;
  bool isFavorite=false;
  DoctorProfileModel doctorsListModel=DoctorProfileModel(
    id: 1,
    name: "Dr. Ali Uzair",
    specialization: "Cardiologist and Surgeon",
    imageUrl: "https://sunrisehospitalcochin.com/storage/doctor/profile_image/irg33w5TN2RIuw885nFK3XUMn8l5DsxOYhfwilOG.jpg",
    rating: 4.9,
    reviews: 90,
    patients: 116,
    experience: 3,
    about: "He is one of the top most cardiologist specialist in Crist Hospital in London, UK. He achieved several awards for her wonderful contribution.",
  );



 void toggleFavorite(){
   isFavorite=!isFavorite;
   notifyListeners();
 }

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
