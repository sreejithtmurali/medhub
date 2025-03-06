

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medhub/app/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import '../../../services/api_service.dart'; // Import the API service

class AddMyPrescriptionsModel extends BaseViewModel {
  final ImagePicker picker = ImagePicker();
  File? image, prescription;

  // Controllers and state variables
  TextEditingController doctorNameController = TextEditingController();
  DateTime? selectedDate;
  String errorMessage = '';
  bool isLoading = false;

  void init() {
    // Initialize anything needed when the view is created
    selectedDate = null;
    doctorNameController.text = '';
    errorMessage = '';
  }

  Future<XFile?> pickimage() async {
    if (await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
    var picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      return picked;
    }
    return null;
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  bool validateInputs() {
    if (prescription == null) {
      errorMessage = 'Please upload a prescription image';
      return false;
    }

    if (doctorNameController.text.trim().isEmpty) {
      errorMessage = 'Doctor name is required';
      return false;
    }

    if (selectedDate == null) {
      errorMessage = 'Please select a prescription date';
      return false;
    }

    errorMessage = '';
    return true;
  }

  Future<void> uploadPrescription() async {
    if (!validateInputs()) {
      notifyListeners();
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      // Call API service to upload prescription
       bool ?s = await apiService.uploadPrescription(
        prescriptionImage: prescription!,
        doctorName: doctorNameController.text.trim(),
        prescriptionDate: selectedDate.toString()!,
      );

      isLoading = false;

      if (s==true) {
        // Clear form and show success
        prescription = null;
        doctorNameController.clear();
        selectedDate = null;
        errorMessage = '';

        // You might want to navigate back or show a success message
        // navigationService.back();
        // Or
        // showDialog with success message
      } else {
        errorMessage = "unable to upload";
      }
    } catch (e) {
      isLoading = false;
      errorMessage = 'An error occurred: $e';
    } finally {
      notifyListeners();
    }
  }


  @override
  void dispose() {
    doctorNameController.dispose();
    super.dispose();
  }
}