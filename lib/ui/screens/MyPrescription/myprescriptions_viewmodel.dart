import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/mypres/Data.dart';
import '../../../services/api_service.dart';

class MyPrescriptionsModel extends BaseViewModel {
  List<Prescription>?mylist=[];

  static const environment = ApiEnvironment.dev;

  String baseUrl = environment.baseUrl;
  void navaddpres() {
    navigationService.navigateTo(Routes.addMyPrescriptions);
  }

  init() async {
   mylist= await apiService.getallprescription();
   notifyListeners();
  }



}
