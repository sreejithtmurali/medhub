import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:medhub/models/User.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../services/api_service.dart';

class ProfileUpdteViewModel extends BaseViewModel {
  TextEditingController uname=TextEditingController();
  TextEditingController psw=TextEditingController();
  TextEditingController email=TextEditingController();
  var apiservice=locator<ApiService>();
  var formkey=GlobalKey<FormState>();
  bool isPasswordVisible = false;
  final TextEditingController dateController = TextEditingController();
  String? selectedGender;
  void update(){
    if(formkey.currentState!.validate()){
      if(selectedGender!=null){
        navigationService.navigateTo(Routes.dashboardview);
      }
    }
  }
  Future<void> logout() async {
    bool s= await userService.logout();
    if(s){
      navigationService.pushNamedAndRemoveUntil(Routes.loginView);
    }
  }

}
