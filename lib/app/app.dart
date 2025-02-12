import 'package:medhub/ui/screens/Dashboard/dashboardview.dart';
import 'package:medhub/ui/screens/login/login_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api_service.dart';

import '../ui/screens/DoctorView/Doctor_view.dart';
import '../ui/screens/doctorslisting/doctorslist_view.dart';
import '../ui/screens/home/home_view.dart';
import '../ui/screens/splash/splash_view.dart';


@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: Dashboardview),
    MaterialRoute(page: DoctorView),
    MaterialRoute(page: DoctorsList)
  ],
  dependencies: [
    LazySingleton(classType: ApiService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),

  ],
)
class AppSetup {}
