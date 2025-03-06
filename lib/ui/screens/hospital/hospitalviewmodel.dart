import 'package:medhub/app/app.router.dart';
import 'package:medhub/app/utils.dart';
import 'package:medhub/models/getalldoctors/Data.dart';
import 'package:stacked/stacked.dart';

import '../../../models/getalldoctors/Data.dart';
import '../../../models/hospitalall/Data.dart';
import '../../../services/api_service.dart';

class HospitalDetailViewModel extends BaseViewModel {
  Hospital? hospital;
  HospitalDetailViewModel({required this.hospital});
  static const environment = ApiEnvironment.dev;

  String baseUrl = environment.baseUrl;
  List<Doctor>? doctors = [];
  init(){
    doctors = hospital!.doctors;
  }
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> initialize() async {
init();
    _isLoading = false;
    notifyListeners();
  }


  void navigateToDoctorDetail(Doctor doctorId) {
    // Implement navigation
    print('Navigate to doctor: $doctorId');
    navigationService.navigateTo(Routes.doctorView,arguments: DoctorViewArguments(doctor: doctorId));
  }
}
