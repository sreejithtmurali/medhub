import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:medhub/app/app.locator.dart';
import 'package:medhub/models/hospitalall/Data.dart';
import 'package:medhub/services/api_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/Productsall/Products.dart';
import '../../../models/allbookings/GetAllBookings.dart';
import '../../../models/getalldoctors/Data.dart';

class HomeViewModel extends BaseViewModel {
  static const environment = ApiEnvironment.dev;
  List<GetAllBookings>?mybookings=[];



  String baseUrl = environment.baseUrl;
  List<Doctor>? doctorslist=[];
  List<Hospital>?hospitallist=[];
  init() async {
    getalldoctors();
    hospitallist=await apiService.getallHospitals()??[];
    notifyListeners();
    setBusy(true);
    try {
      mybookings= await apiService.getallAppointment()??[];
      notifyListeners();

    } catch (e) {
      // Handle error - could show dialog or set error state
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }
  Future<void> getalldoctors() async {
   doctorslist=await apiService.getallDoctors();
   notifyListeners();
  }
void navdoctor(Doctor doctor){
  navigationService.navigateTo(Routes.doctorView,arguments: DoctorViewArguments(doctor: doctor));
}
  void navhospitallist() {
    navigationService.navigateTo(Routes.hospitalsList);
  }

  void navdoctorlist() {
    navigationService.navigateTo(Routes.doctorsList);
  }
void navhospital(Hospital hospital) {
  navigationService.navigateTo(Routes.hospitalDetailView,arguments: HospitalDetailViewArguments(hospital: hospital));
}
}
