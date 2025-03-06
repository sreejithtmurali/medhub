
import 'package:medhub/ui/screens/Dashboard/dashboardview.dart';
//import 'package:medhub/ui/screens/MyPrescription/addmyprescriptions.dart';
import 'package:medhub/ui/screens/Profile/Profile_view.dart';
import 'package:medhub/ui/screens/Sosview/sosview.dart';
import 'package:medhub/ui/screens/add_medication/AddMedicationView.dart';
import 'package:medhub/ui/screens/login/login_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api_service.dart';

import '../services/medicationservice.dart';
import '../ui/screens/DoctorView/Doctor_view.dart';
import '../ui/screens/MyPrescription/myprescriptions.dart';
import '../ui/screens/MyPrescriptionAdd/addmyprescriptions.dart';
import '../ui/screens/My_medication/myMedicationView.dart';
import '../ui/screens/doctorslisting/doctorslist_view.dart';
import '../ui/screens/home/home_view.dart';
import '../ui/screens/hospital/hospitalview.dart';
import '../ui/screens/splash/splash_view.dart';


@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: Dashboardview),
    MaterialRoute(page: DoctorView),
    MaterialRoute(page: DoctorsList),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: SOSView),
    MaterialRoute(page: HospitalDetailView),
    MaterialRoute(page: MyPrescriptions),
    MaterialRoute(page: AddMyPrescriptions),
    MaterialRoute(page: AddMedicationView),
    MaterialRoute(page: ViewAllMedications)
  ],
  dependencies: [
    LazySingleton(classType: ApiService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType:MedicationService),

  ],
)
class AppSetup {}
