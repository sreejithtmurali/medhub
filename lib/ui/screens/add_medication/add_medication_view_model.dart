
import 'package:flutter/material.dart';
import 'package:medhub/app/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../services/medicationservice.dart';
import '../../../models/medication.dart';

class AddMedicationViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final MedicationService _medicationService;

  AddMedicationViewModel({
    required NavigationService navigationService,
    required MedicationService medicationService,
  })  : _navigationService = navigationService,
        _medicationService = medicationService;

  final formKey = GlobalKey<FormState>();
  String name = '';
  DateTime? startDate;
  DateTime? endDate;
  String timeInterval = '';
  bool afterFood = true;
  bool _isUploading = false;

  // Getter for medications
  List<Medication> get medications => _medicationService.medications;

  // Check if there are any medications
  bool get hasMedications => medications.isNotEmpty;

  // Uploading state getter
  bool get isUploading => _isUploading;

  void selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      if (isStartDate) {
        startDate = picked;
      } else {
        endDate = picked;
      }
      notifyListeners();
    }
  }

  void toggleAfterFood(bool? value) {
    afterFood = value ?? true;
    notifyListeners();
  }

  void saveMedication(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (startDate == null || endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select start and end dates')),
        );
        return;
      }

      final medication = Medication(
        name: name,
        startDate: startDate!,
        endDate: endDate!,
        timeInterval: timeInterval,
        afterFood: afterFood,
      );

      _medicationService.addMedication(medication);

      // Reset form after adding
      formKey.currentState!.reset();
      startDate = null;
      endDate = null;
      name = '';
      timeInterval = '';
      afterFood = true;

      notifyListeners();
    }
  }

  void deleteMedication(String id) {
    _medicationService.deleteMedication(id);
    notifyListeners();
  }

  Future<void> uploadMedications() async {
    // Check if there are medications to upload
    if (medications.isEmpty) {
      return;
    }

    // Set uploading state
    _isUploading = true;
    notifyListeners();

    try {
      // Simulate upload process
      await Future.delayed(const Duration(seconds: 2));

      // Prepare upload data
      List<Map<String, dynamic>> uploadData =
      medications.map((med) => med.toMap()).toList();
      List<Map<String, dynamic>> uploadData2 = medications.map((med) {
        // Create a map from the medication object
        Map<String, dynamic> medMap = med.toMap();

        // Remove the ID field
        medMap.remove('id');

        return medMap;
      }).toList();

      // TODO: Replace with actual upload logic to your backend
      print('Uploading medications: $uploadData');

      // Clear medications after successful upload
      while (medications.isNotEmpty) {
        _medicationService.deleteMedication(medications.first.id!);
      }
   await apiService.uploadMedications(uploadData2);
      // Show success message
      // You might want to replace this with a proper dialog or snackbar
     // print('Medications uploaded successfully');
    } catch (e) {
      // Handle upload errors
      print('Upload failed: $e');
    } finally {
      // Reset uploading state
      _isUploading = false;
      notifyListeners();
    }
  }
}