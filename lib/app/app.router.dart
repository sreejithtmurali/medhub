// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i15;
import 'package:flutter/material.dart';
import 'package:medhub/ui/screens/add_medication/AddMedicationView.dart'
    as _i13;
import 'package:medhub/ui/screens/Dashboard/dashboardview.dart' as _i5;
import 'package:medhub/ui/screens/doctorslisting/doctorslist_view.dart' as _i7;
import 'package:medhub/ui/screens/DoctorView/Doctor_view.dart' as _i6;
import 'package:medhub/ui/screens/home/home_view.dart' as _i4;
import 'package:medhub/ui/screens/hospital/hospitalview.dart' as _i10;
import 'package:medhub/ui/screens/login/login_view.dart' as _i3;
import 'package:medhub/ui/screens/My_medication/myMedicationView.dart' as _i14;
import 'package:medhub/ui/screens/MyPrescription/myprescriptions.dart' as _i11;
import 'package:medhub/ui/screens/MyPrescriptionAdd/addmyprescriptions.dart'
    as _i12;
import 'package:medhub/ui/screens/Profile/Profile_view.dart' as _i8;
import 'package:medhub/ui/screens/Sosview/sosview.dart' as _i9;
import 'package:medhub/ui/screens/splash/splash_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i16;

class Routes {
  static const splashView = '/';

  static const loginView = '/login-view';

  static const homeView = '/home-view';

  static const dashboardview = '/Dashboardview';

  static const doctorView = '/doctor-view';

  static const doctorsList = '/doctors-list';

  static const profileView = '/profile-view';

  static const sOSView = '/s-os-view';

  static const hospitalDetailView = '/hospital-detail-view';

  static const myPrescriptions = '/my-prescriptions';

  static const addMyPrescriptions = '/add-my-prescriptions';

  static const addMedicationView = '/add-medication-view';

  static const viewAllMedications = '/view-all-medications';

  static const all = <String>{
    splashView,
    loginView,
    homeView,
    dashboardview,
    doctorView,
    doctorsList,
    profileView,
    sOSView,
    hospitalDetailView,
    myPrescriptions,
    addMyPrescriptions,
    addMedicationView,
    viewAllMedications,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i4.HomeView,
    ),
    _i1.RouteDef(
      Routes.dashboardview,
      page: _i5.Dashboardview,
    ),
    _i1.RouteDef(
      Routes.doctorView,
      page: _i6.DoctorView,
    ),
    _i1.RouteDef(
      Routes.doctorsList,
      page: _i7.DoctorsList,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i8.ProfileView,
    ),
    _i1.RouteDef(
      Routes.sOSView,
      page: _i9.SOSView,
    ),
    _i1.RouteDef(
      Routes.hospitalDetailView,
      page: _i10.HospitalDetailView,
    ),
    _i1.RouteDef(
      Routes.myPrescriptions,
      page: _i11.MyPrescriptions,
    ),
    _i1.RouteDef(
      Routes.addMyPrescriptions,
      page: _i12.AddMyPrescriptions,
    ),
    _i1.RouteDef(
      Routes.addMedicationView,
      page: _i13.AddMedicationView,
    ),
    _i1.RouteDef(
      Routes.viewAllMedications,
      page: _i14.ViewAllMedications,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.LoginView(),
        settings: data,
      );
    },
    _i4.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => const HomeViewArguments(),
      );
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.HomeView(key: args.key),
        settings: data,
      );
    },
    _i5.Dashboardview: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.Dashboardview(),
        settings: data,
      );
    },
    _i6.DoctorView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.DoctorView(),
        settings: data,
      );
    },
    _i7.DoctorsList: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.DoctorsList(),
        settings: data,
      );
    },
    _i8.ProfileView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.ProfileView(),
        settings: data,
      );
    },
    _i9.SOSView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.SOSView(),
        settings: data,
      );
    },
    _i10.HospitalDetailView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.HospitalDetailView(),
        settings: data,
      );
    },
    _i11.MyPrescriptions: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.MyPrescriptions(),
        settings: data,
      );
    },
    _i12.AddMyPrescriptions: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.AddMyPrescriptions(),
        settings: data,
      );
    },
    _i13.AddMedicationView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.AddMedicationView(),
        settings: data,
      );
    },
    _i14.ViewAllMedications: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.ViewAllMedications(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeViewArguments {
  const HomeViewArguments({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant HomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

extension NavigatorStateExtension on _i16.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView({
    _i15.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardview([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardview,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDoctorView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.doctorView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDoctorsList([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.doctorsList,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSOSView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.sOSView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHospitalDetailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.hospitalDetailView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyPrescriptions([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myPrescriptions,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddMyPrescriptions([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addMyPrescriptions,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddMedicationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addMedicationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToViewAllMedications([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.viewAllMedications,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView({
    _i15.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardview([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dashboardview,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDoctorView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.doctorView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDoctorsList([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.doctorsList,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSOSView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.sOSView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHospitalDetailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.hospitalDetailView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMyPrescriptions([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.myPrescriptions,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddMyPrescriptions([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addMyPrescriptions,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddMedicationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addMedicationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithViewAllMedications([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.viewAllMedications,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
