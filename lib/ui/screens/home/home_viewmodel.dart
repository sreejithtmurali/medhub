import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:medhub/app/app.locator.dart';
import 'package:medhub/services/api_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../models/Productsall/Products.dart';

class HomeViewModel extends BaseViewModel {
void navdoctor(){
  navigationService.navigateTo(Routes.doctorView);
}

  void navdoctorlist() {
    navigationService.navigateTo(Routes.doctorsList);
  }
void navhospital() {
  navigationService.navigateTo(Routes.hospitalDetailView);
}
}
