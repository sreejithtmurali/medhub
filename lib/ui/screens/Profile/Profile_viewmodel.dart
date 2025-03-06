import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:medhub/models/User.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../services/api_service.dart';

class ProfileViewModel extends BaseViewModel {
  TextEditingController uname=TextEditingController();
  TextEditingController email=TextEditingController();
  var apiservice=locator<ApiService>();
  var formkey=GlobalKey<FormState>();
  bool isPasswordVisible = false;
  final TextEditingController dateController = TextEditingController();
  String? selectedGender;
  void login(){
    if(formkey.currentState!.validate()){
      if(selectedGender!=null){
        navigationService.navigateTo(Routes.dashboardview);
      }
    }
  }
  navigatePrescrip(){
    navigationService.navigateTo(Routes.myPrescriptions);
  }

  void nevmedications() {
    navigationService.navigateTo(Routes.viewAllMedications);
  }

}
