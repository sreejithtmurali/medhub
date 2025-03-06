// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i24;
import 'package:flutter/material.dart';
import 'package:medhub/models/getalldoctors/Data.dart' as _i25;
import 'package:medhub/models/hospitalall/Data.dart' as _i26;
import 'package:medhub/models/reminder.dart' as _i27;
import 'package:medhub/ui/screens/add_emergency_contact/add_emergency_contact_view.dart'
    as _i16;
import 'package:medhub/ui/screens/add_medication/AddMedicationView.dart'
    as _i13;
import 'package:medhub/ui/screens/add_reminder_view/add_reminder_view.dart'
    as _i19;
import 'package:medhub/ui/screens/Dashboard/dashboardview.dart' as _i5;
import 'package:medhub/ui/screens/doctorslisting/doctorslist_view.dart' as _i7;
import 'package:medhub/ui/screens/DoctorView/Doctor_view.dart' as _i6;
import 'package:medhub/ui/screens/home/home_view.dart' as _i4;
import 'package:medhub/ui/screens/hospital/hospitalview.dart' as _i10;
import 'package:medhub/ui/screens/hospitallisting/hospitallisting_view.dart'
    as _i22;
import 'package:medhub/ui/screens/login/login_view.dart' as _i3;
import 'package:medhub/ui/screens/my_bookings_view/my_bookings_view.dart'
    as _i17;
import 'package:medhub/ui/screens/My_medication/myMedicationView.dart' as _i14;
import 'package:medhub/ui/screens/my_notifications_view/my_noti_view.dart'
    as _i23;
import 'package:medhub/ui/screens/my_reminders_view/my_reminders_view.dart'
    as _i18;
import 'package:medhub/ui/screens/myemergencycontacts/myemergencycontactsview.dart'
    as _i15;
import 'package:medhub/ui/screens/MyPrescription/myprescriptions.dart' as _i11;
import 'package:medhub/ui/screens/MyPrescriptionAdd/addmyprescriptions.dart'
    as _i12;
import 'package:medhub/ui/screens/Profile/Profile_view.dart' as _i8;
import 'package:medhub/ui/screens/profileupdate/profileupdate_view.dart'
    as _i20;
import 'package:medhub/ui/screens/register/register_view.dart' as _i21;
import 'package:medhub/ui/screens/Sosview/sosview.dart' as _i9;
import 'package:medhub/ui/screens/splash/splash_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i28;

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

  static const myEmergencyContactView = '/my-emergency-contact-view';

  static const addEmergencyContactView = '/add-emergency-contact-view';

  static const myBookingsView = '/my-bookings-view';

  static const myRemindersView = '/my-reminders-view';

  static const addReminderView = '/add-reminder-view';

  static const profileUpdteView = '/profile-updte-view';

  static const registerView = '/register-view';

  static const hospitalsList = '/hospitals-list';

  static const notifictionsView = '/notifictions-view';

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
    myEmergencyContactView,
    addEmergencyContactView,
    myBookingsView,
    myRemindersView,
    addReminderView,
    profileUpdteView,
    registerView,
    hospitalsList,
    notifictionsView,
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
    _i1.RouteDef(
      Routes.myEmergencyContactView,
      page: _i15.MyEmergencyContactView,
    ),
    _i1.RouteDef(
      Routes.addEmergencyContactView,
      page: _i16.AddEmergencyContactView,
    ),
    _i1.RouteDef(
      Routes.myBookingsView,
      page: _i17.MyBookingsView,
    ),
    _i1.RouteDef(
      Routes.myRemindersView,
      page: _i18.MyRemindersView,
    ),
    _i1.RouteDef(
      Routes.addReminderView,
      page: _i19.AddReminderView,
    ),
    _i1.RouteDef(
      Routes.profileUpdteView,
      page: _i20.ProfileUpdteView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i21.RegisterView,
    ),
    _i1.RouteDef(
      Routes.hospitalsList,
      page: _i22.HospitalsList,
    ),
    _i1.RouteDef(
      Routes.notifictionsView,
      page: _i23.NotifictionsView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.LoginView(),
        settings: data,
      );
    },
    _i4.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => const HomeViewArguments(),
      );
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.HomeView(key: args.key),
        settings: data,
      );
    },
    _i5.Dashboardview: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.Dashboardview(),
        settings: data,
      );
    },
    _i6.DoctorView: (data) {
      final args = data.getArgs<DoctorViewArguments>(nullOk: false);
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.DoctorView(key: args.key, doctor: args.doctor),
        settings: data,
      );
    },
    _i7.DoctorsList: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.DoctorsList(),
        settings: data,
      );
    },
    _i8.ProfileView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.ProfileView(),
        settings: data,
      );
    },
    _i9.SOSView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.SOSView(),
        settings: data,
      );
    },
    _i10.HospitalDetailView: (data) {
      final args = data.getArgs<HospitalDetailViewArguments>(nullOk: false);
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.HospitalDetailView(hospital: args.hospital),
        settings: data,
      );
    },
    _i11.MyPrescriptions: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.MyPrescriptions(),
        settings: data,
      );
    },
    _i12.AddMyPrescriptions: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.AddMyPrescriptions(),
        settings: data,
      );
    },
    _i13.AddMedicationView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.AddMedicationView(),
        settings: data,
      );
    },
    _i14.ViewAllMedications: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.ViewAllMedications(),
        settings: data,
      );
    },
    _i15.MyEmergencyContactView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.MyEmergencyContactView(),
        settings: data,
      );
    },
    _i16.AddEmergencyContactView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.AddEmergencyContactView(),
        settings: data,
      );
    },
    _i17.MyBookingsView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.MyBookingsView(),
        settings: data,
      );
    },
    _i18.MyRemindersView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.MyRemindersView(),
        settings: data,
      );
    },
    _i19.AddReminderView: (data) {
      final args = data.getArgs<AddReminderViewArguments>(
        orElse: () => const AddReminderViewArguments(),
      );
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.AddReminderView(
            key: args.key, reminderToEdit: args.reminderToEdit),
        settings: data,
      );
    },
    _i20.ProfileUpdteView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.ProfileUpdteView(),
        settings: data,
      );
    },
    _i21.RegisterView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.RegisterView(),
        settings: data,
      );
    },
    _i22.HospitalsList: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i22.HospitalsList(),
        settings: data,
      );
    },
    _i23.NotifictionsView: (data) {
      return _i24.MaterialPageRoute<dynamic>(
        builder: (context) => const _i23.NotifictionsView(),
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

  final _i24.Key? key;

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

class DoctorViewArguments {
  const DoctorViewArguments({
    this.key,
    required this.doctor,
  });

  final _i24.Key? key;

  final _i25.Doctor? doctor;

  @override
  String toString() {
    return '{"key": "$key", "doctor": "$doctor"}';
  }

  @override
  bool operator ==(covariant DoctorViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.doctor == doctor;
  }

  @override
  int get hashCode {
    return key.hashCode ^ doctor.hashCode;
  }
}

class HospitalDetailViewArguments {
  const HospitalDetailViewArguments({required this.hospital});

  final _i26.Hospital hospital;

  @override
  String toString() {
    return '{"hospital": "$hospital"}';
  }

  @override
  bool operator ==(covariant HospitalDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.hospital == hospital;
  }

  @override
  int get hashCode {
    return hospital.hashCode;
  }
}

class AddReminderViewArguments {
  const AddReminderViewArguments({
    this.key,
    this.reminderToEdit,
  });

  final _i24.Key? key;

  final _i27.Reminder? reminderToEdit;

  @override
  String toString() {
    return '{"key": "$key", "reminderToEdit": "$reminderToEdit"}';
  }

  @override
  bool operator ==(covariant AddReminderViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.reminderToEdit == reminderToEdit;
  }

  @override
  int get hashCode {
    return key.hashCode ^ reminderToEdit.hashCode;
  }
}

extension NavigatorStateExtension on _i28.NavigationService {
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
    _i24.Key? key,
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

  Future<dynamic> navigateToDoctorView({
    _i24.Key? key,
    required _i25.Doctor? doctor,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.doctorView,
        arguments: DoctorViewArguments(key: key, doctor: doctor),
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

  Future<dynamic> navigateToHospitalDetailView({
    required _i26.Hospital hospital,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.hospitalDetailView,
        arguments: HospitalDetailViewArguments(hospital: hospital),
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

  Future<dynamic> navigateToMyEmergencyContactView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myEmergencyContactView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddEmergencyContactView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addEmergencyContactView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyBookingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myBookingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyRemindersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myRemindersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddReminderView({
    _i24.Key? key,
    _i27.Reminder? reminderToEdit,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addReminderView,
        arguments:
            AddReminderViewArguments(key: key, reminderToEdit: reminderToEdit),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileUpdteView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileUpdteView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHospitalsList([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.hospitalsList,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotifictionsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.notifictionsView,
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
    _i24.Key? key,
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

  Future<dynamic> replaceWithDoctorView({
    _i24.Key? key,
    required _i25.Doctor? doctor,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.doctorView,
        arguments: DoctorViewArguments(key: key, doctor: doctor),
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

  Future<dynamic> replaceWithHospitalDetailView({
    required _i26.Hospital hospital,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.hospitalDetailView,
        arguments: HospitalDetailViewArguments(hospital: hospital),
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

  Future<dynamic> replaceWithMyEmergencyContactView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.myEmergencyContactView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddEmergencyContactView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addEmergencyContactView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMyBookingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.myBookingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMyRemindersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.myRemindersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddReminderView({
    _i24.Key? key,
    _i27.Reminder? reminderToEdit,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addReminderView,
        arguments:
            AddReminderViewArguments(key: key, reminderToEdit: reminderToEdit),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileUpdteView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileUpdteView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHospitalsList([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.hospitalsList,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotifictionsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.notifictionsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
