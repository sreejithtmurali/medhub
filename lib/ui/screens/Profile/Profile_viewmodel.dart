import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medhub/app/utils.dart';
import 'package:medhub/models/User.dart';
import 'package:medhub/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/api_service.dart';

class ProfileViewModel extends BaseViewModel {
  static const environment = ApiEnvironment.dev;

   String baseUrl = environment.baseUrl;
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _imagePicker = ImagePicker();

  TextEditingController uname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  var formkey = GlobalKey<FormState>();

  User? user;
  bool isPasswordVisible = false;
  final TextEditingController dateController = TextEditingController();
  String? selectedGender;
  File? profileImageFile;
  bool isImageSelected = false;
String? url;
  // Initialize the view model
  init() async {
    print("profile init called");
    setBusy(true);
    try {

      user = await _userService.getUser();
      uname.text = user!.name ?? '';
      email.text = user!.email ?? '';
      phone.text = user!.phone?.toString() ?? '';
      dateController.text = user!.dob ?? '';
      selectedGender = user!.gender;
print("image::::${user!.image}");
      print("profile initalized");
      notifyListeners();
    } catch (e) {
      print('Error initializing profile: $e');
    }
    setBusy(false);
  }

  // Select image from gallery
  Future<void> selectImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        profileImageFile = File(pickedFile.path);
        isImageSelected = true;
        notifyListeners();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Take image from camera
  Future<void> takeImageFromCamera() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        profileImageFile = File(pickedFile.path);
        isImageSelected = true;
        notifyListeners();
      }
    } catch (e) {
      print('Error taking image: $e');
    }
  }

  // Show image source dialog
  Future<void> showImageSourceDialog() async {
    final response = await _dialogService.showDialog(
      title: 'Select Image Source',
      description: 'Choose where to get your profile image from',
      buttonTitle: 'Gallery',
      cancelTitle: 'Camera',
    );

    if (response?.confirmed == true) {
      await selectImageFromGallery();
    } else {
      await takeImageFromCamera();
    }
  }

  // Update profile
  void update() async {
    if (formkey.currentState!.validate()) {
      if (selectedGender != null) {
        setBusy(true);

        // Update user object with form values
        user!.name = uname.text;
        user!.email = email.text;
        user!.phone = phone.text;
        user!.gender = selectedGender;
        user!.dob = dateController.text;
        bool s;
        // Call service to update profile
        if(isImageSelected){
         s =await apiService.updateUserProfile(user!,profileImage:profileImageFile );
        }else{
           s=await apiService.updateUserProfile(user!,profileImage:profileImageFile );
        }
        notifyListeners();
        if(s){
         var user2=await apiService.profile();
         user!.image="$baseUrl${user2?.image}";
         user!.name = user2?.name;
         user!.email = user2?.email;
         user!.phone =user2?.phone.toString();
         user!.gender = user2?.gender;
         user!.dob = user2?.dob;
          notifyListeners();
        bool success = await _userService.updateUserProfile(
          user!,

        );

        setBusy(false);

        if (success) {
          await _dialogService.showDialog(
            title: 'Success',
            description: 'Profile updated successfully!',
          );
          _navigationService.navigateTo(Routes.dashboardview);
        }
        else {
          await _dialogService.showDialog(
            title: 'Error',
            description: 'Failed to update profile. Please try again.',
          );
        }
        }
      } else {
        await _dialogService.showDialog(
          title: 'Missing Information',
          description: 'Please select your gender.',
        );
      }
    }
  }

  navigatePrescrip() {
    _navigationService.navigateTo(Routes.myPrescriptions);
  }

  void nevmedications() {
    _navigationService.navigateTo(Routes.viewAllMedications);
  }

  void nevemergency() {
    _navigationService.navigateTo(Routes.myEmergencyContactView);
  }

  void nevbookings() {
    _navigationService.navigateTo(Routes.myBookingsView);
  }

  void nevreminder() {
    _navigationService.navigateTo(Routes.myRemindersView);
  }

  Future<void> logout() async {
    bool s = await _userService.logout();
    if (s) {
      _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
    }
  }
}