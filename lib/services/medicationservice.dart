import 'dart:async';
import '../models/medication.dart';

class MedicationService {
  final List<Medication> _medications = [];
  final StreamController<List<Medication>> _medicationsController =
  StreamController<List<Medication>>.broadcast();

  Stream<List<Medication>> get medicationsStream => _medicationsController.stream;

  List<Medication> get medications => List.unmodifiable(_medications);

  void addMedication(Medication medication) {
    // Generate a unique ID
    medication.id = DateTime.now().millisecondsSinceEpoch.toString();

    _medications.add(medication);
    _medicationsController.add(List.unmodifiable(_medications));
  }

  void updateMedication(Medication updatedMedication) {
    final index = _medications.indexWhere((med) => med.id == updatedMedication.id);
    if (index != -1) {
      _medications[index] = updatedMedication;
      _medicationsController.add(List.unmodifiable(_medications));
    }
  }

  void deleteMedication(String id) {
    _medications.removeWhere((medication) => medication.id == id);
    _medicationsController.add(List.unmodifiable(_medications));
  }

  void dispose() {
    _medicationsController.close();
  }
}