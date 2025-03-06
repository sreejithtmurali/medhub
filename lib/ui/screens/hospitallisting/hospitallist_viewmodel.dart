import 'dart:async';

import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/getalldoctors/Data.dart';
import '../../../models/hospitalall/Data.dart';
import '../../../services/api_service.dart';

class HospitalListModel extends BaseViewModel {
  static const environment = ApiEnvironment.dev;

  String baseUrl = environment.baseUrl;
  List<Hospital>? _originalHospitalsList = [];
  List<Hospital>? filteredHospitalsList = [];

  init() async {
    await getallHospitals();
    notifyListeners();
  }

  Future<void> getallHospitals() async {
    _originalHospitalsList = await apiService.getallHospitals();
    filteredHospitalsList = _originalHospitalsList;
    notifyListeners();
  }

  void navhospital(Hospital hospital) {
    navigationService.navigateTo(
      Routes.homeView,
      arguments: HospitalDetailViewArguments(hospital: hospital),
    );
  }

  void searchHospitals(String query) {
    if (query.isEmpty) {
      filteredHospitalsList = _originalHospitalsList;
    } else {
      filteredHospitalsList = _originalHospitalsList?.where((hospital) {
        // Search across multiple fields: name, location, about
        return hospital.name!.toLowerCase().contains(query.toLowerCase())  ||
            hospital.location!.toLowerCase().contains(query.toLowerCase())  ||
            hospital.about!.toLowerCase().contains(query.toLowerCase()) ;
      }).toList();
    }
    notifyListeners();
  }
}