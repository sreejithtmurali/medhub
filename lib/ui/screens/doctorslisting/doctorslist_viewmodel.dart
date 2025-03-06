import 'dart:async';

import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/getalldoctors/Data.dart';
import '../../../models/hospitalall/Data.dart';
import '../../../services/api_service.dart';

class DoctorsListModel extends BaseViewModel {
  navigatelogin() {
    Timer(Duration(seconds: 4), () => {
      navigationService.navigateTo(Routes.loginView)
    });
  }

  static const environment = ApiEnvironment.dev;

  String baseUrl = environment.baseUrl;
  List<Doctor>? _originalDoctorsList = [];
  List<Doctor>? filteredDoctorsList = [];

  init() async {
    await getalldoctors();
    await getallhospitals();
    notifyListeners();
  }

  Future<void> getalldoctors() async {
    _originalDoctorsList = await apiService.getallDoctors();
    filteredDoctorsList = _originalDoctorsList;
    notifyListeners();
  }

  Future<void> getallhospitals() async {
    hospitallist = await apiService.getallHospitals();
    notifyListeners();
  }

  List<Hospital>? hospitallist = [];

  void navdoctor(Doctor d) {
    navigationService.navigateTo(
      Routes.doctorView,
      arguments: DoctorViewArguments(doctor: d),
    );
  }

  void searchDoctors(String query) {
    if (query.isEmpty) {
      filteredDoctorsList = _originalDoctorsList;
    } else {
      filteredDoctorsList = _originalDoctorsList?.where((doctor) {
        // Search across multiple fields: name, department, hospital name
        return doctor.name!.toLowerCase().contains(query.toLowerCase())  ||
            doctor.department!.toLowerCase().contains(query.toLowerCase())  ||
            doctor.hospitalName!.toLowerCase().contains(query.toLowerCase()) ;
      }).toList();
    }
    notifyListeners();
  }
}