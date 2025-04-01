import 'package:flutter/cupertino.dart';

import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../../../services/api_service.dart';

import '../../../services/user_service.dart';
 // Import the Product class

class RegisterViewModel extends BaseViewModel {


  final formkey=GlobalKey<FormState>();

TextEditingController namecontroller = TextEditingController();
TextEditingController phnctrlr = TextEditingController();
TextEditingController emailctrlr = TextEditingController();
TextEditingController password = TextEditingController();

bool accept=false;
  Future<void> register() async {
    print("register");
    if (formkey.currentState!.validate()) {
      print("register validated");
      bool? status = await apiService.Register(
          Email: emailctrlr.text,
          name: namecontroller.text,
          phone: phnctrlr.text,
          password: password.text);
      if (status == true) {
      navigationService.navigateTo(Routes.loginView);
      }
    }
  }
  void navlogin(){
    navigationService.navigateTo(Routes.loginView);
  }


  bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegExp.hasMatch(email);
  }

// Phone validation method
  bool isValidPhone(String phone) {
    // Check if phone number contains exactly 10 digits
    final phoneRegExp = RegExp(r'^[0-9]{10}$');

    return phoneRegExp.hasMatch(phone);
  }

// Password validation method
  bool isValidPassword(String password) {
    // Password should be at least 8 characters and contain at least one uppercase,
    // one lowercase, one number, and one special character
    final passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    return passwordRegExp.hasMatch(password);
  }

// Name validation method
  bool isValidName(String name) {
    // Name should be at least 2 characters and contain only letters and spaces
    final nameRegExp = RegExp(r'^[a-zA-Z ]{2,}$');

    return nameRegExp.hasMatch(name);
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

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    if (!isValidPhone(value)) {
      return "Please enter a valid 10-digit phone number";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (!isValidPassword(value)) {
      return "Password must be at least 8 characters with uppercase, lowercase, number, and special character";
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    if (!isValidName(value)) {
      return "Please enter a valid name";
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != password) {
      return "Passwords don't match";
    }
    return null;
  }
}


//wait