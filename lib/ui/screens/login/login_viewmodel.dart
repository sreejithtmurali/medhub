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

bool isValidEmail(String email) {
  final emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  return emailRegExp.hasMatch(email);
}
// Validation for form fields
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!isValidEmail(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }
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
