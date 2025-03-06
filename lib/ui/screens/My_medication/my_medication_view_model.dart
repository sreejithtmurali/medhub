import 'package:flutter/material.dart';
import 'package:medhub/app/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../models/allmedication/Data.dart';

class ViewAllMedicationsModel extends BaseViewModel {
  List<Medication> medications = []; // Changed to non-nullable, initialized as empty list

  init() async {
    try {
      // Fetch medications, use null-aware operator
      final fetchedMedications = await apiService.getallMedications();

      // Assign to medications, defaulting to empty list if null
      medications = fetchedMedications ?? [];

      notifyListeners();
      print('Number of medications: ${medications.length}');
    } catch (e) {
      // Handle potential errors during medication retrieval
      medications = [];
      notifyListeners();
      print('Error fetching medications: $e');
    }
  }

  deleteMedication(Medication medication) async {
    try {
      // Remove medication using where to ensure correct removal
      medications.removeWhere((med) => med.id == medication.id);

      // Call delete API
      await apiService.deleteMediction(medication);

      notifyListeners();
    } catch (e) {
      // Handle deletion error
      print('Error deleting medication: $e');
      // Optionally, you might want to add the medication back or show an error
    }
  }
}