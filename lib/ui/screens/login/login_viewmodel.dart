import 'package:flutter/cupertino.dart';

import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';

import '../../../models/User.dart';
import '../../../services/api_service.dart';

import '../../../services/user_service.dart';
 // Import the Product class

class LoginViewModel extends BaseViewModel {

void navregister(){
 navigationService.navigateTo(Routes.registerView);
}
  final formkey=GlobalKey<FormState>();

TextEditingController namecontroller = TextEditingController();
TextEditingController password = TextEditingController();



  Future<void> login() async {
    if (formkey.currentState!.validate()) {
      User? user = await apiService.login(
          email: namecontroller.text,
          password: password.text);
      if (user != null) {
        bool saved = await userService.saveUser(user);
        if (saved == true) {
        navigationService.pushNamedAndRemoveUntil(Routes.dashboardview);
        }
      }
    }
  }
  navRegister(){
 navigationService.navigateTo(Routes.registerView);
  }
bool isviewable=true;
  void togglepass() {
    isviewable=!isviewable;
    notifyListeners();
  }
}
